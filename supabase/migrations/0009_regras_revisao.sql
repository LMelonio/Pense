-- Pense · 0009 · Regras da revisão e das vidas (decisões de produto de 26/10/2026, itens F2 do plano de melhorias)
-- F2-01 Revisão adiantada (questão que ainda não venceu) é treino: acertar não domina, não dá XP e a questão volta
--       amanhã. Só domina e pontua quem acerta numa revisão vencida.
-- F2-02 A vida da revisão vem só de questão vencida recuperada, no máximo 1 por dia (no fuso do aluno), e só quando
--       falta vida (com as vidas cheias, a vida do dia continua disponível).
-- F2-03 Questão dominada volta quando vence (7, 21, 60 dias): acertando sem dica, avança; errando, volta a pendente.
-- F2-05 A primeira lição do aluno (nenhuma questão feita ainda) não gasta vida.
-- F2-06 Na revisão, acertar na 2ª tentativa conta como uma dica a mais no XP (4 sem dica, 3 com dica).
-- As mesmas regras estão em src/domain/regras.ts e sessoes.ts; a suíte src/domain/paridade.test.ts confere os dois.
-- Aplique no SQL Editor ANTES de publicar o app.

-- Dia (no fuso do aluno) em que a revisão já devolveu a vida (F2-02)
alter table public.perfis add column if not exists dia_vida_revisao date;
-- Lição que não gasta vida: a primeira do aluno (F2-05)
alter table public.sessoes_estudo add column if not exists sem_custo_vida boolean not null default false;

-- Questão que pode entrar na revisão agora: pendente (vencida ou não, para adiantar) ou dominada já vencida (F2-03)
create or replace function public._na_revisao(p_perfil uuid, p_questao text)
returns boolean language sql stable set search_path = public as $$
  select exists (select 1 from fila_revisao where perfil_id = p_perfil and questao_id = p_questao
                  and (status = 'pendente' or (status = 'dominada' and vence_em <= now())))
$$;
revoke all on function public._na_revisao(uuid, text) from public, anon, authenticated;

-- ---------- iniciar_sessao: igual à 0007, marcando a primeira lição (F2-05)
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

  insert into sessoes_estudo (perfil_id, tipo, exame_id, recorte_id, assunto, unidade, inicio, fuso, questoes, sem_custo_vida)
  values (v_uid, p_tipo, p_exame, p_recorte, p_assunto, p_unidade, now(), _fuso(p_fuso), case when p_tipo <> 'revisao' then p_questoes end,
          p_tipo = 'licao' and coalesce((select questoes_feitas from perfis where id = v_uid), 0) = 0)
  returning id into v_id;
  return v_id;
end $$;

-- ---------- abrir_dica: igual à 0007, aceitando a dominada vencida (F2-03)
create or replace function public.abrir_dica(p_sessao uuid, p_questao text, p_dica int)
returns void language plpgsql security definer set search_path = public as $$
declare v_uid uuid := auth.uid(); v_sessao sessoes_estudo;
begin
  if v_uid is null then raise exception 'não autenticado'; end if;
  if p_dica is null or p_dica not in (1, 2) then raise exception 'dica inválida'; end if;
  select * into v_sessao from sessoes_estudo where id = p_sessao and perfil_id = v_uid for update;
  if not found then raise exception 'sessão não encontrada'; end if;
  if v_sessao.fim is not null then raise exception 'sessão já concluída'; end if;
  if v_sessao.tipo <> 'revisao' or not _na_revisao(v_uid, p_questao) then
    raise exception 'questão fora da revisão';
  end if;
  update sessoes_estudo set dicas = dicas || jsonb_build_object(p_questao, greatest(p_dica, coalesce((dicas ->> p_questao)::int, 0)))
   where id = p_sessao;
end $$;

-- ---------- responder: igual à 0007, com a primeira lição sem gastar vida (F2-05) e a dominada vencida (F2-03)
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
    if v_sessao.tipo = 'licao' and not v_sessao.sem_custo_vida
       and (select _vidas_agora(vidas, vidas_atualizadas_em) from perfis where id = v_uid) = 0 then
      raise exception 'sem_vidas';
    end if;
  else
    if not _na_revisao(v_uid, p_questao) then
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
    if v_sessao.tipo = 'licao' and not v_sessao.sem_custo_vida then v_vidas := _ajustar_vidas(v_uid, -1); end if;
    insert into fila_revisao (perfil_id, questao_id, vence_em, repeticoes, lapsos, status, ultima_letra)
    values (v_uid, p_questao, _amanha(v_sessao.fuso), 0, 0, 'pendente', v_letra)
    on conflict (perfil_id, questao_id) do update
      set vence_em = excluded.vence_em, lapsos = fila_revisao.lapsos + 1, status = 'pendente', ultima_letra = excluded.ultima_letra;
  end if;
  return jsonb_build_object('correta', v_correta, 'gabarito', v_gabarito, 'vidas', v_vidas);
end $$;

-- ---------- concluir_sessao: igual à 0007, com a revisão nova (F2-01, F2-02, F2-03, F2-06) e "vidaGanha" no resumo
create or replace function public.concluir_sessao(p_sessao uuid)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  v_uid uuid := auth.uid(); v_sessao sessoes_estudo; v_fuso text; v_dia date;
  v_acertos int := 0; v_total int := 0; v_xp int := 0; v_perfeita boolean := false; v_aprovado boolean;
  v_coroa_antes int := 0; v_coroa_depois int := 0; v_conquistas text[] := '{}';
  v_tema record; v_prog progresso_tema; v_hist jsonb; v_dominio int; v_coroa int; v_alvo boolean;
  v_meta int; v_xp_antes int; v_xp_depois int; v_perfil perfis; v_resumo jsonb;
  v_vencida boolean; v_recuperadas int := 0; v_vida boolean := false;
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
    -- Revisão. Por questão: acertou se alguma tentativa acertou (antes de ver a resolução); as dicas que contam são as
    -- da tentativa certa; "errou antes" = acertou só na 2ª tentativa. Vencida = já tinha chegado o dia dela.
    for v_tema in
      select t.questao_id, bool_or(t.correta) as acertou, coalesce(max(t.dicas_usadas) filter (where t.correta), 0) as dicas,
             bool_or(not t.correta and t.letra is not null) as errou_antes
        from tentativas t where t.sessao_id = p_sessao group by t.questao_id
    loop
      select coalesce(bool_or(f.vence_em <= now()), false) into v_vencida
        from fila_revisao f where f.perfil_id = v_uid and f.questao_id = v_tema.questao_id;
      v_total := v_total + 1;
      if v_tema.acertou then
        v_acertos := v_acertos + 1;
        if v_vencida then
          v_recuperadas := v_recuperadas + 1;
          v_xp := v_xp + (array[5, 4, 3])[least(2, v_tema.dicas + case when v_tema.errou_antes then 1 else 0 end) + 1];
        end if;
      end if;
      -- Errou, ou acertou adiantado (treino): volta amanhã. Vencida e certa: com dica, 3 dias; sem dica, domina (7, 21, 60)
      update fila_revisao f set
        vence_em = case when not v_tema.acertou or not v_vencida then _amanha(v_fuso)
                        when v_tema.dicas > 0 then now() + interval '3 days'
                        else now() + make_interval(days => (array[7, 21, 60])[least(f.repeticoes, 2) + 1]) end,
        lapsos = f.lapsos + case when v_tema.acertou then 0 else 1 end,
        repeticoes = f.repeticoes + case when v_tema.acertou and v_vencida then 1 else 0 end,
        status = case when v_tema.acertou and v_vencida and v_tema.dicas = 0 then 'dominada' else 'pendente' end
      where f.perfil_id = v_uid and f.questao_id = v_tema.questao_id;
    end loop;

    if v_total > 0 then
      v_perfeita := v_acertos = v_total;
      update perfis set revisoes_concluidas = revisoes_concluidas + 1, questoes_feitas = questoes_feitas + v_total,
                        acertos_total = acertos_total + v_acertos where id = v_uid;
      -- 1 vida por dia, só por questão vencida recuperada e só se faltar vida
      select * into v_perfil from perfis where id = v_uid for update;
      if v_recuperadas > 0 and v_perfil.dia_vida_revisao is distinct from v_dia
         and _vidas_agora(v_perfil.vidas, v_perfil.vidas_atualizadas_em) < 3 then
        insert into vidas_ganhas (perfil_id, origem) values (v_uid, 'revisao');
        perform _ajustar_vidas(v_uid, +1);
        update perfis set dia_vida_revisao = v_dia where id = v_uid;
        v_vida := true;
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
                                 'conquistas', to_jsonb(v_conquistas), 'coroaAntes', v_coroa_antes, 'coroaDepois', v_coroa_depois,
                                 'vidaGanha', v_vida);
  update sessoes_estudo set fim = now(), acertos = v_acertos, total = v_total, xp = v_xp, perfeita = v_perfeita, resumo = v_resumo
   where id = p_sessao;
  return v_resumo;
end $$;
