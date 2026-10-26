// Pense Pro: aberto pelo "Pense Pro: vidas ilimitadas" quando as vidas acabam.
import { useNavigate } from 'react-router-dom';
import { CartaoPro } from '../components/CartaoPro';
import { IcVoltar, Mascote } from '../components/Icones';

export default function Pro() {
  const nav = useNavigate();
  return (
    <div className="app">
      <header className="row cabecalho-voltar">
        <button onClick={() => nav(-1)} aria-label="Voltar" className="linkbtn botao-voltar"><IcVoltar /></button>
        <h1 className="title fs-22">Pense Pro</h1>
      </header>
      <main className="screen">
        <div className="col alinha-centro centro">
          <Mascote largura={120} faisca />
          <p className="small texto2 largura-300">Estude sem esperar as vidas voltarem e sem anúncios.</p>
        </div>
        <CartaoPro />
      </main>
    </div>
  );
}
