// Sem vidas: esperar a recarga, assistir a um anúncio (+1 vida) ou conhecer o Pense Pro (vidas ilimitadas).
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { MINUTOS_POR_VIDA, VIDAS_MAX, ajustarVidas, vidasAgora } from '../domain/regras';
import { AnuncioPremiado } from './AnuncioPremiado';
import { IcCoracao, IcPlay } from './Icones';

/** Abre o anúncio premiado; se o aluno assistir até o fim, soma 1 vida. Renderize `anuncio` na tela. */
export function useAnuncioDeVida() {
  const { atualizar, avisar } = useDados();
  const [aberto, setAberto] = useState(false);
  async function concluir() {
    setAberto(false);
    await atualizar((d) => ({ ...d, perfil: ajustarVidas(d.perfil, +1) }), { perfil: true });
    avisar('+1 vida! Bons estudos.');
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
      <p className="small" style={{ textAlign: 'center', color: 'var(--text2)' }}>Você recupera 1 vida a cada {MINUTOS_POR_VIDA} minutos. A próxima chega em {proximaEmMin} min.</p>
      <button className="btn lav" onClick={abrir}><IcPlay size={18} />Assistir anúncio e ganhar 1 vida</button>
      <button className="btn ghost" onClick={() => nav('/pro')}>Pense Pro: vidas ilimitadas</button>
      <button className="linkbtn" onClick={esperar}>Esperar {proximaEmMin} min</button>
      {anuncio}
    </div>
  );
}
