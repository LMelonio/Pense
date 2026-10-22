-- Pense · 0001 · Conteúdo multi-prova (exames, editais, áreas/matérias, questões)
-- Rode no Supabase: SQL Editor > New query > cole e execute (ou `supabase db push`).

create extension if not exists pgcrypto;

create table if not exists public.exames (
  id text primary key,
  nome text not null,
  tipo text not null check (tipo in ('exame_nacional', 'vestibular', 'concurso', 'processo_seletivo')),
  organizador text,
  ativo boolean not null default true,
  criado_em timestamptz not null default now()
);

create table if not exists public.editais (
  id uuid primary key default gen_random_uuid(),
  exame_id text not null references public.exames(id) on delete cascade,
  orgao text,
  cargo text,
  banca text,
  ano int,
  data_prova date,
  nivel text,
  link text,
  criado_em timestamptz not null default now()
);

-- Recorte = área (ENEM) ou matéria (concursos)
create table if not exists public.recortes (
  id text primary key,
  exame_id text not null references public.exames(id) on delete cascade,
  sigla text not null,
  nome text not null,
  cor text not null default 'lav',
  ordem int not null default 0
);

create table if not exists public.edital_conteudo (
  edital_id uuid not null references public.editais(id) on delete cascade,
  recorte_id text not null references public.recortes(id) on delete cascade,
  assunto text not null,
  topico text,
  peso int,
  primary key (edital_id, recorte_id, assunto)
);

create table if not exists public.textos_base (
  id text primary key,
  exame_id text references public.exames(id) on delete cascade,
  texto text not null
);

create table if not exists public.questoes (
  id text primary key,
  exame_id text not null references public.exames(id) on delete cascade,
  edital_id uuid references public.editais(id) on delete set null,
  recorte_id text not null references public.recortes(id),
  banca text,
  orgao text,
  cargo text,
  nivel text,
  ano int not null,
  numero int,
  formato text not null default '5_alternativas' check (formato in ('5_alternativas', '4_alternativas', 'certo_errado')),
  disciplina text,
  assunto text not null,
  topico text,
  lingua text,
  texto_base_id text references public.textos_base(id),
  texto_apoio text,
  comando text not null,
  gabarito char(1) not null,
  dica1 text,
  dica2 text,
  explicacao text,
  dificuldade text check (dificuldade in ('fácil', 'média', 'difícil')),
  xp_base int not null default 10,
  ativa boolean not null default true,
  revisado boolean not null default false,
  criado_em timestamptz not null default now()
);
create index if not exists questoes_tema_idx on public.questoes (exame_id, recorte_id, assunto) where ativa;

create table if not exists public.questao_figuras (
  questao_id text not null references public.questoes(id) on delete cascade,
  ordem int not null,
  imagem text not null,
  descricao text,
  primary key (questao_id, ordem)
);

create table if not exists public.alternativas (
  questao_id text not null references public.questoes(id) on delete cascade,
  letra char(1) not null,
  texto text,
  imagem text,
  primary key (questao_id, letra)
);

-- Temas (assuntos) com contagem, para listas e trilha
create or replace view public.v_temas with (security_invoker = true) as
select q.exame_id, q.recorte_id, r.nome as recorte_nome, q.assunto, count(*)::int as questoes
from public.questoes q join public.recortes r on r.id = q.recorte_id
where q.ativa
group by q.exame_id, q.recorte_id, r.nome, q.assunto;

-- Conteúdo é público para leitura; escrita só pelo painel/admin (service role).
alter table public.exames enable row level security;
alter table public.editais enable row level security;
alter table public.recortes enable row level security;
alter table public.edital_conteudo enable row level security;
alter table public.textos_base enable row level security;
alter table public.questoes enable row level security;
alter table public.questao_figuras enable row level security;
alter table public.alternativas enable row level security;

do $$
declare t text;
begin
  foreach t in array array['exames','editais','recortes','edital_conteudo','textos_base','questoes','questao_figuras','alternativas'] loop
    execute format('drop policy if exists "leitura publica" on public.%I', t);
    execute format('create policy "leitura publica" on public.%I for select to anon, authenticated using (true)', t);
  end loop;
end $$;
-- Pense · 0002 · Usuários e progresso (perfis, preferências, sessões, tentativas, revisão, conquistas)
-- Cada aluno só lê e grava as próprias linhas (RLS com auth.uid()).

create table if not exists public.perfis (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text not null default 'Estudante',
  usuario text unique,
  xp_total int not null default 0,
  vidas int not null default 5 check (vidas between 0 and 5),
  vidas_atualizadas_em timestamptz not null default now(),
  sequencia_atual int not null default 0,
  sequencia_recorde int not null default 0,
  ultimo_dia_meta date,
  questoes_feitas int not null default 0,
  acertos_total int not null default 0,
  revisoes_concluidas int not null default 0,
  criado_em timestamptz not null default now()
);

create table if not exists public.preferencias (
  perfil_id uuid primary key references public.perfis(id) on delete cascade,
  exame_id text not null default 'enem' references public.exames(id),
  edital_id uuid references public.editais(id) on delete set null,
  cargo text,
  data_prova date,
  lingua text not null default 'Inglês' check (lingua in ('Inglês', 'Espanhol')),
  meta_xp int not null default 30 check (meta_xp in (10, 20, 30, 50)),
  lembrete_ativo boolean not null default true,
  lembrete_hora time not null default '19:00',
  explicacao_imediata boolean not null default true,
  tema text not null default 'claro' check (tema in ('claro', 'escuro', 'auto')),
  tamanho_texto text not null default 'padrao' check (tamanho_texto in ('padrao', 'grande', 'maior')),
  sons boolean not null default true,
  vibracao boolean not null default true,
  reduzir_animacoes boolean not null default false,
  ranking_visivel boolean not null default false,
  responsavel_email text,
  onboarding_ok boolean not null default false,
  atualizado_em timestamptz not null default now()
);

create table if not exists public.xp_diario (
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  dia date not null,
  xp int not null default 0,
  primary key (perfil_id, dia)
);

create table if not exists public.sessoes_estudo (
  id uuid primary key default gen_random_uuid(),
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  tipo text not null check (tipo in ('licao', 'revisao', 'desafio')),
  exame_id text references public.exames(id),
  recorte_id text references public.recortes(id),
  assunto text,
  inicio timestamptz not null,
  fim timestamptz not null,
  acertos int not null,
  total int not null,
  xp int not null,
  perfeita boolean not null default false
);
create index if not exists sessoes_perfil_idx on public.sessoes_estudo (perfil_id, inicio desc);

create table if not exists public.tentativas (
  id bigint generated always as identity primary key,
  sessao_id uuid references public.sessoes_estudo(id) on delete cascade,
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  questao_id text not null references public.questoes(id) on delete cascade,
  letra char(1),
  correta boolean not null,
  dicas_usadas int not null default 0,
  viu_resolucao boolean not null default false,
  tempo_ms int,
  origem text not null check (origem in ('licao', 'revisao', 'desafio')),
  criado_em timestamptz not null default now()
);
create index if not exists tentativas_perfil_idx on public.tentativas (perfil_id, questao_id);

create table if not exists public.progresso_tema (
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  recorte_id text not null references public.recortes(id) on delete cascade,
  assunto text not null,
  dominio numeric(5, 2) not null default 0,
  coroa smallint not null default 0 check (coroa between 0 and 3),
  licoes int not null default 0,
  historico jsonb not null default '[]'::jsonb,
  ultima_pratica timestamptz,
  primary key (perfil_id, recorte_id, assunto)
);

create table if not exists public.fila_revisao (
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  questao_id text not null references public.questoes(id) on delete cascade,
  vence_em timestamptz not null,
  repeticoes int not null default 0,
  lapsos int not null default 0,
  status text not null default 'pendente' check (status in ('pendente', 'dominada')),
  ultima_letra char(1),
  -- campos para o algoritmo FSRS (fase seguinte)
  estabilidade real,
  dificuldade real,
  primary key (perfil_id, questao_id)
);
create index if not exists fila_vence_idx on public.fila_revisao (perfil_id, vence_em) where status = 'pendente';

create table if not exists public.progresso_unidade (
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  chave text not null, -- recorte_id|número da unidade
  desafio_ok boolean not null default false,
  primary key (perfil_id, chave)
);

create table if not exists public.conquistas (
  codigo text primary key,
  nome text not null,
  descricao text not null,
  icone text,
  meta int,
  ordem int not null default 0
);

create table if not exists public.usuario_conquistas (
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  codigo text not null references public.conquistas(codigo) on delete cascade,
  obtida_em timestamptz not null default now(),
  primary key (perfil_id, codigo)
);

create table if not exists public.interesse_pro (
  perfil_id uuid primary key references public.perfis(id) on delete cascade,
  plano text not null check (plano in ('mensal', 'anual')),
  criado_em timestamptz not null default now()
);

create table if not exists public.assinaturas (
  perfil_id uuid primary key references public.perfis(id) on delete cascade,
  plano text not null,
  status text not null,
  expira_em timestamptz,
  atualizado_em timestamptz not null default now()
);

-- RLS: cada aluno só vê e altera o que é dele
alter table public.perfis enable row level security;
drop policy if exists "dono" on public.perfis;
create policy "dono" on public.perfis for all to authenticated using (id = auth.uid()) with check (id = auth.uid());

do $$
declare t text;
begin
  foreach t in array array['preferencias','xp_diario','sessoes_estudo','tentativas','progresso_tema','fila_revisao','progresso_unidade','usuario_conquistas','interesse_pro'] loop
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists "dono" on public.%I', t);
    execute format('create policy "dono" on public.%I for all to authenticated using (perfil_id = auth.uid()) with check (perfil_id = auth.uid())', t);
  end loop;
end $$;

-- Assinaturas: o aluno só lê (quem grava é o webhook do RevenueCat com service role)
alter table public.assinaturas enable row level security;
drop policy if exists "dono le" on public.assinaturas;
create policy "dono le" on public.assinaturas for select to authenticated using (perfil_id = auth.uid());

alter table public.conquistas enable row level security;
drop policy if exists "leitura publica" on public.conquistas;
create policy "leitura publica" on public.conquistas for select to anon, authenticated using (true);
-- Pense · 0003 · Gatilhos e funções

-- Cria perfil e preferências quando alguém se cadastra (inclusive login anônimo e Google)
create or replace function public.criar_perfil_novo_usuario()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.perfis (id, nome)
  values (new.id, coalesce(nullif(new.raw_user_meta_data ->> 'nome', ''), nullif(new.raw_user_meta_data ->> 'full_name', ''), 'Estudante'))
  on conflict (id) do nothing;
  insert into public.preferencias (perfil_id) values (new.id) on conflict (perfil_id) do nothing;
  return new;
end $$;

drop trigger if exists ao_criar_usuario on auth.users;
create trigger ao_criar_usuario after insert on auth.users
for each row execute function public.criar_perfil_novo_usuario();

-- Marca a data de atualização das preferências
create or replace function public.tocar_atualizado_em()
returns trigger language plpgsql as $$
begin new.atualizado_em = now(); return new; end $$;
drop trigger if exists prefs_atualizado on public.preferencias;
create trigger prefs_atualizado before update on public.preferencias
for each row execute function public.tocar_atualizado_em();

-- O aluno exclui a própria conta (LGPD). Apaga o usuário e, em cascata, todos os dados dele.
create or replace function public.excluir_minha_conta()
returns void language plpgsql security definer set search_path = public, auth as $$
begin
  if auth.uid() is null then raise exception 'não autenticado'; end if;
  delete from auth.users where id = auth.uid();
end $$;
revoke all on function public.excluir_minha_conta() from public, anon;
grant execute on function public.excluir_minha_conta() to authenticated;

-- Ranking da turma: só quem ligou "aparecer no ranking"; mostra nome e XP da semana
create or replace view public.v_ranking_semana with (security_invoker = false) as
select p.id, p.nome, coalesce(sum(x.xp), 0)::int as xp_semana
from public.perfis p
join public.preferencias pr on pr.perfil_id = p.id and pr.ranking_visivel
left join public.xp_diario x on x.perfil_id = p.id and x.dia >= current_date - 6
group by p.id, p.nome;
revoke all on public.v_ranking_semana from anon;
grant select on public.v_ranking_semana to authenticated;

-- Resumo para o painel/curadoria
create or replace view public.v_resumo_conteudo with (security_invoker = true) as
select e.nome as exame, r.nome as recorte, count(q.*)::int as questoes,
  count(*) filter (where q.revisado)::int as revisadas,
  count(*) filter (where q.dificuldade = 'fácil')::int as faceis,
  count(*) filter (where q.dificuldade = 'média')::int as medias,
  count(*) filter (where q.dificuldade = 'difícil')::int as dificeis
from public.questoes q join public.exames e on e.id = q.exame_id join public.recortes r on r.id = q.recorte_id
where q.ativa group by e.nome, r.nome, r.ordem order by e.nome, r.ordem;
-- Pense · 0004 · Dados de base: exames, áreas/matérias e conquistas
-- (as questões entram depois, com os arquivos de supabase/seed ou com `npm run seed`)

insert into public.exames (id, nome, tipo, organizador, ativo) values
  ('enem', 'ENEM', 'exame_nacional', 'INEP', true),
  ('concursos-base', 'Concursos · base comum', 'concurso', 'várias bancas', false),
  ('vestibulares', 'Vestibulares', 'vestibular', 'comissões das universidades', false),
  ('selecoes', 'Processos seletivos', 'processo_seletivo', 'organizador da seleção', false)
on conflict (id) do update set nome = excluded.nome, tipo = excluded.tipo, organizador = excluded.organizador;

insert into public.recortes (id, exame_id, sigla, nome, cor, ordem) values
  ('enem-LC', 'enem', 'LC', 'Linguagens', 'lc', 1),
  ('enem-CH', 'enem', 'CH', 'Humanas', 'ch', 2),
  ('enem-CN', 'enem', 'CN', 'Natureza', 'cn', 3),
  ('enem-MT', 'enem', 'MT', 'Matemática', 'mt', 4),
  ('conc-POR', 'concursos-base', 'POR', 'Língua Portuguesa', 'lc', 1),
  ('conc-RLM', 'concursos-base', 'RLM', 'Raciocínio lógico', 'mt', 2),
  ('conc-INF', 'concursos-base', 'INF', 'Informática', 'cn', 3),
  ('conc-ATU', 'concursos-base', 'ATU', 'Atualidades', 'ch', 4),
  ('conc-DIR', 'concursos-base', 'DIR', 'Noções de Direito', 'lav', 5)
on conflict (id) do update set nome = excluded.nome, cor = excluded.cor, ordem = excluded.ordem;

insert into public.conquistas (codigo, nome, descricao, icone, meta, ordem) values
  ('primeiro_passo', 'Primeiro passo', 'Concluiu a primeira lição.', 'seed', 1, 1),
  ('sete_dias', '7 dias seguidos', 'Bateu a meta 7 dias seguidos.', 'flame', 7, 2),
  ('licao_perfeita', 'Lição perfeita', 'Terminou uma lição sem errar.', 'star', 1, 3),
  ('revisao_em_dia', 'Revisão em dia', 'Concluiu 5 revisões.', 'refresh', 5, 4),
  ('trezentas', '300 questões', 'Respondeu 300 questões.', 'target', 300, 5),
  ('dez_ouros', '10 coroas de Ouro', 'Levou 10 temas até o Ouro.', 'crown', 10, 6),
  ('quatro_areas', 'Todas as áreas', 'Praticou todas as áreas do seu exame.', 'book', 4, 7),
  ('trinta_dias', '30 dias seguidos', 'Bateu a meta 30 dias seguidos.', 'calendar', 30, 8)
on conflict (codigo) do update set nome = excluded.nome, descricao = excluded.descricao, meta = excluded.meta;
