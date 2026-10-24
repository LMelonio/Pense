// Regras de jogo do Pense (valores do protótipo; ajuste aqui).
import type { DadosAluno, ItemRevisao, Perfil, ProgressoTema, Questao, Conteudo } from '../data/types';

export const XP_ACERTO = 10;
export const XP_REPETIDA = 5; // questão que o aluno já tinha acertado antes
export const BONUS_PERFEITA = 5;
export const XP_REVISAO = [5, 4, 3]; // sem dica, 1 dica, 2 dicas
export const VIDAS_MAX = 3;
export const MINUTOS_POR_VIDA = 30;
export const QUESTOES_POR_LICAO = 5;
export const TEMAS_POR_UNIDADE = 6;
export const DESAFIO_QTD = 10;
export const DESAFIO_MINIMO = 0.7;

export const METAS = [
  { xp: 10, nome: 'Leve', min: 3 },
  { xp: 20, nome: 'Regular', min: 6 },
  { xp: 30, nome: 'Firme', min: 10 },
  { xp: 50, nome: 'Intensa', min: 15 }
];

const NIVEIS = [0, 50, 150, 300, 500, 750, 1050, 1500, 2000, 2600, 3300, 4100, 5000, 6000, 7200, 8500, 10000];
const NOMES_NIVEL = ['Iniciante', 'Aprendiz', 'Atenta', 'Persistente', 'Focada', 'Estudiosa', 'Curiosa', 'Exploradora', 'Determinada', 'Brilhante', 'Mestre', 'Sábia', 'Lenda'];

export function nivel(xp: number) {
  let n = 1;
  for (let i = 0; i < NIVEIS.length; i++) if (xp >= NIVEIS[i]) n = i + 1;
  const base = NIVEIS[n - 1] ?? 0;
  const prox = NIVEIS[n] ?? base + 2000;
  return { nivel: n, nome: NOMES_NIVEL[Math.min(n - 1, NOMES_NIVEL.length - 1)], base, prox, pct: Math.min(100, ((xp - base) / (prox - base)) * 100) };
}

export const hoje = (d = new Date()) => d.toLocaleDateString('en-CA'); // AAAA-MM-DD no fuso local
export const ontem = () => hoje(new Date(Date.now() - 86400000));
export const chaveTema = (recorte_id: string, assunto: string) => `${recorte_id}|${assunto}`;

/** Vidas atuais, contando a recuperação com o tempo. */
export function vidasAgora(p: Perfil, agora = Date.now()) {
  if (p.vidas >= VIDAS_MAX) return { vidas: VIDAS_MAX, proximaEmMin: 0 };
  const desde = new Date(p.vidas_atualizadas_em).getTime();
  const ganhas = Math.floor((agora - desde) / (MINUTOS_POR_VIDA * 60000));
  const vidas = Math.min(VIDAS_MAX, p.vidas + Math.max(0, ganhas));
  const resto = MINUTOS_POR_VIDA - Math.floor(((agora - desde) / 60000) % MINUTOS_POR_VIDA);
  return { vidas, proximaEmMin: vidas >= VIDAS_MAX ? 0 : resto };
}

/** Grava a recuperação de vidas no perfil e aplica um delta (+1, -1). */
export function ajustarVidas(p: Perfil, delta: number): Perfil {
  const { vidas } = vidasAgora(p);
  const nova = Math.max(0, Math.min(VIDAS_MAX, vidas + delta));
  const agora = Date.now();
  let marco = p.vidas_atualizadas_em;
  if (vidas >= VIDAS_MAX || nova >= VIDAS_MAX) marco = new Date(agora).toISOString();
  else if (vidas !== p.vidas) {
    const desde = new Date(p.vidas_atualizadas_em).getTime();
    const ganhas = vidas - p.vidas;
    marco = new Date(desde + ganhas * MINUTOS_POR_VIDA * 60000).toISOString();
  }
  return { ...p, vidas: nova, vidas_atualizadas_em: marco };
}

/** Sequência mostrada hoje (zera se passou um dia sem bater a meta). */
export function sequenciaAtual(p: Perfil) {
  if (!p.ultimo_dia_meta) return 0;
  return p.ultimo_dia_meta === hoje() || p.ultimo_dia_meta === ontem() ? p.sequencia_atual : 0;
}

/** Soma XP no dia e atualiza a sequência quando a meta é batida. */
export function somarXP(d: DadosAluno, xp: number): DadosAluno {
  const dia = hoje();
  const antes = d.xpDia[dia] ?? 0;
  const depois = antes + xp;
  let perfil: Perfil = { ...d.perfil, xp_total: d.perfil.xp_total + xp };
  if (antes < d.prefs.meta_xp && depois >= d.prefs.meta_xp && perfil.ultimo_dia_meta !== dia) {
    const seq = perfil.ultimo_dia_meta === ontem() ? perfil.sequencia_atual + 1 : 1;
    perfil = { ...perfil, sequencia_atual: seq, sequencia_recorde: Math.max(seq, perfil.sequencia_recorde), ultimo_dia_meta: dia };
  }
  return { ...d, perfil, xpDia: { ...d.xpDia, [dia]: depois } };
}

export function dominioDe(hist: boolean[]) {
  if (!hist.length) return 0;
  return Math.round((hist.filter(Boolean).length / hist.length) * 100);
}

/** Coroa: 0 Novo, 1 Bronze (1ª lição com algum acerto), 2 Prata (≥60%), 3 Ouro (≥85% com 8+ respostas). */
export function coroaCalculada(t: ProgressoTema) {
  if (t.licoes === 0 || t.dominio === 0) return 0;
  if (t.dominio >= 85 && t.historico.length >= 8) return 3;
  if (t.dominio >= 60 && t.historico.length >= 5) return 2;
  return 1;
}

export function atualizarTema(t: ProgressoTema | undefined, recorte_id: string, assunto: string, respostas: boolean[], perfeita: boolean): ProgressoTema {
  const base: ProgressoTema = t ?? { recorte_id, assunto, dominio: 0, coroa: 0, licoes: 0, historico: [], ultima_pratica: null };
  const historico = [...base.historico, ...respostas].slice(-10);
  const novo: ProgressoTema = { ...base, historico, dominio: dominioDe(historico), licoes: base.licoes + 1, ultima_pratica: new Date().toISOString() };
  let coroa = Math.max(base.coroa, coroaCalculada(novo));
  if (perfeita) coroa = Math.max(coroa, Math.min(3, base.coroa + 1));
  return { ...novo, coroa };
}

export const NOMES_COROA = ['Novo', 'Bronze', 'Prata', 'Ouro'];

const DIA = 86400000;
const amanha = () => { const d = new Date(); d.setHours(0, 0, 0, 0); return new Date(d.getTime() + DIA).toISOString(); };

/** Errou na lição: entra na revisão de amanhã. */
export function agendarErro(item: ItemRevisao | undefined, questao_id: string, letra: string | null): ItemRevisao {
  return { questao_id, vence_em: amanha(), repeticoes: item?.repeticoes ?? 0, lapsos: (item?.lapsos ?? 0) + (item ? 1 : 0), status: 'pendente', ultima_letra: letra };
}

/** Resultado no Refazer: sem dica → dominada (volta em 7, 21, 60 dias); com dica → 3 dias; errou → amanhã. */
export function reagendar(item: ItemRevisao, acertou: boolean, dicas: number): ItemRevisao {
  if (!acertou) return { ...item, vence_em: amanha(), lapsos: item.lapsos + 1, status: 'pendente' };
  if (dicas > 0) return { ...item, vence_em: new Date(Date.now() + 3 * DIA).toISOString(), repeticoes: item.repeticoes + 1, status: 'pendente' };
  const passos = [7, 21, 60];
  const dias = passos[Math.min(item.repeticoes, passos.length - 1)];
  return { ...item, vence_em: new Date(Date.now() + dias * DIA).toISOString(), repeticoes: item.repeticoes + 1, status: 'dominada' };
}

export function revisaoVencida(d: DadosAluno) {
  const agora = Date.now();
  return Object.values(d.revisao).filter((r) => r.status === 'pendente' && new Date(r.vence_em).getTime() <= agora);
}
export function revisaoPendente(d: DadosAluno) {
  return Object.values(d.revisao).filter((r) => r.status === 'pendente');
}

// ---------- Conteúdo: temas, lições, trilha

export interface InfoTema { recorte_id: string; assunto: string; total: number }

export function questoesDoExame(c: Conteudo, exame_id: string, lingua: string) {
  return c.questoes.filter((q) => q.exame_id === exame_id && (!q.lingua || q.lingua === lingua));
}

/** Matérias do exame que têm questões na língua escolhida (Inglês ou Espanhol, conforme a preferência). */
export function recortesVisiveis(c: Conteudo, exame_id: string, lingua: string) {
  const comQuestoes = new Set(questoesDoExame(c, exame_id, lingua).map((q) => q.recorte_id));
  return c.recortes.filter((r) => r.exame_id === exame_id && comQuestoes.has(r.id)).sort((a, b) => a.ordem - b.ordem);
}

/** Áreas do exame (Linguagens, Humanas…) e a área de cada matéria, para a conquista "Todas as áreas". */
export function areasDoExame(c: Conteudo, exame_id: string) {
  const areaDe: Record<string, string> = {};
  for (const r of c.recortes) if (r.exame_id === exame_id) areaDe[r.id] = r.area ?? r.id;
  return { total: new Set(Object.values(areaDe)).size, areaDe };
}
export type Areas = ReturnType<typeof areasDoExame>;

/** Subconteúdos da matéria, do que tem mais questões para o que tem menos. O empate vai pela ordem dos caracteres
 * (não pela do idioma do aparelho), a mesma do banco ao conferir o desafio (_temas_da_unidade, migration 0007). */
export function temasDoRecorte(c: Conteudo, recorte_id: string, lingua: string): InfoTema[] {
  const cont = new Map<string, number>();
  for (const q of c.questoes) if (q.recorte_id === recorte_id && (!q.lingua || q.lingua === lingua)) cont.set(q.assunto, (cont.get(q.assunto) ?? 0) + 1);
  return [...cont.entries()].map(([assunto, total]) => ({ recorte_id, assunto, total }))
    .sort((a, b) => b.total - a.total || (a.assunto < b.assunto ? -1 : a.assunto > b.assunto ? 1 : 0));
}

function embaralhar<T>(xs: T[]) {
  const a = [...xs];
  for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; }
  return a;
}

/** Monta uma lição: prioriza questões ainda não vistas. Subconteúdo com poucas questões é completado com outros da mesma matéria. */
export function montarLicao(c: Conteudo, d: DadosAluno, recorte_id: string, assunto: string, n = QUESTOES_POR_LICAO): Questao[] {
  const vistas = new Set(d.vistas);
  const ordenar = (qs: Questao[]) => [...embaralhar(qs.filter((q) => !vistas.has(q.id))), ...embaralhar(qs.filter((q) => vistas.has(q.id)))];
  const daMateria = c.questoes.filter((q) => q.recorte_id === recorte_id && (!q.lingua || q.lingua === d.prefs.lingua));
  const doTema = ordenar(daMateria.filter((q) => q.assunto === assunto));
  const outras = doTema.length < n ? ordenar(daMateria.filter((q) => q.assunto !== assunto)) : [];
  return [...doTema, ...outras].slice(0, n);
}

/** XP de um acerto: menos XP para questão que o aluno já tinha acertado (o servidor aplica a mesma regra). */
export const xpDoAcerto = (d: DadosAluno, questao_id: string) => (d.acertadas.includes(questao_id) ? XP_REPETIDA : XP_ACERTO);

export function unidadesDoRecorte(c: Conteudo, recorte_id: string, lingua: string) {
  const temas = temasDoRecorte(c, recorte_id, lingua);
  const unidades: InfoTema[][] = [];
  for (let i = 0; i < temas.length; i += TEMAS_POR_UNIDADE) unidades.push(temas.slice(i, i + TEMAS_POR_UNIDADE));
  return unidades;
}

/** Tema feito na trilha: já tem coroa (pelo menos um acerto). */
export const temaFeito = (d: DadosAluno, t: InfoTema) => (d.temas[chaveTema(t.recorte_id, t.assunto)]?.coroa ?? 0) >= 1;

/** Desafio da unidade liberado: desafio da unidade anterior vencido e todos os temas desta feitos. */
export function desafioLiberado(d: DadosAluno, unidades: InfoTema[][], recorte_id: string, idx: number) {
  const un = unidades[idx];
  if (!un?.length) return false;
  return (idx === 0 || !!d.unidades[`${recorte_id}|${idx - 1}`]) && un.every((t) => temaFeito(d, t));
}

export function montarDesafio(c: Conteudo, d: DadosAluno, temas: InfoTema[]) {
  const nomes = new Set(temas.map((t) => t.assunto));
  const recorte = temas[0]?.recorte_id;
  const pool = c.questoes.filter((q) => q.recorte_id === recorte && nomes.has(q.assunto) && (!q.lingua || q.lingua === d.prefs.lingua));
  return embaralhar(pool).slice(0, DESAFIO_QTD);
}

// ---------- Conquistas

export const CONQUISTAS = [
  { codigo: 'primeiro_passo', nome: 'Primeiro passo', descricao: 'Concluiu a primeira lição.', icone: 'seed', cor: '#3FA37A', meta: 1 },
  { codigo: 'sete_dias', nome: '7 dias seguidos', descricao: 'Bateu a meta 7 dias seguidos.', icone: 'flame', cor: '#F2A93B', meta: 7 },
  { codigo: 'licao_perfeita', nome: 'Lição perfeita', descricao: 'Terminou uma lição sem errar.', icone: 'star', cor: '#6A5AE0', meta: 1 },
  { codigo: 'revisao_em_dia', nome: 'Revisão em dia', descricao: 'Concluiu 5 revisões.', icone: 'refresh', cor: '#4C7BD9', meta: 5 },
  { codigo: 'trezentas', nome: '300 questões', descricao: 'Respondeu 300 questões.', icone: 'target', cor: '#E07A4F', meta: 300 },
  { codigo: 'dez_ouros', nome: '10 coroas de Ouro', descricao: 'Levou 10 temas até o Ouro.', icone: 'crown', cor: '#D8A93B', meta: 10 },
  { codigo: 'quatro_areas', nome: 'Todas as áreas', descricao: 'Praticou todas as áreas do seu exame.', icone: 'book', cor: '#3FA37A', meta: 4 },
  { codigo: 'trinta_dias', nome: '30 dias seguidos', descricao: 'Bateu a meta 30 dias seguidos.', icone: 'calendar', cor: '#F2A93B', meta: 30 }
] as const;

export function progressoConquista(codigo: string, d: DadosAluno, areas: Areas) {
  const temas = Object.values(d.temas);
  switch (codigo) {
    case 'primeiro_passo': return temas.reduce((s, t) => s + t.licoes, 0);
    case 'sete_dias':
    case 'trinta_dias': return d.perfil.sequencia_recorde;
    case 'licao_perfeita': return d.conquistas.licao_perfeita ? 1 : 0;
    case 'revisao_em_dia': return d.perfil.revisoes_concluidas;
    case 'trezentas': return d.perfil.questoes_feitas;
    case 'dez_ouros': return temas.filter((t) => t.coroa === 3).length;
    case 'quatro_areas': return Math.min(areas.total, new Set(temas.map((t) => areas.areaDe[t.recorte_id]).filter(Boolean)).size);
    default: return 0;
  }
}

export function novasConquistas(d: DadosAluno, areas: Areas, extra: { perfeita?: boolean } = {}) {
  const ganhas: string[] = [];
  for (const c of CONQUISTAS) {
    if (d.conquistas[c.codigo]) continue;
    const meta = c.codigo === 'quatro_areas' ? areas.total : c.meta;
    const ok = c.codigo === 'licao_perfeita' ? !!extra.perfeita : progressoConquista(c.codigo, d, areas) >= meta;
    if (ok) ganhas.push(c.codigo);
  }
  return ganhas;
}
