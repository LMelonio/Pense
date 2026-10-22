// Implementação com Supabase (Auth + Postgres com RLS). Tabelas em supabase/migrations.
import type { SupabaseClient, User } from '@supabase/supabase-js';
import type { Mudancas, Provedores, Repo, Usuario } from './repo';
import { carregarConteudoLocal, traduzirErro, urlBase } from './repo';
import type { Conteudo, DadosAluno, Questao } from './types';
import { PREFS_PADRAO } from './types';
import { dadosIniciais } from './demoRepo';

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

function falhou(error: { message: string } | null, onde: string) {
  if (error) throw new Error(`${onde}: ${error.message}`);
}

function erroAuth(error: { message: string } | null) {
  if (error) throw new Error(traduzirErro(error.message));
}

const PROVEDORES_RESERVA: Provedores = { google: false, email: true, anonimo: true };

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

export function criarSupabaseRepo(sb: SupabaseClient, url: string, chave: string): Repo {
  let provedores: Promise<Provedores> | null = null;
  return {
    modo: 'supabase',

    // Lê do Auth quais logins estão ligados, para não mandar o aluno a uma página de erro do Supabase.
    provedores() {
      provedores ??= fetch(`${url}/auth/v1/settings`, { headers: { apikey: chave } })
        .then((r) => (r.ok ? r.json() : Promise.reject(new Error(`HTTP ${r.status}`))))
        .then((j) => ({ google: !!j.external?.google, email: !!j.external?.email, anonimo: !!j.external?.anonymous_users }))
        .catch(() => { provedores = null; return PROVEDORES_RESERVA; });
      return provedores;
    },

    async carregarConteudo(): Promise<Conteudo> {
      const [ex, rc, tb] = await Promise.all([
        sb.from('exames').select('*'),
        sb.from('recortes').select('*').order('ordem'),
        todasAsLinhas<{ id: string; texto: string }>((a, b) => sb.from('textos_base').select('id,texto').range(a, b))
      ]);
      falhou(ex.error, 'Exames'); falhou(rc.error, 'Recortes');
      type Linha = Omit<Questao, 'alternativas' | 'figuras'> & {
        alternativas: { letra: string; texto: string | null; imagem: string | null }[];
        questao_figuras: { ordem: number; imagem: string; descricao: string }[];
      };
      const qs = await todasAsLinhas<Linha>((a, b) =>
        sb.from('questoes').select('*, alternativas(letra,texto,imagem), questao_figuras(ordem,imagem,descricao)').eq('ativa', true).order('id').range(a, b));
      if (!qs.length) {
        console.warn('[Pense] O banco não tem questões ainda (rode a carga). Usando o conteúdo embutido.');
        return carregarConteudoLocal();
      }
      const questoes: Questao[] = qs.map(({ alternativas, questao_figuras, ...q }) => ({
        ...q,
        alternativas: [...alternativas].sort((x, y) => x.letra.localeCompare(y.letra)),
        figuras: [...questao_figuras].sort((x, y) => x.ordem - y.ordem).map((f) => ({ imagem: f.imagem, descricao: f.descricao }))
      }));
      return { exames: ex.data ?? [], recortes: rc.data ?? [], textos_base: Object.fromEntries(tb.map((t) => [t.id, t.texto])), questoes };
    },

    async usuarioAtual() {
      const { data } = await sb.auth.getSession();
      return paraUsuario(data.session?.user);
    },
    aoMudarUsuario(cb) {
      const { data } = sb.auth.onAuthStateChange((_e, s) => cb(paraUsuario(s?.user)));
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
        sb.from('tentativas').select('questao_id').eq('perfil_id', id).limit(5000),
        sb.from('interesse_pro').select('plano').eq('perfil_id', id).maybeSingle()
      ]);
      for (const [r, n] of [[pf, 'perfil'], [pr, 'preferências'], [tm, 'temas'], [rv, 'revisão'], [xd, 'XP'], [cq, 'conquistas'], [un, 'unidades'], [vt, 'tentativas']] as const) falhou(r.error, n);
      const d: DadosAluno = {
        ...base,
        perfil: pf.data ? { ...base.perfil, ...pf.data } : base.perfil,
        prefs: pr.data ? { ...PREFS_PADRAO, ...pr.data, lembrete_hora: String(pr.data.lembrete_hora ?? '19:00').slice(0, 5) } : base.prefs,
        temas: Object.fromEntries((tm.data ?? []).map((t) => [`${t.recorte_id}|${t.assunto}`, { ...t, dominio: Number(t.dominio) }])),
        revisao: Object.fromEntries((rv.data ?? []).map((r) => [r.questao_id, r])),
        xpDia: Object.fromEntries((xd.data ?? []).map((x) => [x.dia, x.xp])),
        conquistas: Object.fromEntries((cq.data ?? []).map((c) => [c.codigo, c.obtida_em])),
        unidades: Object.fromEntries((un.data ?? []).map((x) => [x.chave, x.desafio_ok])),
        vistas: [...new Set((vt.data ?? []).map((x) => x.questao_id as string))],
        interessePro: ip.data?.plano ?? null
      };
      if (!pf.data) await this.salvar(d, { perfil: true, prefs: true });
      return d;
    },

    async salvar(d, m: Mudancas) {
      const id = d.perfil.id;
      const ops: PromiseLike<{ error: { message: string } | null }>[] = [];
      if (m.perfil) ops.push(sb.from('perfis').upsert({ ...d.perfil, id }));
      if (m.prefs) ops.push(sb.from('preferencias').upsert({ ...d.prefs, perfil_id: id }));
      if (m.temas?.length) ops.push(sb.from('progresso_tema').upsert(m.temas.map((k) => ({ ...d.temas[k], perfil_id: id }))));
      if (m.revisao?.length) ops.push(sb.from('fila_revisao').upsert(m.revisao.map((k) => ({ ...d.revisao[k], perfil_id: id }))));
      if (m.xpDia?.length) ops.push(sb.from('xp_diario').upsert(m.xpDia.map((dia) => ({ perfil_id: id, dia, xp: d.xpDia[dia] }))));
      if (m.conquistas?.length) ops.push(sb.from('usuario_conquistas').upsert(m.conquistas.map((c) => ({ perfil_id: id, codigo: c, obtida_em: d.conquistas[c] }))));
      if (m.unidades?.length) ops.push(sb.from('progresso_unidade').upsert(m.unidades.map((c) => ({ perfil_id: id, chave: c, desafio_ok: d.unidades[c] }))));
      if (m.interessePro && d.interessePro) ops.push(sb.from('interesse_pro').upsert({ perfil_id: id, plano: d.interessePro }));
      const res = await Promise.all(ops);
      res.forEach((r) => falhou(r.error, 'Gravação'));
    },

    async registrarSessao(s, t) {
      const { data: u } = await sb.auth.getUser();
      if (!u.user) return;
      const { data, error } = await sb.from('sessoes_estudo').insert({ ...s, perfil_id: u.user.id }).select('id').single();
      falhou(error, 'Sessão');
      if (t.length) {
        const { error: e2 } = await sb.from('tentativas').insert(t.map((x) => ({ ...x, perfil_id: u.user!.id, sessao_id: data!.id })));
        falhou(e2, 'Tentativas');
      }
    },

    async exportar(d) {
      const { data: s } = await sb.from('sessoes_estudo').select('*').eq('perfil_id', d.perfil.id);
      const { data: t } = await sb.from('tentativas').select('*').eq('perfil_id', d.perfil.id);
      return { dados: d, sessoes: s ?? [], tentativas: t ?? [] };
    },

    async excluirConta() {
      const { error } = await sb.rpc('excluir_minha_conta');
      erroAuth(error);
      await sb.auth.signOut({ scope: 'local' }); // o usuário já não existe no servidor
    }
  };
}
