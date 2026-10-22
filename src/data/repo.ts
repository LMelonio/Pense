// Camada de dados: o app fala só com esta interface.
// Com VITE_SUPABASE_URL e VITE_SUPABASE_ANON_KEY definidos, usa o Supabase; sem eles, o modo demonstração (navegador).
import type { Conteudo, DadosAluno, Sessao, Tentativa } from './types';

/** Início de uma lição, desafio ou revisão. */
export type NovaSessao = Pick<Sessao, 'tipo' | 'exame_id' | 'recorte_id' | 'assunto'> & { unidade: number | null };

/** Resultado calculado pelo servidor ao concluir a sessão. */
export interface ResumoSessao {
  acertos: number; total: number; xp: number; perfeita: boolean; aprovado: boolean | null;
  conquistas: string[]; coroaAntes: number; coroaDepois: number;
}

export type Provedor = 'anonimo' | 'email' | 'google';
export interface Usuario { id: string; email: string | null; anonimo: boolean; nome?: string | null; provedor?: Provedor }

/** Formas de entrar ligadas no servidor. */
export interface Provedores { google: boolean; email: boolean; anonimo: boolean }

// O que mudou em DadosAluno. No Supabase, perfil (XP, vidas, sequência), temas, revisão, XP do dia, conquistas e
// unidades são calculados pelo servidor nas sessões; daqui só vão o nome, as preferências e o interesse no Pro.
export interface Mudancas {
  nome?: boolean;
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
  provedores(): Promise<Provedores>;
  entrarEmail(email: string, senha: string): Promise<void>;
  cadastrarEmail(email: string, senha: string, nome: string): Promise<{ confirmarEmail: boolean }>;
  entrarGoogle(): Promise<void>;
  entrarAnonimo(): Promise<void>;
  /** Visitante sem login passa a ter e-mail e senha, mantendo o progresso. */
  vincularEmail(email: string, senha: string): Promise<{ confirmarEmail: boolean }>;
  /** Visitante sem login liga uma conta Google, mantendo o progresso. */
  vincularGoogle(): Promise<void>;
  recuperarSenha(email: string): Promise<void>;
  definirSenha(senha: string): Promise<void>;
  sair(): Promise<void>;
  carregarDados(u: Usuario): Promise<DadosAluno>;
  salvar(d: DadosAluno, m: Mudancas): Promise<void>;
  /** Abre a sessão (no Supabase, no servidor). Devolve o id usado em responder e concluirSessao. */
  iniciarSessao(s: NovaSessao): Promise<string>;
  /** Registra uma resposta. No Supabase o servidor confere o gabarito, gasta a vida e agenda a revisão. */
  responder(sessao: string, t: Tentativa): Promise<void>;
  /** Fecha a sessão. No Supabase devolve o resultado calculado no servidor; no modo demonstração, null (vale o cálculo local). */
  concluirSessao(sessao: string): Promise<ResumoSessao | null>;
  /** +1 vida por anúncio assistido (no Supabase, com limite diário no servidor). */
  ganharVidaAnuncio(): Promise<void>;
  excluirConta(): Promise<void>;
}

export async function carregarConteudoLocal(): Promise<Conteudo> {
  const r = await fetch('./data/conteudo.json');
  if (!r.ok) throw new Error('Não foi possível carregar as questões.');
  const j = await r.json();
  return { exames: j.exames, recortes: j.recortes, textos_base: j.textos_base, questoes: j.questoes };
}

/** Endereço do app sem rota nem parâmetros: destino da volta do Google e dos links de e-mail. */
export const urlBase = () => location.origin + location.pathname;

/** Tira da barra de endereço os parâmetros de retorno (?recuperar, ?error…), mantendo a rota. */
export const limparRetornoDaUrl = () => history.replaceState(history.state, '', urlBase() + location.hash);

/** Voltou pelo link de "Esqueci minha senha" (ver recuperarSenha). */
export const voltouDaRecuperacao = () => new URLSearchParams(location.search).has('recuperar');

// Mensagens do Supabase Auth (em inglês) traduzidas para o aluno. A ordem importa: a primeira que casar vale.
const ERROS: [RegExp, string][] = [
  [/invalid login credentials/i, 'E-mail ou senha incorretos.'],
  [/already (been )?registered|user already exists|email_exists/i, 'Este e-mail já tem uma conta no Pense. Entre com ele.'],
  [/email not confirmed/i, 'Confirme seu e-mail pelo link que enviamos antes de entrar.'],
  [/password should be at least/i, 'A senha precisa de pelo menos 6 caracteres.'],
  [/weak|easy to guess|pwned/i, 'Essa senha é fácil demais de adivinhar. Escolha outra.'],
  [/should be different from the old/i, 'A nova senha precisa ser diferente da atual.'],
  [/rate limit|only request this after|too many/i, 'Muitas tentativas seguidas. Espere um pouco e tente de novo.'],
  [/anonymous sign-ins are disabled/i, 'O acesso sem login está desligado no Supabase (Authentication › Sign In / Providers).'],
  [/provider is not enabled|unsupported provider/i, 'O login com Google ainda não está disponível.'],
  [/manual linking is disabled/i, 'Ligar contas está desligado no Supabase (Authentication › Sign In / Providers).'],
  [/identity is already linked|identity_already_exists/i, 'Esta conta Google já pertence a outro usuário do Pense. Saia e entre direto com o Google.'],
  [/invalid format|email address .* is invalid|validate email/i, 'Digite um e-mail válido.'],
  [/not authorized/i, 'Não foi possível enviar e-mail para este endereço agora.'],
  [/session missing|jwt expired/i, 'Sua sessão expirou. Entre de novo.'],
  [/expired|invalid.*(link|token|code)|code verifier/i, 'O link expirou ou foi aberto em outro navegador. Peça um novo.'],
  [/signups? not allowed/i, 'Novos cadastros estão desligados no momento.'],
  [/failed to fetch|networkerror|load failed|network request failed/i, 'Sem conexão com o servidor. Confira sua internet.'],
  [/abort|timed? ?out|demorou/i, 'O servidor demorou para responder. Tente de novo.'],
  [/sem_vidas/i, 'Suas vidas acabaram.'],
  [/limite_anuncios/i, 'Você já ganhou 5 vidas com anúncios hoje. Espere a recarga ou conheça o Pense Pro.'],
  [/permission denied|row-level security|violates|constraint|sessão (não encontrada|já concluída)/i, 'O servidor recusou os dados. Recarregue o app e tente de novo.'],
  [/access_denied|cancel/i, 'O login foi cancelado.']
];

export function traduzirErro(msg: string) {
  return ERROS.find(([re]) => re.test(msg))?.[1] ?? msg;
}

/** Erro que o Supabase devolve na URL ao voltar do Google ou de um link de e-mail. */
export function erroDoRetorno() {
  const p = new URLSearchParams(location.search);
  const msg = p.get('error_description') || p.get('error');
  return msg ? traduzirErro(msg) : null;
}
