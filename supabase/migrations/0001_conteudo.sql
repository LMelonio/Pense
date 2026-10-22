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
