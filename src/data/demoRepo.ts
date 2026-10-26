// Modo demonstração: tudo fica no navegador (localStorage), sem Supabase. O demoRepo faz o papel do servidor com as
// regras do banco (domain/sessoes.ts): abre a sessão, confere o gabarito, gasta a vida, agenda a revisão e fecha a
// sessão devolvendo o resumo. As telas só gravam direto o nome, as preferências e o interesse no Pro, como no Supabase.
import type { Repo, Usuario } from './repo';
import { carregarConteudoLocal, traduzirErro } from './repo';
import type { Conteudo, DadosAluno, NovaSessao, Questao, ResumoSessao, Tentativa } from './types';
import { PREFS_PADRAO } from './types';
import { VIDAS_MAX, ajustarVidas, desafioLiberado, naRevisao, primeiraLicao, unidadesDoRecorte, vidasAgora } from '../domain/regras';
import { fecharLicao, fecharRevisao, marcarVista, registrarErro } from '../domain/sessoes';
import { catalogo } from '../domain/catalogo';

const K_USER = 'pense:demo:usuario';
const K_CONTAS = 'pense:demo:contas';
const kDados = (id: string) => `pense:demo:dados:${id}`;
const kSessoes = (id: string) => `pense:demo:sessoes:${id}`;
const kAnuncios = (id: string) => `pense:demo:anuncios:${id}`;
const SESSOES_GUARDADAS = 30;
const LIMITE_ANUNCIOS = 5; // por 24 horas, como ganhar_vida_anuncio
const DIA = 86400000;

type Ouvinte = (u: Usuario | null) => void;
const ouvintes = new Set<Ouvinte>();

/** Sessão guardada no navegador: o que o banco guarda em sessoes_estudo e tentativas. */
interface SessaoDemo extends NovaSessao {
  id: string;
  inicio: string;
  tentativas: Tentativa[];
  dicas: Record<string, number>;
  /** A primeira lição do aluno não gasta vida (como sessoes_estudo.sem_custo_vida, migration 0010). */
  semCustoVida?: boolean;
  resumo: ResumoSessao | null;
}

function ler<T>(k: string): T | null {
  try { const v = localStorage.getItem(k); return v ? (JSON.parse(v) as T) : null; } catch { return null; }
}
function gravar(k: string, v: unknown) {
  try { localStorage.setItem(k, JSON.stringify(v)); } catch { /* armazenamento indisponível */ }
}
function avisar(u: Usuario | null) { ouvintes.forEach((cb) => cb(u)); }
const novoId = () => (crypto.randomUUID ? crypto.randomUUID() : String(Date.now()) + Math.random().toString(16).slice(2));
/** Recusa com a mesma mensagem que o banco daria (traduzida para o aluno). */
function recusar(motivo: string): never { throw new Error(traduzirErro(motivo)); }

export function dadosIniciais(u: Pick<Usuario, 'id' | 'nome'>, agora = Date.now()): DadosAluno {
  return {
    perfil: { id: u.id, nome: u.nome || 'Estudante', usuario: null, xp_total: 0, vidas: VIDAS_MAX, vidas_atualizadas_em: new Date(agora).toISOString(), sequencia_atual: 0, sequencia_recorde: 0, ultimo_dia_meta: null, questoes_feitas: 0, acertos_total: 0, revisoes_concluidas: 0, dia_vida_revisao: null },
    prefs: { ...PREFS_PADRAO },
    temas: {}, revisao: {}, xpDia: {}, conquistas: {}, unidades: {}, vistas: [], acertadas: [], interessePro: null
  };
}

function dadosDe(u: Pick<Usuario, 'id' | 'nome'>): DadosAluno {
  const d = ler<DadosAluno>(kDados(u.id));
  if (!d) return dadosIniciais(u);
  const base = dadosIniciais(u);
  return { ...base, ...d, perfil: { ...base.perfil, ...d.perfil }, prefs: { ...PREFS_PADRAO, ...d.prefs } };
}

function usuarioLogado(): Usuario {
  return ler<Usuario>(K_USER) ?? recusar('session missing');
}

function sessoesDe(uid: string) { return ler<Record<string, SessaoDemo>>(kSessoes(uid)) ?? {}; }

/** Guarda a sessão e descarta as mais antigas (o resultado de cada uma já está nos dados do aluno). */
function gravarSessao(uid: string, s: SessaoDemo) {
  const todas = { ...sessoesDe(uid), [s.id]: s };
  const antigas = Object.values(todas).sort((a, b) => a.inicio.localeCompare(b.inicio)).slice(0, -SESSOES_GUARDADAS);
  for (const x of antigas) delete todas[x.id];
  gravar(kSessoes(uid), todas);
}

function sessaoAberta(uid: string, id: string) {
  const s = sessoesDe(uid)[id] ?? recusar('sessão não encontrada');
  if (s.resumo) recusar('sessão já concluída');
  return s;
}

let conteudo: Promise<Conteudo> | null = null;
const conteudoDemo = () => (conteudo ??= carregarConteudoLocal().catch((e) => { conteudo = null; throw e; }));

export const demoRepo: Repo = {
  modo: 'demo',
  carregarConteudo: conteudoDemo,
  async usuarioAtual() { return ler<Usuario>(K_USER); },
  aoMudarUsuario(cb) { ouvintes.add(cb); return () => { ouvintes.delete(cb); }; },
  async provedores() { return { google: false, email: true, anonimo: true }; },
  async entrarEmail(email) {
    const contas = ler<Record<string, Usuario>>(K_CONTAS) ?? {};
    const u = contas[email.toLowerCase()];
    if (!u) throw new Error('Conta não encontrada neste navegador. Crie uma conta.');
    gravar(K_USER, u); avisar(u);
  },
  async cadastrarEmail(email, _senha, nome) {
    const contas = ler<Record<string, Usuario>>(K_CONTAS) ?? {};
    const u: Usuario = contas[email.toLowerCase()] ?? { id: novoId(), email, anonimo: false, nome, provedor: 'email' };
    contas[email.toLowerCase()] = u; gravar(K_CONTAS, contas); gravar(K_USER, u); avisar(u);
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
    const contas = ler<Record<string, Usuario>>(K_CONTAS) ?? {};
    contas[email.toLowerCase()] = nu; gravar(K_CONTAS, contas); gravar(K_USER, nu); avisar(nu);
    return { confirmarEmail: false };
  },
  async vincularGoogle() { throw new Error('No modo demonstração o login com Google fica desligado. Configure o Supabase para usar.'); },
  async recuperarSenha() { throw new Error('No modo demonstração não há envio de e-mail. Crie a conta de novo neste navegador.'); },
  async definirSenha() { /* no modo demonstração a senha não é conferida */ },
  async sair() { localStorage.removeItem(K_USER); avisar(null); },
  async carregarDados(u) { return dadosDe(u); },

  // Como no Supabase: daqui só vão o nome, as preferências e o interesse no Pro.
  async salvar(d, m) {
    const base = dadosDe({ id: d.perfil.id, nome: d.perfil.nome });
    gravar(kDados(d.perfil.id), {
      ...base,
      perfil: m.nome ? { ...base.perfil, nome: d.perfil.nome } : base.perfil,
      prefs: m.prefs?.length ? { ...base.prefs, ...Object.fromEntries(m.prefs.map((k) => [k, d.prefs[k]])) } : base.prefs,
      interessePro: m.interessePro ? d.interessePro : base.interessePro
    });
  },

  async iniciarSessao(nova) {
    const u = usuarioLogado();
    if (nova.tipo === 'desafio') {
      const c = await conteudoDemo();
      const d = dadosDe(u);
      const unidades = unidadesDoRecorte(c, nova.recorte_id ?? '', d.prefs.lingua);
      if (!desafioLiberado(d, unidades, nova.recorte_id ?? '', nova.unidade ?? -1)) recusar('desafio_bloqueado');
    }
    const semCustoVida = nova.tipo === 'licao' && primeiraLicao(dadosDe(u));
    const s: SessaoDemo = { ...nova, id: novoId(), inicio: new Date().toISOString(), tentativas: [], dicas: {}, semCustoVida, resumo: null };
    gravarSessao(u.id, s);
    return s.id;
  },

  // As mesmas conferências de responder (migrations 0007, 0009 e 0010): questão da sessão, uma resposta por questão na
  // lição e no desafio (a primeira lição não gasta vida), até 2 tentativas na revisão (letra nula = ver a resolução).
  // Como no banco, a tentativa fica gravada na hora (a questão já conta como vista, mesmo sem concluir a sessão).
  async responder(sessao, t) {
    const u = usuarioLogado();
    const s = sessaoAberta(u.id, sessao);
    const q = catalogo(await conteudoDemo()).questao(t.questao_id) ?? recusar('questão não encontrada');
    const letra = t.letra?.trim().toUpperCase() || null;
    if (letra && !q.alternativas.some((a) => a.letra === letra)) recusar('alternativa inválida');
    const correta = !!letra && letra === q.gabarito;
    const d = dadosDe(u);
    const agora = Date.now();
    const daQuestao = s.tentativas.filter((x) => x.questao_id === q.id);
    if (s.tipo !== 'revisao') {
      if (!s.questoes?.includes(q.id)) recusar('questões fora da sessão');
      if (daQuestao.length) return; // clique repetido
      if (!letra) recusar('resposta vazia');
      const gastaVida = s.tipo === 'licao' && !s.semCustoVida;
      if (gastaVida && vidasAgora(d.perfil, agora).vidas === 0) recusar('sem_vidas');
      s.tentativas.push({ ...t, letra, correta, dicas_usadas: 0, viu_resolucao: false, origem: s.tipo });
      gravar(kDados(u.id), marcarVista(correta ? d : registrarErro(d, q.id, letra, gastaVida, agora), q.id));
    } else {
      if (!naRevisao(d.revisao[q.id], agora)) recusar('questão fora da revisão');
      if (letra && daQuestao.some((x) => x.letra === letra)) return; // clique repetido
      if (daQuestao.some((x) => x.correta || x.viu_resolucao) || daQuestao.length >= 2) recusar('questão encerrada');
      if (!daQuestao.length && new Set(s.tentativas.map((x) => x.questao_id)).size >= 10) recusar('questões fora da sessão');
      const dicas = Math.max(s.dicas[q.id] ?? 0, Math.min(Math.max(t.dicas_usadas, 0), 2));
      s.tentativas.push({ ...t, letra, correta, dicas_usadas: dicas, viu_resolucao: !letra, origem: 'revisao' });
    }
    gravarSessao(u.id, s);
  },

  async abrirDica(sessao, questao_id, dica) {
    if (dica !== 1 && dica !== 2) recusar('dica inválida');
    const u = usuarioLogado();
    const s = sessaoAberta(u.id, sessao);
    if (s.tipo !== 'revisao' || !naRevisao(dadosDe(u).revisao[questao_id])) recusar('questão fora da revisão');
    s.dicas[questao_id] = Math.max(dica, s.dicas[questao_id] ?? 0);
    gravarSessao(u.id, s);
  },

  async concluirSessao(sessao) {
    const u = usuarioLogado();
    const s = sessoesDe(u.id)[sessao] ?? recusar('sessão não encontrada');
    if (s.resumo) return s.resumo; // concluir de novo devolve o mesmo resumo
    const c = await conteudoDemo();
    const d = dadosDe(u);
    const f = s.tipo === 'revisao'
      ? fecharRevisao(d, c, s.exame_id, s.tentativas)
      : fecharLicao(d, c, {
        tipo: s.tipo, exame_id: s.exame_id, recorte_id: s.recorte_id ?? '', assunto: s.assunto ?? '', unidade: s.unidade ?? 0,
        questoes: (s.questoes ?? []).map((id) => catalogo(c).questao(id)).filter((q): q is Questao => !!q), tentativas: s.tentativas
      });
    gravar(kDados(u.id), f.dados);
    gravarSessao(u.id, { ...s, resumo: f.resumo });
    return f.resumo;
  },

  async ganharVidaAnuncio() {
    const u = usuarioLogado();
    const agora = Date.now();
    const recentes = (ler<number[]>(kAnuncios(u.id)) ?? []).filter((t) => agora - t < DIA);
    if (recentes.length >= LIMITE_ANUNCIOS) recusar('limite_anuncios');
    gravar(kAnuncios(u.id), [...recentes, agora]);
    const d = dadosDe(u);
    gravar(kDados(u.id), { ...d, perfil: ajustarVidas(d.perfil, +1, agora) });
  },

  async excluirConta() {
    const u = ler<Usuario>(K_USER);
    if (u) for (const k of [kDados(u.id), kSessoes(u.id), kAnuncios(u.id)]) localStorage.removeItem(k);
    localStorage.removeItem(K_USER); avisar(null);
  }
};
