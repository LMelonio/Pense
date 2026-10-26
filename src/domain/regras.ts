// Regras de jogo do Pense (valores do protótipo; ajuste aqui).
// O banco tem as mesmas regras (supabase/migrations): mude os dois juntos, com uma migration nova.
// As funções que dependem da hora recebem `agora` (padrão: Date.now()), para os testes controlarem o relógio.
import type { DadosAluno, ItemRevisao, Perfil, ProgressoTema, Questao, Conteudo, Recorte } from '../data/types';

export const XP_ACERTO = 10;
export const XP_REPETIDA = 5; // questão que o aluno já tinha acertado antes
export const BONUS_PERFEITA = 5;
export const XP_REVISAO = [5, 4, 3]; // sem dica, 1 dica, 2 dicas
export const VIDAS_MAX = 3;
export const MINUTOS_POR_VIDA = 120; // o banco usa o mesmo valor (_vidas_agora, migration 0008)
export const QUESTOES_POR_LICAO = 5;
export const QUESTOES_POR_REVISAO = 10; // o máximo de uma sessão de revisão (o resto fica para a próxima)
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

const DIA = 86400000;
export const hoje = (agora: number | Date = Date.now()) => new Date(agora).toLocaleDateString('en-CA'); // AAAA-MM-DD no fuso local
export const ontem = (agora: number | Date = Date.now()) => hoje(new Date(agora).getTime() - DIA);
export const chaveTema = (recorte_id: string, assunto: string) => `${recorte_id}|${assunto}`;
export const chaveUnidade = (recorte_id: string, unidade: number) => `${recorte_id}|${unidade}`;

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
export function ajustarVidas(p: Perfil, delta: number, agora = Date.now()): Perfil {
  const { vidas } = vidasAgora(p, agora);
  const nova = Math.max(0, Math.min(VIDAS_MAX, vidas + delta));
  let marco = p.vidas_atualizadas_em;
  if (vidas >= VIDAS_MAX || nova >= VIDAS_MAX) marco = new Date(agora).toISOString();
  else if (vidas !== p.vidas) {
    const desde = new Date(p.vidas_atualizadas_em).getTime();
    const ganhas = vidas - p.vidas;
    marco = new Date(desde + ganhas * MINUTOS_POR_VIDA * 60000).toISOString();
  }
  return { ...p, vidas: nova, vidas_atualizadas_em: marco };
}

/** A primeira lição do aluno não gasta vida. Vale até ele responder a primeira questão, mesmo sem concluir a lição
 * (as vistas vêm das tentativas). O banco confere o mesmo ao abrir a sessão (iniciar_sessao, migration 0010). */
export const primeiraLicao = (d: DadosAluno) => d.perfil.questoes_feitas === 0 && d.vistas.length === 0;

/** Sequência mostrada hoje (zera se passou um dia sem bater a meta). */
export function sequenciaAtual(p: Perfil, agora = Date.now()) {
  if (!p.ultimo_dia_meta) return 0;
  return p.ultimo_dia_meta === hoje(agora) || p.ultimo_dia_meta === ontem(agora) ? p.sequencia_atual : 0;
}

/** Soma XP no dia e atualiza a sequência quando a meta é batida. */
export function somarXP(d: DadosAluno, xp: number, agora = Date.now()): DadosAluno {
  const dia = hoje(agora);
  const antes = d.xpDia[dia] ?? 0;
  const depois = antes + xp;
  let perfil: Perfil = { ...d.perfil, xp_total: d.perfil.xp_total + xp };
  if (antes < d.prefs.meta_xp && depois >= d.prefs.meta_xp && perfil.ultimo_dia_meta !== dia) {
    const seq = perfil.ultimo_dia_meta === ontem(agora) ? perfil.sequencia_atual + 1 : 1;
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

export function atualizarTema(t: ProgressoTema | undefined, recorte_id: string, assunto: string, respostas: boolean[], perfeita: boolean, agora = Date.now()): ProgressoTema {
  const base: ProgressoTema = t ?? { recorte_id, assunto, dominio: 0, coroa: 0, licoes: 0, historico: [], ultima_pratica: null };
  const historico = [...base.historico, ...respostas].slice(-10);
  const novo: ProgressoTema = { ...base, historico, dominio: dominioDe(historico), licoes: base.licoes + 1, ultima_pratica: new Date(agora).toISOString() };
  let coroa = Math.max(base.coroa, coroaCalculada(novo));
  if (perfeita) coroa = Math.max(coroa, Math.min(3, base.coroa + 1));
  return { ...novo, coroa };
}

export const NOMES_COROA = ['Novo', 'Bronze', 'Prata', 'Ouro'];

/** Meia-noite de amanhã no fuso do aparelho (o banco usa o fuso que o app manda ao abrir a sessão). */
function amanha(agora: number) {
  const d = new Date(agora);
  d.setHours(0, 0, 0, 0);
  d.setDate(d.getDate() + 1);
  return d.toISOString();
}

/** Errou na lição: entra na revisão de amanhã. */
export function agendarErro(item: ItemRevisao | undefined, questao_id: string, letra: string | null, agora = Date.now()): ItemRevisao {
  return { questao_id, vence_em: amanha(agora), repeticoes: item?.repeticoes ?? 0, lapsos: (item?.lapsos ?? 0) + (item ? 1 : 0), status: 'pendente', ultima_letra: letra };
}

/** A questão já chegou ao dia dela na revisão. */
export const venceu = (r: ItemRevisao, agora = Date.now()) => new Date(r.vence_em).getTime() <= agora;

/** Pode entrar numa revisão agora: pendente (vencida, ou adiantada como treino) ou dominada que voltou para confirmar. */
export const naRevisao = (r: ItemRevisao | undefined, agora = Date.now()) => !!r && (r.status === 'pendente' || venceu(r, agora));

/** Resultado no Refazer. Errou → volta amanhã. Acertou antes do dia (revisão adiantada) → treino: volta amanhã, sem
 * contar como revisão. Acertou no dia: de primeira e sem dica → dominada (volta em 7, 21, 60 dias); com dica ou só na
 * 2ª tentativa → 3 dias. */
export function reagendar(item: ItemRevisao, acertou: boolean, dicas: number, segundaTentativa: boolean, agora = Date.now()): ItemRevisao {
  if (!acertou) return { ...item, vence_em: amanha(agora), lapsos: item.lapsos + 1, status: 'pendente' };
  if (!venceu(item, agora)) return { ...item, vence_em: amanha(agora), status: 'pendente' };
  if (dicas > 0 || segundaTentativa) return { ...item, vence_em: new Date(agora + 3 * DIA).toISOString(), repeticoes: item.repeticoes + 1, status: 'pendente' };
  const passos = [7, 21, 60];
  const dias = passos[Math.min(item.repeticoes, passos.length - 1)];
  return { ...item, vence_em: new Date(agora + dias * DIA).toISOString(), repeticoes: item.repeticoes + 1, status: 'dominada' };
}

/** XP de uma questão da revisão: só vale no dia dela (adiantada é treino). Cada dica, e acertar só na 2ª tentativa,
 * tiram 1 ponto: 5, 4 ou 3. */
export function xpDaRevisao(acertou: boolean, dicas: number, segundaTentativa: boolean, vencida: boolean) {
  return acertou && vencida ? XP_REVISAO[Math.min(2, dicas + (segundaTentativa ? 1 : 0))] : 0;
}

/** Revisão do dia: as questões que venceram (os erros pendentes e as dominadas que voltaram para confirmar). */
export function revisaoVencida(d: DadosAluno, agora = Date.now()) {
  return Object.values(d.revisao).filter((r) => venceu(r, agora));
}
/** Lista de erros: questões pendentes, vencidas ou não. */
export function revisaoPendente(d: DadosAluno) {
  return Object.values(d.revisao).filter((r) => r.status === 'pendente');
}

/** Terminar a revisão do dia agora devolveria 1 vida: faltam vidas, há questões vencidas para recuperar (acertando
 * pelo menos 1) e a vida da revisão de hoje ainda não veio. */
export function vidaPelaRevisao(d: DadosAluno, agora = Date.now()) {
  return vidasAgora(d.perfil, agora).vidas < VIDAS_MAX && revisaoVencida(d, agora).length > 0 && d.perfil.dia_vida_revisao !== hoje(agora);
}

/** A saída de quem fica sem vidas antes de ter questão vencida (o 1º dia): enquanto o aluno nunca ganhou a vida da
 * revisão, adiantar a revisão e acertar pelo menos 1 devolve 1 vida (continua sem XP). Uma vez só. */
export function vidaPeloTreino(d: DadosAluno, agora = Date.now()) {
  return vidasAgora(d.perfil, agora).vidas === 0 && d.perfil.dia_vida_revisao === null
    && revisaoVencida(d, agora).length === 0 && revisaoPendente(d).length > 0;
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

// Temas por matéria e língua, calculados uma vez por carga de conteúdo (a lista é lida em todas as telas).
const cacheTemas = new WeakMap<Conteudo, Map<string, InfoTema[]>>();

/** Subconteúdos da matéria, do que tem mais questões para o que tem menos. O empate vai pela ordem dos caracteres
 * (não pela do idioma do aparelho), a mesma do banco ao conferir o desafio (_temas_da_unidade, migration 0007).
 * A lista devolvida é compartilhada: não altere. */
export function temasDoRecorte(c: Conteudo, recorte_id: string, lingua: string): InfoTema[] {
  let porMateria = cacheTemas.get(c);
  if (!porMateria) cacheTemas.set(c, (porMateria = new Map()));
  const k = chaveTema(recorte_id, lingua);
  let temas = porMateria.get(k);
  if (!temas) {
    const cont = new Map<string, number>();
    for (const q of c.questoes) if (q.recorte_id === recorte_id && (!q.lingua || q.lingua === lingua)) cont.set(q.assunto, (cont.get(q.assunto) ?? 0) + 1);
    temas = [...cont.entries()].map(([assunto, total]) => ({ recorte_id, assunto, total }))
      .sort((a, b) => b.total - a.total || (a.assunto < b.assunto ? -1 : a.assunto > b.assunto ? 1 : 0));
    porMateria.set(k, temas);
  }
  return temas;
}

export function embaralhar<T>(xs: T[]) {
  const a = [...xs];
  for (let i = a.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [a[i], a[j]] = [a[j], a[i]]; }
  return a;
}

/** Monta uma lição: prioriza questões ainda não vistas. Subconteúdo com poucas questões é completado com outros da mesma matéria.
 * `misturar` existe para os testes montarem a lição sem sorteio. */
export function montarLicao(c: Conteudo, d: DadosAluno, recorte_id: string, assunto: string, n = QUESTOES_POR_LICAO, misturar: <T>(xs: T[]) => T[] = embaralhar): Questao[] {
  const vistas = new Set(d.vistas);
  const ordenar = (qs: Questao[]) => [...misturar(qs.filter((q) => !vistas.has(q.id))), ...misturar(qs.filter((q) => vistas.has(q.id)))];
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

/** Unidade em andamento na trilha: a primeira com o desafio ainda não vencido (com tudo vencido, a última). */
export function unidadeAtual(d: DadosAluno, unidades: InfoTema[][], recorte_id: string) {
  const i = unidades.findIndex((_, k) => !d.unidades[chaveUnidade(recorte_id, k)]);
  return i < 0 ? Math.max(0, unidades.length - 1) : i;
}

/** Desafio da unidade liberado: desafio da unidade anterior vencido e todos os temas desta feitos. */
export function desafioLiberado(d: DadosAluno, unidades: InfoTema[][], recorte_id: string, idx: number) {
  const un = unidades[idx];
  if (!un?.length) return false;
  return (idx === 0 || !!d.unidades[chaveUnidade(recorte_id, idx - 1)]) && un.every((t) => temaFeito(d, t));
}

export function montarDesafio(c: Conteudo, d: DadosAluno, temas: InfoTema[], misturar: <T>(xs: T[]) => T[] = embaralhar) {
  const nomes = new Set(temas.map((t) => t.assunto));
  const recorte = temas[0]?.recorte_id;
  const pool = c.questoes.filter((q) => q.recorte_id === recorte && nomes.has(q.assunto) && (!q.lingua || q.lingua === d.prefs.lingua));
  return misturar(pool).slice(0, DESAFIO_QTD);
}

/** Matéria em que o aluno estudou por último (entre as visíveis); sem histórico, a primeira. */
export function materiaAtual(d: DadosAluno, recortes: Recorte[]) {
  let id: string | null = null, quando = -Infinity;
  for (const t of Object.values(d.temas)) {
    const ms = t.ultima_pratica ? new Date(t.ultima_pratica).getTime() : NaN;
    if (ms > quando && recortes.some((r) => r.id === t.recorte_id)) { id = t.recorte_id; quando = ms; }
  }
  return recortes.find((r) => r.id === id) ?? recortes[0];
}

export type ProximoPasso =
  | { tipo: 'revisao'; n: number; vida: boolean } // questões vencidas na revisão (vida: terminar devolve 1 vida)
  | { tipo: 'adiantar'; n: number; vida: boolean } // sem vidas e nada vencido: adiantar a revisão dos erros guardados (treino; vida: vidaPeloTreino)
  | { tipo: 'tema'; recorte: Recorte; tema: InfoTema; unidade: number } // próximo tema da trilha
  | { tipo: 'desafio'; recorte: Recorte; unidade: number }; // desafio da unidade liberado

/** O que fazer agora, em ordem: revisão vencida; sem vidas, adiantar a revisão dos erros guardados; próximo tema da
 * trilha (na matéria estudada por último) ou o desafio da unidade. */
export function proximoPasso(d: DadosAluno, c: Conteudo, recortes: Recorte[], agora = Date.now()): ProximoPasso | null {
  const vencidas = revisaoVencida(d, agora).length;
  if (vencidas) return { tipo: 'revisao', n: vencidas, vida: vidaPelaRevisao(d, agora) };
  const guardados = revisaoPendente(d).length;
  if (guardados && vidasAgora(d.perfil, agora).vidas === 0) return { tipo: 'adiantar', n: guardados, vida: vidaPeloTreino(d, agora) };
  const recorte = materiaAtual(d, recortes);
  if (!recorte) return null;
  const unidades = unidadesDoRecorte(c, recorte.id, d.prefs.lingua);
  const unidade = unidadeAtual(d, unidades, recorte.id);
  const tema = unidades[unidade]?.find((t) => !temaFeito(d, t));
  if (tema) return { tipo: 'tema', recorte, tema, unidade };
  if (!d.unidades[chaveUnidade(recorte.id, unidade)] && desafioLiberado(d, unidades, recorte.id, unidade)) return { tipo: 'desafio', recorte, unidade };
  return null;
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
