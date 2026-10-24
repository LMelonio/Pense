// Implementação com Supabase (Auth + Postgres com RLS). Tabelas e funções em supabase/migrations.
// XP, vidas, sequência, coroas, revisão e conquistas são calculados no banco (0006): o app manda as respostas.
import type { SupabaseClient, User } from '@supabase/supabase-js';
import type { Mudancas, Provedores, Repo, ResumoSessao, Usuario } from './repo';
import { carregarConteudoLocal, falhaDeRede, traduzirErro, urlBase } from './repo';
import type { Conteudo, DadosAluno, Questao } from './types';
import { PREFS_PADRAO } from './types';
import { dadosIniciais } from './demoRepo';
import { VIDAS_MAX } from '../domain/regras';

function paraUsuario(u: User | null | undefined): Usuario | null {
  if (!u) return null;
  const meta = u.user_metadata ?? {};
  const provs = (u.app_metadata?.providers as string[] | undefined) ?? [];
  return {
    id: u.id,
    email: u.email || null,
    anonimo: !!u.is_anonymous,
    // nome da conta Google primeiro: o visitante que liga o Google tem nome = 'Estudante' nos metadados
    nome: (meta.full_name ?? meta.name ?? meta.nome ?? null) as string | null,
    provedor: u.is_anonymous ? 'anonimo' : provs.includes('google') ? 'google' : 'email'
  };
}

// Mensagem técnica só no console; o aluno vê a versão traduzida.
function falhou(error: { message: string } | null, onde: string) {
  if (!error) return;
  console.error(`[Pense] ${onde}:`, error.message);
  throw new Error(traduzirErro(error.message));
}

function erroAuth(error: { message: string } | null) {
  if (error) throw new Error(traduzirErro(error.message));
}

const PROVEDORES_RESERVA: Provedores = { google: false, email: true, anonimo: true };
const LIMITE_CONTEUDO_MS = 4000; // depois disso, usa o conteúdo embutido no app
const espera = (ms: number) => new Promise((r) => setTimeout(r, ms));

/** Tenta de novo quando a falha é de rede (não quando o servidor recusou). */
async function comRetentativa<T>(f: () => Promise<T>, tentativas = 3): Promise<T> {
  for (let i = 1; ; i++) {
    try { return await f(); } catch (e) {
      if (!falhaDeRede(e) || i >= tentativas) throw e;
      await espera(600 * i);
    }
  }
}

async function todasAsLinhas<T>(consulta: (de: number, ate: number) => PromiseLike<{ data: T[] | null; error: { message: string } | null }>) {
  const linhas: T[] = [];
  for (let de = 0; ; de += 1000) {
    const { data, error } = await consulta(de, de + 999);
    falhou(error, 'Leitura');
    linhas.push(...(data ?? []));
    if (!data || data.length < 1000) break;
  }
  return linhas;
}

const fuso = () => Intl.DateTimeFormat().resolvedOptions().timeZone;

export function criarSupabaseRepo(sb: SupabaseClient, url: string, chave: string): Repo {
  let provedores: Promise<Provedores> | null = null;

  async function rpc<T>(funcao: string, args: Record<string, unknown> = {}): Promise<T> {
    const { data, error } = await sb.rpc(funcao, args);
    falhou(error, funcao);
    return data as T;
  }

  async function conteudoDoBanco(sinal: AbortSignal): Promise<Conteudo | null> {
    const [ex, rc, tb] = await Promise.all([
      sb.from('exames').select('*').abortSignal(sinal),
      sb.from('recortes').select('*').order('ordem').abortSignal(sinal),
      todasAsLinhas<{ id: string; texto: string }>((a, b) => sb.from('textos_base').select('id,texto').range(a, b).abortSignal(sinal))
    ]);
    falhou(ex.error, 'Exames'); falhou(rc.error, 'Recortes');
    type Linha = Omit<Questao, 'alternativas' | 'figuras'> & {
      alternativas: { letra: string; texto: string | null; imagem: string | null }[];
      questao_figuras: { ordem: number; imagem: string; descricao: string }[];
    };
    const qs = await todasAsLinhas<Linha>((a, b) =>
      sb.from('questoes').select('*, alternativas(letra,texto,imagem), questao_figuras(ordem,imagem,descricao)').eq('ativa', true).order('id').range(a, b).abortSignal(sinal));
    if (!qs.length) return null;
    const questoes: Questao[] = qs.map(({ alternativas, questao_figuras, ...q }) => ({
      ...q,
      alternativas: [...alternativas].sort((x, y) => x.letra.localeCompare(y.letra)),
      figuras: [...questao_figuras].sort((x, y) => x.ordem - y.ordem).map((f) => ({ imagem: f.imagem, descricao: f.descricao }))
    }));
    return { exames: ex.data ?? [], recortes: rc.data ?? [], textos_base: Object.fromEntries(tb.map((t) => [t.id, t.texto])), questoes };
  }

  return {
    modo: 'supabase',

    // Lê do Auth quais logins estão ligados, para não mandar o aluno a uma página de erro do Supabase.
    // Com o servidor lento, desiste em 4 s e usa a reserva (o login em si tem o próprio limite de tempo).
    provedores() {
      if (provedores) return provedores;
      const ctrl = new AbortController();
      const relogio = setTimeout(() => ctrl.abort(), LIMITE_CONTEUDO_MS);
      provedores = fetch(`${url}/auth/v1/settings`, { headers: { apikey: chave }, signal: ctrl.signal })
        .then((r) => (r.ok ? r.json() : Promise.reject(new Error(`HTTP ${r.status}`))))
        .then((j) => ({ google: !!j.external?.google, email: !!j.external?.email, anonimo: !!j.external?.anonymous_users }))
        .catch(() => { provedores = null; return PROVEDORES_RESERVA; })
        .finally(() => clearTimeout(relogio));
      return provedores;
    },

    // Banco primeiro; se demorar mais de 4 s, falhar ou estiver vazio, usa o conteúdo embutido (mesmas questões).
    async carregarConteudo(): Promise<Conteudo> {
      const ctrl = new AbortController();
      const relogio = setTimeout(() => ctrl.abort(), LIMITE_CONTEUDO_MS);
      try {
        const c = await conteudoDoBanco(ctrl.signal);
        if (c) return c;
        console.warn('[Pense] O banco não tem questões ainda (rode a carga). Usando o conteúdo embutido.');
      } catch (e) {
        console.warn('[Pense] Banco lento ou fora do ar; usando o conteúdo embutido.', (e as Error).message);
      } finally {
        clearTimeout(relogio);
      }
      return carregarConteudoLocal();
    },

    async usuarioAtual() {
      const { data } = await sb.auth.getSession();
      return paraUsuario(data.session?.user);
    },
    aoMudarUsuario(cb) {
      // Fora do callback do Supabase: chamar o banco aqui dentro pode travar a sessão (recomendação do supabase-js).
      const { data } = sb.auth.onAuthStateChange((_e, s) => { setTimeout(() => cb(paraUsuario(s?.user)), 0); });
      return () => data.subscription.unsubscribe();
    },
    async entrarEmail(email, senha) {
      const { error } = await sb.auth.signInWithPassword({ email, password: senha });
      erroAuth(error);
    },
    async cadastrarEmail(email, senha, nome) {
      const { data, error } = await sb.auth.signUp({ email, password: senha, options: { data: { nome }, emailRedirectTo: urlBase() } });
      erroAuth(error);
      return { confirmarEmail: !data.session };
    },
    async entrarGoogle() {
      const { error } = await sb.auth.signInWithOAuth({ provider: 'google', options: { redirectTo: urlBase(), queryParams: { prompt: 'select_account' } } });
      erroAuth(error);
    },
    async entrarAnonimo() {
      const { error } = await sb.auth.signInAnonymously({ options: { data: { nome: 'Estudante' } } });
      erroAuth(error);
    },
    async vincularEmail(email, senha) {
      // Primeiro o e-mail, depois a senha: o Supabase só aceita senha depois que o visitante tem e-mail.
      const { data, error } = await sb.auth.updateUser({ email }, { emailRedirectTo: urlBase() });
      erroAuth(error);
      if (data.user?.new_email) return { confirmarEmail: true };
      const { error: e2 } = await sb.auth.updateUser({ password: senha });
      erroAuth(e2);
      return { confirmarEmail: false };
    },
    async vincularGoogle() {
      // Precisa de "Manual linking" ligado no Supabase. Volta para o app com a mesma conta, agora ligada ao Google.
      const { error } = await sb.auth.linkIdentity({ provider: 'google', options: { redirectTo: urlBase() } });
      erroAuth(error);
    },
    async recuperarSenha(email) {
      // ?recuperar=1 avisa o app, na volta, para abrir a tela de nova senha (no fluxo PKCE o Supabase não manda PASSWORD_RECOVERY).
      const { error } = await sb.auth.resetPasswordForEmail(email, { redirectTo: `${urlBase()}?recuperar=1` });
      erroAuth(error);
    },
    async definirSenha(senha) {
      const { error } = await sb.auth.updateUser({ password: senha });
      erroAuth(error);
    },
    async sair() { await sb.auth.signOut(); },

    async carregarDados(u) {
      const base = dadosIniciais(u);
      const id = u.id;
      const [pf, pr, tm, rv, xd, cq, un, vt, ip] = await Promise.all([
        sb.from('perfis').select('*').eq('id', id).maybeSingle(),
        sb.from('preferencias').select('*').eq('perfil_id', id).maybeSingle(),
        sb.from('progresso_tema').select('*').eq('perfil_id', id),
        sb.from('fila_revisao').select('*').eq('perfil_id', id),
        sb.from('xp_diario').select('dia,xp').eq('perfil_id', id).gte('dia', new Date(Date.now() - 90 * 86400000).toISOString().slice(0, 10)),
        sb.from('usuario_conquistas').select('codigo,obtida_em').eq('perfil_id', id),
        sb.from('progresso_unidade').select('chave,desafio_ok').eq('perfil_id', id),
        sb.from('tentativas').select('questao_id,correta').eq('perfil_id', id).limit(5000),
        sb.from('interesse_pro').select('plano').eq('perfil_id', id).maybeSingle()
      ]);
      for (const [r, n] of [[pf, 'perfil'], [pr, 'preferências'], [tm, 'temas'], [rv, 'revisão'], [xd, 'XP'], [cq, 'conquistas'], [un, 'unidades'], [vt, 'tentativas']] as const) falhou(r.error, n);
      const tentativas = (vt.data ?? []) as { questao_id: string; correta: boolean }[];
      const perfil = pf.data ? { ...base.perfil, ...pf.data } : base.perfil;
      const d: DadosAluno = {
        ...base,
        perfil: { ...perfil, vidas: Math.min(perfil.vidas, VIDAS_MAX) },
        prefs: pr.data ? { ...PREFS_PADRAO, ...pr.data, lembrete_hora: String(pr.data.lembrete_hora ?? '19:00').slice(0, 5) } : base.prefs,
        temas: Object.fromEntries((tm.data ?? []).map((t) => [`${t.recorte_id}|${t.assunto}`, { ...t, dominio: Number(t.dominio) }])),
        revisao: Object.fromEntries((rv.data ?? []).map((r) => [r.questao_id, r])),
        xpDia: Object.fromEntries((xd.data ?? []).map((x) => [x.dia, x.xp])),
        conquistas: Object.fromEntries((cq.data ?? []).map((c) => [c.codigo, c.obtida_em])),
        unidades: Object.fromEntries((un.data ?? []).map((x) => [x.chave, x.desafio_ok])),
        vistas: [...new Set(tentativas.map((x) => x.questao_id))],
        acertadas: [...new Set(tentativas.filter((x) => x.correta).map((x) => x.questao_id))],
        interessePro: ip.data?.plano ?? null
      };
      // O gatilho do cadastro cria perfil e preferências; contas antigas sem eles são completadas aqui.
      if (!pf.data || !pr.data) await rpc('garantir_perfil');
      return d;
    },

    // Só o que o aluno pode gravar direto: nome, preferências e interesse no Pro. O resto vem das sessões (servidor).
    async salvar(d, m: Mudancas) {
      const id = d.perfil.id;
      const ops: PromiseLike<{ error: { message: string } | null }>[] = [];
      if (m.nome) ops.push(sb.from('perfis').update({ nome: d.perfil.nome }).eq('id', id));
      if (m.prefs?.length) ops.push(sb.from('preferencias').update(Object.fromEntries(m.prefs.map((k) => [k, d.prefs[k]]))).eq('perfil_id', id));
      if (m.interessePro && d.interessePro) ops.push(sb.from('interesse_pro').upsert({ perfil_id: id, plano: d.interessePro }));
      const res = await Promise.all(ops);
      res.forEach((r) => falhou(r.error, 'Gravação'));
    },

    iniciarSessao: (s) => comRetentativa(() => rpc<string>('iniciar_sessao', {
      p_tipo: s.tipo, p_exame: s.exame_id, p_recorte: s.recorte_id, p_assunto: s.assunto, p_unidade: s.unidade, p_fuso: fuso(), p_questoes: s.questoes
    })),

    async responder(sessao, t) {
      await comRetentativa(() => rpc('responder', {
        p_sessao: sessao, p_questao: t.questao_id, p_letra: t.letra, p_dicas: t.dicas_usadas, p_viu_resolucao: t.viu_resolucao, p_tempo_ms: Math.round(t.tempo_ms)
      }));
    },

    async abrirDica(sessao, questao_id, dica) {
      await comRetentativa(() => rpc('abrir_dica', { p_sessao: sessao, p_questao: questao_id, p_dica: dica }));
    },

    concluirSessao: (sessao) => comRetentativa(() => rpc<ResumoSessao>('concluir_sessao', { p_sessao: sessao })),

    async ganharVidaAnuncio() {
      await rpc('ganhar_vida_anuncio');
    },

    async excluirConta() {
      const { error } = await sb.rpc('excluir_minha_conta');
      erroAuth(error);
      await sb.auth.signOut({ scope: 'local' }); // o usuário já não existe no servidor
    }
  };
}
