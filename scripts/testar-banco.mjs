// Testa as regras do banco num Postgres local (PGlite, sem Docker): roda as migrations e as questões de
// supabase/seed e tenta, como aluno, o que o app faz e o que ele nunca faz (trapaças das baterias de testes).
// Uso: npm install --no-save @electric-sql/pglite@0.2.17 && node scripts/testar-banco.mjs
import { readFileSync, readdirSync } from 'node:fs';

let PGlite;
try { ({ PGlite } = await import('@electric-sql/pglite')); } catch {
  console.error('Instale o PGlite antes: npm install --no-save @electric-sql/pglite@0.2.17');
  process.exit(1);
}

const raiz = new URL('../', import.meta.url);
const ler = (caminho) => readFileSync(new URL(caminho, raiz), 'utf8');
const conteudo = JSON.parse(ler('public/data/conteudo.json'));

// Papéis, auth.uid() e permissões padrão como no Supabase
const PREPARO = `
create role anon nologin; create role authenticated nologin; create role service_role nologin bypassrls;
create schema auth;
create table auth.users (id uuid primary key, raw_user_meta_data jsonb not null default '{}', is_anonymous boolean default false);
create function auth.uid() returns uuid language sql stable as $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
grant usage on schema auth to anon, authenticated;
grant execute on function auth.uid() to anon, authenticated;
grant usage on schema public to anon, authenticated, service_role;
alter default privileges in schema public grant all on tables to anon, authenticated, service_role;
alter default privileges in schema public grant all on functions to anon, authenticated, service_role;
alter default privileges in schema public grant all on sequences to anon, authenticated, service_role;
`;
const semPgcrypto = (sql) => sql.replace(/create extension if not exists pgcrypto;/g, ''); // gen_random_uuid já vem no Postgres

async function criarBanco(arquivosSql) {
  const db = new PGlite();
  await db.exec(PREPARO);
  for (const sql of arquivosSql) await db.exec(semPgcrypto(sql));
  for (const f of readdirSync(new URL('supabase/seed/', raiz)).sort()) await db.exec(ler(`supabase/seed/${f}`));
  return db;
}

/** Cria um aluno (o gatilho cria perfil e preferências) e devolve funções que rodam como ele. */
async function criarAluno(db, id) {
  await db.query('insert into auth.users (id) values ($1)', [id]);
  const sql = async (texto, params = []) => {
    await db.exec(`reset role; select set_config('request.jwt.claim.sub', '${id}', false); set role authenticated;`);
    try { return await db.query(texto, params); } finally { await db.exec('reset role;'); }
  };
  const rpc = async (f, args) => {
    const nomes = Object.keys(args);
    const r = await sql(`select public.${f}(${nomes.map((n, i) => `${n} => $${i + 1}`).join(', ')}) as r`, Object.values(args));
    return r.rows[0].r;
  };
  return { id, sql, rpc };
}

const erro = async (p) => { try { await p; return null; } catch (e) { return e.message; } };
const resultados = [];
function check(id, nome, ok, detalhe = '') {
  resultados.push(ok);
  console.log(`${ok ? 'ok    ' : 'FALHOU'} ${id.padEnd(5)} ${nome}${detalhe ? `  [${detalhe}]` : ''}`);
}
let seq = 0;
const uid = () => `00000000-0000-0000-0000-${String(++seq).padStart(12, '0')}`;

// ---------- Conteúdo, com as mesmas contas do app (src/domain/regras.ts)
const porRecorte = (r, lingua = 'Inglês') => conteudo.questoes.filter((q) => q.recorte_id === r && (!q.lingua || q.lingua === lingua));
function temas(r, lingua = 'Inglês') {
  const cont = new Map();
  for (const q of porRecorte(r, lingua)) cont.set(q.assunto, (cont.get(q.assunto) ?? 0) + 1);
  return [...cont.entries()].map(([assunto, total]) => ({ assunto, total }))
    .sort((a, b) => b.total - a.total || (a.assunto < b.assunto ? -1 : a.assunto > b.assunto ? 1 : 0));
}
function unidades(r, lingua = 'Inglês') {
  const t = temas(r, lingua); const u = [];
  for (let i = 0; i < t.length; i += 6) u.push(t.slice(i, i + 6).map((x) => x.assunto));
  return u;
}
/** montarLicao sem embaralhar: o subconteúdo primeiro, completado com a matéria. */
function licaoDe(r, assunto, n = 5) {
  const qs = porRecorte(r);
  return [...qs.filter((q) => q.assunto === assunto), ...qs.filter((q) => q.assunto !== assunto)].slice(0, n).map((q) => q.id);
}
const gab = Object.fromEntries(conteudo.questoes.map((q) => [q.id, q.gabarito]));
const errada = (id) => ['A', 'B', 'C', 'D', 'E'].find((l) => l !== gab[id]);

const iniciar = (a, tipo, recorte, assunto, unidade, questoes = null) => a.rpc('iniciar_sessao', {
  p_tipo: tipo, p_exame: 'enem', p_recorte: recorte, p_assunto: assunto, p_unidade: unidade, p_fuso: 'America/Sao_Paulo', p_questoes: questoes
});
const responder = (a, s, q, letra, extra = {}) => a.rpc('responder', {
  p_sessao: s, p_questao: q, p_letra: letra, p_dicas: extra.dicas ?? 0, p_viu_resolucao: extra.viu ?? false, p_tempo_ms: 1000
});
const concluir = (a, s) => a.rpc('concluir_sessao', { p_sessao: s });
async function licaoCompleta(a, r, assunto, ids, certas = ids.length) {
  const s = await iniciar(a, 'licao', r, assunto, null, ids);
  for (const [i, q] of ids.entries()) await responder(a, s, q, i < certas ? gab[q] : errada(q));
  return concluir(a, s);
}

// ---------- setup_completo.sql (banco novo) roda inteiro
{
  const e = await erro(criarBanco([ler('supabase/setup_completo.sql')]));
  check('S01', 'setup_completo.sql roda num banco novo', !e, e ?? '');
}

const migrations = readdirSync(new URL('supabase/migrations/', raiz)).sort().map((f) => ler(`supabase/migrations/${f}`));
const db = await criarBanco(migrations);
const MAT = 'enem-MAT';
const temasMAT = temas(MAT);
const grande = temasMAT.find((t) => t.total >= 6).assunto; // subconteúdo com 5+ questões
const pequeno = temasMAT.find((t) => t.total < 5).assunto; // subconteúdo curto
const doGrande = porRecorte(MAT).filter((q) => q.assunto === grande).map((q) => q.id);
const outrosMAT = porRecorte(MAT).filter((q) => q.assunto !== grande).map((q) => q.id);
const deHistoria = porRecorte('enem-HIS').map((q) => q.id);

// ---------- Lição limitada às suas questões e ao tamanho (N01)
{
  const a = await criarAluno(db, uid());
  const s = await iniciar(a, 'licao', MAT, grande, null, doGrande.slice(0, 5));
  const e1 = await erro(responder(a, s, outrosMAT[0], gab[outrosMAT[0]]));
  check('RP27', 'Lição recusa questão fora da lista', !!e1, e1 ?? 'aceitou');
  const e2 = await erro(responder(a, s, deHistoria[0], gab[deHistoria[0]]));
  check('RP27', 'Lição recusa questão de outra matéria', !!e2, e2 ?? 'aceitou');

  const a2 = await criarAluno(db, uid());
  const s2 = await iniciar(a2, 'licao', MAT, grande, null, doGrande.slice(0, 5));
  let aceitas = 0;
  for (const q of porRecorte(MAT).slice(0, 60).map((x) => x.id)) if (!(await erro(responder(a2, s2, q, gab[q])))) aceitas++;
  const r = await concluir(a2, s2);
  check('RP27', 'Ataque de 60 respostas numa lição fica em até 5 e 55 XP', aceitas <= 5 && r.xp <= 55, `${aceitas} aceitas, +${r.xp} XP`);

  const casos = [
    ['N01a', 'Lição com 6 questões é recusada', doGrande.slice(0, 6)],
    ['N01b', 'Subconteúdo com 5+ questões não aceita questão de outro', [...doGrande.slice(0, 4), outrosMAT[0]]],
    ['N01c', 'Lista com questão repetida é recusada', [doGrande[0], doGrande[0], doGrande[1]]],
    ['N01d', 'Lista com questão de outra matéria é recusada', [...doGrande.slice(0, 4), deHistoria[0]]],
    ['N01e', 'Lista sem questão do subconteúdo é recusada', outrosMAT.slice(0, 5)],
    ['N01f', 'Lição sem lista (app antigo) é recusada', null]
  ];
  for (const [id, nome, lista] of casos) {
    const e = await erro(iniciar(a, 'licao', MAT, grande, null, lista));
    check(id, nome, !!e, e ?? 'aceitou');
  }
}

// ---------- Lições normais (o que o app faz) e regressões da 0006
{
  const a = await criarAluno(db, uid());
  const ids = licaoDe(MAT, grande);
  const r = await licaoCompleta(a, MAT, grande, ids);
  check('L01', 'Lição normal de 5 questões, todas certas', r.total === 5 && r.xp === 55 && r.perfeita, JSON.stringify({ total: r.total, xp: r.xp }));
  const rP = await licaoCompleta(a, MAT, pequeno, licaoDe(MAT, pequeno), 3);
  check('L02', 'Subconteúdo curto completado com a matéria (B06)', rP.total === 5 && rP.acertos === 3, JSON.stringify({ total: rP.total, acertos: rP.acertos }));
  const tING = temas('enem-ING')[0].assunto;
  const rI = await licaoCompleta(a, 'enem-ING', tING, licaoDe('enem-ING', tING));
  check('L03', 'Lição de Inglês (matéria com língua)', rI.total > 0, `${rI.total} questões`);

  const c = await criarAluno(db, uid());
  const s = await iniciar(c, 'licao', MAT, grande, null, ids);
  await responder(c, s, ids[0], errada(ids[0]));
  const rep = await responder(c, s, ids[0], gab[ids[0]]);
  check('RP02', 'Clique repetido devolve a 1ª resposta', rep.repetida === true && rep.correta === false);
  const v = (await c.sql('select vidas from perfis')).rows[0].vidas;
  await responder(c, s, ids[0], errada(ids[0]));
  const v2 = (await c.sql('select vidas from perfis')).rows[0].vidas;
  check('RP05', 'Erro repetido não tira outra vida', v === v2, `${v} → ${v2}`);
  const c1 = await concluir(c, s); const c2 = await concluir(c, s);
  check('RP10', 'Concluir 2 vezes não soma de novo', JSON.stringify(c1) === JSON.stringify(c2));
  const e = await erro(responder(c, s, ids[1], gab[ids[1]]));
  check('RP11', 'Responder após concluir é recusado', !!e, e ?? 'aceitou');

  const b = await criarAluno(db, uid());
  const sb = await iniciar(b, 'licao', MAT, grande, null, ids);
  for (const q of ids.slice(0, 3)) await responder(b, sb, q, errada(q));
  const e4 = await erro(responder(b, sb, ids[3], gab[ids[3]]));
  check('RP17', 'Sem vidas a lição recusa resposta', /sem_vidas/.test(e4 ?? ''), e4 ?? 'aceitou');
  const e5 = await erro(responder(a, sb, ids[3], gab[ids[3]]));
  check('RP13', 'Responder na sessão de outro aluno é recusado', !!e5, e5 ?? 'aceitou');
}

// ---------- Revisão (N02 e N04)
{
  const a = await criarAluno(db, uid());
  const ids = licaoDe(MAT, grande);
  await licaoCompleta(a, MAT, grande, ids, 2); // 2 certas, 3 erradas: entram na fila
  const fila = ids.slice(2);
  const fora = outrosMAT.find((q) => !ids.includes(q));

  const s = await iniciar(a, 'revisao', null, null, null);
  const e1 = await erro(responder(a, s, fora, gab[fora]));
  check('RP23', 'Revisão recusa questão fora da fila', !!e1, e1 ?? 'aceitou');
  const e1b = await erro(responder(a, s, ids[0], gab[ids[0]]));
  check('RP23', 'Revisão recusa questão acertada (não está na fila)', !!e1b, e1b ?? 'aceitou');

  await responder(a, s, fila[0], null, { dicas: 2, viu: true });
  const e2 = await erro(responder(a, s, fila[0], gab[fila[0]]));
  check('RP22', 'Depois de ver a resolução, resposta é recusada', !!e2, e2 ?? 'aceitou');

  await a.rpc('abrir_dica', { p_sessao: s, p_questao: fila[1], p_dica: 1 });
  await responder(a, s, fila[1], gab[fila[1]], { dicas: 0 });
  const d = (await a.sql('select dicas_usadas from tentativas where sessao_id = $1 and questao_id = $2', [s, fila[1]])).rows[0].dicas_usadas;
  check('RP24', 'Dica aberta conta mesmo se o app informar 0', d === 1, `dicas_usadas = ${d}`);

  await responder(a, s, fila[2], errada(fila[2]));
  const rep = await responder(a, s, fila[2], errada(fila[2]));
  const outra = ['A', 'B', 'C', 'D', 'E'].find((l) => l !== gab[fila[2]] && l !== errada(fila[2]));
  await responder(a, s, fila[2], outra);
  const e3 = await erro(responder(a, s, fila[2], gab[fila[2]]));
  check('R01', 'Terceira tentativa na mesma questão é recusada', !!e3 && rep.repetida === true, e3 ?? 'aceitou');
  const e4 = await erro(responder(a, s, fila[1], errada(fila[1])));
  check('R02', 'Depois de acertar, outra letra é recusada', !!e4, e4 ?? 'aceitou');

  const r = await concluir(a, s);
  const status = Object.fromEntries((await a.sql('select questao_id, status from fila_revisao')).rows.map((x) => [x.questao_id, x.status]));
  check('R03', 'Só a questão sem resolução conta, com 4 XP (1 dica)', r.acertos === 1 && r.xp === 4 && r.total === 3, JSON.stringify({ acertos: r.acertos, xp: r.xp, total: r.total }));
  check('R04', 'Questão vista na resolução continua pendente', status[fila[0]] === 'pendente' && status[fila[1]] === 'pendente', JSON.stringify(status));

  const s2 = await iniciar(a, 'revisao', null, null, null);
  await responder(a, s2, fila[2], gab[fila[2]]);
  const r2 = await concluir(a, s2);
  const st = (await a.sql('select status from fila_revisao where questao_id = $1', [fila[2]])).rows[0].status;
  check('R05', 'Acerto sem dica dá 5 XP e vira dominada', r2.xp === 5 && st === 'dominada', `${r2.xp} XP, ${st}`);
  const s3 = await iniciar(a, 'revisao', null, null, null);
  const e5 = await erro(responder(a, s3, fila[2], gab[fila[2]]));
  check('R06', 'Questão dominada não volta a dar XP', !!e5, e5 ?? 'aceitou');
  const e6 = await erro(a.rpc('abrir_dica', { p_sessao: s3, p_questao: fora, p_dica: 1 }));
  check('R08', 'Dica de questão fora da fila é recusada', !!e6, e6 ?? 'aceitou');

  const b = await criarAluno(db, uid());
  await db.query(`insert into fila_revisao (perfil_id, questao_id, vence_em, status) select $1, id, now(), 'pendente' from questoes where recorte_id = 'enem-MAT' order by id limit 11`, [b.id]);
  const naFila = (await db.query('select questao_id from fila_revisao where perfil_id = $1 order by questao_id', [b.id])).rows.map((x) => x.questao_id);
  const s4 = await iniciar(b, 'revisao', null, null, null);
  let aceitas = 0;
  for (const q of naFila) if (!(await erro(responder(b, s4, q, gab[q])))) aceitas++;
  check('R07', 'Revisão aceita até 10 questões', aceitas === 10, `${aceitas} de ${naFila.length}`);
}

// ---------- Desafio (N03)
{
  const R = 'enem-TIC';
  const un = unidades(R);
  const a = await criarAluno(db, uid());
  const pool0 = porRecorte(R).filter((q) => un[0].includes(q.assunto)).map((q) => q.id);
  const n0 = Math.min(10, pool0.length);

  const e1 = await erro(iniciar(a, 'desafio', MAT, null, 5, porRecorte(MAT).filter((q) => unidades(MAT)[5]?.includes(q.assunto)).slice(0, 10).map((q) => q.id)));
  check('RP26', 'Desafio de unidade bloqueada é recusado', !!e1, e1 ?? 'aceitou');
  const e2 = await erro(iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0)));
  check('RP26', 'Desafio sem os subconteúdos feitos é recusado', !!e2, e2 ?? 'aceitou');

  for (const t of un[0]) await licaoCompleta(a, R, t, licaoDe(R, t));
  const e3 = await erro(iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0 - 1)));
  check('D01', 'Desafio com menos questões que o normal é recusado', !!e3, e3 ?? 'aceitou');
  const foraUn = porRecorte(R).find((q) => !un[0].includes(q.assunto));
  if (foraUn) {
    const e4 = await erro(iniciar(a, 'desafio', R, null, 0, [...pool0.slice(0, n0 - 1), foraUn.id]));
    check('D02', 'Desafio com questão de outra unidade é recusado', !!e4, e4 ?? 'aceitou');
  }

  const s1 = await iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0));
  await responder(a, s1, pool0[0], gab[pool0[0]]);
  const r1 = await concluir(a, s1);
  check('RP25', 'Desafio com 1 resposta não libera unidade', !r1.aprovado, `aprovado = ${r1.aprovado}`);

  const s2 = await iniciar(a, 'desafio', R, null, 0, pool0.slice(0, n0));
  const certas = Math.ceil(n0 * 0.7);
  for (const [i, q] of pool0.slice(0, n0).entries()) await responder(a, s2, q, i < certas ? gab[q] : errada(q));
  const r2 = await concluir(a, s2);
  const ok = (await a.sql('select desafio_ok from progresso_unidade where chave = $1', [`${R}|0`])).rows[0]?.desafio_ok;
  check('D03', `Desafio normal com ${certas}/${n0} é aprovado e grava a unidade`, r2.aprovado === true && ok === true, JSON.stringify({ aprovado: r2.aprovado, ok }));

  const unM = unidades(MAT);
  const b = await criarAluno(db, uid());
  for (const t of unM[0]) await licaoCompleta(b, MAT, t, licaoDe(MAT, t));
  const poolM1 = porRecorte(MAT).filter((q) => unM[1].includes(q.assunto)).map((q) => q.id).slice(0, 10);
  const e5 = await erro(iniciar(b, 'desafio', MAT, null, 1, poolM1));
  check('D04', 'Unidade 2 bloqueada sem vencer o desafio da unidade 1', !!e5, e5 ?? 'aceitou');

  // A divisão em unidades do banco tem de ser a mesma do app, em todas as matérias e nas duas línguas
  let iguais = 0, total = 0; const dif = [];
  for (const lingua of ['Inglês', 'Espanhol']) for (const r of conteudo.recortes.map((x) => x.id)) {
    const u = unidades(r, lingua);
    for (let i = 0; i <= u.length; i++) {
      total++;
      const sql = (await db.query('select public._temas_da_unidade($1, $2, $3) as t', [r, lingua, i])).rows[0].t;
      if (JSON.stringify(sql) === JSON.stringify(u[i] ?? [])) iguais++; else dif.push(`${r}/${lingua}/${i}`);
    }
  }
  check('D05', 'Unidades do banco iguais às do app', iguais === total, `${iguais}/${total} ${dif.slice(0, 3).join(' ')}`);
}

// ---------- Vidas: recarga de 1 a cada 2 horas e +1 por anúncio, até 5 em 24 horas (0008)
{
  const vidasAgora = async (vidas, minutosAtras) =>
    (await db.query(`select public._vidas_agora($1, now() - make_interval(mins => $2)) as v`, [vidas, minutosAtras])).rows[0].v;
  check('V01', 'Sem recarga antes de 2 horas', (await vidasAgora(1, 119)) === 1);
  check('V02', 'Uma vida volta com 2 horas', (await vidasAgora(1, 121)) === 2);
  check('V03', 'Recarga nunca passa de 3', (await vidasAgora(0, 600)) === 3);

  const a = await criarAluno(db, uid());
  await db.query("update perfis set vidas = 1, vidas_atualizadas_em = now() - interval '150 minutes' where id = $1", [a.id]);
  const nova = (await db.query('select public._ajustar_vidas($1, -1) as v', [a.id])).rows[0].v;
  const marco = (await db.query("select round(extract(epoch from now() - vidas_atualizadas_em) / 60)::int as m from perfis where id = $1", [a.id])).rows[0].m;
  check('V04', 'Erro depois de uma recarga mantém o relógio da próxima vida', nova === 1 && marco === 30, `vidas ${nova}, próxima recarga começou há ${marco} min`);

  await db.query('update perfis set vidas = 0, vidas_atualizadas_em = now() where id = $1', [a.id]);
  const r = await a.rpc('ganhar_vida_anuncio', {});
  check('V05', 'Anúncio devolve 1 vida na hora', r.vidas === 1, JSON.stringify(r));
  for (let i = 0; i < 4; i++) await a.rpc('ganhar_vida_anuncio', {});
  const e = await erro(a.rpc('ganhar_vida_anuncio', {}));
  check('RP19', '6º anúncio em 24 horas é recusado', /limite_anuncios/.test(e ?? ''), e ?? 'aceitou');
}

// ---------- Gravação direta e permissões
{
  const a = await criarAluno(db, uid());
  const e1 = await erro(a.sql('delete from preferencias where perfil_id = auth.uid()'));
  const resta = (await db.query('select count(*)::int n from preferencias where perfil_id = $1', [a.id])).rows[0].n;
  check('DB32', 'Aluno não apaga as próprias preferências', resta === 1, e1 ?? 'apagou');
  await a.sql('update preferencias set meta_xp = 20 where perfil_id = auth.uid()');
  await a.sql("update preferencias set tema = 'escuro' where perfil_id = auth.uid()");
  const p = (await db.query('select meta_xp, tema from preferencias where perfil_id = $1', [a.id])).rows[0];
  check('DB24', 'Alterar um campo das preferências não apaga o outro', p.meta_xp === 20 && p.tema === 'escuro', JSON.stringify(p));
  const e2 = await erro(a.sql('update perfis set xp_total = 9999'));
  check('DB01', 'Aluno não altera xp_total direto', !!e2, e2 ?? 'alterou');
  const e3 = await erro(a.sql("update sessoes_estudo set questoes = '{}'"));
  check('DB16', 'Aluno não altera a lista de questões da sessão', !!e3, e3 ?? 'alterou');
  const e4 = await erro(a.sql("select public._temas_da_unidade('enem-MAT', null, 0)"));
  check('AN01', 'Aluno não chama a função interna de unidades', !!e4, e4 ?? 'chamou');
  await db.exec("reset role; select set_config('request.jwt.claim.sub', '', false); set role anon;");
  const e5 = await erro(db.query("select public.iniciar_sessao('licao', 'enem', 'enem-MAT', 'x', null, 'UTC', '{}')"));
  const e6 = await erro(db.query("select public.abrir_dica(gen_random_uuid(), 'x', 1)"));
  await db.exec('reset role;');
  check('AN02', 'Anônimo não chama iniciar_sessao nem abrir_dica', !!e5 && !!e6, `${e5} | ${e6}`);
  const versoes = (await db.query("select count(*)::int n from pg_proc where proname = 'iniciar_sessao'")).rows[0].n;
  check('AN03', 'Só existe a versão nova de iniciar_sessao', versoes === 1, `${versoes} versões`);
}

const falhas = resultados.filter((ok) => !ok).length;
console.log(`\n${resultados.length - falhas} de ${resultados.length} passaram`);
process.exit(falhas ? 1 : 0);
