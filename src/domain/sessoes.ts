// Sessões de estudo com as mesmas contas do banco (responder e concluir_sessao, migrations 0006, 0007, 0009 e 0010).
// Funções puras: recebem os dados do aluno e devolvem os dados novos (e o resumo, ao fechar).
// - registrarErro e registrarRevisao: a reação imediata da tela a cada questão, até o servidor confirmar.
// - fecharLicao e fecharRevisao: o "concluir_sessao" do modo demonstração (demoRepo). No Supabase, quem fecha é o banco.
import type { Conteudo, DadosAluno, Questao, ResumoSessao, Tentativa } from '../data/types';
import {
  BONUS_PERFEITA, DESAFIO_MINIMO, VIDAS_MAX, agendarErro, ajustarVidas, areasDoExame, atualizarTema, chaveTema, chaveUnidade, hoje,
  novasConquistas, reagendar, somarXP, venceu, vidasAgora, xpDaRevisao, xpDoAcerto
} from './regras';

export interface Fechamento { dados: DadosAluno; resumo: ResumoSessao }

const resumoVazio = (): ResumoSessao => ({ acertos: 0, total: 0, xp: 0, perfeita: false, aprovado: null, conquistas: [], coroaAntes: 0, coroaDepois: 0, vidaGanha: false });

function comConquistas(d: DadosAluno, ganhas: string[], agora: number): DadosAluno {
  const quando = new Date(agora).toISOString();
  return { ...d, conquistas: { ...d.conquistas, ...Object.fromEntries(ganhas.map((g) => [g, quando])) } };
}

/** Errou numa lição ou desafio: a questão vai para a revisão de amanhã; na lição também gasta 1 vida. */
export function registrarErro(d: DadosAluno, questao_id: string, letra: string | null, gastaVida: boolean, agora = Date.now()): DadosAluno {
  return {
    ...d,
    perfil: gastaVida ? ajustarVidas(d.perfil, -1, agora) : d.perfil,
    revisao: { ...d.revisao, [questao_id]: agendarErro(d.revisao[questao_id], questao_id, letra, agora) }
  };
}

/** Respondeu numa lição ou desafio: a questão passa a ser vista na hora (o banco lê as vistas das tentativas). */
export function marcarVista(d: DadosAluno, questao_id: string): DadosAluno {
  return d.vistas.includes(questao_id) ? d : { ...d, vistas: [...d.vistas, questao_id] };
}

/** Terminou uma questão no Refazer: reagenda conforme acerto, dicas, 2ª tentativa e se ela já tinha vencido
 * (adiantada é treino). */
export function registrarRevisao(d: DadosAluno, questao_id: string, acertou: boolean, dicas: number, segundaTentativa: boolean, agora = Date.now()): DadosAluno {
  const atual = d.revisao[questao_id] ?? agendarErro(undefined, questao_id, null, agora);
  return { ...d, revisao: { ...d.revisao, [questao_id]: reagendar(atual, acertou, dicas, segundaTentativa, agora) } };
}

export interface EntradaLicao {
  tipo: 'licao' | 'desafio';
  exame_id: string;
  recorte_id: string;
  /** Tema da lição ('' no desafio, que mistura os temas da unidade). */
  assunto: string;
  unidade: number;
  /** Questões da sessão (o tema de cada resposta e, no desafio, quantas precisavam ser respondidas). */
  questoes: Questao[];
  tentativas: Tentativa[];
}

/** Fecha uma lição ou desafio: XP (com bônus de lição perfeita), domínio e coroa por tema, unidade, contadores e conquistas. */
export function fecharLicao(d: DadosAluno, c: Conteudo, e: EntradaLicao, agora = Date.now()): Fechamento {
  const k = chaveTema(e.recorte_id, e.assunto);
  const coroaAntes = d.temas[k]?.coroa ?? 0;
  const { tentativas: todas } = e;
  if (!todas.length) return { dados: d, resumo: resumoVazio() };

  const assuntoDe = new Map(e.questoes.map((q) => [q.id, q.assunto]));
  const acertos = todas.filter((t) => t.correta).length;
  const total = todas.length;
  const perfeita = e.tipo === 'licao' && total >= 3 && acertos === total;
  const xp = todas.reduce((s, t) => s + (t.correta ? xpDoAcerto(d, t.questao_id) : 0), 0) + (perfeita ? BONUS_PERFEITA : 0);
  // O desafio só vale com todas as questões respondidas (o banco confere o mesmo)
  const aprovado = e.tipo === 'desafio' ? total === e.questoes.length && acertos / total >= DESAFIO_MINIMO : null;

  let n = somarXP(d, xp, agora);
  const temas = { ...n.temas };
  for (const nomeTema of new Set(todas.map((t) => assuntoDe.get(t.questao_id) ?? e.assunto))) {
    const kk = chaveTema(e.recorte_id, nomeTema);
    const resp = todas.filter((t) => (assuntoDe.get(t.questao_id) ?? e.assunto) === nomeTema).map((t) => t.correta);
    temas[kk] = atualizarTema(temas[kk], e.recorte_id, nomeTema, resp, perfeita && nomeTema === e.assunto, agora);
  }
  n = {
    ...n, temas,
    vistas: [...new Set([...n.vistas, ...todas.map((t) => t.questao_id)])],
    acertadas: [...new Set([...n.acertadas, ...todas.filter((t) => t.correta).map((t) => t.questao_id)])],
    perfil: { ...n.perfil, questoes_feitas: n.perfil.questoes_feitas + total, acertos_total: n.perfil.acertos_total + acertos },
    unidades: aprovado ? { ...n.unidades, [chaveUnidade(e.recorte_id, e.unidade)]: true } : n.unidades
  };
  const ganhas = novasConquistas(n, areasDoExame(c, e.exame_id), { perfeita });
  n = comConquistas(n, ganhas, agora);
  return { dados: n, resumo: { acertos, total, xp, perfeita, aprovado, conquistas: ganhas, coroaAntes, coroaDepois: n.temas[k]?.coroa ?? coroaAntes, vidaGanha: false } };
}

export interface QuestaoRevisada { questao_id: string; acertou: boolean; dicas: number; segundaTentativa: boolean }

/** Uma linha por questão, como o banco agrupa as tentativas da revisão: recuperada se alguma tentativa acertou;
 * as dicas que contam são as da tentativa certa; acertou na 2ª tentativa se antes errou uma letra. */
export function questoesDaRevisao(tentativas: Tentativa[]): QuestaoRevisada[] {
  const porQuestao = new Map<string, QuestaoRevisada>();
  for (const t of tentativas) {
    const q = porQuestao.get(t.questao_id) ?? { questao_id: t.questao_id, acertou: false, dicas: 0, segundaTentativa: false };
    if (t.correta) { q.acertou = true; q.dicas = Math.max(q.dicas, t.dicas_usadas); }
    else if (t.letra) q.segundaTentativa = true;
    porQuestao.set(t.questao_id, q);
  }
  return [...porQuestao.values()].map((q) => ({ ...q, segundaTentativa: q.acertou && q.segundaTentativa }));
}

/** Fecha uma revisão: reagenda cada questão e soma o XP (só das que já tinham vencido; as adiantadas são treino).
 * Recuperar pelo menos uma vencida devolve 1 vida, uma vez por dia e só se faltar vida. Exceção (vidaPeloTreino): sem
 * vidas e sem nunca ter ganho a vida da revisão, acertar pelo menos 1 no treino também devolve. */
export function fecharRevisao(d: DadosAluno, c: Conteudo, exame_id: string, tentativas: Tentativa[], agora = Date.now()): Fechamento {
  const questoes = questoesDaRevisao(tentativas);
  const total = questoes.length;
  if (!total) return { dados: d, resumo: resumoVazio() };
  const revisao = { ...d.revisao };
  let xp = 0, acertos = 0, recuperadas = 0;
  for (const q of questoes) {
    const item = revisao[q.questao_id];
    const vencida = !!item && venceu(item, agora);
    if (q.acertou) acertos++;
    if (q.acertou && vencida) recuperadas++;
    xp += xpDaRevisao(q.acertou, q.dicas, q.segundaTentativa, vencida);
    if (item) revisao[q.questao_id] = reagendar(item, q.acertou, q.dicas, q.segundaTentativa, agora);
  }
  let n = somarXP({ ...d, revisao }, xp, agora);
  const dia = hoje(agora);
  const vidas = vidasAgora(n.perfil, agora).vidas;
  const primeiraVida = n.perfil.dia_vida_revisao === null && vidas === 0 && acertos > 0;
  const vidaGanha = (recuperadas > 0 || primeiraVida) && n.perfil.dia_vida_revisao !== dia && vidas < VIDAS_MAX;
  const perfil = vidaGanha ? { ...ajustarVidas(n.perfil, +1, agora), dia_vida_revisao: dia } : n.perfil;
  n = {
    ...n,
    perfil: { ...perfil, revisoes_concluidas: perfil.revisoes_concluidas + 1, questoes_feitas: perfil.questoes_feitas + total, acertos_total: perfil.acertos_total + acertos },
    acertadas: [...new Set([...n.acertadas, ...questoes.filter((q) => q.acertou).map((q) => q.questao_id)])]
  };
  const ganhas = novasConquistas(n, areasDoExame(c, exame_id));
  n = comConquistas(n, ganhas, agora);
  return { dados: n, resumo: { ...resumoVazio(), acertos, total, xp, perfeita: acertos === total, conquistas: ganhas, vidaGanha } };
}
