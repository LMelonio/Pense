// Cartão do Pense Pro (ainda não lançado): benefícios, planos e "Me avise quando lançar".
import { useState } from 'react';
import { useDados } from '../state/AppContext';

const PLANOS = [
  { k: 'mensal', n: 'Mensal', p: 'R$ 9,90', s: 'por mês · R$ 118,80 no ano', tag: '' },
  { k: 'anual', n: 'Anual', p: 'R$ 69,90', s: 'R$ 5,83 por mês · economize R$ 48,90', tag: 'Promo 41% off' }
] as const;

export function CartaoPro() {
  const { dados, atualizar, avisar } = useDados();
  const [plano, setPlano] = useState<'mensal' | 'anual'>('anual');
  return (
    <div className="col cartao-pro">
      <div className="row"><span className="title fs-22">Pense Pro</span><span className="pill pilula-lav-escura">Em breve</span></div>
      <ul className="lista-pro">
        <li>Vidas ilimitadas, sem anúncios</li><li>Simulados completos, com o tempo da prova</li><li>Correção de redação com IA</li><li>Relatório de desempenho</li>
      </ul>
      <div role="radiogroup" aria-label="Escolha do plano" className="grade-2">
        {PLANOS.map((x) => (
          <button key={x.k} role="radio" aria-checked={plano === x.k} onClick={() => setPlano(x.k)} className={plano === x.k ? 'plano sel' : 'plano'}>
            {x.tag && <span className="plano-tag">{x.tag}</span>}
            <span className="plano-nome">{x.n}</span>
            <span className="big bloco fs-20">{x.p}</span>
            <span className="bloco fs-12">{x.s}</span>
          </button>
        ))}
      </div>
      <button className="btn white pro" onClick={async () => { await atualizar((d) => ({ ...d, interessePro: plano }), { interessePro: true }); avisar('Pronto! Vamos te avisar quando o Pro lançar.'); }}>
        {dados.interessePro ? 'Pronto, vamos te avisar' : 'Me avise quando lançar'}
      </button>
      <span className="fs-12">Preços em teste. Ninguém é cobrado agora.</span>
    </div>
  );
}
