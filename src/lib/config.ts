import { createClient } from '@supabase/supabase-js';
import type { Repo } from '../data/repo';
import { demoRepo } from '../data/demoRepo';
import { criarSupabaseRepo } from '../data/supabaseRepo';

const url = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const chave = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;

export const supabaseConfigurado = !!(url && chave && !url.includes('SEU-PROJETO'));

const LIMITE_MS = 10000;

/** fetch com limite de tempo: sem isso, uma chamada pendurada deixa o app em "Carregando…" para sempre. */
function fetchComLimite(entrada: RequestInfo | URL, init: RequestInit = {}) {
  const ctrl = new AbortController();
  const relogio = setTimeout(() => ctrl.abort(new DOMException('O servidor demorou para responder.', 'TimeoutError')), LIMITE_MS);
  if (init.signal?.aborted) ctrl.abort(init.signal.reason);
  else init.signal?.addEventListener('abort', () => ctrl.abort(init.signal?.reason), { once: true });
  return fetch(entrada, { ...init, signal: ctrl.signal }).finally(() => clearTimeout(relogio));
}

export const supabase = supabaseConfigurado
  ? createClient(url!, chave!, {
    auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true, flowType: 'pkce' },
    global: { fetch: fetchComLimite }
  })
  : null;

export const repo: Repo = supabase ? criarSupabaseRepo(supabase, url!, chave!) : demoRepo;
