// Anúncio premiado: o aluno assiste até o fim e ganha 1 vida. Por enquanto é um espaço reservado com contagem;
// para veicular anúncios de verdade, troque o miolo pela chamada da rede (ex.: anúncios premiados do Google Ad Manager).
import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import { IcX, Mascote } from './Icones';

export const SEGUNDOS_ANUNCIO = 15;

export function AnuncioPremiado({ aberto, concluir, cancelar }: { aberto: boolean; concluir: () => void; cancelar: () => void }) {
  const [resta, setResta] = useState(SEGUNDOS_ANUNCIO);

  useEffect(() => {
    if (!aberto) return;
    setResta(SEGUNDOS_ANUNCIO);
    const t = window.setInterval(() => setResta((s) => Math.max(0, s - 1)), 1000);
    return () => window.clearInterval(t);
  }, [aberto]);

  if (!aberto) return null;
  // Portal no body: o anúncio cobre a tela inteira mesmo quando aberto de dentro de uma folha.
  return createPortal(
    <div className="anuncio" role="dialog" aria-modal="true" aria-label="Anúncio">
      <div className="row" style={{ justifyContent: 'space-between' }}>
        <span className="pill" style={{ background: 'var(--card)', border: '1.5px solid var(--line)', color: 'var(--text2)' }}>Anúncio{resta > 0 ? ` · ${resta} s` : ''}</span>
        <button className="linkbtn" onClick={cancelar} aria-label="Fechar o anúncio sem ganhar a vida" style={{ color: 'var(--icon)' }}><IcX /></button>
      </div>
      <div className="anuncio-espaco">
        <Mascote largura={120} />
        <b style={{ fontFamily: 'var(--font-title)', fontSize: 20 }}>Espaço do anúncio</b>
        <span className="muted" style={{ maxWidth: 260 }}>Aqui vai aparecer o vídeo da rede de anúncios. Assista até o fim para ganhar 1 vida.</span>
      </div>
      <button className="btn" disabled={resta > 0} onClick={concluir}>{resta > 0 ? `Sua vida chega em ${resta} s` : 'Receber 1 vida'}</button>
    </div>,
    document.body
  );
}
