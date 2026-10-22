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
