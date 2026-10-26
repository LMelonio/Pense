// Primeiro acesso: língua estrangeira e frequência de estudo (meta diária). Dá para mudar depois no Perfil.
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { Mascote } from '../components/Icones';
import { Segmentado } from '../components/Base';
import { METAS } from '../domain/regras';

export default function PrimeiroAcesso() {
  const { dados, atualizar } = useDados();
  const nav = useNavigate();
  const [lingua, setLingua] = useState(dados.prefs.lingua);
  const [meta, setMeta] = useState(dados.prefs.meta_xp);

  async function salvar() {
    await atualizar((d) => ({ ...d, prefs: { ...d.prefs, lingua, meta_xp: meta, onboarding_ok: true } }), { prefs: ['lingua', 'meta_xp', 'onboarding_ok'] });
    nav('/inicio', { replace: true });
  }

  return (
    <div className="app">
      <main className="screen">
        <div className="row alinha-base gap-6">
          <Mascote largura={96} />
          <div className="card balao">
            <h1 className="h2 fs-19">Vamos montar o seu ritmo de estudo</h1>
          </div>
        </div>
        <div className="col"><span className="kicker">Língua estrangeira</span>
          <span className="muted">Qual você vai fazer na prova?</span>
          <Segmentado rotulo="Língua estrangeira" valor={lingua} mudar={setLingua} opcoes={[{ v: 'Inglês', nome: 'Inglês' }, { v: 'Espanhol', nome: 'Espanhol' }]} />
        </div>
        <div className="col"><span className="kicker">Frequência de estudo</span>
          <span className="muted">Quanto você quer estudar por dia?</span>
          <div role="radiogroup" aria-label="Frequência de estudo" className="col gap-10">
            {METAS.map((m) => (
              <button key={m.xp} type="button" role="radio" aria-checked={meta === m.xp} onClick={() => setMeta(m.xp)} className={`alt ${meta === m.xp ? 'sel' : ''}`}>
                <span className="alt-body peso-600">{m.nome}</span>
                <span className="muted">{m.xp} XP por dia · ~{m.min} min</span>
              </button>
            ))}
          </div>
        </div>
        <span className="muted centro">Dá para mudar essas escolhas depois, no Perfil.</span>
        <div className="spacer" />
        <button className="btn" onClick={salvar}>Começar a estudar</button>
      </main>
    </div>
  );
}
