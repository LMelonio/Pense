// Camada de dados: o app fala só com esta interface.
// Com VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY definidos, usa o Supabase; sem eles, o modo demonstração (navegador).
import type { Conteudo, DadosAluno, Sessao, Tentativa } from './types';

export interface Usuario { id: string; email: string | null; anonimo: boolean; nome?: string | null }

export interface Mudancas {
  perfil?: boolean;
  prefs?: boolean;
  temas?: string[];
  revisao?: string[];
  xpDia?: string[];
  conquistas?: string[];
  unidades?: string[];
  vistas?: string[];
  interessePro?: boolean;
}

export interface Repo {
  modo: 'supabase' | 'demo';
  carregarConteudo(): Promise<Conteudo>;
  usuarioAtual(): Promise<Usuario | null>;
  aoMudarUsuario(cb: (u: Usuario | null) => void): () => void;
  entrarEmail(email: string, senha: string): Promise<void>;
  cadastrarEmail(email: string, senha: string, nome: string): Promise<{ confirmarEmail: boolean }>;
  entrarGoogle(): Promise<void>;
  entrarAnonimo(): Promise<void>;
  vincularEmail(email: string, senha: string): Promise<void>;
  sair(): Promise<void>;
  carregarDados(u: Usuario): Promise<DadosAluno>;
  salvar(d: DadosAluno, m: Mudancas): Promise<void>;
  registrarSessao(s: Sessao, t: Tentativa[]): Promise<void>;
  exportar(d: DadosAluno): Promise<unknown>;
  excluirConta(): Promise<void>;
}

export async function carregarConteudoLocal(): Promise<Conteudo> {
  const r = await fetch('./data/conteudo.json');
  if (!r.ok) throw new Error('Não foi possível carregar as questões.');
  const j = await r.json();
  return { exames: j.exames, recortes: j.recortes, textos_base: j.textos_base, questoes: j.questoes };
}
