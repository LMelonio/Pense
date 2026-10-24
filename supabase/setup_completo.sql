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

-- Pense · 0005 · Matérias no lugar das áreas do ENEM e máximo de 3 vidas
-- As questões do ENEM passam a ser agrupadas por matéria (Português, Inglês, História…), cada uma com seus
-- assuntos. A área (Linguagens, Humanas, Natureza, Matemática) vira um atributo da matéria.

alter table public.recortes add column if not exists area text;

insert into public.recortes (id, exame_id, sigla, nome, cor, ordem, area) values
  ('enem-POR', 'enem', 'POR', 'Português', 'lc', 1, 'Linguagens'),
  ('enem-LIT', 'enem', 'LIT', 'Literatura', 'lc', 2, 'Linguagens'),
  ('enem-ING', 'enem', 'ING', 'Inglês', 'lc', 3, 'Linguagens'),
  ('enem-ESP', 'enem', 'ESP', 'Espanhol', 'lc', 4, 'Linguagens'),
  ('enem-ART', 'enem', 'ART', 'Artes', 'lc', 5, 'Linguagens'),
  ('enem-EDF', 'enem', 'EDF', 'Educação Física', 'lc', 6, 'Linguagens'),
  ('enem-TIC', 'enem', 'TIC', 'Tecnologia', 'lc', 7, 'Linguagens'),
  ('enem-HIS', 'enem', 'HIS', 'História', 'ch', 8, 'Humanas'),
  ('enem-GEO', 'enem', 'GEO', 'Geografia', 'ch', 9, 'Humanas'),
  ('enem-FIL', 'enem', 'FIL', 'Filosofia', 'ch', 10, 'Humanas'),
  ('enem-SOC', 'enem', 'SOC', 'Sociologia', 'ch', 11, 'Humanas'),
  ('enem-BIO', 'enem', 'BIO', 'Biologia', 'cn', 12, 'Natureza'),
  ('enem-QUI', 'enem', 'QUI', 'Química', 'cn', 13, 'Natureza'),
  ('enem-FIS', 'enem', 'FIS', 'Física', 'cn', 14, 'Natureza'),
  ('enem-MAT', 'enem', 'MAT', 'Matemática', 'mt', 15, 'Matemática')
on conflict (id) do update set sigla = excluded.sigla, nome = excluded.nome, cor = excluded.cor, ordem = excluded.ordem, area = excluded.area;

update public.questoes set recorte_id = case disciplina
  when 'Língua Portuguesa' then 'enem-POR'
  when 'Literatura' then 'enem-LIT'
  when 'Inglês' then 'enem-ING'
  when 'Espanhol' then 'enem-ESP'
  when 'Artes' then 'enem-ART'
  when 'Educação Física' then 'enem-EDF'
  when 'Tecnologias da Informação e Comunicação' then 'enem-TIC'
  when 'História' then 'enem-HIS'
  when 'Geografia' then 'enem-GEO'
  when 'Filosofia' then 'enem-FIL'
  when 'Sociologia' then 'enem-SOC'
  when 'Biologia' then 'enem-BIO'
  when 'Química' then 'enem-QUI'
  when 'Física' then 'enem-FIS'
  when 'Matemática' then 'enem-MAT'
  else recorte_id end
where exame_id = 'enem';

-- Progresso guardado pelas áreas antigas não corresponde mais às matérias: sai junto com as áreas.
update public.sessoes_estudo set recorte_id = null where recorte_id in ('enem-LC', 'enem-CH', 'enem-CN', 'enem-MT');
delete from public.progresso_unidade where split_part(chave, '|', 1) in ('enem-LC', 'enem-CH', 'enem-CN', 'enem-MT');
delete from public.recortes where id in ('enem-LC', 'enem-CH', 'enem-CN', 'enem-MT'); -- progresso_tema sai em cascata

-- Vidas: no máximo 3 (sem vidas, o aluno espera, assiste a um anúncio ou vai para o Pro)
update public.perfis set vidas = least(vidas, 3);
alter table public.perfis alter column vidas set default 3;
alter table public.perfis drop constraint if exists perfis_vidas_check;
alter table public.perfis add constraint perfis_vidas_check check (vidas between 0 and 3);

-- Pense · 0006 · Pontuação calculada no servidor
-- XP, vidas, sequência, coroas, revisão, unidades e conquistas passam a ser calculados por funções do banco a partir
-- das respostas (o gabarito é conferido aqui). O aluno não grava mais essas colunas direto pela API: só o nome do
-- perfil, as preferências e o interesse no Pro. As regras espelham src/domain/regras.ts.

-- Sessões abertas no início; fim e resultado são preenchidos ao concluir
alter table public.sessoes_estudo alter column fim drop not null;
alter table public.sessoes_estudo alter column acertos set default 0;
alter table public.sessoes_estudo alter column total set default 0;
alter table public.sessoes_estudo alter column xp set default 0;
alter table public.sessoes_estudo add column if not exists unidade int;
alter table public.sessoes_estudo add column if not exists fuso text;
alter table public.sessoes_estudo add column if not exists resumo jsonb;

-- Dados coerentes
alter table public.sessoes_estudo drop constraint if exists sessoes_coerentes;
alter table public.sessoes_estudo add constraint sessoes_coerentes
  check (acertos >= 0 and total >= 0 and acertos <= total and xp >= 0 and (fim is null or fim >= inicio));
update public.perfis set nome = left(btrim(nome), 40) where char_length(nome) > 40 or nome <> btrim(nome);
update public.perfis set nome = 'Estudante' where btrim(nome) = '';
alter table public.perfis drop constraint if exists perfis_nome_tamanho;
alter table public.perfis add constraint perfis_nome_tamanho check (char_length(btrim(nome)) between 1 and 40);
update public.preferencias set responsavel_email = null where responsavel_email !~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$';
alter table public.preferencias drop constraint if exists preferencias_email_responsavel;
alter table public.preferencias add constraint preferencias_email_responsavel
  check (responsavel_email is null or responsavel_email ~* '^[^@[:space:]]+@[^@[:space:]]+\.[^@[:space:]]+$');

-- Uma resposta por questão em cada lição ou desafio (clique repetido não duplica); antes, tira as duplicadas
delete from public.tentativas t using public.tentativas d
 where t.origem in ('licao', 'desafio') and d.origem in ('licao', 'desafio')
   and t.sessao_id = d.sessao_id and t.questao_id = d.questao_id and t.id > d.id;
create unique index if not exists tentativas_uma_por_questao on public.tentativas (sessao_id, questao_id)
  where origem in ('licao', 'desafio');

-- Vidas extras (anúncio e revisão), para o limite diário
create table if not exists public.vidas_ganhas (
  perfil_id uuid not null references public.perfis(id) on delete cascade,
  origem text not null check (origem in ('anuncio', 'revisao')),
  criado_em timestamptz not null default now()
);
create index if not exists vidas_ganhas_idx on public.vidas_ganhas (perfil_id, origem, criado_em desc);
alter table public.vidas_ganhas enable row level security; -- sem política: só as funções do banco usam

-- Nome com até 40 caracteres também no cadastro (o do Google pode ser maior)
create or replace function public.criar_perfil_novo_usuario()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.perfis (id, nome)
  values (new.id, left(coalesce(nullif(btrim(new.raw_user_meta_data ->> 'nome'), ''), nullif(btrim(new.raw_user_meta_data ->> 'full_name'), ''), 'Estudante'), 40))
  on conflict (id) do nothing;
  insert into public.preferencias (perfil_id) values (new.id) on conflict (perfil_id) do nothing;
  return new;
end $$;

-- ---------- Funções internas

-- Vidas atuais, com a recarga de 1 a cada 30 minutos (máximo 3)
create or replace function public._vidas_agora(p_vidas int, p_desde timestamptz)
returns int language sql stable as $$
  select case when p_vidas >= 3 then 3
    else least(3, p_vidas + greatest(0, floor(extract(epoch from (now() - p_desde)) / 1800)::int)) end
$$;

-- Aplica a recarga e um delta (+1, -1), guardando o marco da próxima recarga (igual a ajustarVidas)
create or replace function public._ajustar_vidas(p_perfil uuid, p_delta int)
returns int language plpgsql security definer set search_path = public as $$
declare v_vidas int; v_desde timestamptz; v_atual int; v_nova int; v_marco timestamptz;
begin
  select vidas, vidas_atualizadas_em into v_vidas, v_desde from perfis where id = p_perfil for update;
  v_atual := _vidas_agora(v_vidas, v_desde);
  v_nova := greatest(0, least(3, v_atual + p_delta));
  if v_atual >= 3 or v_nova >= 3 then v_marco := now();
  elsif v_atual <> v_vidas then v_marco := v_desde + make_interval(mins => (v_atual - v_vidas) * 30);
  else v_marco := v_desde;
  end if;
  update perfis set vidas = v_nova, vidas_atualizadas_em = v_marco where id = p_perfil;
  return v_nova;
end $$;

-- Fuso do aluno (para o "dia" da meta e a revisão de amanhã); inválido vira o de Brasília
create or replace function public._fuso(p text)
returns text language sql stable as $$
  select coalesce((select name from pg_timezone_names where name = p limit 1), 'America/Sao_Paulo')
$$;

-- Meia-noite de amanhã no fuso do aluno
create or replace function public._amanha(p_fuso text)
returns timestamptz language sql stable as $$
  select (((now() at time zone p_fuso)::date + 1)::timestamp) at time zone p_fuso
$$;

-- ---------- Funções chamadas pelo app

-- Garante perfil e preferências (o gatilho já cria; serve para contas antigas)
create or replace function public.garantir_perfil()
returns void language plpgsql security definer set search_path = public as $$
begin
  if auth.uid() is null then raise exception 'não autenticado'; end if;
  insert into perfis (id) values (auth.uid()) on conflict (id) do nothing;
  insert into preferencias (perfil_id) values (auth.uid()) on conflict (perfil_id) do nothing;
end $$;

create or replace function public.iniciar_sessao(p_tipo text, p_exame text, p_recorte text, p_assunto text, p_unidade int, p_fuso text)
returns uuid language plpgsql security definer set search_path = public as $$
declare v_uid uuid := auth.uid(); v_id uuid;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  if p_tipo not in ('licao', 'revisao', 'desafio') then raise exception 'tipo de sessão inválido'; end if;
  insert into sessoes_estudo (perfil_id, tipo, exame_id, recorte_id, assunto, unidade, inicio, fuso)
  values (v_uid, p_tipo, p_exame, p_recorte, p_assunto, p_unidade, now(), _fuso(p_fuso))
  returning id into v_id;
  return v_id;
end $$;

-- Registra uma resposta. O banco confere o gabarito; na lição, errar gasta 1 vida; na lição e no desafio, o erro
-- entra na revisão de amanhã. Na revisão, letra nula = "ver resolução".
create or replace function public.responder(p_sessao uuid, p_questao text, p_letra text, p_dicas int default 0, p_viu_resolucao boolean default false, p_tempo_ms int default null)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_uid uuid := auth.uid(); v_sessao sessoes_estudo; v_gabarito text; v_letra text := upper(nullif(btrim(p_letra), ''));
  v_correta boolean; v_vidas int; v_anterior tentativas; v_qtd int;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  select * into v_sessao from sessoes_estudo where id = p_sessao and perfil_id = v_uid for update;
  if not found then raise exception 'sessão não encontrada'; end if;
  if v_sessao.fim is not null then raise exception 'sessão já concluída'; end if;
  select gabarito into v_gabarito from questoes where id = p_questao and ativa;
  if v_gabarito is null then raise exception 'questão não encontrada'; end if;
  if v_letra is not null and not exists (select 1 from alternativas where questao_id = p_questao and letra = v_letra) then
    raise exception 'alternativa inválida';
  end if;

  if v_sessao.tipo in ('licao', 'desafio') then
    select * into v_anterior from tentativas where sessao_id = p_sessao and questao_id = p_questao;
    if found then -- clique repetido: devolve a mesma resposta, sem efeito
      return jsonb_build_object('correta', v_anterior.correta, 'gabarito', v_gabarito, 'repetida', true);
    end if;
    if v_letra is null then raise exception 'resposta vazia'; end if;
    if v_sessao.tipo = 'licao' and (select _vidas_agora(vidas, vidas_atualizadas_em) from perfis where id = v_uid) = 0 then
      raise exception 'sem_vidas';
    end if;
  else
    select count(*) into v_qtd from tentativas where sessao_id = p_sessao and questao_id = p_questao;
    if v_qtd >= 3 then raise exception 'tentativas esgotadas'; end if;
    if v_letra is not null and exists (select 1 from tentativas where sessao_id = p_sessao and questao_id = p_questao and letra = v_letra) then
      return jsonb_build_object('correta', v_letra = v_gabarito, 'gabarito', v_gabarito, 'repetida', true);
    end if;
  end if;

  v_correta := v_letra is not null and v_letra = v_gabarito;
  insert into tentativas (sessao_id, perfil_id, questao_id, letra, correta, dicas_usadas, viu_resolucao, tempo_ms, origem)
  values (p_sessao, v_uid, p_questao, v_letra, v_correta, greatest(0, least(coalesce(p_dicas, 0), 3)), coalesce(p_viu_resolucao, false),
          greatest(0, least(coalesce(p_tempo_ms, 0), 3600000)), v_sessao.tipo);

  if not v_correta and v_sessao.tipo in ('licao', 'desafio') then
    if v_sessao.tipo = 'licao' then v_vidas := _ajustar_vidas(v_uid, -1); end if;
    insert into fila_revisao (perfil_id, questao_id, vence_em, repeticoes, lapsos, status, ultima_letra)
    values (v_uid, p_questao, _amanha(v_sessao.fuso), 0, 0, 'pendente', v_letra)
    on conflict (perfil_id, questao_id) do update
      set vence_em = excluded.vence_em, lapsos = fila_revisao.lapsos + 1, status = 'pendente', ultima_letra = excluded.ultima_letra;
  end if;
  return jsonb_build_object('correta', v_correta, 'gabarito', v_gabarito, 'vidas', v_vidas);
end $$;

-- Fecha a sessão e aplica o resultado. Chamar de novo devolve o mesmo resumo, sem aplicar outra vez.
create or replace function public.concluir_sessao(p_sessao uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_uid uuid := auth.uid(); v_sessao sessoes_estudo; v_fuso text; v_dia date;
  v_acertos int := 0; v_total int := 0; v_xp int := 0; v_perfeita boolean := false; v_aprovado boolean;
  v_coroa_antes int := 0; v_coroa_depois int := 0; v_conquistas text[] := '{}';
  v_tema record; v_prog progresso_tema; v_hist jsonb; v_dominio int; v_coroa int; v_alvo boolean;
  v_meta int; v_xp_antes int; v_xp_depois int; v_perfil perfis; v_resumo jsonb;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  select * into v_sessao from sessoes_estudo where id = p_sessao and perfil_id = v_uid for update;
  if not found then raise exception 'sessão não encontrada'; end if;
  if v_sessao.fim is not null then return v_sessao.resumo; end if;
  v_fuso := coalesce(v_sessao.fuso, 'America/Sao_Paulo');
  v_dia := (now() at time zone v_fuso)::date;

  if v_sessao.tipo in ('licao', 'desafio') then
    -- 10 XP por acerto; 5 se o aluno já tinha acertado essa questão antes
    select count(*) filter (where t.correta), count(*),
           coalesce(sum(case when not t.correta then 0
                             when exists (select 1 from tentativas t2 where t2.perfil_id = v_uid and t2.questao_id = t.questao_id
                                          and t2.correta and t2.sessao_id is distinct from p_sessao) then 5
                             else 10 end), 0)
      into v_acertos, v_total, v_xp
      from tentativas t where t.sessao_id = p_sessao;

    if v_total > 0 then
      v_perfeita := v_sessao.tipo = 'licao' and v_acertos = v_total and v_total >= 3;
      if v_perfeita then v_xp := v_xp + 5; end if;
      if v_sessao.tipo = 'desafio' then v_aprovado := v_acertos::numeric / v_total >= 0.7; end if;

      -- domínio (últimas 10 respostas) e coroa de cada subconteúdo respondido
      for v_tema in
        select q.recorte_id, q.assunto, jsonb_agg(to_jsonb(t.correta) order by t.criado_em, t.id) as respostas
          from tentativas t join questoes q on q.id = t.questao_id
         where t.sessao_id = p_sessao group by q.recorte_id, q.assunto
      loop
        select * into v_prog from progresso_tema where perfil_id = v_uid and recorte_id = v_tema.recorte_id and assunto = v_tema.assunto;
        v_hist := coalesce(v_prog.historico, '[]'::jsonb) || v_tema.respostas;
        select coalesce(jsonb_agg(e order by i), '[]'::jsonb) into v_hist
          from jsonb_array_elements(v_hist) with ordinality as x(e, i) where i > jsonb_array_length(v_hist) - 10;
        v_dominio := round(100.0 * (select count(*) from jsonb_array_elements(v_hist) e where e = 'true'::jsonb) / jsonb_array_length(v_hist));
        v_coroa := case
          when v_dominio >= 85 and jsonb_array_length(v_hist) >= 8 then 3
          when v_dominio >= 60 and jsonb_array_length(v_hist) >= 5 then 2
          when v_dominio > 0 then 1 -- Bronze exige pelo menos um acerto
          else 0 end;
        v_coroa := greatest(coalesce(v_prog.coroa, 0), v_coroa);
        v_alvo := v_tema.recorte_id = v_sessao.recorte_id and v_tema.assunto = v_sessao.assunto;
        if v_perfeita and v_alvo then v_coroa := greatest(v_coroa, least(3, coalesce(v_prog.coroa, 0) + 1)); end if;
        if v_alvo then v_coroa_antes := coalesce(v_prog.coroa, 0); v_coroa_depois := v_coroa; end if;
        insert into progresso_tema (perfil_id, recorte_id, assunto, dominio, coroa, licoes, historico, ultima_pratica)
        values (v_uid, v_tema.recorte_id, v_tema.assunto, v_dominio, v_coroa, 1, v_hist, now())
        on conflict (perfil_id, recorte_id, assunto) do update
          set dominio = excluded.dominio, coroa = excluded.coroa, licoes = progresso_tema.licoes + 1,
              historico = excluded.historico, ultima_pratica = excluded.ultima_pratica;
      end loop;

      if v_sessao.tipo = 'desafio' and v_aprovado and v_sessao.unidade is not null then
        insert into progresso_unidade (perfil_id, chave, desafio_ok) values (v_uid, v_sessao.recorte_id || '|' || v_sessao.unidade, true)
        on conflict (perfil_id, chave) do update set desafio_ok = true;
      end if;
      update perfis set questoes_feitas = questoes_feitas + v_total, acertos_total = acertos_total + v_acertos where id = v_uid;
    end if;

  else
    -- revisão: recuperada se acertou sem ver a resolução; 5, 4 ou 3 XP conforme as dicas; reagenda na fila
    for v_tema in
      select t.questao_id, bool_or(t.correta) as acertou, coalesce(max(t.dicas_usadas) filter (where t.correta), 0) as dicas
        from tentativas t where t.sessao_id = p_sessao group by t.questao_id
    loop
      v_total := v_total + 1;
      if v_tema.acertou then
        v_acertos := v_acertos + 1;
        v_xp := v_xp + (array[5, 4, 3])[least(2, v_tema.dicas) + 1];
      end if;
      update fila_revisao f set
        vence_em = case when not v_tema.acertou then _amanha(v_fuso)
                        when v_tema.dicas > 0 then now() + interval '3 days'
                        else now() + make_interval(days => (array[7, 21, 60])[least(f.repeticoes, 2) + 1]) end,
        lapsos = f.lapsos + case when v_tema.acertou then 0 else 1 end,
        repeticoes = f.repeticoes + case when v_tema.acertou then 1 else 0 end,
        status = case when v_tema.acertou and v_tema.dicas = 0 then 'dominada' else 'pendente' end
      where f.perfil_id = v_uid and f.questao_id = v_tema.questao_id;
    end loop;

    if v_total > 0 then
      v_perfeita := v_acertos = v_total;
      update perfis set revisoes_concluidas = revisoes_concluidas + 1, questoes_feitas = questoes_feitas + v_total,
                        acertos_total = acertos_total + v_acertos where id = v_uid;
      -- recuperar ao menos uma questão devolve 1 vida (até 5 por dia)
      if v_acertos > 0 and (select count(*) from vidas_ganhas where perfil_id = v_uid and origem = 'revisao' and criado_em > now() - interval '24 hours') < 5 then
        insert into vidas_ganhas (perfil_id, origem) values (v_uid, 'revisao');
        perform _ajustar_vidas(v_uid, +1);
      end if;
    end if;
  end if;

  if v_total > 0 then
    -- XP do dia e sequência: a sequência sobe no dia em que a meta é batida
    select coalesce(meta_xp, 30) into v_meta from preferencias where perfil_id = v_uid;
    v_meta := coalesce(v_meta, 30);
    select coalesce((select xp from xp_diario where perfil_id = v_uid and dia = v_dia), 0) into v_xp_antes;
    insert into xp_diario (perfil_id, dia, xp) values (v_uid, v_dia, v_xp)
    on conflict (perfil_id, dia) do update set xp = xp_diario.xp + excluded.xp
    returning xp into v_xp_depois;
    select * into v_perfil from perfis where id = v_uid for update;
    if v_xp_antes < v_meta and v_xp_depois >= v_meta and v_perfil.ultimo_dia_meta is distinct from v_dia then
      update perfis set
        sequencia_atual = case when v_perfil.ultimo_dia_meta = v_dia - 1 then v_perfil.sequencia_atual + 1 else 1 end,
        sequencia_recorde = greatest(v_perfil.sequencia_recorde, case when v_perfil.ultimo_dia_meta = v_dia - 1 then v_perfil.sequencia_atual + 1 else 1 end),
        ultimo_dia_meta = v_dia
      where id = v_uid;
    end if;
    update perfis set xp_total = xp_total + v_xp where id = v_uid;

    -- conquistas novas
    select * into v_perfil from perfis where id = v_uid;
    select coalesce(array_agg(c), '{}') into v_conquistas
      from unnest(array['primeiro_passo', 'sete_dias', 'licao_perfeita', 'revisao_em_dia', 'trezentas', 'dez_ouros', 'quatro_areas', 'trinta_dias']) as c
     where not exists (select 1 from usuario_conquistas u where u.perfil_id = v_uid and u.codigo = c)
       and case c
         when 'primeiro_passo' then (select coalesce(sum(licoes), 0) from progresso_tema where perfil_id = v_uid) >= 1
         when 'sete_dias' then v_perfil.sequencia_recorde >= 7
         when 'licao_perfeita' then v_perfeita and v_sessao.tipo = 'licao'
         when 'revisao_em_dia' then v_perfil.revisoes_concluidas >= 5
         when 'trezentas' then v_perfil.questoes_feitas >= 300
         when 'dez_ouros' then (select count(*) from progresso_tema where perfil_id = v_uid and coroa = 3) >= 10
         when 'quatro_areas' then
           (select count(distinct coalesce(r.area, r.id)) from progresso_tema t join recortes r on r.id = t.recorte_id
             where t.perfil_id = v_uid and r.exame_id = v_sessao.exame_id)
           >= (select count(distinct coalesce(area, id)) from recortes where exame_id = v_sessao.exame_id)
         when 'trinta_dias' then v_perfil.sequencia_recorde >= 30
       end;
    insert into usuario_conquistas (perfil_id, codigo) select v_uid, unnest(v_conquistas);
  end if;

  v_resumo := jsonb_build_object('acertos', v_acertos, 'total', v_total, 'xp', v_xp, 'perfeita', v_perfeita, 'aprovado', v_aprovado,
                                 'conquistas', to_jsonb(v_conquistas), 'coroaAntes', v_coroa_antes, 'coroaDepois', v_coroa_depois);
  update sessoes_estudo set fim = now(), acertos = v_acertos, total = v_total, xp = v_xp, perfeita = v_perfeita, resumo = v_resumo
   where id = p_sessao;
  return v_resumo;
end $$;

-- Assistiu a um anúncio premiado: +1 vida (até 5 por dia)
create or replace function public.ganhar_vida_anuncio()
returns jsonb language plpgsql security definer set search_path = public as $$
declare v_uid uuid := auth.uid(); v_vidas int;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  if (select count(*) from vidas_ganhas where perfil_id = v_uid and origem = 'anuncio' and criado_em > now() - interval '24 hours') >= 5 then
    raise exception 'limite_anuncios';
  end if;
  insert into vidas_ganhas (perfil_id, origem) values (v_uid, 'anuncio');
  v_vidas := _ajustar_vidas(v_uid, +1);
  return jsonb_build_object('vidas', v_vidas);
end $$;

-- ---------- Permissões: o aluno só grava direto o nome, as preferências e o interesse no Pro

revoke insert, update, delete on public.perfis from anon, authenticated;
grant update (nome) on public.perfis to authenticated;
revoke insert, update, delete on public.xp_diario, public.sessoes_estudo, public.tentativas, public.progresso_tema,
  public.fila_revisao, public.progresso_unidade, public.usuario_conquistas from anon, authenticated;

revoke all on function public._vidas_agora(int, timestamptz), public._ajustar_vidas(uuid, int), public._fuso(text), public._amanha(text)
  from public, anon, authenticated;
revoke all on function public.garantir_perfil(), public.iniciar_sessao(text, text, text, text, int, text),
  public.responder(uuid, text, text, int, boolean, int), public.concluir_sessao(uuid), public.ganhar_vida_anuncio()
  from public, anon;
grant execute on function public.garantir_perfil(), public.iniciar_sessao(text, text, text, text, int, text),
  public.responder(uuid, text, text, int, boolean, int), public.concluir_sessao(uuid), public.ganhar_vida_anuncio()
  to authenticated;

-- Pense · 0007 · Sessões conferidas: questões da lição e do desafio, revisão só da fila, desafio na ordem da trilha
-- Correções da segunda bateria de testes (N01 a N04 e N08). As funções do banco passam a recusar o que o app nunca
-- envia: questão fora da lição ou do desafio, lição ou desafio de tamanho diferente, revisão de questão fora da fila,
-- desafio fora de ordem ou aprovado sem responder tudo e resposta depois de ver a resolução. As dicas da revisão são
-- registradas no banco quando o aluno abre cada uma.

-- Questões montadas pelo app para a lição ou o desafio (responder só aceita estas) e dicas abertas na revisão
alter table public.sessoes_estudo add column if not exists questoes text[];
alter table public.sessoes_estudo add column if not exists dicas jsonb not null default '{}'::jsonb;

-- O aluno altera as próprias preferências, mas não apaga a linha
revoke delete on public.preferencias from anon, authenticated;

-- ---------- Funções internas

-- Subconteúdos de uma unidade da trilha: os da matéria, do que tem mais questões para o que tem menos (empate pela
-- ordem dos caracteres do nome), 6 por unidade. Mesma conta de unidadesDoRecorte (src/domain/regras.ts).
create or replace function public._temas_da_unidade(p_recorte text, p_lingua text, p_unidade int)
returns text[] language sql stable set search_path = public as $$
  select coalesce(array_agg(assunto order by pos), '{}') from (
    select assunto, row_number() over (order by count(*) desc, assunto collate "C") - 1 as pos
      from questoes where recorte_id = p_recorte and ativa and (lingua is null or lingua = p_lingua)
     group by assunto
  ) t where pos / 6 = p_unidade
$$;

-- ---------- Funções chamadas pelo app

-- A versão anterior não recebia as questões
drop function if exists public.iniciar_sessao(text, text, text, text, int, text);

-- Abre a sessão. Lição e desafio chegam com a lista de questões montada pelo app (montarLicao e montarDesafio),
-- conferida aqui: a lição tem até 5 questões da matéria, com as do subconteúdo primeiro (outras só completam um
-- subconteúdo curto); o desafio tem as questões dos subconteúdos da unidade (10, ou todas se forem menos) e só abre
-- com o desafio anterior vencido e todos os subconteúdos da unidade com coroa.
create or replace function public.iniciar_sessao(p_tipo text, p_exame text, p_recorte text, p_assunto text, p_unidade int, p_fuso text, p_questoes text[] default null)
returns uuid language plpgsql security definer set search_path = public as $$
declare
  v_uid uuid := auth.uid(); v_id uuid; v_n int := coalesce(cardinality(p_questoes), 0);
  v_lingua text; v_temas text[]; v_disp int;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  if p_tipo not in ('licao', 'revisao', 'desafio') then raise exception 'tipo de sessão inválido'; end if;

  if p_tipo in ('licao', 'desafio') then
    if v_n = 0 or array_position(p_questoes, null) is not null
       or v_n <> (select count(distinct q) from unnest(p_questoes) q)
       or v_n <> (select count(*) from questoes where id = any(p_questoes) and ativa and exame_id = p_exame and recorte_id = p_recorte) then
      raise exception 'questões fora da sessão';
    end if;
    -- língua das questões (Inglês, Espanhol) ou, nas matérias sem língua, a das preferências
    v_lingua := coalesce((select max(lingua) from questoes where id = any(p_questoes)), (select lingua from preferencias where perfil_id = v_uid));
  end if;

  if p_tipo = 'licao' then
    select count(*) into v_disp from questoes
     where recorte_id = p_recorte and assunto = p_assunto and ativa and (lingua is null or lingua = v_lingua);
    if v_n > 5 or v_disp = 0
       or (select count(*) from questoes where id = any(p_questoes) and assunto = p_assunto) < least(v_n, v_disp) then
      raise exception 'questões fora da sessão';
    end if;
  elsif p_tipo = 'desafio' then
    v_temas := _temas_da_unidade(p_recorte, v_lingua, p_unidade);
    if p_unidade is null or cardinality(v_temas) = 0 then raise exception 'questões fora da sessão'; end if;
    if (p_unidade > 0 and not exists (select 1 from progresso_unidade where perfil_id = v_uid and chave = p_recorte || '|' || (p_unidade - 1) and desafio_ok))
       or (select count(*) from progresso_tema where perfil_id = v_uid and recorte_id = p_recorte and assunto = any(v_temas) and coroa >= 1) < cardinality(v_temas) then
      raise exception 'desafio_bloqueado';
    end if;
    select count(*) into v_disp from questoes
     where recorte_id = p_recorte and assunto = any(v_temas) and ativa and (lingua is null or lingua = v_lingua);
    if v_n <> least(10, v_disp) or exists (select 1 from questoes where id = any(p_questoes) and not (assunto = any(v_temas))) then
      raise exception 'questões fora da sessão';
    end if;
  end if;

  insert into sessoes_estudo (perfil_id, tipo, exame_id, recorte_id, assunto, unidade, inicio, fuso, questoes)
  values (v_uid, p_tipo, p_exame, p_recorte, p_assunto, p_unidade, now(), _fuso(p_fuso), case when p_tipo <> 'revisao' then p_questoes end)
  returning id into v_id;
  return v_id;
end $$;

-- Abriu a dica 1 ou 2 de uma questão na revisão. O XP da questão usa este registro (o app pode informar mais dicas,
-- nunca menos). Repetir a chamada não muda nada.
create or replace function public.abrir_dica(p_sessao uuid, p_questao text, p_dica int)
returns void language plpgsql security definer set search_path = public as $$
declare v_uid uuid := auth.uid(); v_sessao sessoes_estudo;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  if p_dica is null or p_dica not in (1, 2) then raise exception 'dica inválida'; end if;
  select * into v_sessao from sessoes_estudo where id = p_sessao and perfil_id = v_uid for update;
  if not found then raise exception 'sessão não encontrada'; end if;
  if v_sessao.fim is not null then raise exception 'sessão já concluída'; end if;
  if v_sessao.tipo <> 'revisao'
     or not exists (select 1 from fila_revisao where perfil_id = v_uid and questao_id = p_questao and status = 'pendente') then
    raise exception 'questão fora da revisão';
  end if;
  update sessoes_estudo set dicas = dicas || jsonb_build_object(p_questao, greatest(p_dica, coalesce((dicas ->> p_questao)::int, 0)))
   where id = p_sessao;
end $$;

-- Registra uma resposta. O banco confere o gabarito; na lição, errar gasta 1 vida; na lição e no desafio, o erro
-- entra na revisão de amanhã. Lição e desafio só aceitam as questões da sessão. Na revisão, só questões pendentes na
-- fila do aluno (até 10 por sessão), no máximo 2 tentativas por questão, e letra nula = "ver resolução"; depois de
-- acertar ou de ver a resolução, a questão está encerrada.
create or replace function public.responder(p_sessao uuid, p_questao text, p_letra text, p_dicas int default 0, p_viu_resolucao boolean default false, p_tempo_ms int default null)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_uid uuid := auth.uid(); v_sessao sessoes_estudo; v_gabarito text; v_letra text := upper(nullif(btrim(p_letra), ''));
  v_correta boolean; v_vidas int; v_anterior tentativas; v_dicas int := 0;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  select * into v_sessao from sessoes_estudo where id = p_sessao and perfil_id = v_uid for update;
  if not found then raise exception 'sessão não encontrada'; end if;
  if v_sessao.fim is not null then raise exception 'sessão já concluída'; end if;
  select gabarito into v_gabarito from questoes where id = p_questao and ativa;
  if v_gabarito is null then raise exception 'questão não encontrada'; end if;
  if v_letra is not null and not exists (select 1 from alternativas where questao_id = p_questao and letra = v_letra) then
    raise exception 'alternativa inválida';
  end if;

  if v_sessao.tipo in ('licao', 'desafio') then
    if not coalesce(p_questao = any(v_sessao.questoes), false) then raise exception 'questões fora da sessão'; end if;
    select * into v_anterior from tentativas where sessao_id = p_sessao and questao_id = p_questao;
    if found then -- clique repetido: devolve a mesma resposta, sem efeito
      return jsonb_build_object('correta', v_anterior.correta, 'gabarito', v_gabarito, 'repetida', true);
    end if;
    if v_letra is null then raise exception 'resposta vazia'; end if;
    if v_sessao.tipo = 'licao' and (select _vidas_agora(vidas, vidas_atualizadas_em) from perfis where id = v_uid) = 0 then
      raise exception 'sem_vidas';
    end if;
  else
    if not exists (select 1 from fila_revisao where perfil_id = v_uid and questao_id = p_questao and status = 'pendente') then
      raise exception 'questão fora da revisão';
    end if;
    if v_letra is not null and exists (select 1 from tentativas where sessao_id = p_sessao and questao_id = p_questao and letra = v_letra) then
      return jsonb_build_object('correta', v_letra = v_gabarito, 'gabarito', v_gabarito, 'repetida', true);
    end if;
    if exists (select 1 from tentativas where sessao_id = p_sessao and questao_id = p_questao and (correta or viu_resolucao))
       or (select count(*) from tentativas where sessao_id = p_sessao and questao_id = p_questao) >= 2 then
      raise exception 'questão encerrada';
    end if;
    if not exists (select 1 from tentativas where sessao_id = p_sessao and questao_id = p_questao)
       and (select count(distinct questao_id) from tentativas where sessao_id = p_sessao) >= 10 then
      raise exception 'questões fora da sessão';
    end if;
    v_dicas := greatest(coalesce((v_sessao.dicas ->> p_questao)::int, 0), least(greatest(coalesce(p_dicas, 0), 0), 2));
  end if;

  v_correta := v_letra is not null and v_letra = v_gabarito;
  insert into tentativas (sessao_id, perfil_id, questao_id, letra, correta, dicas_usadas, viu_resolucao, tempo_ms, origem)
  values (p_sessao, v_uid, p_questao, v_letra, v_correta, v_dicas, v_sessao.tipo = 'revisao' and v_letra is null,
          greatest(0, least(coalesce(p_tempo_ms, 0), 3600000)), v_sessao.tipo);

  if not v_correta and v_sessao.tipo in ('licao', 'desafio') then
    if v_sessao.tipo = 'licao' then v_vidas := _ajustar_vidas(v_uid, -1); end if;
    insert into fila_revisao (perfil_id, questao_id, vence_em, repeticoes, lapsos, status, ultima_letra)
    values (v_uid, p_questao, _amanha(v_sessao.fuso), 0, 0, 'pendente', v_letra)
    on conflict (perfil_id, questao_id) do update
      set vence_em = excluded.vence_em, lapsos = fila_revisao.lapsos + 1, status = 'pendente', ultima_letra = excluded.ultima_letra;
  end if;
  return jsonb_build_object('correta', v_correta, 'gabarito', v_gabarito, 'vidas', v_vidas);
end $$;

-- Fecha a sessão e aplica o resultado. Chamar de novo devolve o mesmo resumo, sem aplicar outra vez.
-- Igual à 0006, exceto o desafio: só é aprovado com todas as questões da sessão respondidas.
create or replace function public.concluir_sessao(p_sessao uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_uid uuid := auth.uid(); v_sessao sessoes_estudo; v_fuso text; v_dia date;
  v_acertos int := 0; v_total int := 0; v_xp int := 0; v_perfeita boolean := false; v_aprovado boolean;
  v_coroa_antes int := 0; v_coroa_depois int := 0; v_conquistas text[] := '{}';
  v_tema record; v_prog progresso_tema; v_hist jsonb; v_dominio int; v_coroa int; v_alvo boolean;
  v_meta int; v_xp_antes int; v_xp_depois int; v_perfil perfis; v_resumo jsonb;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  select * into v_sessao from sessoes_estudo where id = p_sessao and perfil_id = v_uid for update;
  if not found then raise exception 'sessão não encontrada'; end if;
  if v_sessao.fim is not null then return v_sessao.resumo; end if;
  v_fuso := coalesce(v_sessao.fuso, 'America/Sao_Paulo');
  v_dia := (now() at time zone v_fuso)::date;

  if v_sessao.tipo in ('licao', 'desafio') then
    -- 10 XP por acerto; 5 se o aluno já tinha acertado essa questão antes
    select count(*) filter (where t.correta), count(*),
           coalesce(sum(case when not t.correta then 0
                             when exists (select 1 from tentativas t2 where t2.perfil_id = v_uid and t2.questao_id = t.questao_id
                                          and t2.correta and t2.sessao_id is distinct from p_sessao) then 5
                             else 10 end), 0)
      into v_acertos, v_total, v_xp
      from tentativas t where t.sessao_id = p_sessao;

    if v_total > 0 then
      v_perfeita := v_sessao.tipo = 'licao' and v_acertos = v_total and v_total >= 3;
      if v_perfeita then v_xp := v_xp + 5; end if;
      if v_sessao.tipo = 'desafio' then
        v_aprovado := v_total = coalesce(cardinality(v_sessao.questoes), 0) and v_acertos::numeric / v_total >= 0.7;
      end if;

      -- domínio (últimas 10 respostas) e coroa de cada subconteúdo respondido
      for v_tema in
        select q.recorte_id, q.assunto, jsonb_agg(to_jsonb(t.correta) order by t.criado_em, t.id) as respostas
          from tentativas t join questoes q on q.id = t.questao_id
         where t.sessao_id = p_sessao group by q.recorte_id, q.assunto
      loop
        select * into v_prog from progresso_tema where perfil_id = v_uid and recorte_id = v_tema.recorte_id and assunto = v_tema.assunto;
        v_hist := coalesce(v_prog.historico, '[]'::jsonb) || v_tema.respostas;
        select coalesce(jsonb_agg(e order by i), '[]'::jsonb) into v_hist
          from jsonb_array_elements(v_hist) with ordinality as x(e, i) where i > jsonb_array_length(v_hist) - 10;
        v_dominio := round(100.0 * (select count(*) from jsonb_array_elements(v_hist) e where e = 'true'::jsonb) / jsonb_array_length(v_hist));
        v_coroa := case
          when v_dominio >= 85 and jsonb_array_length(v_hist) >= 8 then 3
          when v_dominio >= 60 and jsonb_array_length(v_hist) >= 5 then 2
          when v_dominio > 0 then 1 -- Bronze exige pelo menos um acerto
          else 0 end;
        v_coroa := greatest(coalesce(v_prog.coroa, 0), v_coroa);
        v_alvo := v_tema.recorte_id = v_sessao.recorte_id and v_tema.assunto = v_sessao.assunto;
        if v_perfeita and v_alvo then v_coroa := greatest(v_coroa, least(3, coalesce(v_prog.coroa, 0) + 1)); end if;
        if v_alvo then v_coroa_antes := coalesce(v_prog.coroa, 0); v_coroa_depois := v_coroa; end if;
        insert into progresso_tema (perfil_id, recorte_id, assunto, dominio, coroa, licoes, historico, ultima_pratica)
        values (v_uid, v_tema.recorte_id, v_tema.assunto, v_dominio, v_coroa, 1, v_hist, now())
        on conflict (perfil_id, recorte_id, assunto) do update
          set dominio = excluded.dominio, coroa = excluded.coroa, licoes = progresso_tema.licoes + 1,
              historico = excluded.historico, ultima_pratica = excluded.ultima_pratica;
      end loop;

      if v_sessao.tipo = 'desafio' and v_aprovado and v_sessao.unidade is not null then
        insert into progresso_unidade (perfil_id, chave, desafio_ok) values (v_uid, v_sessao.recorte_id || '|' || v_sessao.unidade, true)
        on conflict (perfil_id, chave) do update set desafio_ok = true;
      end if;
      update perfis set questoes_feitas = questoes_feitas + v_total, acertos_total = acertos_total + v_acertos where id = v_uid;
    end if;

  else
    -- revisão: recuperada se acertou sem ver a resolução; 5, 4 ou 3 XP conforme as dicas; reagenda na fila
    for v_tema in
      select t.questao_id, bool_or(t.correta) as acertou, coalesce(max(t.dicas_usadas) filter (where t.correta), 0) as dicas
        from tentativas t where t.sessao_id = p_sessao group by t.questao_id
    loop
      v_total := v_total + 1;
      if v_tema.acertou then
        v_acertos := v_acertos + 1;
        v_xp := v_xp + (array[5, 4, 3])[least(2, v_tema.dicas) + 1];
      end if;
      update fila_revisao f set
        vence_em = case when not v_tema.acertou then _amanha(v_fuso)
                        when v_tema.dicas > 0 then now() + interval '3 days'
                        else now() + make_interval(days => (array[7, 21, 60])[least(f.repeticoes, 2) + 1]) end,
        lapsos = f.lapsos + case when v_tema.acertou then 0 else 1 end,
        repeticoes = f.repeticoes + case when v_tema.acertou then 1 else 0 end,
        status = case when v_tema.acertou and v_tema.dicas = 0 then 'dominada' else 'pendente' end
      where f.perfil_id = v_uid and f.questao_id = v_tema.questao_id;
    end loop;

    if v_total > 0 then
      v_perfeita := v_acertos = v_total;
      update perfis set revisoes_concluidas = revisoes_concluidas + 1, questoes_feitas = questoes_feitas + v_total,
                        acertos_total = acertos_total + v_acertos where id = v_uid;
      -- recuperar ao menos uma questão devolve 1 vida (até 5 por dia)
      if v_acertos > 0 and (select count(*) from vidas_ganhas where perfil_id = v_uid and origem = 'revisao' and criado_em > now() - interval '24 hours') < 5 then
        insert into vidas_ganhas (perfil_id, origem) values (v_uid, 'revisao');
        perform _ajustar_vidas(v_uid, +1);
      end if;
    end if;
  end if;

  if v_total > 0 then
    -- XP do dia e sequência: a sequência sobe no dia em que a meta é batida
    select coalesce(meta_xp, 30) into v_meta from preferencias where perfil_id = v_uid;
    v_meta := coalesce(v_meta, 30);
    select coalesce((select xp from xp_diario where perfil_id = v_uid and dia = v_dia), 0) into v_xp_antes;
    insert into xp_diario (perfil_id, dia, xp) values (v_uid, v_dia, v_xp)
    on conflict (perfil_id, dia) do update set xp = xp_diario.xp + excluded.xp
    returning xp into v_xp_depois;
    select * into v_perfil from perfis where id = v_uid for update;
    if v_xp_antes < v_meta and v_xp_depois >= v_meta and v_perfil.ultimo_dia_meta is distinct from v_dia then
      update perfis set
        sequencia_atual = case when v_perfil.ultimo_dia_meta = v_dia - 1 then v_perfil.sequencia_atual + 1 else 1 end,
        sequencia_recorde = greatest(v_perfil.sequencia_recorde, case when v_perfil.ultimo_dia_meta = v_dia - 1 then v_perfil.sequencia_atual + 1 else 1 end),
        ultimo_dia_meta = v_dia
      where id = v_uid;
    end if;
    update perfis set xp_total = xp_total + v_xp where id = v_uid;

    -- conquistas novas
    select * into v_perfil from perfis where id = v_uid;
    select coalesce(array_agg(c), '{}') into v_conquistas
      from unnest(array['primeiro_passo', 'sete_dias', 'licao_perfeita', 'revisao_em_dia', 'trezentas', 'dez_ouros', 'quatro_areas', 'trinta_dias']) as c
     where not exists (select 1 from usuario_conquistas u where u.perfil_id = v_uid and u.codigo = c)
       and case c
         when 'primeiro_passo' then (select coalesce(sum(licoes), 0) from progresso_tema where perfil_id = v_uid) >= 1
         when 'sete_dias' then v_perfil.sequencia_recorde >= 7
         when 'licao_perfeita' then v_perfeita and v_sessao.tipo = 'licao'
         when 'revisao_em_dia' then v_perfil.revisoes_concluidas >= 5
         when 'trezentas' then v_perfil.questoes_feitas >= 300
         when 'dez_ouros' then (select count(*) from progresso_tema where perfil_id = v_uid and coroa = 3) >= 10
         when 'quatro_areas' then
           (select count(distinct coalesce(r.area, r.id)) from progresso_tema t join recortes r on r.id = t.recorte_id
             where t.perfil_id = v_uid and r.exame_id = v_sessao.exame_id)
           >= (select count(distinct coalesce(area, id)) from recortes where exame_id = v_sessao.exame_id)
         when 'trinta_dias' then v_perfil.sequencia_recorde >= 30
       end;
    insert into usuario_conquistas (perfil_id, codigo) select v_uid, unnest(v_conquistas);
  end if;

  v_resumo := jsonb_build_object('acertos', v_acertos, 'total', v_total, 'xp', v_xp, 'perfeita', v_perfeita, 'aprovado', v_aprovado,
                                 'conquistas', to_jsonb(v_conquistas), 'coroaAntes', v_coroa_antes, 'coroaDepois', v_coroa_depois);
  update sessoes_estudo set fim = now(), acertos = v_acertos, total = v_total, xp = v_xp, perfeita = v_perfeita, resumo = v_resumo
   where id = p_sessao;
  return v_resumo;
end $$;

-- ---------- Permissões

revoke all on function public._temas_da_unidade(text, text, int) from public, anon, authenticated;
revoke all on function public.iniciar_sessao(text, text, text, text, int, text, text[]), public.abrir_dica(uuid, text, int)
  from public, anon;
grant execute on function public.iniciar_sessao(text, text, text, text, int, text, text[]), public.abrir_dica(uuid, text, int)
  to authenticated;
