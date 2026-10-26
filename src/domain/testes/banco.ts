// Postgres local para os testes (PGlite, sem Docker): roda as migrations e as questões de supabase/seed como no
// Supabase (papéis anon/authenticated, auth.uid() e permissões padrão) e dá acesso "como aluno" (RLS valendo).
// Uso: npm install --no-save @electric-sql/pglite@0.2.17 (não fica no package.json; o CI instala antes dos testes).
import { readFileSync, readdirSync } from 'node:fs';
import type { SupabaseClient } from '@supabase/supabase-js';
import type { Conteudo } from '../../data/types';

/** O pedaço do PGlite que os testes usam (o pacote é carregado na hora, sem tipos no typecheck). */
export interface Banco {
  exec(sql: string): Promise<unknown>;
  query<T = Record<string, unknown>>(sql: string, params?: unknown[]): Promise<{ rows: T[] }>;
  transaction<T>(f: (tx: Banco) => Promise<T>): Promise<T>;
}

const raiz = new URL('../../../', import.meta.url);
export const ler = (caminho: string) => readFileSync(new URL(caminho, raiz), 'utf8');
export const conteudo: Conteudo = JSON.parse(ler('public/data/conteudo.json'));

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
const semPgcrypto = (sql: string) => sql.replace(/create extension if not exists pgcrypto;/g, ''); // gen_random_uuid já vem no Postgres

export const migrations = () => readdirSync(new URL('supabase/migrations/', raiz)).sort().map((f) => ler(`supabase/migrations/${f}`));

export async function criarBanco(arquivosSql = migrations()): Promise<Banco> {
  const nome = '@electric-sql/pglite';
  let PGlite: new () => Banco;
  try { ({ PGlite } = await import(/* @vite-ignore */ nome)); } catch {
    throw new Error('Instale o PGlite antes: npm install --no-save @electric-sql/pglite@0.2.17');
  }
  const db = new PGlite();
  await db.exec(PREPARO);
  for (const sql of arquivosSql) await db.exec(semPgcrypto(sql));
  for (const f of readdirSync(new URL('supabase/seed/', raiz)).sort()) await db.exec(ler(`supabase/seed/${f}`));
  return db;
}

let seq = 0;
/** Ids previsíveis e diferentes em cada teste. */
export const novoUid = () => `00000000-0000-0000-0000-${String(++seq).padStart(12, '0')}`;

/** Roda como o aluno: papel authenticated e auth.uid() = id, numa transação (nada vaza para a consulta seguinte). */
export function comoAluno(db: Banco, id: string) {
  return <T = Record<string, unknown>>(sql: string, params: unknown[] = []) => db.transaction(async (tx) => {
    await tx.query("select set_config('request.jwt.claim.sub', $1, true)", [id]);
    await tx.exec('set local role authenticated');
    return tx.query<T>(sql, params);
  });
}

export interface Aluno {
  id: string;
  sql: ReturnType<typeof comoAluno>;
  /** Chama uma função do banco como o aluno, com parâmetros nomeados (como o supabase.rpc). */
  rpc<T = unknown>(f: string, args?: Record<string, unknown>): Promise<T>;
}

/** Cria um aluno (o gatilho do cadastro cria perfil e preferências). */
export async function criarAluno(db: Banco, id = novoUid()): Promise<Aluno> {
  await db.query('insert into auth.users (id) values ($1)', [id]);
  const sql = comoAluno(db, id);
  const rpc = async <T,>(f: string, args: Record<string, unknown> = {}) => {
    const nomes = Object.keys(args);
    const r = await sql<{ r: string | null }>(`select public.${f}(${nomes.map((n, i) => `${n} => $${i + 1}`).join(', ')})::text as r`, Object.values(args));
    return lerRetorno(r.rows[0]?.r) as T;
  };
  return { id, sql, rpc };
}

/** Roda como visitante sem login (papel anon). */
export function comoAnonimo(db: Banco) {
  return <T = Record<string, unknown>>(sql: string, params: unknown[] = []) => db.transaction(async (tx) => {
    await tx.exec('set local role anon');
    return tx.query<T>(sql, params);
  });
}

/** "Passa o tempo" para um aluno: recua em N dias tudo o que ele tem guardado com data (o banco não tem relógio falso). */
export async function passarDias(db: Banco, id: string, dias: number) {
  if (!/^[0-9a-f-]{36}$/.test(id) || !Number.isInteger(dias)) throw new Error('aluno ou dias inválidos');
  const n = `make_interval(days => ${dias})`;
  await db.exec(`
    update public.fila_revisao set vence_em = vence_em - ${n} where perfil_id = '${id}';
    update public.perfis set vidas_atualizadas_em = vidas_atualizadas_em - ${n}, ultimo_dia_meta = ultimo_dia_meta - ${dias},
      dia_vida_revisao = dia_vida_revisao - ${dias} where id = '${id}';
    with x as (delete from public.xp_diario where perfil_id = '${id}' returning *) insert into public.xp_diario select perfil_id, dia - ${dias}, xp from x;
    update public.sessoes_estudo set inicio = inicio - ${n}, fim = fim - ${n} where perfil_id = '${id}';
    update public.tentativas set criado_em = criado_em - ${n} where perfil_id = '${id}';
    update public.vidas_ganhas set criado_em = criado_em - ${n} where perfil_id = '${id}';
  `);
}

/** O que o PostgREST devolveria: jsonb vira objeto, uuid fica texto, void vira null. */
function lerRetorno(r: string | null | undefined) {
  if (r == null || r === '') return null;
  try { return JSON.parse(r); } catch { return r; }
}

// ---------- Cliente Supabase falso: o supabaseRepo de verdade, falando com o PGlite como o aluno

type Resultado = { data: unknown; error: { message: string } | null };
const IDENT = /^[a-z_]+$/;
function ident(x: string) {
  if (!IDENT.test(x)) throw new Error(`nome inválido: ${x}`);
  return x;
}

/** O pedaço do construtor de consultas do supabase-js que o supabaseRepo usa (select, eq, gte, update…). */
class Consulta implements PromiseLike<Resultado> {
  private colunas = '*';
  private filtros: [string, string, unknown][] = [];
  private limite: number | null = null;
  private desde = 0;
  private ordem: string | null = null;
  private unico = false;
  private mudanca: Record<string, unknown> | null = null;
  constructor(private sql: ReturnType<typeof comoAluno>, private tabela: string) {}
  select(c = '*') { this.colunas = c; return this; }
  eq(c: string, v: unknown) { this.filtros.push([c, '=', v]); return this; }
  gte(c: string, v: unknown) { this.filtros.push([c, '>=', v]); return this; }
  limit(n: number) { this.limite = n; return this; }
  range(de: number, ate: number) { this.desde = de; this.limite = ate - de + 1; return this; }
  order(c: string) { this.ordem = c; return this; }
  abortSignal() { return this; }
  maybeSingle() { this.unico = true; return this; }
  update(v: Record<string, unknown>) { this.mudanca = v; return this; }
  then<A = Resultado, B = never>(ok?: ((r: Resultado) => A | PromiseLike<A>) | null, falha?: ((e: unknown) => B | PromiseLike<B>) | null) {
    return this.executar().then(ok, falha);
  }
  private async executar(): Promise<Resultado> {
    try {
      const params: unknown[] = [];
      const p = (v: unknown) => { params.push(typeof v === 'object' && v !== null ? JSON.stringify(v) : v); return `$${params.length}`; };
      const tabela = ident(this.tabela);
      if (this.mudanca) {
        const sets = Object.entries(this.mudanca).map(([c, v]) => `${ident(c)} = ${p(v)}`).join(', ');
        const onde = this.filtros.map(([c, op, v]) => `${ident(c)} ${op} ${p(v)}`).join(' and ');
        await this.sql(`update public.${tabela} set ${sets}${onde ? ` where ${onde}` : ''}`, params);
        return { data: null, error: null };
      }
      const cols = this.colunas === '*' ? '*' : this.colunas.split(',').map((c) => ident(c.trim())).join(', ');
      const onde = this.filtros.map(([c, op, v]) => `${ident(c)} ${op} ${p(v)}`).join(' and ');
      const r = await this.sql<{ linhas: unknown[] }>(
        `select coalesce(json_agg(t), '[]'::json) as linhas from (select ${cols} from public.${tabela}${onde ? ` where ${onde}` : ''}` +
        `${this.ordem ? ` order by ${ident(this.ordem)}` : ''}${this.limite != null ? ` limit ${this.limite}` : ''}${this.desde ? ` offset ${this.desde}` : ''}) t`,
        params
      );
      const linhas = r.rows[0].linhas;
      return { data: this.unico ? (linhas[0] ?? null) : linhas, error: null };
    } catch (e) {
      return { data: null, error: { message: (e as Error).message } };
    }
  }
}

/** Um SupabaseClient que só conhece from() e rpc() (o que o supabaseRepo usa nas sessões e ao carregar os dados),
 * ligados ao PGlite como o aluno `id`. */
export function clienteFalso(db: Banco, id: string): SupabaseClient {
  const sql = comoAluno(db, id);
  const cliente = {
    from: (tabela: string) => new Consulta(sql, tabela),
    rpc: async (f: string, args: Record<string, unknown> = {}): Promise<Resultado> => {
      try {
        const nomes = Object.keys(args);
        const r = await sql<{ r: string | null }>(`select public.${ident(f)}(${nomes.map((n, i) => `${ident(n)} => $${i + 1}`).join(', ')})::text as r`, Object.values(args));
        return { data: lerRetorno(r.rows[0]?.r), error: null };
      } catch (e) {
        return { data: null, error: { message: (e as Error).message } };
      }
    }
  };
  return cliente as unknown as SupabaseClient;
}
