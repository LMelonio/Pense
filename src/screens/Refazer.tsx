// Refazer com dicas: Dica 1 → Dica 2 → Resolução (só depois de tentar). Duas tentativas por questão.
// No Supabase, as tentativas vão ao servidor, que reagenda a fila e calcula XP e a vida no fim.
import { useMemo, useRef, useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { repo } from '../lib/config';
import { plural } from '../lib/texto';
import { QuestaoView } from '../components/QuestaoView';
import type { EstadoAlt } from '../components/QuestaoView';
import { IcLampada, IcLock, IcRevisar, IcX, Mascote } from '../components/Icones';
import { Texto } from '../components/Texto';
import { Folha, tocar, vibrar } from '../components/Base';
import { XP_REVISAO, agendarErro, ajustarVidas, areasDoExame, hoje, novasConquistas, reagendar, revisaoPendente, revisaoVencida, somarXP } from '../domain/regras';
import type { ResumoSessao } from '../data/repo';
import type { Questao, Tentativa } from '../data/types';

const MAX_SESSAO = 10;

export default function Refazer() {
  const { dados, conteudo, atualizar, sincronizar, avisar } = useDados();
  const [params] = useSearchParams();
  const nav = useNavigate();
  const questoes = useMemo(() => {
    const ids = params.get('ids')?.split(',').filter(Boolean);
    const tema = params.get('tema');
    const recorte = params.get('recorte');
    let itens = params.get('todas') || ids ? revisaoPendente(dados) : revisaoVencida(dados);
    if (ids) itens = itens.filter((r) => ids.includes(r.questao_id));
    const qs = itens.map((r) => conteudo.questoes.find((q) => q.id === r.questao_id)).filter((q): q is Questao => !!q);
    return qs.filter((q) => (!tema || q.assunto === tema) && (!recorte || q.recorte_id === recorte)).slice(0, MAX_SESSAO);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const [i, setI] = useState(0);
  const [sel, setSel] = useState<string | null>(null);
  const [erradas, setErradas] = useState<string[]>([]);
  const [dicas, setDicas] = useState(0);
  const [resultado, setResultado] = useState<null | 'acertou' | 'falhou'>(null);
  const [res, setRes] = useState<number[]>([]); // XP por questão terminada
  const [fim, setFim] = useState<{ xp: number; recuperadas: number; total: number } | null>(null);
  const [concluindo, setConcluindo] = useState(false);
  const [confirmarSaida, setConfirmarSaida] = useState(false);
  const tentativas = useRef<Tentativa[]>([]);
  const finalizadas = useRef(new Set<string>()); // questões já terminadas (clique repetido não conta de novo)
  const sessaoRef = useRef<Promise<string> | null>(null);
  const filaRef = useRef<Promise<void>>(Promise.resolve());
  const falhou = useRef(false);
  const inicioQ = useRef(Date.now());

  if (!questoes.length) {
    return (
      <div className="app"><div className="screen" style={{ justifyContent: 'center', alignItems: 'center', textAlign: 'center' }}>
        <Mascote largura={140} /><h1 className="title">Nada para revisar agora</h1>
        <p className="muted">Quando você errar uma questão numa lição, ela aparece aqui.</p>
        <Link to="/inicio" className="btn">Voltar ao início</Link>
      </div></div>
    );
  }

  const q = questoes[Math.min(i, questoes.length - 1)];
  const item = dados.revisao[q.id];
  const terminou = resultado !== null;
  const xpAgora = resultado === 'falhou' ? 0 : XP_REVISAO[Math.min(2, dicas)];
  const resolucaoLiberada = erradas.length > 0 || dicas >= 2;

  const estados: Record<string, EstadoAlt> = {};
  for (const a of q.alternativas) {
    if (erradas.includes(a.letra)) estados[a.letra] = 'riscada';
    else if (terminou) estados[a.letra] = a.letra === q.gabarito ? 'certa' : 'apagada';
    else estados[a.letra] = sel === a.letra ? 'sel' : 'neutra';
  }
  const rotuloAntes = item?.ultima_letra && !erradas.includes(item.ultima_letra) && !terminou ? { [item.ultima_letra]: 'sua resposta antes' } : undefined;

  function sessao() {
    sessaoRef.current ??= repo.iniciarSessao({ tipo: 'revisao', exame_id: dados.prefs.exame_id, recorte_id: null, assunto: null, unidade: null })
      .catch((e) => { sessaoRef.current = null; throw e; });
    return sessaoRef.current;
  }

  function registrar(correta: boolean, letra: string | null, viu: boolean) {
    const t: Tentativa = { questao_id: q.id, letra, correta, dicas_usadas: dicas, viu_resolucao: viu, tempo_ms: Date.now() - inicioQ.current, origem: 'revisao' };
    tentativas.current.push(t);
    filaRef.current = filaRef.current.then(async () => { await repo.responder(await sessao(), t); }).catch(() => { falhou.current = true; });
  }

  function finalizarQuestao(acertou: boolean) {
    if (finalizadas.current.has(q.id)) return;
    finalizadas.current.add(q.id);
    setResultado(acertou ? 'acertou' : 'falhou');
    setRes((r) => [...r, acertou ? XP_REVISAO[Math.min(2, dicas)] : 0]);
    atualizar((d) => {
      const atual = d.revisao[q.id] ?? agendarErro(undefined, q.id, null);
      return { ...d, revisao: { ...d.revisao, [q.id]: reagendar(atual, acertou, dicas) } };
    }, { revisao: [q.id] });
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

  /** Fecha a revisão com as questões terminadas até aqui (no fim ou ao sair no meio). */
  async function concluir(xps: number[]) {
    if (concluindo) return;
    setConcluindo(true);
    const total = xps.length;
    const xp = xps.reduce((s, x) => s + x, 0);
    const recuperadas = xps.filter((x) => x > 0).length;
    const areas = areasDoExame(conteudo, dados.prefs.exame_id);
    let ganhas: string[] = [];
    await atualizar((d) => {
      let n = somarXP(d, xp);
      const perfil = recuperadas > 0 ? ajustarVidas(n.perfil, +1) : n.perfil; // recuperar ao menos uma devolve 1 vida
      n = { ...n, perfil: { ...perfil, revisoes_concluidas: n.perfil.revisoes_concluidas + 1, questoes_feitas: n.perfil.questoes_feitas + total, acertos_total: n.perfil.acertos_total + recuperadas } };
      ganhas = novasConquistas(n, areas);
      const agora = new Date().toISOString();
      return { ...n, conquistas: { ...n.conquistas, ...Object.fromEntries(ganhas.map((g) => [g, agora])) } };
    }, { perfil: true, xpDia: [hoje()] });
    if (ganhas.length) await atualizar((d) => d, { conquistas: ganhas }); // no modo demonstração grava as conquistas

    let resumo: ResumoSessao | null = null;
    try {
      await filaRef.current;
      if (falhou.current) for (const t of tentativas.current.filter((x) => x.letra)) await repo.responder(await sessao(), t);
      resumo = await repo.concluirSessao(await sessao());
    } catch (e) {
      avisar(`Não deu para salvar esta revisão. ${(e as Error).message}`);
    }
    sincronizar();
    tocar('fim', dados.prefs.sons);
    setFim({ xp: resumo?.xp ?? xp, recuperadas: resumo?.acertos ?? recuperadas, total: resumo?.total ?? total });
  }

  function proxima() {
    if (i < questoes.length - 1) {
      setI(i + 1); setSel(null); setErradas([]); setDicas(0); setResultado(null); inicioQ.current = Date.now();
      return;
    }
    concluir(res);
  }

  function sair() {
    if (res.length) setConfirmarSaida(true);
    else nav(-1);
  }

  const passos = [0, 1, 2].map((k) => {
    const resol = k === 2;
    const aberto = resol ? (terminou || dicas >= 3) && resultado !== null : dicas > k;
    const podeAbrir = !terminou && (resol ? resolucaoLiberada && !aberto : dicas === k);
    return { k, resol, aberto, podeAbrir, bloqueado: !aberto && !podeAbrir };
  });

  if (fim) {
    const { xp, recuperadas, total } = fim;
    const faltam = total - recuperadas;
    const texto = recuperadas === total
      ? (total === 1 ? 'Você recuperou a questão!' : `Você recuperou as ${total} questões!`)
      : recuperadas === 0
        ? (total === 1 ? 'Essa ainda não foi. Ela volta amanhã.' : 'Essas ainda não foram. Elas voltam amanhã.')
        : `Você recuperou ${recuperadas} de ${plural(total, 'questão', 'questões')}. ${faltam === 1 ? 'A outra volta amanhã.' : 'As outras voltam amanhã.'}`;
    return (
      <div className="app" style={{ background: 'var(--bg-licao)' }}>
        <div className="screen" style={{ alignItems: 'center', textAlign: 'center', paddingTop: 40 }}>
          <Mascote largura={160} humor={recuperadas ? 'comemorando' : 'triste'} />
          <h1 className="title" style={{ fontSize: 30 }}>Revisão feita!</h1>
          <p className="muted" style={{ fontSize: 15 }}>{texto}</p>
          <div style={{ display: 'grid', gridTemplateColumns: recuperadas ? '1fr 1fr' : '1fr', gap: 8, width: '100%' }}>
            <div className="card soft-lav"><div className="big">+{xp} XP</div><span className="small">na revisão</span></div>
            {recuperadas > 0 && <div className="card" style={{ background: 'var(--coral-soft)', borderColor: 'transparent', color: 'var(--coral-text)' }}><div className="big">+1 vida</div><span className="small">por recuperar</span></div>}
          </div>
          <div className="spacer" />
          <Link to="/revisar" className="btn" replace>Continuar</Link>
        </div>
      </div>
    );
  }

  return (
    <div className="app" style={{ background: 'var(--bg-licao)' }}>
      <header className="row" style={{ padding: '16px 18px 8px', gap: 12 }}>
        <button onClick={sair} aria-label="Sair da revisão" className="linkbtn" style={{ color: 'var(--icon)', padding: 8 }}><IcX /></button>
        <div className="spacer" style={{ display: 'grid', gridTemplateColumns: `repeat(${questoes.length}, 1fr)`, gap: 4 }} role="progressbar" aria-label="Progresso da revisão" aria-valuemin={0} aria-valuemax={questoes.length} aria-valuenow={res.length}>
          {questoes.map((_, k) => <span key={k} style={{ height: 12, borderRadius: 99, background: k < i ? (res[k] ? 'var(--ok)' : 'var(--coral)') : k === i ? (terminou ? (resultado === 'acertou' ? 'var(--ok)' : 'var(--coral)') : '#A9DCD2') : 'var(--line)' }} />)}
        </div>
        <span className="pill" style={{ background: 'var(--lav-soft)', color: 'var(--lav-dark)', height: 32, gap: 5 }}><IcRevisar size={15} />Revisão</span>
      </header>
      <div className="screen licao" style={{ paddingBottom: 130 }}>
        <div className="row" style={{ background: 'var(--amber-soft)', color: 'var(--amber-text)', borderRadius: 14, padding: '10px 12px', gap: 10 }}>
          <IcRevisar size={20} color="#B8781A" />
          <span className="small">Você errou esta questão antes. A resposta só aparece depois que você tentar.</span>
        </div>
        <QuestaoView key={q.id} q={q} recorte={conteudo.recortes.find((r) => r.id === q.recorte_id)} nomeExame={conteudo.exames.find((e) => e.id === q.exame_id)?.nome ?? ''}
          textoBase={q.texto_base_id ? conteudo.textos_base[q.texto_base_id] : null} estados={estados} escolher={(l) => !terminou && setSel(l)} bloqueado={terminou} rotuloExtra={rotuloAntes} />

        <section aria-label="Dicas" style={{ background: 'var(--card)', border: '2px solid #C9C2F7', borderRadius: 22, overflow: 'hidden' }}>
          <div className="row" style={{ padding: '12px 14px', background: 'var(--lav-soft)', gap: 10 }}>
            <span style={{ width: 34, height: 34, borderRadius: 11, background: 'var(--lav)', display: 'grid', placeItems: 'center' }}><IcLampada color="#fff" size={18} /></span>
            <span className="col spacer" style={{ gap: 0 }}><b className="h2" style={{ fontSize: 17, color: 'var(--lav-text)' }}>Precisa de uma ajuda?</b><span className="small" style={{ color: 'var(--lav-dark)' }}>Cada dica reduz o XP desta questão</span></span>
            <span className="big" style={{ fontSize: 16, color: 'var(--lav-dark)' }}>+{xpAgora} XP</span>
          </div>
          {passos.map((p) => (
            <div key={p.k} style={{ padding: '10px 14px', borderTop: p.k ? '1.5px solid var(--lav-soft)' : 0 }} className="col">
              <div className="row">
                <span aria-hidden="true" style={{ width: 26, height: 26, borderRadius: '50%', display: 'grid', placeItems: 'center', fontFamily: 'var(--font-title)', fontWeight: 600, fontSize: 13, background: p.aberto ? (p.resol ? 'var(--ok)' : 'var(--lav)') : 'var(--lav-soft)', color: p.aberto ? '#fff' : '#7C73C9' }}>{p.resol ? '✓' : p.k + 1}</span>
                <span className="spacer" style={{ fontWeight: 600, fontSize: 14, color: p.bloqueado ? 'var(--text3)' : 'var(--text)' }}>{p.resol ? 'Resolução' : `Dica ${p.k + 1}`}</span>
                {p.podeAbrir && <button className="btn lav sm" style={{ height: 34 }} onClick={() => (p.resol ? verResolucao() : setDicas(p.k + 1))}>{p.resol ? 'Ver resolução' : 'Abrir'}</button>}
                {p.bloqueado && <span className="row muted" style={{ gap: 4, fontSize: 12 }}><IcLock size={14} />{p.resol ? 'depois de tentar' : 'abra a anterior'}</span>}
              </div>
              {p.aberto && (
                <div className="a-rise" style={{ marginLeft: 36, borderRadius: 12, padding: '10px 12px', background: p.resol ? 'var(--ok-soft)' : 'var(--lav-soft)', color: p.resol ? 'var(--ok-text)' : 'var(--lav-text)' }}>
                  <Texto md={p.resol ? q.explicacao : p.k === 0 ? q.dica1 : q.dica2} className="texto-questao small" />
                </div>
              )}
            </div>
          ))}
        </section>

        {terminou && (
          <div className="row a-rise" role="status" style={{ gap: 12, borderRadius: 18, padding: '12px 14px', background: resultado === 'acertou' ? 'var(--ok-soft)' : 'var(--coral-soft)', color: resultado === 'acertou' ? 'var(--ok-text)' : 'var(--coral-text)' }}>
            <Mascote largura={52} humor={resultado === 'acertou' ? 'comemorando' : 'triste'} flutuar={false} />
            <span className="col" style={{ gap: 2 }}>
              <b className="h2" style={{ fontSize: 18 }}>{resultado === 'acertou' ? `Recuperada! +${XP_REVISAO[Math.min(2, dicas)]} XP` : 'Essa volta amanhã'}</b>
              <span className="small">{resultado === 'acertou' ? (dicas ? 'Volta em 3 dias para confirmar.' : 'Ela sai da sua lista de erros.') : 'Leia a resolução e siga em frente.'}</span>
            </span>
          </div>
        )}
      </div>
      <div className="footer-cta">
        {terminou
          ? <button className="btn" disabled={concluindo} onClick={proxima}>{concluindo ? 'Salvando…' : i === questoes.length - 1 ? 'Concluir revisão' : 'Próxima questão'}</button>
          : <button className="btn" disabled={!sel} onClick={verificar}>{erradas.length ? 'Tentar de novo' : 'Verificar'}</button>}
      </div>
      <Folha aberta={confirmarSaida} fechar={() => setConfirmarSaida(false)} titulo="Sair da revisão">
        <span className="title" style={{ fontSize: 24 }}>Sair da revisão?</span>
        <p className="small">Você terminou {plural(res.length, 'questão', 'questões')} de {questoes.length}. Se sair agora, elas contam e as outras ficam para depois.</p>
        <button className="btn" onClick={() => setConfirmarSaida(false)}>Continuar a revisão</button>
        <button className="linkbtn" disabled={concluindo} onClick={() => { setConfirmarSaida(false); concluir(res); }}>Sair e salvar o que fiz</button>
      </Folha>
    </div>
  );
}
