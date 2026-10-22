// Pense Pro: aberto pelo "Pense Pro: vidas ilimitadas" quando as vidas acabam.
import { useNavigate } from 'react-router-dom';
import { CartaoPro } from '../components/CartaoPro';
import { IcVoltar, Mascote } from '../components/Icones';

export default function Pro() {
  const nav = useNavigate();
  return (
    <div className="app">
      <header className="row" style={{ padding: '14px 16px 10px', borderBottom: '1.5px solid var(--line)', gap: 8 }}>
        <button onClick={() => nav(-1)} aria-label="Voltar" className="linkbtn" style={{ color: 'var(--text)', display: 'grid', placeItems: 'center', width: 42, height: 42, padding: 0 }}><IcVoltar /></button>
        <h1 className="title" style={{ fontSize: 22 }}>Pense Pro</h1>
      </header>
      <div className="screen">
        <div className="col" style={{ alignItems: 'center', textAlign: 'center' }}>
          <Mascote largura={120} faisca />
          <p className="small" style={{ color: 'var(--text2)', maxWidth: 300 }}>Estude sem esperar as vidas voltarem e sem anúncios.</p>
        </div>
        <CartaoPro />
      </div>
    </div>
  );
}
