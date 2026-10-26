// Lição (e mini-simulado da trilha): uma questão por vez, com retorno imediato.
// A tela reage na hora a cada resposta; o servidor confere o gabarito, gasta a vida e, no fim, calcula o resultado.
import { useEffect, useMemo, useRef, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { useSessaoEstudo } from '../state/useSessaoEstudo';
import { plural } from '../lib/texto';
import { QuestaoView } from '../components/QuestaoView';
import type { EstadoAlt } from '../components/QuestaoView';
import { IcCoracao, IcPlay, IcX, Mascote } from '../components/Icones';
import { Texto } from '../components/Texto';
import { Folha, tocar, vibrar } from '../components/Base';
import { SemVidas, useAnuncioDeVida } from '../components/SemVidas';
import { chaveTema, desafioLiberado, montarDesafio, montarLicao, primeiraLicao as ehPrimeiraLicao, unidadesDoRecorte, vidasAgora, xpDoAcerto } from '../domain/regras';
import { marcarVista, registrarErro } from '../domain/sessoes';
import { catalogo } from '../domain/catalogo';
import type { ResumoSessao, Tentativa } from '../data/types';

/** O que a tela de Resultado recebe: o resumo do servidor e como a sessão terminou. */
export type EstadoResultado = ResumoSessao & {
  tipo: 'licao' | 'desafio';
  tema: string;
  recorte_id: string;
  segundos: number;
  erros: string[];
  motivo?: 'vidas' | 'saiu'; // terminou antes da última questão
  salvo: boolean; // false: o servidor não confirmou (sem internet); o resumo é só o que a tela sabe
};

const reduzirMovimento = () => document.documentElement.dataset.motion === 'reduce' || window.matchMedia('(prefers-reduced-motion: reduce)').matches;

export default function Licao({ desafio = false }: { desafio?: boolean }) {
  const { recorte: recParam = '', assunto: assParam = '', unidade: uniParam = '0' } = useParams();
  const recorte_id = decodeURIComponent(recParam);
  const assunto = decodeURIComponent(assParam);
  const { dados, conteudo, atualizar } = useDados();
  const nav = useNavigate();
  const recorte = catalogo(conteudo).recorte(recorte_id);
  const exame = catalogo(conteudo).exame(recorte?.exame_id) ?? conteudo.exames[0];
  const unidadeIdx = Number(uniParam);
  const voltarPara = desafio ? '/trilha' : '/inicio';

  const unidades = useMemo(() => unidadesDoRecorte(conteudo, recorte_id, dados.prefs.lingua), [conteudo, recorte_id, dados.prefs.lingua]);
  // O link direto não pula etapas: o desafio só abre com a unidade anterior vencida e os temas desta feitos.
  const [liberado] = useState(() => !desafio || desafioLiberado(dados, unidades, recorte_id, unidadeIdx));
  // A primeira lição do aluno não gasta vida (o servidor confere o mesmo ao abrir a sessão)
  const [primeiraLicao] = useState(() => !desafio && ehPrimeiraLicao(dados));
  const questoes = useMemo(() => {
    if (desafio) return montarDesafio(conteudo, dados, unidades[unidadeIdx] ?? []);
    return montarLicao(conteudo, dados, recorte_id, assunto);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const [i, setI] = useState(0);
  const [sel, setSel] = useState<string | null>(null);
  const [verificada, setVerificada] = useState(false);
  const [respostas, setRespostas] = useState<Tentativa[]>([]);
  const [confirmarSaida, setConfirmarSaida] = useState(false);
  const [concluindo, setConcluindo] = useState(false);
  const inicio = useRef(Date.now());
  const inicioQ = useRef(Date.now());
  const travado = useRef(false); // um clique por questão em Verificar
  const telaRef = useRef<HTMLElement>(null);
  const painelRef = useRef<HTMLDivElement>(null);
  const vidas = vidasAgora(dados.perfil).vidas;
  const { abrir: assistirAnuncio, anuncio } = useAnuncioDeVida();
  const sessao = useSessaoEstudo(() => ({
    tipo: desafio ? 'desafio' : 'licao', exame_id: exame.id, recorte_id, assunto: desafio ? null : assunto, unidade: desafio ? unidadeIdx : null,
    questoes: questoes.map((x) => x.id)
  }), desafio ? 'este desafio' : 'esta lição');

  const q = questoes[i] as (typeof questoes)[number] | undefined;
  const acertou = verificada && !!q && sel === q.gabarito;

  // Errou: a tela rola até a alternativa certa, que fica à vista acima do painel da explicação.
  useEffect(() => {
    if (!verificada || acertou) return;
    const quadro = requestAnimationFrame(() => {
      const tela = telaRef.current, painel = painelRef.current;
      const certa = tela?.querySelector<HTMLElement>('.alt.certa');
      if (!tela || !painel || !certa) return;
      const t = tela.getBoundingClientRect(), c = certa.getBoundingClientRect();
      const limite = t.bottom - painel.offsetHeight - 12;
      let delta = c.bottom > limite ? c.bottom - limite : 0;
      if (c.top - delta < t.top + 8) delta = c.top - (t.top + 8); // alternativa alta: mostra o começo dela
      if (delta) tela.scrollBy({ top: delta, behavior: reduzirMovimento() ? 'auto' : 'smooth' });
    });
    return () => cancelAnimationFrame(quadro);
  }, [verificada, acertou, i]);

  if (!liberado) {
    return (
      <div className="app"><main className="screen tela-centro">
        <Mascote largura={120} /><h1 className="title">Desafio bloqueado</h1>
        <p className="muted">Faça todos os temas desta unidade (e vença o desafio da anterior) para liberar.</p>
        <Link to="/trilha" className="btn" replace>Ir para a trilha</Link>
      </main></div>
    );
  }
  if (!q) {
    return <div className="app"><main className="screen"><h1 className="title">Não há questões para este tema ainda.</h1><Link to="/inicio" className="btn">Voltar</Link></main></div>;
  }
  // Sem vidas antes de começar (link direto ou Voltar): a mesma tela de vidas esgotadas
  if (!desafio && vidas === 0 && respostas.length === 0) {
    return <div className="app"><main className="screen just-centro"><h1 className="sr-only">Lição: {assunto}</h1><SemVidas esperar={() => nav(voltarPara, { replace: true })} /></main></div>;
  }

  const semVidas = !desafio && vidas === 0;
  const ultima = i === questoes.length - 1 || (semVidas && verificada);

  const estados: Record<string, EstadoAlt> = {};
  for (const a of q.alternativas) {
    if (!verificada) estados[a.letra] = sel === a.letra ? 'sel' : 'neutra';
    else estados[a.letra] = a.letra === q.gabarito ? 'certa' : a.letra === sel ? 'errada' : 'apagada';
  }

  function verificar() {
    if (!q || !sel || verificada || travado.current) return;
    travado.current = true;
    setVerificada(true);
    const ok = sel === q.gabarito;
    tocar(ok ? 'acerto' : 'erro', dados.prefs.sons);
    vibrar(dados.prefs.vibracao, ok ? 20 : 60);
    const t: Tentativa = { questao_id: q.id, letra: sel, correta: ok, dicas_usadas: 0, viu_resolucao: false, tempo_ms: Date.now() - inicioQ.current, origem: desafio ? 'desafio' : 'licao' };
    setRespostas((r) => (r.some((x) => x.questao_id === q.id) ? r : [...r, t]));
    sessao.responder(t);
    // na tela já; o servidor faz o mesmo (e a questão já conta como vista: sair no meio não devolve a 1ª lição grátis)
    atualizar((d) => marcarVista(ok ? d : registrarErro(d, q.id, sel, !desafio && !primeiraLicao), q.id));
  }

  async function concluir(todas: Tentativa[], motivo?: EstadoResultado['motivo']) {
    if (concluindo) return;
    setConcluindo(true);
    const resumo = await sessao.concluir(todas);
    tocar('fim', dados.prefs.sons);
    const coroa = dados.temas[chaveTema(recorte_id, assunto)]?.coroa ?? 0;
    const acertos = todas.filter((t) => t.correta).length;
    const estado: EstadoResultado = {
      // Sem resposta do servidor, só o que a tela sabe: acertos e erros, sem XP
      ...(resumo ?? { acertos, total: todas.length, xp: 0, perfeita: false, aprovado: null, conquistas: [], coroaAntes: coroa, coroaDepois: coroa, vidaGanha: false }),
      tipo: desafio ? 'desafio' : 'licao', tema: desafio ? `Unidade ${unidadeIdx + 1} · ${recorte?.nome}` : assunto, recorte_id,
      segundos: Math.round((Date.now() - inicio.current) / 1000), erros: todas.filter((t) => !t.correta).map((t) => t.questao_id),
      motivo, salvo: !!resumo
    };
    nav('/resultado', { replace: true, state: estado });
  }

  function proxima() {
    if (ultima) { concluir(respostas, i < questoes.length - 1 ? 'vidas' : undefined); return; }
    setI(i + 1); setSel(null); setVerificada(false); travado.current = false; inicioQ.current = Date.now();
  }

  function sair() {
    if (!respostas.length) nav(voltarPara);
    else setConfirmarSaida(true);
  }

  const pct = ((i + (verificada ? 1 : 0)) / questoes.length) * 100;
  return (
    <div className="app app-licao">
      <header className="row topo-licao">
        <button onClick={sair} aria-label={desafio ? 'Sair do desafio' : 'Sair da lição'} className="linkbtn botao-fechar"><IcX /></button>
        <div className="bar spacer barra-licao" role="progressbar" aria-label={desafio ? 'Progresso do desafio' : 'Progresso da lição'} aria-valuemin={0} aria-valuemax={questoes.length} aria-valuenow={i + (verificada ? 1 : 0)}><span style={{ width: `${pct}%`, background: 'var(--ok)' }} /></div>
        {desafio ? <span className="pill pilula-lav">Desafio</span>
          : <span className="row vidas-licao" role="img" aria-label={plural(vidas, 'vida', 'vidas')}><IcCoracao size={22} />{vidas}</span>}
      </header>
      <main className="screen licao" tabIndex={0} aria-label="Questão" ref={telaRef} style={{ paddingBottom: verificada ? '75vh' : 120 }}>
        <h1 className="sr-only">{desafio ? `Desafio da unidade ${unidadeIdx + 1}` : `Lição: ${assunto}`}, questão {i + 1} de {questoes.length}</h1>
        <QuestaoView key={q.id} q={q} recorte={catalogo(conteudo).recorte(q.recorte_id) ?? recorte} nomeExame={exame.nome} textoBase={q.texto_base_id ? conteudo.textos_base[q.texto_base_id] : null}
          estados={estados} escolher={(l) => !verificada && setSel(l)} bloqueado={verificada} />
      </main>
      {!verificada ? (
        <div className="footer-cta">
          <button className="btn" disabled={!sel} onClick={verificar}>Verificar</button>
        </div>
      ) : (
        <div className={`feedback ${acertou ? 'ok' : 'erro'}`} role="status" ref={painelRef}>
          <div className="row gap-12">
            <Mascote largura={58} humor={acertou ? 'comemorando' : 'triste'} />
            <div className="col gap-2">
              <span className="feedback-titulo">{acertou ? 'Mandou bem!' : 'Quase lá'}</span>
              <span className="small peso-600">{acertou ? `+${xpDoAcerto(dados, q.id)} XP` : `Resposta certa: ${q.gabarito}${desafio ? '' : primeiraLicao ? ' · na 1ª lição, errar não gasta vida' : ' · −1 vida'}`}</span>
            </div>
          </div>
          {dados.prefs.explicacao_imediata && q.explicacao && <div className="feedback-corpo"><Texto md={q.explicacao} className="texto-questao small" /></div>}
          {semVidas && !acertou && <p className="small peso-600">Suas vidas acabaram. Assista a um anúncio para ganhar 1 vida e continuar, ou termine a lição aqui.</p>}
          <div className="col">
            {semVidas && !acertou && <button className="btn lav" onClick={assistirAnuncio}><IcPlay size={18} />Assistir anúncio e continuar</button>}
            <button className={`btn ${acertou ? '' : 'coral'}`} disabled={concluindo} onClick={proxima}>{concluindo ? 'Salvando…' : ultima ? 'Ver resultado' : acertou ? 'Continuar' : 'Entendi'}</button>
          </div>
        </div>
      )}
      <Folha aberta={confirmarSaida} fechar={() => setConfirmarSaida(false)} titulo={desafio ? 'Sair do desafio' : 'Sair da lição'}>
        <span className="title fs-24">{desafio ? 'Sair do desafio?' : 'Sair da lição?'}</span>
        <p className="small">Você respondeu {plural(respostas.length, 'questão', 'questões')} de {questoes.length}. {desafio ? 'Se sair agora, o desafio não conta; dá para tentar de novo quando quiser.' : `A lição termina aqui e o XP do que você acertou fica salvo.${primeiraLicao ? '' : ' Vidas gastas não voltam.'}`}</p>
        <button className="btn" onClick={() => setConfirmarSaida(false)}>{desafio ? 'Continuar o desafio' : 'Continuar a lição'}</button>
        {desafio
          ? <button className="linkbtn" onClick={() => nav(voltarPara, { replace: true })}>Sair do desafio</button>
          : <button className="linkbtn" disabled={concluindo} onClick={() => { setConfirmarSaida(false); concluir(respostas, 'saiu'); }}>Sair e salvar o que fiz</button>}
      </Folha>
      {anuncio}
    </div>
  );
}
