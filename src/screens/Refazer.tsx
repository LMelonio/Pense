// Refazer com dicas: Dica 1 → Dica 2 → Resolução (só depois de tentar). Duas tentativas por questão.
// As tentativas vão ao servidor, que reagenda a fila e calcula o XP e a vida no fim.
// Questão que ainda não venceu (revisão adiantada) é treino: acertar não vale XP nem tira da lista; ela volta amanhã.
import { useEffect, useMemo, useRef, useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { useSessaoEstudo } from '../state/useSessaoEstudo';
import { plural } from '../lib/texto';
import { QuestaoView } from '../components/QuestaoView';
import type { EstadoAlt } from '../components/QuestaoView';
import { IcLampada, IcLock, IcRevisar, IcX, Mascote } from '../components/Icones';
import { Texto } from '../components/Texto';
import { Folha, tocar, vibrar } from '../components/Base';
import { QUESTOES_POR_REVISAO, revisaoPendente, revisaoVencida, venceu, vidaPeloTreino, xpDaRevisao } from '../domain/regras';
import { registrarRevisao } from '../domain/sessoes';
import { catalogo } from '../domain/catalogo';
import type { ItemRevisao, Questao, Tentativa } from '../data/types';

const PASSOS_DOMINADA = [7, 21, 60];
const reduzirMovimento = () => document.documentElement.dataset.motion === 'reduce' || window.matchMedia('(prefers-reduced-motion: reduce)').matches;

/** Uma questão terminada: acertou, XP ganho e se valia (vencida) ou era treino. */
interface Feita { acertou: boolean; xp: number; vencida: boolean }

/** O texto do fim da revisão, com o que aconteceu com cada questão. */
function textoDoFim(feitas: Feita[]) {
  const recuperadas = feitas.filter((f) => f.acertou && f.vencida).length;
  const treino = feitas.filter((f) => f.acertou && !f.vencida).length;
  const voltam = feitas.length - recuperadas - treino;
  const total = feitas.length;
  if (recuperadas === total) return total === 1 ? 'Você recuperou a questão!' : `Você recuperou as ${total} questões!`;
  if (treino === total) return total === 1 ? 'Você acertou no treino. Ela volta amanhã, valendo XP.' : `Você acertou as ${total} no treino. Elas voltam amanhã, valendo XP.`;
  if (voltam === total) return total === 1 ? 'Essa ainda não foi. Ela volta amanhã.' : 'Essas ainda não foram. Elas voltam amanhã.';
  const partes = [
    recuperadas && `recuperou ${recuperadas}`,
    treino && `acertou ${treino} no treino`,
    voltam && `${voltam} ${voltam === 1 ? 'volta' : 'voltam'} amanhã`
  ].filter(Boolean) as string[];
  return `Você ${partes.slice(0, -1).join(', ')} e ${partes[partes.length - 1]}.`;
}

export default function Refazer() {
  const { dados, conteudo, atualizar } = useDados();
  const [params] = useSearchParams();
  const nav = useNavigate();
  // Busca: ids (erros de uma lição), recorte + tema (um grupo da tela Revisar), recorte + temas (a unidade da trilha,
  // separados por |); todas=1 inclui as que ainda não venceram.
  const [questoes] = useState<Questao[]>(() => {
    const ids = params.get('ids')?.split(',').filter(Boolean);
    const tema = params.get('tema');
    const temas = params.get('temas')?.split('|').filter(Boolean);
    const recorte = params.get('recorte');
    let itens = params.get('todas') || ids ? revisaoPendente(dados) : revisaoVencida(dados);
    if (ids) itens = itens.filter((r) => ids.includes(r.questao_id));
    const qs = itens.map((r) => catalogo(conteudo).questao(r.questao_id)).filter((q): q is Questao => !!q);
    return qs.filter((q) => (!tema || q.assunto === tema) && (!temas || temas.includes(q.assunto)) && (!recorte || q.recorte_id === recorte)).slice(0, QUESTOES_POR_REVISAO);
  });
  const filtrada = ['ids', 'tema', 'temas', 'recorte'].some((k) => params.has(k)); // um grupo, não a revisão inteira
  // Como cada questão estava ao abrir a revisão (a tela reagenda na hora, mas os textos falam do antes)
  const [antes] = useState(() => {
    const agora = Date.now();
    return Object.fromEntries(questoes.map((q) => [q.id, { item: dados.revisao[q.id] as ItemRevisao | undefined, vencida: !!dados.revisao[q.id] && venceu(dados.revisao[q.id], agora) }]));
  });
  const guardados = useMemo(() => revisaoPendente(dados).length, [dados]);
  const [vidaTreino] = useState(() => vidaPeloTreino(dados)); // a 1ª vez sem vidas: o treino devolve 1 vida

  const [i, setI] = useState(0);
  const [sel, setSel] = useState<string | null>(null);
  const [erradas, setErradas] = useState<string[]>([]);
  const [dicas, setDicas] = useState(0);
  const [resultado, setResultado] = useState<null | 'acertou' | 'falhou'>(null);
  const [feitas, setFeitas] = useState<Feita[]>([]);
  const [fim, setFim] = useState<{ xp: number; vida: boolean; feitas: Feita[] } | null>(null);
  const [concluindo, setConcluindo] = useState(false);
  const [confirmarSaida, setConfirmarSaida] = useState(false);
  const tentativas = useRef<Tentativa[]>([]);
  const finalizadas = useRef(new Set<string>()); // questões já terminadas (clique repetido não conta de novo)
  const inicioQ = useRef(Date.now());
  const resultadoRef = useRef<HTMLDivElement>(null);
  const sessao = useSessaoEstudo(() => ({ tipo: 'revisao', exame_id: dados.prefs.exame_id, recorte_id: null, assunto: null, unidade: null, questoes: null }), 'esta revisão');

  // Terminou a questão: o resultado aparece à vista (ele fica embaixo das dicas)
  useEffect(() => {
    if (resultado) resultadoRef.current?.scrollIntoView({ block: 'nearest', behavior: reduzirMovimento() ? 'auto' : 'smooth' });
  }, [resultado]);

  if (!questoes.length) {
    return (
      <div className="app"><main className="screen tela-centro">
        <Mascote largura={140} />
        {filtrada ? <>
          <h1 className="title">Nada para revisar aqui</h1>
          <p className="muted">Estas questões já foram revisadas ou saíram da lista. Veja o que ainda tem na sua revisão.</p>
          <Link to="/revisar" className="btn" replace>Ver a revisão</Link>
          <Link to="/inicio" className="linkbtn">Voltar ao início</Link>
        </> : guardados ? <>
          <h1 className="title">Nada vence hoje</h1>
          <p className="muted">Você tem {plural(guardados, 'erro guardado', 'erros guardados')}. Se quiser, adiante a revisão agora: é treino, sem XP.</p>
          <Link to="/refazer?todas=1" className="btn" replace>Adiantar revisão</Link>
          <Link to="/inicio" className="linkbtn">Voltar ao início</Link>
        </> : <>
          <h1 className="title">Nada para revisar agora</h1>
          <p className="muted">Quando você errar uma questão numa lição, ela aparece aqui.</p>
          <Link to="/inicio" className="btn">Voltar ao início</Link>
        </>}
      </main></div>
    );
  }

  const q = questoes[Math.min(i, questoes.length - 1)];
  const { item, vencida } = antes[q.id];
  const confirmar = vencida && item?.status === 'dominada'; // já recuperada antes; voltou para confirmar
  const terminou = resultado !== null;
  const xpAgora = xpDaRevisao(true, dicas, erradas.length > 0, vencida); // o que vale acertar agora
  const xpFeito = feitas[feitas.length - 1]?.xp ?? 0;
  const resolucaoLiberada = erradas.length > 0 || dicas >= 2;

  const estados: Record<string, EstadoAlt> = {};
  for (const a of q.alternativas) {
    if (erradas.includes(a.letra)) estados[a.letra] = 'riscada';
    else if (terminou) estados[a.letra] = a.letra === q.gabarito ? 'certa' : 'apagada';
    else estados[a.letra] = sel === a.letra ? 'sel' : 'neutra';
  }
  // Um rótulo só: a resposta da lição até o aluno tentar; depois, a tentativa dele (riscada); terminou, nenhum.
  const ultimaTentativa = erradas[erradas.length - 1];
  const rotulo = terminou ? undefined
    : ultimaTentativa ? { [ultimaTentativa]: 'sua tentativa' }
    : item?.ultima_letra ? { [item.ultima_letra]: 'sua resposta antes' } : undefined;

  function registrar(correta: boolean, letra: string | null, viu: boolean) {
    const t: Tentativa = { questao_id: q.id, letra, correta, dicas_usadas: dicas, viu_resolucao: viu, tempo_ms: Date.now() - inicioQ.current, origem: 'revisao' };
    tentativas.current.push(t);
    sessao.responder(t);
  }

  function abrirDica(n: number) {
    setDicas(n);
    sessao.abrirDica(q.id, n);
  }

  function finalizarQuestao(acertou: boolean) {
    if (finalizadas.current.has(q.id)) return;
    finalizadas.current.add(q.id);
    setResultado(acertou ? 'acertou' : 'falhou');
    setFeitas((f) => [...f, { acertou, xp: xpDaRevisao(acertou, dicas, erradas.length > 0, vencida), vencida }]);
    atualizar((d) => registrarRevisao(d, q.id, acertou, dicas, erradas.length > 0)); // na tela já; o servidor reagenda ao concluir
  }

  function verificar() {
    if (!sel || terminou || finalizadas.current.has(q.id)) return;
    if (tentativas.current.some((t) => t.questao_id === q.id && t.letra === sel)) return; // clique repetido
    const ok = sel === q.gabarito;
    registrar(ok, sel, false);
    tocar(ok ? 'acerto' : 'erro', dados.prefs.sons); vibrar(dados.prefs.vibracao, ok ? 20 : 60);
    if (ok) { finalizarQuestao(true); return; }
    const novas = [...erradas, sel];
    setErradas(novas); setSel(null);
    if (novas.length >= 2) finalizarQuestao(false);
  }

  function verResolucao() {
    if (finalizadas.current.has(q.id)) return;
    registrar(false, null, true);
    setDicas(3);
    finalizarQuestao(false);
  }

  /** Fecha a revisão com as questões tentadas até aqui (no fim ou ao sair no meio). */
  async function concluir() {
    if (concluindo) return;
    setConcluindo(true);
    // Saiu no meio de uma questão já tentada: o servidor a conta como não recuperada
    const meio = !finalizadas.current.has(q.id) && tentativas.current.some((t) => t.questao_id === q.id) ? [{ acertou: false, xp: 0, vencida }] : [];
    const resumo = await sessao.concluir(tentativas.current);
    tocar('fim', dados.prefs.sons);
    setFim({ xp: resumo?.xp ?? 0, vida: !!resumo?.vidaGanha, feitas: [...feitas, ...meio] });
  }

  function proxima() {
    if (i < questoes.length - 1) {
      setI(i + 1); setSel(null); setErradas([]); setDicas(0); setResultado(null); inicioQ.current = Date.now();
      return;
    }
    concluir();
  }

  function sair() {
    if (feitas.length) setConfirmarSaida(true);
    else nav(-1);
  }

  // Terminada a questão, as dicas e a resolução ficam todas abertas para leitura (sem mudar o XP).
  const passos = [0, 1, 2].map((k) => {
    const resol = k === 2;
    if (terminou) return { k, resol, aberto: true, podeAbrir: false, bloqueado: false };
    const aberto = !resol && dicas > k;
    const podeAbrir = resol ? resolucaoLiberada : dicas === k;
    return { k, resol, aberto, podeAbrir, bloqueado: !aberto && !podeAbrir };
  });

  if (fim) {
    const treinoSo = fim.feitas.every((f) => f.acertou && !f.vencida);
    const comemorar = fim.feitas.some((f) => f.acertou);
    return (
      <div className="app app-licao">
        <main className="screen tela-fim">
          <Mascote largura={160} humor={comemorar ? 'comemorando' : 'triste'} />
          <h1 className="title fs-30">{treinoSo ? 'Treino feito!' : 'Revisão feita!'}</h1>
          <p className="muted fs-15">{textoDoFim(fim.feitas)}</p>
          <div className={`${fim.vida ? 'grade-2' : 'grade-1'} largura-total`}>
            <div className="card soft-lav"><div className="big">+{fim.xp} XP</div><span className="small">na revisão</span></div>
            {fim.vida && <div className="card soft-coral"><div className="big">+1 vida</div><span className="small">a vida do dia</span></div>}
          </div>
          <div className="spacer" />
          <Link to="/revisar" className="btn" replace>Continuar</Link>
        </main>
      </div>
    );
  }

  const aviso = !vencida && vidaTreino ? 'Treino: esta questão ainda não venceu e não vale XP (ela volta amanhã, valendo). Mas acertando pelo menos 1, você recupera 1 vida.'
    : !vencida ? 'Treino: esta questão ainda não venceu. Acertar agora não vale XP, e ela volta amanhã, valendo.'
    : confirmar ? 'Você já recuperou esta questão: ela voltou para confirmar. A resposta só aparece depois que você tentar.'
    : 'Você errou esta questão antes. A resposta só aparece depois que você tentar.';
  const titulo = resultado === 'falhou' ? 'Essa volta amanhã'
    : !vencida ? 'Acertou! Era treino'
    : `${confirmar ? 'Confirmada' : 'Recuperada'}! +${xpFeito} XP`;
  const detalhe = resultado === 'falhou' ? 'Leia a resolução e siga em frente.'
    : !vencida ? 'Ela volta amanhã, valendo XP.'
    : dicas ? 'Recuperada com dica: volta em 3 dias para confirmar.'
    : erradas.length ? 'Acertou na 2ª tentativa: volta em 3 dias para confirmar.'
    : confirmar ? `Volta em ${PASSOS_DOMINADA[Math.min(item?.repeticoes ?? 0, 2)]} dias para confirmar de novo.`
    : 'Acertou de primeira e sem dica: ela sai da sua lista de erros.';

  return (
    <div className="app app-licao">
      <header className="row topo-licao">
        <button onClick={sair} aria-label="Sair da revisão" className="linkbtn botao-sair"><IcX /></button>
        <div className="spacer segmentos" style={{ gridTemplateColumns: `repeat(${questoes.length}, 1fr)` }} role="progressbar" aria-label="Progresso da revisão" aria-valuemin={0} aria-valuemax={questoes.length} aria-valuenow={feitas.length}>
          {questoes.map((_, k) => <span key={k} className="segmento" style={{ background: k < i ? (feitas[k]?.acertou ? 'var(--ok)' : 'var(--coral)') : k === i ? (terminou ? (resultado === 'acertou' ? 'var(--ok)' : 'var(--coral)') : '#A9DCD2') : 'var(--line)' }} />)}
        </div>
        <span className="pill pilula-lav pilula-revisao"><IcRevisar size={15} />{vencida ? 'Revisão' : 'Treino'}</span>
      </header>
      <main className="screen licao pb-130" tabIndex={0} aria-label="Questão">
        <h1 className="sr-only">{vencida ? 'Revisão' : 'Treino'}, questão {i + 1} de {questoes.length}</h1>
        <div className="row aviso-ambar">
          <IcRevisar size={20} color="var(--amber-ink)" />
          <span className="small">{aviso}</span>
        </div>
        <QuestaoView key={q.id} q={q} recorte={catalogo(conteudo).recorte(q.recorte_id)} nomeExame={catalogo(conteudo).exame(q.exame_id)?.nome ?? ''}
          textoBase={q.texto_base_id ? conteudo.textos_base[q.texto_base_id] : null} estados={estados} escolher={(l) => !terminou && setSel(l)} bloqueado={terminou} rotuloExtra={rotulo} />

        <section aria-label="Dicas" className="dicas">
          <div className="row dicas-topo">
            <span className="dicas-icone"><IcLampada color="#fff" size={18} /></span>
            {terminou
              ? <b className="h2 spacer fs-17 dicas-titulo">Dicas desta questão</b>
              : <>
                <span className="col spacer gap-0"><b className="h2 fs-17 dicas-titulo">Precisa de uma ajuda?</b><span className="small tinta-lav">{vencida ? 'Cada dica reduz o XP desta questão' : 'No treino, as dicas não tiram nada'}</span></span>
                {vencida && <span className="big fs-16 tinta-lav">+{xpAgora} XP</span>}
              </>}
          </div>
          {passos.map((p) => (
            <div key={p.k} className="col dica">
              <div className="row">
                <span aria-hidden="true" className={`dica-num${p.aberto ? ' aberta' : ''}${p.resol ? ' resol' : ''}`}>{p.resol ? '✓' : p.k + 1}</span>
                <span className={`spacer dica-nome${p.bloqueado ? ' bloqueada' : ''}`}>{p.resol ? 'Resolução' : `Dica ${p.k + 1}`}</span>
                {p.podeAbrir && <button className="btn lav sm baixo" onClick={() => (p.resol ? verResolucao() : abrirDica(p.k + 1))}>{p.resol ? 'Ver resolução' : 'Abrir'}</button>}
                {p.bloqueado && <span className="row muted gap-4 fs-12"><IcLock size={14} />{p.resol ? 'depois de tentar' : 'abra a anterior'}</span>}
              </div>
              {p.aberto && (
                <div className={`a-rise dica-texto${p.resol ? ' resol' : ''}`}>
                  <Texto md={p.resol ? q.explicacao : p.k === 0 ? q.dica1 : q.dica2} className="texto-questao small" />
                </div>
              )}
            </div>
          ))}
        </section>

        {terminou && (
          <div ref={resultadoRef} className={`row a-rise resultado-questao ${resultado === 'acertou' ? 'ok' : 'erro'}`} role="status">
            <Mascote largura={52} humor={resultado === 'acertou' ? 'comemorando' : 'triste'} flutuar={false} />
            <span className="col gap-2">
              <b className="h2 fs-18">{titulo}</b>
              <span className="small">{detalhe}</span>
            </span>
          </div>
        )}
      </main>
      <div className="footer-cta">
        {/* A região de aviso fica sempre montada: o leitor de tela só anuncia mudanças numa região que já existia */}
        <p className={!terminou && erradas.length === 1 ? 'small aviso-tentativa' : 'sr-only'} role="status">
          {!terminou && erradas.length === 1 ? `Resta 1 tentativa.${dicas < 2 ? ' Se quiser, abra uma dica.' : ''}` : ''}
        </p>
        {terminou
          ? <button className="btn" disabled={concluindo} onClick={proxima}>{concluindo ? 'Salvando…' : i === questoes.length - 1 ? 'Concluir revisão' : 'Próxima questão'}</button>
          : <button className="btn" disabled={!sel} onClick={verificar}>{erradas.length ? 'Tentar de novo' : 'Verificar'}</button>}
      </div>
      <Folha aberta={confirmarSaida} fechar={() => setConfirmarSaida(false)} titulo="Sair da revisão">
        <span className="title fs-24">Sair da revisão?</span>
        <p className="small">Você terminou {plural(feitas.length, 'questão', 'questões')} de {questoes.length}. Se sair agora, elas contam e as outras ficam para depois.</p>
        <button className="btn" onClick={() => setConfirmarSaida(false)}>Continuar a revisão</button>
        <button className="linkbtn" disabled={concluindo} onClick={() => { setConfirmarSaida(false); concluir(); }}>Sair e salvar o que fiz</button>
      </Folha>
    </div>
  );
}
