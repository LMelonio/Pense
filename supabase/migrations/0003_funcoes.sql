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
