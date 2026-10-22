import { createClient } from '@supabase/supabase-js';
import type { Repo } from '../data/repo';
import { demoRepo } from '../data/demoRepo';
import { criarSupabaseRepo } from '../data/supabaseRepo';

const url = import.meta.env.VITE_SUPABASE_URL as string | undefined;
const chave = import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined;

export const supabaseConfigurado = !!(url && chave && !url.includes('SEU-PROJETO'));

export const supabase = supabaseConfigurado
  ? createClient(url!, chave!, { auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true, flowType: 'pkce' } })
  : null;

export const repo: Repo = supabase ? criarSupabaseRepo(supabase) : demoRepo;
