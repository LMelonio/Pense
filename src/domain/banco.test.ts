// Regras do banco num Postgres local (PGlite): roda as migrations e as questões de supabase/seed e tenta, como aluno,
// o que o app faz e o que ele nunca faz (trapaças das baterias de testes). Os códigos (N01a, RP27…) são os dos
// relatórios. Temas, unidades e lições vêm de regras.ts: o banco tem de concordar com o app.
// Antes, uma vez: npm install --no-save @electric-sql/pglite@0.2.17
import { beforeAll, describe, expect, test } from 'vitest';
import { comoAnonimo, conteudo, criarAluno, criarBanco, ler, passarDias } from './testes/banco';
import type { Aluno, Banco } from './testes/banco';
import { montarLicao, temasDoRecorte, unidadesDoRecorte } from './regras';
import { dadosIniciais } from '../data/demoRepo';
import type { ResumoSessao } from '../data/types';

const semSorteio = <T,>(xs: T[]) => xs;
const vazio = dadosIniciais({ id: 'teste', nome: null });
const porRecorte = (r: string, lingua = 'Inglês') => conteudo.questoes.filter((q) => q.recorte_id === r && (!q.lingua || q.lingua === lingua));
const temas = (r: string, lingua = 'Inglês') => temasDoRecorte(conteudo, r, lingua);
const unidades = (r: string, lingua = 'Inglês') => unidadesDoRecorte(conteudo, r, lingua).map((u) => u.map((t) => t.assunto));
/** A lição que o app monta para um aluno novo, sem sorteio: o subconteúdo primeiro, completado com a matéria. */
const licaoDe = (r: string, assunto: string) => montarLicao(conteudo, vazio, r, assunto, 5, semSorteio).map((q) => q.id);
const gab = Object.fromEntries(conteudo.questoes.map((q) => [q.id, q.gabarito]));
const errada = (id: string) => ['A', 'B', 'C', 'D', 'E'].find((l) => l !== gab[id])!;
const erro = async (p: Promise<unknown>) => { try { await p; return null; } catch (e) { return (e as Error).message; } };

type Resposta = { correta: boolean; gabarito: string; repetida?: boolean; vidas?: number | null };
const iniciar = (a: Aluno, tipo: string, recorte: string | null, assunto: string | null, unidade: number | null, questoes: string[] | null = null) =>
  a.rpc<string>('iniciar_sessao', { p_tipo: tipo, p_exame: 'enem', p_recorte: recorte, p_assunto: assunto, p_unidade: unidade, p_fuso: 'America/Sao_Paulo', p_questoes: questoes });
const responder = (a: Aluno, s: string, q: string, letra: string | null, extra: { dicas?: number; viu?: boolean } = {}) =>
  a.rpc<Resposta>('responder', { p_sessao: s, p_questao: q, p_letra: letra, p_dicas: extra.dicas ?? 0, p_viu_resolucao: extra.viu ?? false, p_tempo_ms: 1000 });
const concluir = (a: Aluno, s: string) => a.rpc<ResumoSessao>('concluir_sessao', { p_sessao: s });
async function licaoCompleta(a: Aluno, r: string, assunto: string, ids: string[], certas = ids.length) {
  const s = await iniciar(a, 'licao', r, assunto, null, ids);
  for (const [i, q] of ids.entries()) await responder(a, s, q, i < certas ? gab[q] : errada(q));
  return concluir(a, s);
}
const vidasDe = async (a: Aluno) => (await a.sql<{ vidas: number }>('select vidas from perfis')).rows[0].vidas;

const MAT = 'enem-MAT';
const temasMAT = temas(MAT);
const grande = temasMAT.find((t) => t.total >= 6)!.assunto; // subconteúdo com 5+ questões
const pequeno = temasMAT.find((t) => t.total < 5)!.assunto; // subconteúdo curto
const doGrande = porRecorte(MAT).filter((q) => q.assunto === grande).map((q) => q.id);
const outrosMAT = porRecorte(MAT).filter((q) => q.assunto !== grande).map((q) => q.id);
const deHistoria = porRecorte('enem-HIS').map((q) => q.id);

let db: Banco;
beforeAll(async () => { db = await criarBanco(); });

/** Aluno que já concluiu uma lição (a primeira não gasta vida): as próximas gastam. */
async function veterano() {
  const a = await criarAluno(db);
  const t = temas('enem-SOC')[0].assunto;
  await licaoCompleta(a, 'enem-SOC', t, licaoDe('enem-SOC', t));
  return a;
}

test('S01 · setup_completo.sql roda num banco novo', async () => {
  expect(await erro(criarBanco([ler('supabase/setup_completo.sql')]))).toBeNull();
});

describe('Lição limitada às suas questões e ao tamanho (N01)', () => {
  test('RP27 · Lição recusa questão fora da lista e de outra matéria', async () => {
    const a = await criarAluno(db);
    const s = await iniciar(a, 'licao', MAT, grande, null, doGrande.slice(0, 5));
    expect(await erro(responder(a, s, outrosMAT[0], gab[outrosMAT[0]]))).toBeTruthy();
    expect(await erro(responder(a, s, deHistoria[0], gab[deHistoria[0]]))).toBeTruthy();
  });

  test('RP27 · Ataque de 60 respostas numa lição fica em até 5 e 55 XP', async () => {
    const a = await criarAluno(db);
    const s = await iniciar(a, 'licao', MAT, grande, null, doGrande.slice(0, 5));
    let aceitas = 0;
    for (const q of porRecorte(MAT).slice(0, 60).map((x) => x.id)) if (!(await erro(responder(a, s, q, gab[q])))) aceitas++;
    const r = await concluir(a, s);
    expect(aceitas).toBeLessThanOrEqual(5);
    expect(r.xp).toBeLessThanOrEqual(55);
  });

  test.each([
    ['N01a', 'Lição com 6 questões é recusada', doGrande.slice(0, 6)],
    ['N01b', 'Subconteúdo com 5+ questões não aceita questão de outro', [...doGrande.slice(0, 4), outrosMAT[0]]],
    ['N01c', 'Lista com questão repetida é recusada', [doGrande[0], doGrande[0], doGrande[1]]],
    ['N01d', 'Lista com questão de outra matéria é recusada', [...doGrande.slice(0, 4), deHistoria[0]]],
    ['N01e', 'Lista sem questão do subconteúdo é recusada', outrosMAT.slice(0, 5)],
    ['N01f', 'Lição sem lista (app antigo) é recusada', null]
  ])('%s · %s', async (_codigo, _nome, lista) => {
    const a = await criarAluno(db);
    expect(await erro(iniciar(a, 'licao', MAT, grande, null, lista))).toBeTruthy();
  });
});

describe('Lições normais (o que o app faz) e regressões da 0006', () => {
  test('L01 · Lição normal de 5 questões, todas certas', async () => {
    const r = await licaoCompleta(await criarAluno(db), MAT, grande, licaoDe(MAT, grande));
    expect(r).toMatchObject({ total: 5, xp: 55, perfeita: true });
  });

  test('L02 · Subconteúdo curto completado com a matéria (B06)', async () => {
    const r = await licaoCompleta(await criarAluno(db), MAT, pequeno, licaoDe(MAT, pequeno), 3);
    expect(r).toMatchObject({ total: 5, acertos: 3 });
  });

  test('L03 · Lição de Inglês (matéria com língua)', async () => {
    const t = temas('enem-ING')[0].assunto;
    const r = await licaoCompleta(await criarAluno(db), 'enem-ING', t, licaoDe('enem-ING', t));
    expect(r.total).toBeGreaterThan(0);
  });

  test('RP02, RP05, RP10, RP11 · Clique repetido, erro repetido, concluir 2 vezes, responder depois', async () => {
    const c = await veterano();
    const ids = licaoDe(MAT, grande);
    const s = await iniciar(c, 'licao', MAT, grande, null, ids);
    await responder(c, s, ids[0], errada(ids[0]));
    const rep = await responder(c, s, ids[0], gab[ids[0]]);
    expect(rep, 'RP02 · Clique repetido devolve a 1ª resposta').toMatchObject({ repetida: true, correta: false });
    const v = await vidasDe(c);
    await responder(c, s, ids[0], errada(ids[0]));
    expect(await vidasDe(c), 'RP05 · Erro repetido não tira outra vida').toBe(v);
    const c1 = await concluir(c, s);
    expect(await concluir(c, s), 'RP10 · Concluir 2 vezes não soma de novo').toEqual(c1);
    expect(await erro(responder(c, s, ids[1], gab[ids[1]])), 'RP11 · Responder após concluir é recusado').toBeTruthy();
  });

  test('RP17, RP13 · Sem vidas a lição recusa resposta; sessão de outro aluno é recusada', async () => {
    const b = await veterano();
    const ids = licaoDe(MAT, grande);
    const s = await iniciar(b, 'licao', MAT, grande, null, ids);
    for (const q of ids.slice(0, 3)) await responder(b, s, q, errada(q));
    expect(await erro(responder(b, s, ids[3], gab[ids[3]])), 'RP17').toMatch(/sem_vidas/);
    const outro = await criarAluno(db);
    expect(await erro(responder(outro, s, ids[3], gab[ids[3]])), 'RP13').toBeTruthy();
  });
});

describe('Revisão (N02 e N04)', () => {
  let a: Aluno;
  let fila: string[];
  let fora: string;
  let s: string;
  beforeAll(async () => {
    a = await criarAluno(db);
    const ids = licaoDe(MAT, grande);
    await licaoCompleta(a, MAT, grande, ids, 2); // 2 certas, 3 erradas: entram na fila
    await passarDias(db, a.id, 1); // vencem
    fila = ids.slice(2);
    fora = outrosMAT.find((q) => !ids.includes(q))!;
    s = await iniciar(a, 'revisao', null, null, null);
  });

  test('RP23 · Revisão recusa questão fora da fila e questão acertada', async () => {
    expect(await erro(responder(a, s, fora, gab[fora]))).toBeTruthy();
    const certa = licaoDe(MAT, grande)[0];
    expect(await erro(responder(a, s, certa, gab[certa]))).toBeTruthy();
  });

  test('RP22 · Depois de ver a resolução, resposta é recusada', async () => {
    await responder(a, s, fila[0], null, { dicas: 2, viu: true });
    expect(await erro(responder(a, s, fila[0], gab[fila[0]]))).toBeTruthy();
  });

  test('RP24 · Dica aberta conta mesmo se o app informar 0', async () => {
    await a.rpc('abrir_dica', { p_sessao: s, p_questao: fila[1], p_dica: 1 });
    await responder(a, s, fila[1], gab[fila[1]], { dicas: 0 });
    const d = (await a.sql<{ dicas_usadas: number }>('select dicas_usadas from tentativas where sessao_id = $1 and questao_id = $2', [s, fila[1]])).rows[0].dicas_usadas;
    expect(d).toBe(1);
  });

  test('R01, R02 · Terceira tentativa e outra letra depois de acertar são recusadas', async () => {
    await responder(a, s, fila[2], errada(fila[2]));
    const rep = await responder(a, s, fila[2], errada(fila[2]));
    const outra = ['A', 'B', 'C', 'D', 'E'].find((l) => l !== gab[fila[2]] && l !== errada(fila[2]))!;
    await responder(a, s, fila[2], outra);
    expect(rep.repetida, 'R01 · repetida').toBe(true);
    expect(await erro(responder(a, s, fila[2], gab[fila[2]])), 'R01').toBeTruthy();
    expect(await erro(responder(a, s, fila[1], errada(fila[1]))), 'R02').toBeTruthy();
  });

  test('R03, R04 · Só a questão sem resolução conta, com 4 XP (1 dica); as outras seguem pendentes', async () => {
    const r = await concluir(a, s);
    expect(r).toMatchObject({ acertos: 1, xp: 4, total: 3 });
    const status = Object.fromEntries((await a.sql<{ questao_id: string; status: string }>('select questao_id, status from fila_revisao')).rows.map((x) => [x.questao_id, x.status]));
    expect(status[fila[0]], 'R04').toBe('pendente');
    expect(status[fila[1]], 'R04').toBe('pendente');
  });

  test('R05, R06, R08 · Acerto sem dica dá 5 XP e domina; dominada não pontua de novo; dica fora da fila', async () => {
    await passarDias(db, a.id, 1); // a que errou duas vezes volta no dia seguinte
    const s2 = await iniciar(a, 'revisao', null, null, null);
    await responder(a, s2, fila[2], gab[fila[2]]);
    const r2 = await concluir(a, s2);
    const st = (await a.sql<{ status: string }>('select status from fila_revisao where questao_id = $1', [fila[2]])).rows[0].status;
    expect(r2.xp, 'R05').toBe(5);
    expect(st, 'R05').toBe('dominada');
    const s3 = await iniciar(a, 'revisao', null, null, null);
    expect(await erro(responder(a, s3, fila[2], gab[fila[2]])), 'R06').toBeTruthy();
    expect(await erro(a.rpc('abrir_dica', { p_sessao: s3, p_questao: fora, p_dica: 1 })), 'R08').toBeTruthy();
  });

  test('R07 · Revisão aceita até 10 questões', async () => {
    const b = await criarAluno(db);
    await db.query(`insert into fila_revisao (perfil_id, questao_id, vence_em, status) select $1, id, now(), 'pendente' from questoes where recorte_id = 'enem-MAT' order by id limit 11`, [b.id]);
    const naFila = (await db.query<{ questao_id: string }>('select questao_id from fila_revisao where perfil_id = $1 order by questao_id', [b.id])).rows.map((x) => x.questao_id);
    const s4 = await iniciar(b, 'revisao', null, null, null);
    let aceitas = 0;
    for (const q of naFila) if (!(await erro(responder(b, s4, q, gab[q])))) aceitas++;
    expect(aceitas).toBe(10);
  });
});

describe('Desafio (N03)', () => {
  const R = 'enem-TIC';
  const un = unidades(R);
  const pool0 = porRecorte(R).filter((q) => un[0].includes(q.assunto)).map((q) => q.id);
  const n0 = Math.min(10, pool0.length);

  test('RP26, D01, D02, RP25, D03 · Desafio na ordem da trilha, completo e aprovado', async () => {
    const a = await criarAluno(db);
    const blocMAT = porRecorte(MAT).filter((q) => unidades(MAT)[5]?.includes(q.assunto)).slice(0, 10).map((q) => q.id);
    expect(await erro(iniciar(a, 'desafio', MAT, null, 5, blocMAT)), 'RP26 · unidade bloqueada').toBeTruthy();
    expect(await erro(iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0))), 'RP26 · subconteúdos não feitos').toBeTruthy();

    for (const t of un[0]) await licaoCompleta(a, R, t, licaoDe(R, t));
    expect(await erro(iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0 - 1))), 'D01 · menos questões que o normal').toBeTruthy();
    const foraUn = porRecorte(R).find((q) => !un[0].includes(q.assunto));
    if (foraUn) expect(await erro(iniciar(a, 'desafio', R, null, 0, [...pool0.slice(0, n0 - 1), foraUn.id])), 'D02 · questão de outra unidade').toBeTruthy();

    const s1 = await iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0));
    await responder(a, s1, pool0[0], gab[pool0[0]]);
    expect((await concluir(a, s1)).aprovado, 'RP25 · 1 resposta não libera a unidade').toBeFalsy();

    const s2 = await iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0));
    const certas = Math.ceil(n0 * 0.7);
    for (const [i, q] of pool0.slice(0, n0).entries()) await responder(a, s2, q, i < certas ? gab[q] : errada(q));
    const r2 = await concluir(a, s2);
    const ok = (await a.sql<{ desafio_ok: boolean }>('select desafio_ok from progresso_unidade where chave = $1', [`${R}|0`])).rows[0]?.desafio_ok;
    expect(r2.aprovado, `D03 · ${certas}/${n0} aprova`).toBe(true);
    expect(ok, 'D03 · grava a unidade').toBe(true);
  });

  test('D04 · Unidade 2 bloqueada sem vencer o desafio da unidade 1', async () => {
    const unM = unidades(MAT);
    const b = await criarAluno(db);
    for (const t of unM[0]) await licaoCompleta(b, MAT, t, licaoDe(MAT, t));
    const poolM1 = porRecorte(MAT).filter((q) => unM[1].includes(q.assunto)).map((q) => q.id).slice(0, 10);
    expect(await erro(iniciar(b, 'desafio', MAT, null, 1, poolM1))).toBeTruthy();
  });

  test('D05 · Unidades do banco iguais às do app, em todas as matérias e nas duas línguas', async () => {
    const dif: string[] = [];
    for (const lingua of ['Inglês', 'Espanhol']) for (const r of conteudo.recortes.map((x) => x.id)) {
      const u = unidades(r, lingua);
      for (let i = 0; i <= u.length; i++) {
        const sql = (await db.query<{ t: string[] }>('select public._temas_da_unidade($1, $2, $3) as t', [r, lingua, i])).rows[0].t;
        if (JSON.stringify(sql) !== JSON.stringify(u[i] ?? [])) dif.push(`${r}/${lingua}/${i}`);
      }
    }
    expect(dif).toEqual([]);
  });
});

describe('Vidas: recarga de 1 a cada 2 horas e +1 por anúncio, até 5 em 24 horas (0008)', () => {
  const vidasAgora = async (vidas: number, minutosAtras: number) =>
    (await db.query<{ v: number }>('select public._vidas_agora($1, now() - make_interval(mins => $2)) as v', [vidas, minutosAtras])).rows[0].v;

  test('V01, V02, V03 · Recarga', async () => {
    expect(await vidasAgora(1, 119), 'V01 · sem recarga antes de 2 horas').toBe(1);
    expect(await vidasAgora(1, 121), 'V02 · uma vida volta com 2 horas').toBe(2);
    expect(await vidasAgora(0, 600), 'V03 · nunca passa de 3').toBe(3);
  });

  test('V04 · Erro depois de uma recarga mantém o relógio da próxima vida', async () => {
    const a = await criarAluno(db);
    await db.query("update perfis set vidas = 1, vidas_atualizadas_em = now() - interval '150 minutes' where id = $1", [a.id]);
    const nova = (await db.query<{ v: number }>('select public._ajustar_vidas($1, -1) as v', [a.id])).rows[0].v;
    const marco = (await db.query<{ m: number }>('select round(extract(epoch from now() - vidas_atualizadas_em) / 60)::int as m from perfis where id = $1', [a.id])).rows[0].m;
    expect({ nova, marco }).toEqual({ nova: 1, marco: 30 });
  });

  test('V05, RP19 · Anúncio devolve 1 vida na hora; o 6º em 24 horas é recusado', async () => {
    const a = await criarAluno(db);
    await db.query('update perfis set vidas = 0, vidas_atualizadas_em = now() where id = $1', [a.id]);
    expect(await a.rpc('ganhar_vida_anuncio'), 'V05').toMatchObject({ vidas: 1 });
    for (let i = 0; i < 4; i++) await a.rpc('ganhar_vida_anuncio');
    expect(await erro(a.rpc('ganhar_vida_anuncio')), 'RP19').toMatch(/limite_anuncios/);
  });
});

describe('Gravação direta e permissões', () => {
  test('DB32, DB24 · Preferências: não apaga a linha; um campo não apaga o outro', async () => {
    const a = await criarAluno(db);
    await erro(a.sql('delete from preferencias where perfil_id = auth.uid()'));
    expect((await db.query<{ n: number }>('select count(*)::int n from preferencias where perfil_id = $1', [a.id])).rows[0].n, 'DB32').toBe(1);
    await a.sql('update preferencias set meta_xp = 20 where perfil_id = auth.uid()');
    await a.sql("update preferencias set tema = 'escuro' where perfil_id = auth.uid()");
    expect((await db.query('select meta_xp, tema from preferencias where perfil_id = $1', [a.id])).rows[0], 'DB24').toEqual({ meta_xp: 20, tema: 'escuro' });
  });

  test('DB01, DB16, AN01 · Aluno não grava XP, não muda a lista da sessão, não chama função interna', async () => {
    const a = await criarAluno(db);
    expect(await erro(a.sql('update perfis set xp_total = 9999')), 'DB01').toBeTruthy();
    expect(await erro(a.sql("update sessoes_estudo set questoes = '{}'")), 'DB16').toBeTruthy();
    expect(await erro(a.sql("select public._temas_da_unidade('enem-MAT', null, 0)")), 'AN01').toBeTruthy();
  });

  test('AN02, AN03 · Anônimo não chama iniciar_sessao nem abrir_dica; só existe a versão nova de iniciar_sessao', async () => {
    const anon = comoAnonimo(db);
    expect(await erro(anon("select public.iniciar_sessao('licao', 'enem', 'enem-MAT', 'x', null, 'UTC', '{}')")), 'AN02').toBeTruthy();
    expect(await erro(anon("select public.abrir_dica(gen_random_uuid(), 'x', 1)")), 'AN02').toBeTruthy();
    expect((await db.query<{ n: number }>("select count(*)::int n from pg_proc where proname = 'iniciar_sessao'")).rows[0].n, 'AN03').toBe(1);
  });
});
