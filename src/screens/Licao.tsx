// Lição (e mini-simulado da trilha): uma questão por vez, com retorno imediato.
// A tela calcula tudo na hora; no Supabase, as respostas vão ao servidor, que confere o gabarito e tem a palavra final.
import { useMemo, useRef, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { repo } from '../lib/config';
import { plural } from '../lib/texto';
import { QuestaoView } from '../components/QuestaoView';
import type { EstadoAlt } from '../components/QuestaoView';
import { IcCoracao, IcPlay, IcX, Mascote } from '../components/Icones';
import { Texto } from '../components/Texto';
import { Folha, tocar, vibrar } from '../components/Base';
import { SemVidas, useAnuncioDeVida } from '../components/SemVidas';
import {
  BONUS_PERFEITA, DESAFIO_MINIMO, agendarErro, ajustarVidas, areasDoExame, atualizarTema, chaveTema, desafioLiberado, hoje,
  montarDesafio, montarLicao, novasConquistas, somarXP, unidadesDoRecorte, vidasAgora, xpDoAcerto
} from '../domain/regras';
import type { ResumoSessao } from '../data/repo';
import type { Tentativa } from '../data/types';

export interface EstadoResultado {
  tipo: 'licao' | 'desafio';
  tema: string; recorte_id: string; acertos: number; total: number; xp: number; perfeita: boolean;
  coroaAntes: number; coroaDepois: number; segundos: number; erros: string[]; aprovado?: boolean; conquistas: string[];
  motivo?: 'vidas' | 'saiu'; // terminou antes da última questão
}

export default function Licao({ desafio = false }: { desafio?: boolean }) {
  const { recorte: recParam = '', assunto: assParam = '', unidade: uniParam = '0' } = useParams();
  const recorte_id = decodeURIComponent(recParam);
  const assunto = decodeURIComponent(assParam);
  const { dados, conteudo, atualizar, sincronizar, avisar } = useDados();
  const nav = useNavigate();
  const recorte = conteudo.recortes.find((r) => r.id === recorte_id);
  const exame = conteudo.exames.find((e) => e.id === recorte?.exame_id) ?? conteudo.exames[0];
  const unidadeIdx = Number(uniParam);
  const voltarPara = desafio ? '/trilha' : '/inicio';

  const unidades = useMemo(() => unidadesDoRecorte(conteudo, recorte_id, dados.prefs.lingua), [conteudo, recorte_id, dados.prefs.lingua]);
  // O link direto não pula etapas: o desafio só abre com a unidade anterior vencida e os temas desta feitos.
  const [liberado] = useState(() => !desafio || desafioLiberado(dados, unidades, recorte_id, unidadeIdx));
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
  const sessaoRef = useRef<Promise<string> | null>(null);
  const filaRef = useRef<Promise<void>>(Promise.resolve());
  const falhou = useRef(false);
  const vidas = vidasAgora(dados.perfil).vidas;
  const { abrir: assistirAnuncio, anuncio } = useAnuncioDeVida();

  if (!liberado) {
    return (
      <div className="app"><div className="screen" style={{ justifyContent: 'center', alignItems: 'center', textAlign: 'center' }}>
        <Mascote largura={120} /><h1 className="title">Desafio bloqueado</h1>
        <p className="muted">Faça todos os temas desta unidade (e vença o desafio da anterior) para liberar.</p>
        <Link to="/trilha" className="btn" replace>Ir para a trilha</Link>
      </div></div>
    );
  }
  if (!questoes.length) {
    return <div className="app"><div className="screen"><p>Não há questões para este tema ainda.</p><Link to="/inicio" className="btn">Voltar</Link></div></div>;
  }
  // Sem vidas antes de começar (link direto ou Voltar): a mesma tela de vidas esgotadas
  if (!desafio && vidas === 0 && respostas.length === 0) {
    return <div className="app"><div className="screen" style={{ justifyContent: 'center' }}><SemVidas esperar={() => nav(voltarPara, { replace: true })} /></div></div>;
  }

  const q = questoes[i];
  const acertou = verificada && sel === q.gabarito;
  const semVidas = !desafio && vidas === 0;
  const ultima = i === questoes.length - 1 || (semVidas && verificada);

  const estados: Record<string, EstadoAlt> = {};
  for (const a of q.alternativas) {
    if (!verificada) estados[a.letra] = sel === a.letra ? 'sel' : 'neutra';
    else estados[a.letra] = a.letra === q.gabarito ? 'certa' : a.letra === sel ? 'errada' : 'apagada';
  }

  function sessao() {
    sessaoRef.current ??= repo.iniciarSessao({
      tipo: desafio ? 'desafio' : 'licao', exame_id: exame.id, recorte_id, assunto: desafio ? null : assunto, unidade: desafio ? unidadeIdx : null,
      questoes: questoes.map((x) => x.id)
    })
      .catch((e) => { sessaoRef.current = null; throw e; });
    return sessaoRef.current;
  }

  // As respostas vão ao servidor em ordem; se uma falhar, todas são reenviadas no fim (o servidor ignora repetidas).
  function enviar(t: Tentativa) {
    filaRef.current = filaRef.current.then(async () => { await repo.responder(await sessao(), t); }).catch(() => { falhou.current = true; });
  }

  function verificar() {
    if (!sel || verificada || travado.current) return;
    travado.current = true;
    setVerificada(true);
    const ok = sel === q.gabarito;
    tocar(ok ? 'acerto' : 'erro', dados.prefs.sons);
    vibrar(dados.prefs.vibracao, ok ? 20 : 60);
    const t: Tentativa = { questao_id: q.id, letra: sel, correta: ok, dicas_usadas: 0, viu_resolucao: false, tempo_ms: Date.now() - inicioQ.current, origem: desafio ? 'desafio' : 'licao' };
    setRespostas((r) => (r.some((x) => x.questao_id === q.id) ? r : [...r, t]));
    enviar(t);
    if (!ok) {
      atualizar((d) => ({
        ...d,
        perfil: desafio ? d.perfil : ajustarVidas(d.perfil, -1),
        revisao: { ...d.revisao, [q.id]: agendarErro(d.revisao[q.id], q.id, sel) }
      }), { perfil: !desafio, revisao: [q.id] });
    }
  }

  async function concluir(todas: Tentativa[], motivo?: EstadoResultado['motivo']) {
    if (concluindo) return;
    setConcluindo(true);
    const assuntoDe = (id: string) => questoes.find((x) => x.id === id)!.assunto;
    const acertos = todas.filter((t) => t.correta).length;
    const total = todas.length;
    const perfeita = !desafio && total >= 3 && acertos === total;
    const xp = todas.reduce((s, t) => s + (t.correta ? xpDoAcerto(dados, t.questao_id) : 0), 0) + (perfeita ? BONUS_PERFEITA : 0);
    const k = chaveTema(recorte_id, assunto);
    const coroaAntes = dados.temas[k]?.coroa ?? 0;
    const aprovado = desafio ? acertos / Math.max(1, total) >= DESAFIO_MINIMO : undefined;
    const areas = areasDoExame(conteudo, exame.id);
    const temasTocados = [...new Set(todas.map((t) => assuntoDe(t.questao_id)))];
    let ganhas: string[] = [];
    const novo = total === 0 ? null : await atualizar((d) => {
      let n = somarXP(d, xp);
      const temas = { ...n.temas };
      for (const nomeTema of temasTocados) {
        const kk = chaveTema(recorte_id, nomeTema);
        const resp = todas.filter((t) => assuntoDe(t.questao_id) === nomeTema).map((t) => t.correta);
        temas[kk] = atualizarTema(temas[kk], recorte_id, nomeTema, resp, perfeita && nomeTema === assunto);
      }
      n = {
        ...n, temas,
        vistas: [...new Set([...n.vistas, ...todas.map((t) => t.questao_id)])],
        acertadas: [...new Set([...n.acertadas, ...todas.filter((t) => t.correta).map((t) => t.questao_id)])],
        perfil: { ...n.perfil, questoes_feitas: n.perfil.questoes_feitas + total, acertos_total: n.perfil.acertos_total + acertos },
        unidades: desafio && aprovado ? { ...n.unidades, [`${recorte_id}|${unidadeIdx}`]: true } : n.unidades
      };
      ganhas = novasConquistas(n, areas, { perfeita });
      const agora = new Date().toISOString();
      return { ...n, conquistas: { ...n.conquistas, ...Object.fromEntries(ganhas.map((g) => [g, agora])) } };
    }, {
      perfil: true, xpDia: [hoje()], temas: temasTocados.map((t) => chaveTema(recorte_id, t)),
      unidades: desafio && aprovado ? [`${recorte_id}|${unidadeIdx}`] : []
    });
    if (novo && ganhas.length) await atualizar((d) => d, { conquistas: ganhas }); // no modo demonstração grava as conquistas

    // No Supabase o resultado oficial vem do servidor
    let resumo: ResumoSessao | null = null;
    if (total > 0) {
      try {
        await filaRef.current;
        if (falhou.current) for (const t of todas) await repo.responder(await sessao(), t);
        resumo = await repo.concluirSessao(await sessao());
      } catch (e) {
        avisar(`Não deu para salvar esta lição. ${(e as Error).message}`);
      }
      sincronizar();
    }
    tocar('fim', dados.prefs.sons);
    const estado: EstadoResultado = {
      tipo: desafio ? 'desafio' : 'licao', tema: desafio ? `Unidade ${unidadeIdx + 1} · ${recorte?.nome}` : assunto, recorte_id,
      acertos: resumo?.acertos ?? acertos, total: resumo?.total ?? total, xp: resumo?.xp ?? xp, perfeita: resumo?.perfeita ?? perfeita,
      coroaAntes: resumo ? resumo.coroaAntes : coroaAntes, coroaDepois: resumo ? resumo.coroaDepois : novo?.temas[k]?.coroa ?? coroaAntes,
      segundos: Math.round((Date.now() - inicio.current) / 1000), erros: todas.filter((t) => !t.correta).map((t) => t.questao_id),
      aprovado: desafio ? (resumo?.aprovado ?? aprovado) : undefined, conquistas: resumo?.conquistas ?? ganhas, motivo
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
    <div className="app" style={{ background: 'var(--bg-licao)' }}>
      <header className="row" style={{ padding: '16px 18px 8px', gap: 12 }}>
        <button onClick={sair} aria-label={desafio ? 'Sair do desafio' : 'Sair da lição'} className="linkbtn" style={{ color: 'var(--icon)', display: 'grid', placeItems: 'center', width: 40, height: 40, padding: 0 }}><IcX /></button>
        <div className="bar spacer" style={{ height: 14 }} role="progressbar" aria-label={desafio ? 'Progresso do desafio' : 'Progresso da lição'} aria-valuemin={0} aria-valuemax={questoes.length} aria-valuenow={i + (verificada ? 1 : 0)}><span style={{ width: `${pct}%`, background: 'var(--ok)' }} /></div>
        {desafio ? <span className="pill" style={{ background: 'var(--lav-soft)', color: 'var(--lav-dark)' }}>Desafio</span>
          : <span className="row" role="img" aria-label={plural(vidas, 'vida', 'vidas')} style={{ gap: 4, fontFamily: 'var(--font-title)', fontWeight: 600, color: 'var(--coral-dark)' }}><IcCoracao size={22} />{vidas}</span>}
      </header>
      <div className="screen licao" tabIndex={0} role="region" aria-label="Questão" style={{ paddingBottom: verificada ? '75vh' : 120 }}>
        <QuestaoView key={q.id} q={q} recorte={conteudo.recortes.find((r) => r.id === q.recorte_id) ?? recorte} nomeExame={exame.nome} textoBase={q.texto_base_id ? conteudo.textos_base[q.texto_base_id] : null}
          estados={estados} escolher={(l) => !verificada && setSel(l)} bloqueado={verificada} />
      </div>
      {!verificada ? (
        <div className="footer-cta" style={{ position: 'sticky' }}>
          <button className="btn" disabled={!sel} onClick={verificar}>Verificar</button>
        </div>
      ) : (
        <div className={`feedback ${acertou ? 'ok' : 'erro'}`} role="status">
          <div className="row" style={{ gap: 12 }}>
            <Mascote largura={58} humor={acertou ? 'comemorando' : 'triste'} />
            <div className="col" style={{ gap: 2 }}>
              <span style={{ fontFamily: 'var(--font-title)', fontWeight: 700, fontSize: 22 }}>{acertou ? 'Mandou bem!' : 'Quase lá'}</span>
              <span className="small" style={{ fontWeight: 600 }}>{acertou ? `+${xpDoAcerto(dados, q.id)} XP` : `Resposta certa: ${q.gabarito}${desafio ? '' : ' · −1 vida'}`}</span>
            </div>
          </div>
          {dados.prefs.explicacao_imediata && q.explicacao && <div className="feedback-corpo"><Texto md={q.explicacao} className="texto-questao small" /></div>}
          {semVidas && !acertou && <p className="small" style={{ fontWeight: 600 }}>Suas vidas acabaram. Assista a um anúncio para ganhar 1 vida e continuar, ou termine a lição aqui.</p>}
          <div className="col" style={{ gap: 8 }}>
            {semVidas && !acertou && <button className="btn lav" onClick={assistirAnuncio}><IcPlay size={18} />Assistir anúncio e continuar</button>}
            <button className={`btn ${acertou ? '' : 'coral'}`} disabled={concluindo} onClick={proxima}>{concluindo ? 'Salvando…' : ultima ? 'Ver resultado' : acertou ? 'Continuar' : 'Entendi'}</button>
          </div>
        </div>
      )}
      <Folha aberta={confirmarSaida} fechar={() => setConfirmarSaida(false)} titulo={desafio ? 'Sair do desafio' : 'Sair da lição'}>
        <span className="title" style={{ fontSize: 24 }}>{desafio ? 'Sair do desafio?' : 'Sair da lição?'}</span>
        <p className="small">Você respondeu {plural(respostas.length, 'questão', 'questões')} de {questoes.length}. {desafio ? 'Se sair agora, o desafio não conta; dá para tentar de novo quando quiser.' : 'A lição termina aqui e o XP do que você acertou fica salvo. Vidas gastas não voltam.'}</p>
        <button className="btn" onClick={() => setConfirmarSaida(false)}>{desafio ? 'Continuar o desafio' : 'Continuar a lição'}</button>
        {desafio
          ? <button className="linkbtn" onClick={() => nav(voltarPara, { replace: true })}>Sair do desafio</button>
          : <button className="linkbtn" disabled={concluindo} onClick={() => { setConfirmarSaida(false); concluir(respostas, 'saiu'); }}>Sair e salvar o que fiz</button>}
      </Folha>
      {anuncio}
    </div>
  );
}
