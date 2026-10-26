// Regras do jogo (regras.ts e sessoes.ts), com o relógio passado como parâmetro. Fuso: America/Sao_Paulo (vitest.config.ts).
import { describe, expect, test } from 'vitest';
import {
  BONUS_PERFEITA, MINUTOS_POR_VIDA, VIDAS_MAX, agendarErro, ajustarVidas, areasDoExame, atualizarTema, chaveTema, chaveUnidade, coroaCalculada,
  desafioLiberado, hoje, montarDesafio, montarLicao, naRevisao, nivel, novasConquistas, primeiraLicao, proximoPasso, reagendar, recortesVisiveis, revisaoPendente,
  revisaoVencida, sequenciaAtual, somarXP, temaFeito, temasDoRecorte, unidadeAtual, unidadesDoRecorte, vidaPelaRevisao, vidaPeloTreino, vidasAgora, xpDaRevisao, xpDoAcerto
} from './regras';
import { fecharLicao, fecharRevisao, registrarErro, registrarRevisao } from './sessoes';
import { catalogo } from './catalogo';
import { conteudo } from './testes/banco';
import { dadosIniciais } from '../data/demoRepo';
import type { DadosAluno, ItemRevisao, Tentativa } from '../data/types';

const H = 3600000, DIA = 24 * H;
const AGORA = Date.parse('2026-10-26T15:00:00-03:00'); // segunda-feira, 15 h em Brasília
const semSorteio = <T,>(xs: T[]) => xs;
const novo = (agora = AGORA): DadosAluno => dadosIniciais({ id: 'aluno', nome: 'Ana' }, agora);
const meiaNoite = (dia: string) => new Date(`${dia}T00:00:00-03:00`).toISOString();
const gab = Object.fromEntries(conteudo.questoes.map((q) => [q.id, q.gabarito]));
const tentativa = (questao_id: string, correta: boolean, extra: Partial<Tentativa> = {}): Tentativa =>
  ({ questao_id, letra: correta ? gab[questao_id] : 'Z', correta, dicas_usadas: 0, viu_resolucao: false, tempo_ms: 1000, origem: 'licao', ...extra });
const MAT = 'enem-MAT';

describe('níveis, vidas e sequência', () => {
  test('nível sobe nos limites de XP', () => {
    expect(nivel(0)).toMatchObject({ nivel: 1, nome: 'Iniciante', prox: 50 });
    expect(nivel(50)).toMatchObject({ nivel: 2, nome: 'Aprendiz', base: 50, prox: 150 });
    expect(nivel(149).nivel).toBe(2);
  });

  test('recarga: 1 vida a cada 2 horas, até 3', () => {
    const p = { ...novo().perfil, vidas: 0, vidas_atualizadas_em: new Date(AGORA - (MINUTOS_POR_VIDA - 3) * 60000).toISOString() };
    expect(vidasAgora(p, AGORA)).toEqual({ vidas: 0, proximaEmMin: 3 });
    expect(vidasAgora(p, AGORA + 3 * 60000).vidas).toBe(1);
    expect(vidasAgora(p, AGORA + 10 * H).vidas).toBe(VIDAS_MAX);
  });

  test('errar depois de uma recarga mantém o relógio da próxima vida (como _ajustar_vidas)', () => {
    const p = { ...novo().perfil, vidas: 1, vidas_atualizadas_em: new Date(AGORA - 150 * 60000).toISOString() };
    const depois = ajustarVidas(p, -1, AGORA);
    expect(depois.vidas).toBe(1);
    expect((AGORA - Date.parse(depois.vidas_atualizadas_em)) / 60000).toBe(30);
    expect(ajustarVidas(novo().perfil, -1, AGORA).vidas_atualizadas_em).toBe(new Date(AGORA).toISOString()); // cheia: o relógio começa agora
  });

  test('meta batida começa e continua a sequência; um dia sem meta zera a mostrada', () => {
    let d = somarXP(novo(), 30, AGORA);
    expect(d.perfil).toMatchObject({ sequencia_atual: 1, sequencia_recorde: 1, ultimo_dia_meta: '2026-10-26', xp_total: 30 });
    d = somarXP(d, 10, AGORA); // já bateu hoje: não conta de novo
    expect(d.perfil.sequencia_atual).toBe(1);
    d = somarXP(d, 30, AGORA + DIA);
    expect(d.perfil.sequencia_atual).toBe(2);
    expect(sequenciaAtual(d.perfil, AGORA + 2 * DIA)).toBe(2); // ontem bateu: ainda vale
    expect(sequenciaAtual(d.perfil, AGORA + 3 * DIA)).toBe(0);
    expect(d.xpDia).toEqual({ '2026-10-26': 40, '2026-10-27': 30 });
  });
});

describe('domínio e coroas', () => {
  test('Bronze com um acerto, Prata com 60% em 5+, Ouro com 85% em 8+; a coroa nunca desce', () => {
    let t = atualizarTema(undefined, MAT, 'X', [true, false, false], false, AGORA);
    expect(t).toMatchObject({ dominio: 33, coroa: 1, licoes: 1 });
    t = atualizarTema(t, MAT, 'X', [true, true, true], false, AGORA);
    expect(t).toMatchObject({ dominio: 67, coroa: 2 });
    t = atualizarTema(t, MAT, 'X', [false, false, false, false], false, AGORA);
    expect(t.coroa).toBe(2);
    expect(coroaCalculada({ ...t, dominio: 90, historico: Array(8).fill(true) })).toBe(3);
    expect(coroaCalculada({ ...t, dominio: 0 })).toBe(0);
  });

  test('lição perfeita sobe uma coroa direto', () => {
    const bronze = atualizarTema(undefined, MAT, 'X', [true, false, false, false], false, AGORA);
    expect(bronze).toMatchObject({ dominio: 25, coroa: 1 });
    const t = atualizarTema(bronze, MAT, 'X', [true, true, true], true, AGORA);
    expect(t).toMatchObject({ dominio: 57, coroa: 2 }); // pela regra seria Bronze (57%); a perfeita sobe para Prata
  });
});

describe('revisão espaçada', () => {
  test('erro vai para amanhã à meia-noite; errar de novo conta lapso', () => {
    const i1 = agendarErro(undefined, 'q', 'B', AGORA);
    expect(i1).toMatchObject({ status: 'pendente', lapsos: 0, repeticoes: 0, ultima_letra: 'B', vence_em: meiaNoite('2026-10-27') });
    expect(agendarErro(i1, 'q', 'C', AGORA).lapsos).toBe(1);
  });

  test('vencida: sem dica domina (7, 21, 60 dias); com dica volta em 3 dias; errou volta amanhã', () => {
    const i: ItemRevisao = agendarErro(undefined, 'q', 'B', AGORA - DIA); // errou ontem: vence hoje
    const d1 = reagendar(i, true, 0, false, AGORA);
    expect(d1).toMatchObject({ status: 'dominada', repeticoes: 1 });
    expect(Date.parse(d1.vence_em) - AGORA).toBe(7 * DIA);
    const voltou = AGORA + 7 * DIA; // a dominada vence de novo: acertando, avança
    expect(Date.parse(reagendar(d1, true, 0, false, voltou).vence_em) - voltou).toBe(21 * DIA);
    expect(Date.parse(reagendar({ ...d1, repeticoes: 5 }, true, 0, false, voltou).vence_em) - voltou).toBe(60 * DIA);
    const comDica = reagendar(i, true, 1, false, AGORA);
    expect(comDica).toMatchObject({ status: 'pendente', repeticoes: 1 });
    expect(Date.parse(comDica.vence_em) - AGORA).toBe(3 * DIA);
    expect(reagendar(i, false, 0, false, AGORA)).toMatchObject({ status: 'pendente', lapsos: 1, vence_em: meiaNoite('2026-10-27') });
  });

  test('F2-01 · adiantada (ainda não venceu): acertar é treino, volta amanhã e não conta repetição', () => {
    const i = agendarErro(undefined, 'q', 'B', AGORA); // errou hoje: vence amanhã
    expect(reagendar(i, true, 0, false, AGORA)).toEqual({ ...i, vence_em: meiaNoite('2026-10-27'), status: 'pendente' });
    expect(reagendar(i, false, 0, false, AGORA)).toMatchObject({ status: 'pendente', lapsos: 1 });
    expect(xpDaRevisao(true, 0, false, false)).toBe(0);
  });

  test('F2-06 · XP da revisão: 5, 4 ou 3; a 2ª tentativa conta como uma dica', () => {
    expect([xpDaRevisao(true, 0, false, true), xpDaRevisao(true, 1, false, true), xpDaRevisao(true, 2, false, true)]).toEqual([5, 4, 3]);
    expect([xpDaRevisao(true, 0, true, true), xpDaRevisao(true, 1, true, true), xpDaRevisao(true, 2, true, true)]).toEqual([4, 3, 3]);
    expect(xpDaRevisao(false, 0, false, true)).toBe(0);
  });

test('2ª tentativa também no agendamento: acertar só na 2ª volta em 3 dias, sem dominar', () => {
    const i = agendarErro(undefined, 'q', 'B', AGORA - DIA);
    const r = reagendar(i, true, 0, true, AGORA);
    expect(r).toMatchObject({ status: 'pendente', repeticoes: 1 });
    expect(Date.parse(r.vence_em) - AGORA).toBe(3 * DIA);
    const dominada = reagendar(i, true, 0, false, AGORA);
    expect(reagendar(dominada, true, 0, true, AGORA + 7 * DIA), 'dominada que voltou: 2ª tentativa não confirma').toMatchObject({ status: 'pendente', repeticoes: 2 });
  });

  test('a 1ª lição grátis vale até responder a primeira questão', () => {
    expect(primeiraLicao(novo())).toBe(true);
    expect(primeiraLicao({ ...novo(), vistas: ['q'] }), 'respondeu e saiu sem concluir').toBe(false);
    expect(primeiraLicao({ ...novo(), perfil: { ...novo().perfil, questoes_feitas: 5 } })).toBe(false);
  });

  test('a saída do 1º dia: sem vidas, nada vencido e nunca ganhou a vida da revisão, o treino devolve 1 vida', () => {
    const semVidas = { ...novo(), perfil: { ...novo().perfil, vidas: 0, vidas_atualizadas_em: new Date(AGORA).toISOString() }, revisao: { a: agendarErro(undefined, 'a', 'B', AGORA) } };
    expect(vidaPeloTreino(semVidas, AGORA)).toBe(true);
    expect(vidaPeloTreino({ ...semVidas, perfil: { ...semVidas.perfil, dia_vida_revisao: '2026-10-20' } }, AGORA), 'já ganhou a vida da revisão').toBe(false);
    expect(vidaPeloTreino({ ...semVidas, perfil: { ...semVidas.perfil, vidas: 1 } }, AGORA), 'ainda tem vida').toBe(false);
    expect(vidaPeloTreino({ ...semVidas, perfil: { ...semVidas.perfil, vidas_atualizadas_em: new Date(AGORA - 2 * H).toISOString() } }, AGORA), 'uma vida já recarregou').toBe(false);
    expect(vidaPeloTreino({ ...semVidas, revisao: { a: agendarErro(undefined, 'a', 'B', AGORA - DIA) } }, AGORA), 'venceu: vale a regra normal').toBe(false);
    expect(vidaPeloTreino({ ...semVidas, revisao: {} }, AGORA), 'sem erros guardados').toBe(false);
  });

  test('F2-03 · a revisão do dia tem os erros vencidos e as dominadas que voltaram; a lista de erros, só as pendentes', () => {
    const dominada = reagendar(agendarErro(undefined, 'c', 'B', AGORA - 9 * DIA), true, 0, false, AGORA - 7 * DIA); // dominou há 7 dias: volta hoje
    const d = { ...novo(), revisao: { a: agendarErro(undefined, 'a', 'B', AGORA - DIA), b: agendarErro(undefined, 'b', 'B', AGORA), c: dominada } };
    expect(dominada.status).toBe('dominada');
    expect(revisaoVencida(d, AGORA).map((r) => r.questao_id).sort()).toEqual(['a', 'c']);
    expect(revisaoPendente(d).map((r) => r.questao_id).sort()).toEqual(['a', 'b']);
    expect([naRevisao(d.revisao.a, AGORA), naRevisao(d.revisao.b, AGORA), naRevisao(d.revisao.c, AGORA), naRevisao(d.revisao.c, AGORA - 2 * DIA)]).toEqual([true, true, true, false]);
  });

  test('F2-02 · a vida da revisão: só com questão vencida, faltando vida e uma vez por dia', () => {
    const vencida = agendarErro(undefined, 'a', 'B', AGORA - DIA);
    const base = { ...novo(), perfil: { ...novo().perfil, vidas: 1, vidas_atualizadas_em: new Date(AGORA).toISOString() } };
    expect(vidaPelaRevisao({ ...base, revisao: { a: vencida } }, AGORA)).toBe(true);
    expect(vidaPelaRevisao({ ...base, revisao: { a: agendarErro(undefined, 'a', 'B', AGORA) } }, AGORA), 'só adiantada').toBe(false);
    expect(vidaPelaRevisao({ ...base, revisao: { a: vencida }, perfil: { ...base.perfil, dia_vida_revisao: hoje(AGORA) } }, AGORA), 'já veio hoje').toBe(false);
    expect(vidaPelaRevisao({ ...novo(), revisao: { a: vencida } }, AGORA), 'vidas cheias').toBe(false);
  });
});

describe('conteúdo, lições e trilha', () => {
  test('temas do que tem mais questões para o que tem menos; empate pela ordem dos caracteres; calculados uma vez', () => {
    const t = temasDoRecorte(conteudo, MAT, 'Inglês');
    for (let i = 1; i < t.length; i++) {
      expect(t[i - 1].total > t[i].total || (t[i - 1].total === t[i].total && t[i - 1].assunto < t[i].assunto)).toBe(true);
    }
    expect(temasDoRecorte(conteudo, MAT, 'Inglês')).toBe(t);
    expect(recortesVisiveis(conteudo, 'enem', 'Espanhol').some((r) => r.id === 'enem-ING')).toBe(false);
  });

  test('lição: questões nunca vistas primeiro; tema curto completado com a matéria', () => {
    const [curto] = temasDoRecorte(conteudo, MAT, 'Inglês').filter((t) => t.total < 5);
    const l = montarLicao(conteudo, novo(), MAT, curto.assunto, 5, semSorteio);
    expect(l).toHaveLength(5);
    expect(l.slice(0, curto.total).every((q) => q.assunto === curto.assunto)).toBe(true);
    const grande = temasDoRecorte(conteudo, MAT, 'Inglês')[0];
    const primeira = montarLicao(conteudo, novo(), MAT, grande.assunto, 5, semSorteio);
    const segunda = montarLicao(conteudo, { ...novo(), vistas: primeira.map((q) => q.id) }, MAT, grande.assunto, 5, semSorteio);
    expect(segunda.some((q) => primeira.some((p) => p.id === q.id))).toBe(grande.total < 10);
  });

  test('unidades de 6 temas; a atual é a primeira sem desafio; o desafio libera com os temas feitos', () => {
    const un = unidadesDoRecorte(conteudo, MAT, 'Inglês');
    expect(un[0]).toHaveLength(6);
    let d = novo();
    expect(unidadeAtual(d, un, MAT)).toBe(0);
    expect(desafioLiberado(d, un, MAT, 0)).toBe(false);
    for (const t of un[0]) d = { ...d, temas: { ...d.temas, [chaveTema(MAT, t.assunto)]: atualizarTema(undefined, MAT, t.assunto, [true], false, AGORA) } };
    expect(un[0].every((t) => temaFeito(d, t))).toBe(true);
    expect(desafioLiberado(d, un, MAT, 0)).toBe(true);
    expect(desafioLiberado(d, un, MAT, 1)).toBe(false); // a unidade 1 espera o desafio da 0
    d = { ...d, unidades: { [chaveUnidade(MAT, 0)]: true } };
    expect(unidadeAtual(d, un, MAT)).toBe(1);
    expect(montarDesafio(conteudo, d, un[0], semSorteio).every((q) => un[0].some((t) => t.assunto === q.assunto))).toBe(true);
  });

  test('próximo passo: revisão vencida, depois adiantar a revisão (sem vidas), depois o próximo tema ou o desafio', () => {
    const recortes = recortesVisiveis(conteudo, 'enem', 'Inglês');
    let d = novo();
    expect(proximoPasso(d, conteudo, recortes, AGORA)).toMatchObject({ tipo: 'tema', recorte: { id: recortes[0].id }, unidade: 0 });
    // estudou Matemática por último: o próximo passo segue nela
    d = { ...d, temas: { [chaveTema(MAT, 'X')]: { ...atualizarTema(undefined, MAT, 'X', [true], false, AGORA) } } };
    expect(proximoPasso(d, conteudo, recortes, AGORA)).toMatchObject({ tipo: 'tema', recorte: { id: MAT } });
    const erro = agendarErro(undefined, conteudo.questoes[0].id, 'B', AGORA);
    const semVidas = { ...d, perfil: { ...d.perfil, vidas: 0, vidas_atualizadas_em: new Date(AGORA).toISOString() }, revisao: { [erro.questao_id]: erro } };
    expect(proximoPasso(semVidas, conteudo, recortes, AGORA)).toEqual({ tipo: 'adiantar', n: 1, vida: true }); // nada vencido: treino (na 1ª vez, com vida)
    expect(proximoPasso({ ...semVidas, perfil: { ...semVidas.perfil, dia_vida_revisao: '2026-10-20' } }, conteudo, recortes, AGORA)).toEqual({ tipo: 'adiantar', n: 1, vida: false });
    expect(proximoPasso(semVidas, conteudo, recortes, AGORA + DIA)).toMatchObject({ tipo: 'revisao', n: 1 });
    const un = unidadesDoRecorte(conteudo, MAT, 'Inglês');
    let feito = d;
    for (const t of un[0]) feito = { ...feito, temas: { ...feito.temas, [chaveTema(MAT, t.assunto)]: atualizarTema(undefined, MAT, t.assunto, [true], false, AGORA) } };
    expect(proximoPasso(feito, conteudo, recortes, AGORA)).toMatchObject({ tipo: 'desafio', recorte: { id: MAT }, unidade: 0 });
  });
});

describe('fechamento das sessões (as contas de concluir_sessao)', () => {
  const temaMAT = temasDoRecorte(conteudo, MAT, 'Inglês')[0].assunto;
  const licao = montarLicao(conteudo, novo(), MAT, temaMAT, 5, semSorteio);
  const entrada = (tentativas: Tentativa[]) => ({ tipo: 'licao' as const, exame_id: 'enem', recorte_id: MAT, assunto: temaMAT, unidade: 0, questoes: licao, tentativas });

  test('lição perfeita: 10 XP por acerto + bônus, Prata direto, conquistas', () => {
    const f = fecharLicao(novo(), conteudo, entrada(licao.map((q) => tentativa(q.id, true))), AGORA);
    expect(f.resumo).toMatchObject({ acertos: 5, total: 5, xp: 5 * 10 + BONUS_PERFEITA, perfeita: true, aprovado: null, coroaAntes: 0, coroaDepois: 2 });
    expect(f.resumo.conquistas).toEqual(expect.arrayContaining(['primeiro_passo', 'licao_perfeita']));
    expect(f.dados.perfil).toMatchObject({ xp_total: 55, questoes_feitas: 5, acertos_total: 5, sequencia_atual: 1 });
    expect(f.dados.acertadas).toHaveLength(5);
  });

  test('questão já acertada vale 5 XP', () => {
    const d = { ...novo(), acertadas: [licao[0].id] };
    expect(xpDoAcerto(d, licao[0].id)).toBe(5);
    expect(fecharLicao(d, conteudo, entrada([tentativa(licao[0].id, true)]), AGORA).resumo.xp).toBe(5);
  });

  test('desafio só é aprovado com todas as questões respondidas e 70% de acertos', () => {
    const un = unidadesDoRecorte(conteudo, MAT, 'Inglês');
    const qs = montarDesafio(conteudo, novo(), un[0], semSorteio);
    const e = (ts: Tentativa[]) => ({ tipo: 'desafio' as const, exame_id: 'enem', recorte_id: MAT, assunto: '', unidade: 0, questoes: qs, tentativas: ts });
    expect(fecharLicao(novo(), conteudo, e([tentativa(qs[0].id, true)]), AGORA).resumo.aprovado).toBe(false);
    const f = fecharLicao(novo(), conteudo, e(qs.map((q, i) => tentativa(q.id, i < 7, { origem: 'desafio' }))), AGORA);
    expect(f.resumo).toMatchObject({ aprovado: true, perfeita: false, coroaAntes: 0, coroaDepois: 0 });
    expect(f.dados.unidades[chaveUnidade(MAT, 0)]).toBe(true);
  });

  test('erro na lição gasta vida e agenda a revisão; no desafio só agenda', () => {
    const d = registrarErro(novo(), 'q', 'B', true, AGORA);
    expect(d.perfil.vidas).toBe(2);
    expect(d.revisao.q).toMatchObject({ status: 'pendente', vence_em: meiaNoite('2026-10-27') });
    expect(registrarErro(novo(), 'q', 'B', false, AGORA).perfil.vidas).toBe(3);
  });

  test('revisão: 5, 4 ou 3 XP conforme as dicas, reagenda, devolve 1 vida e conta como acertada', () => {
    const [a, b, c] = licao.map((q) => q.id);
    let d = { ...novo(), perfil: { ...novo().perfil, vidas: 1, vidas_atualizadas_em: new Date(AGORA).toISOString() } };
    for (const id of [a, b, c]) d = registrarErro(d, id, 'B', false, AGORA - DIA);
    const ts = [
      tentativa(a, true, { origem: 'revisao' }),
      tentativa(b, true, { origem: 'revisao', dicas_usadas: 1 }),
      tentativa(c, false, { origem: 'revisao' }), tentativa(c, false, { origem: 'revisao', letra: 'Y' })
    ];
    const f = fecharRevisao(d, conteudo, 'enem', ts, AGORA);
    expect(f.resumo).toMatchObject({ acertos: 2, total: 3, xp: 9 });
    expect(f.dados.revisao[a].status).toBe('dominada');
    expect(f.dados.revisao[b]).toMatchObject({ status: 'pendente', repeticoes: 1 });
    expect(f.dados.revisao[c]).toMatchObject({ status: 'pendente', lapsos: 1 });
    expect(f.dados.perfil).toMatchObject({ vidas: 2, revisoes_concluidas: 1, questoes_feitas: 3, acertos_total: 2 });
    expect(f.dados.acertadas).toEqual(expect.arrayContaining([a, b]));
    expect(f.resumo.vidaGanha).toBe(true);
    expect(f.dados.perfil.dia_vida_revisao).toBe('2026-10-26');
    expect(registrarRevisao(d, a, true, 0, false, AGORA).revisao[a].status).toBe('dominada');
    // a segunda revisão do dia não devolve outra vida
    const outra = registrarErro(f.dados, licao[3].id, 'B', false, AGORA - DIA);
    const g = fecharRevisao(outra, conteudo, 'enem', [tentativa(licao[3].id, true, { origem: 'revisao' })], AGORA);
    expect(g.resumo).toMatchObject({ xp: 5, vidaGanha: false });
    expect(g.dados.perfil.vidas).toBe(2);
  });

  test('F2-01 · revisão só de questões adiantadas: acertos contam, mas sem XP e sem vida', () => {
    const [a] = licao.map((q) => q.id);
    const d = registrarErro({ ...novo(), perfil: { ...novo().perfil, vidas: 1, vidas_atualizadas_em: new Date(AGORA).toISOString() } }, a, 'B', false, AGORA);
    const f = fecharRevisao(d, conteudo, 'enem', [tentativa(a, true, { origem: 'revisao' })], AGORA);
    expect(f.resumo).toMatchObject({ acertos: 1, total: 1, xp: 0, vidaGanha: false });
    expect(f.dados.revisao[a]).toMatchObject({ status: 'pendente', repeticoes: 0, vence_em: meiaNoite('2026-10-27') });
    expect(f.dados.perfil.vidas).toBe(1);
  });

test('a vida do 1º dia: sem vidas, o treino devolve 1 vida (sem XP), uma vez só e só faltando todas', () => {
    const [a, b, c] = licao.map((q) => q.id);
    let d = { ...novo(), perfil: { ...novo().perfil, vidas: 0, vidas_atualizadas_em: new Date(AGORA).toISOString() } };
    d = registrarErro(registrarErro(d, a, 'B', false, AGORA), b, 'B', false, AGORA);
    const f = fecharRevisao(d, conteudo, 'enem', [tentativa(a, true, { origem: 'revisao' })], AGORA);
    expect(f.resumo).toMatchObject({ acertos: 1, xp: 0, vidaGanha: true });
    expect(f.dados.perfil).toMatchObject({ vidas: 1, dia_vida_revisao: '2026-10-26' });
    expect(f.dados.revisao[a]).toMatchObject({ status: 'pendente', vence_em: meiaNoite('2026-10-27') });
    const errou = fecharRevisao(d, conteudo, 'enem', [tentativa(a, false, { origem: 'revisao' })], AGORA);
    expect(errou.resumo.vidaGanha, 'sem acerto, sem vida').toBe(false);
    const comVida = { ...d, perfil: { ...d.perfil, vidas: 1 } };
    expect(fecharRevisao(comVida, conteudo, 'enem', [tentativa(a, true, { origem: 'revisao' })], AGORA).resumo.vidaGanha, 'com vida sobrando').toBe(false);
    // dias depois, sem vidas de novo e nada vencido: a exceção já foi usada
    const depois = AGORA + 3 * DIA;
    const outra = registrarErro({ ...f.dados, revisao: {}, perfil: { ...f.dados.perfil, vidas: 0, vidas_atualizadas_em: new Date(depois).toISOString() } }, c, 'B', false, depois);
    expect(fecharRevisao(outra, conteudo, 'enem', [tentativa(c, true, { origem: 'revisao' })], depois).resumo.vidaGanha).toBe(false);
  });

  test('conquista "Todas as áreas" pede as áreas do exame', () => {
    const areas = areasDoExame(conteudo, 'enem');
    expect(areas.total).toBe(4);
    const d = novo();
    const temas = Object.fromEntries(['enem-POR', 'enem-HIS', 'enem-BIO', MAT].map((r) => [chaveTema(r, 'X'), atualizarTema(undefined, r, 'X', [true], false, AGORA)]));
    expect(novasConquistas({ ...d, temas }, areas)).toContain('quatro_areas');
    expect(novasConquistas({ ...d, temas: { [chaveTema(MAT, 'X')]: temas[chaveTema(MAT, 'X')] } }, areas)).not.toContain('quatro_areas');
  });

  test('catálogo acha questão, matéria e exame pelo id', () => {
    const cat = catalogo(conteudo);
    expect(cat.questao(licao[0].id)).toBe(licao[0]);
    expect(cat.recorte(MAT)?.nome).toBe('Matemática');
    expect(cat.exame('enem')?.id).toBe('enem');
    expect(cat.recorte(null)).toBeUndefined();
    expect(hoje(AGORA)).toBe('2026-10-26');
  });
});
