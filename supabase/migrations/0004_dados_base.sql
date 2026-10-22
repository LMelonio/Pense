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
