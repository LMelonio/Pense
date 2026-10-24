// Sem vidas: esperar a recarga, assistir a um anúncio (+1 vida) ou conhecer o Pense Pro (vidas ilimitadas).
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { repo } from '../lib/config';
import { MINUTOS_POR_VIDA, VIDAS_MAX, ajustarVidas, vidasAgora } from '../domain/regras';
import { duracao } from '../lib/texto';
import { AnuncioPremiado } from './AnuncioPremiado';
import { IcCoracao, IcPlay } from './Icones';

/** Abre o anúncio premiado; se o aluno assistir até o fim, soma 1 vida. Renderize `anuncio` na tela. */
export function useAnuncioDeVida() {
  const { atualizar, avisar, sincronizar } = useDados();
  const [aberto, setAberto] = useState(false);
  async function concluir() {
    setAberto(false);
    await atualizar((d) => ({ ...d, perfil: ajustarVidas(d.perfil, +1) }), { perfil: true });
    try {
      await repo.ganharVidaAnuncio(); // no Supabase, o servidor soma a vida (com limite diário)
      avisar('+1 vida! Bons estudos.');
    } catch (e) {
      avisar((e as Error).message);
      sincronizar(); // desfaz a vida mostrada na tela
    }
  }
  return { abrir: () => setAberto(true), anuncio: <AnuncioPremiado aberto={aberto} concluir={concluir} cancelar={() => setAberto(false)} /> };
}

export function SemVidas({ esperar }: { esperar: () => void }) {
  const { dados } = useDados();
  const nav = useNavigate();
  const { abrir, anuncio } = useAnuncioDeVida();
  const { proximaEmMin } = vidasAgora(dados.perfil);
  return (
    <div className="col" style={{ gap: 12 }}>
      <div className="row" style={{ justifyContent: 'center', gap: 6 }} aria-hidden="true">
        {Array.from({ length: VIDAS_MAX }, (_, i) => <IcCoracao key={i} size={30} bater={false} cor="var(--line)" />)}
      </div>
      <span className="title" style={{ fontSize: 24, textAlign: 'center' }}>Suas vidas acabaram</span>
      <p className="small" style={{ textAlign: 'center', color: 'var(--text2)' }}>Você recupera 1 vida a cada {duracao(MINUTOS_POR_VIDA)}. A próxima chega em {duracao(proximaEmMin)}.</p>
      <button className="btn lav" onClick={abrir}><IcPlay size={18} />Assistir anúncio e ganhar 1 vida</button>
      <button className="btn ghost" onClick={() => nav('/pro')}>Pense Pro: vidas ilimitadas</button>
      <button className="linkbtn" onClick={esperar}>Esperar {duracao(proximaEmMin)}</button>
      {anuncio}
    </div>
  );
}
