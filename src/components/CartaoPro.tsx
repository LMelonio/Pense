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
    <div className="col" style={{ background: 'var(--lav)', color: '#fff', borderRadius: 22, padding: 16, gap: 12 }}>
      <div className="row"><span className="title" style={{ fontSize: 22 }}>Pense Pro</span><span className="pill" style={{ background: 'rgba(255,255,255,.2)' }}>Em breve</span></div>
      <ul style={{ margin: 0, paddingLeft: 18, fontSize: 14, lineHeight: 1.5 }}>
        <li>Vidas ilimitadas, sem anúncios</li><li>Simulados completos, com o tempo da prova</li><li>Correção de redação com IA</li><li>Relatório de desempenho</li>
      </ul>
      <div role="radiogroup" aria-label="Escolha do plano" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
        {PLANOS.map((x) => (
          <button key={x.k} role="radio" aria-checked={plano === x.k} onClick={() => setPlano(x.k)}
            style={{ position: 'relative', textAlign: 'left', padding: 12, borderRadius: 16, border: `2px solid ${plano === x.k ? '#fff' : 'rgba(255,255,255,.35)'}`, background: plano === x.k ? 'rgba(255,255,255,.16)' : 'transparent', color: '#fff', cursor: 'pointer' }}>
            {x.tag && <span style={{ position: 'absolute', top: -10, right: 10, background: '#F2C14E', color: '#5A3E00', borderRadius: 99, fontSize: 11, fontWeight: 700, padding: '2px 8px' }}>{x.tag}</span>}
            <span style={{ display: 'block', fontSize: 13, fontWeight: 600, opacity: 0.9 }}>{x.n}</span>
            <span className="big" style={{ display: 'block', fontSize: 20 }}>{x.p}</span>
            <span style={{ display: 'block', fontSize: 12, opacity: 0.85 }}>{x.s}</span>
          </button>
        ))}
      </div>
      <button className="btn white" style={{ color: 'var(--lav-dark)' }} onClick={async () => { await atualizar((d) => ({ ...d, interessePro: plano }), { interessePro: true }); avisar('Pronto! Vamos te avisar quando o Pro lançar.'); }}>
        {dados.interessePro ? 'Pronto, vamos te avisar' : 'Me avise quando lançar'}
      </button>
      <span style={{ fontSize: 12, opacity: 0.8 }}>Preços em teste. Ninguém é cobrado agora.</span>
    </div>
  );
}
