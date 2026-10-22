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
