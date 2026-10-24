-- Pense · 0008 · Recarga de vida a cada 2 horas
-- Decisão de produto (24/10/2026): sem anúncio, o aluno recupera 1 vida a cada 2 horas (antes, 30 minutos). O anúncio
-- premiado continua dando +1 vida na hora, até 5 em 24 horas. A recarga conta a partir da última recarga (ou do erro,
-- se as vidas estavam cheias), como antes. Mesmas contas de vidasAgora e ajustarVidas (src/domain/regras.ts).

-- Vidas atuais, com a recarga de 1 a cada 2 horas (máximo 3)
create or replace function public._vidas_agora(p_vidas int, p_desde timestamptz)
returns int language sql stable as $$
  select case when p_vidas >= 3 then 3
    else least(3, p_vidas + greatest(0, floor(extract(epoch from (now() - p_desde)) / 7200)::int)) end
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
  elsif v_atual <> v_vidas then v_marco := v_desde + make_interval(mins => (v_atual - v_vidas) * 120);
  else v_marco := v_desde;
  end if;
  update perfis set vidas = v_nova, vidas_atualizadas_em = v_marco where id = p_perfil;
  return v_nova;
end $$;

revoke all on function public._vidas_agora(int, timestamptz), public._ajustar_vidas(uuid, int) from public, anon, authenticated;
