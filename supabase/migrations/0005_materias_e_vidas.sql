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
