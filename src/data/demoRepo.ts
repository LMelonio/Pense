// Modo demonstração: tudo fica no navegador (localStorage). Útil para testar sem configurar o Supabase.
import type { Repo, Usuario } from './repo';
import { carregarConteudoLocal } from './repo';
import type { DadosAluno } from './types';
import { PREFS_PADRAO } from './types';
import { VIDAS_MAX } from '../domain/regras';

const K_USER = 'pense:demo:usuario';
const kDados = (id: string) => `pense:demo:dados:${id}`;
type Ouvinte = (u: Usuario | null) => void;
const ouvintes = new Set<Ouvinte>();

function ler<T>(k: string): T | null {
  try { const v = localStorage.getItem(k); return v ? (JSON.parse(v) as T) : null; } catch { return null; }
}
function gravar(k: string, v: unknown) {
  try { localStorage.setItem(k, JSON.stringify(v)); } catch { /* armazenamento indisponível */ }
}
function avisar(u: Usuario | null) { ouvintes.forEach((cb) => cb(u)); }
const novoId = () => (crypto.randomUUID ? crypto.randomUUID() : String(Date.now()) + Math.random().toString(16).slice(2));

export function dadosIniciais(u: Usuario): DadosAluno {
  const agora = new Date().toISOString();
  return {
    perfil: { id: u.id, nome: u.nome || 'Estudante', usuario: null, xp_total: 0, vidas: VIDAS_MAX, vidas_atualizadas_em: agora, sequencia_atual: 0, sequencia_recorde: 0, ultimo_dia_meta: null, questoes_feitas: 0, acertos_total: 0, revisoes_concluidas: 0 },
    prefs: { ...PREFS_PADRAO },
    temas: {}, revisao: {}, xpDia: {}, conquistas: {}, unidades: {}, vistas: [], acertadas: [], interessePro: null
  };
}

export const demoRepo: Repo = {
  modo: 'demo',
  carregarConteudo: carregarConteudoLocal,
  async usuarioAtual() { return ler<Usuario>(K_USER); },
  aoMudarUsuario(cb) { ouvintes.add(cb); return () => { ouvintes.delete(cb); }; },
  async provedores() { return { google: false, email: true, anonimo: true }; },
  async entrarEmail(email) {
    const contas = ler<Record<string, Usuario>>('pense:demo:contas') ?? {};
    const u = contas[email.toLowerCase()];
    if (!u) throw new Error('Conta não encontrada neste navegador. Crie uma conta.');
    gravar(K_USER, u); avisar(u);
  },
  async cadastrarEmail(email, _senha, nome) {
    const contas = ler<Record<string, Usuario>>('pense:demo:contas') ?? {};
    const u: Usuario = contas[email.toLowerCase()] ?? { id: novoId(), email, anonimo: false, nome, provedor: 'email' };
    contas[email.toLowerCase()] = u; gravar('pense:demo:contas', contas); gravar(K_USER, u); avisar(u);
    return { confirmarEmail: false };
  },
  async entrarGoogle() { throw new Error('No modo demonstração o login com Google fica desligado. Configure o Supabase para usar.'); },
  async entrarAnonimo() {
    const u: Usuario = { id: novoId(), email: null, anonimo: true, nome: 'Estudante', provedor: 'anonimo' };
    gravar(K_USER, u); avisar(u);
  },
  async vincularEmail(email) {
    const u = ler<Usuario>(K_USER); if (!u) return { confirmarEmail: false };
    const nu: Usuario = { ...u, email, anonimo: false, provedor: 'email' };
    const contas = ler<Record<string, Usuario>>('pense:demo:contas') ?? {};
    contas[email.toLowerCase()] = nu; gravar('pense:demo:contas', contas); gravar(K_USER, nu); avisar(nu);
    return { confirmarEmail: false };
  },
  async vincularGoogle() { throw new Error('No modo demonstração o login com Google fica desligado. Configure o Supabase para usar.'); },
  async recuperarSenha() { throw new Error('No modo demonstração não há envio de e-mail. Crie a conta de novo neste navegador.'); },
  async definirSenha() { /* no modo demonstração a senha não é conferida */ },
  async sair() { localStorage.removeItem(K_USER); avisar(null); },
  async carregarDados(u) {
    const d = ler<DadosAluno>(kDados(u.id));
    if (!d) return dadosIniciais(u);
    return { ...dadosIniciais(u), ...d, prefs: { ...PREFS_PADRAO, ...d.prefs } };
  },
  // No navegador vale o cálculo do app (src/domain/regras.ts): o salvar grava tudo, e as sessões não têm servidor.
  async salvar(d) { gravar(kDados(d.perfil.id), d); },
  async iniciarSessao() { return novoId(); },
  async responder() { /* o resultado já foi aplicado na tela e gravado pelo salvar */ },
  async abrirDica() { /* no navegador vale o número de dicas da tela */ },
  async concluirSessao() { return null; },
  async ganharVidaAnuncio() { /* a vida já foi somada na tela e gravada pelo salvar */ },
  async excluirConta() {
    const u = ler<Usuario>(K_USER);
    if (u) { localStorage.removeItem(kDados(u.id)); localStorage.removeItem(`pense:demo:sessoes:${u.id}`); }
    localStorage.removeItem(K_USER); avisar(null);
  }
};
