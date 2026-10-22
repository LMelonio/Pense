// Primeiro acesso: escolha da prova-alvo, língua estrangeira e meta diária.
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { Mascote } from '../components/Icones';
import { Segmentado } from '../components/Base';
import { METAS } from '../domain/regras';

const PROVAS = [
  { id: 'enem', nome: 'ENEM', sub: 'Questões reais de 2024 e 2025, nas 4 áreas', ativo: true, glifo: 'E' },
  { id: 'vestibular', nome: 'Vestibulares', sub: 'Em breve', ativo: false, glifo: 'V' },
  { id: 'concurso', nome: 'Concursos públicos', sub: 'Em breve: Português, Raciocínio lógico e mais', ativo: false, glifo: '§' },
  { id: 'selecao', nome: 'Processos seletivos', sub: 'Em breve', ativo: false, glifo: 'S' }
];

export default function ProvaAlvo() {
  const { dados, atualizar } = useDados();
  const nav = useNavigate();
  const [prova, setProva] = useState(dados.prefs.exame_id);
  const [lingua, setLingua] = useState(dados.prefs.lingua);
  const [meta, setMeta] = useState(dados.prefs.meta_xp);
  const [data, setData] = useState(dados.prefs.data_prova ?? '');

  async function salvar() {
    await atualizar((d) => ({ ...d, prefs: { ...d.prefs, exame_id: prova, lingua, meta_xp: meta, data_prova: data || null, onboarding_ok: true } }), { prefs: true });
    nav('/inicio', { replace: true });
  }

  return (
    <div className="app">
      <div className="screen">
        <div className="row" style={{ alignItems: 'flex-end', gap: 6 }}>
          <Mascote largura={96} />
          <div className="card" style={{ borderRadius: '20px 20px 20px 6px', flex: 1, marginBottom: 20 }}>
            <span className="h2" style={{ fontSize: 19 }}>Qual prova você vai fazer?</span>
          </div>
        </div>
        <div role="radiogroup" aria-label="Prova" className="col" style={{ gap: 10 }}>
          {PROVAS.map((p) => (
            <button key={p.id} type="button" role="radio" aria-checked={prova === p.id} disabled={!p.ativo} onClick={() => setProva(p.id)}
              className={`alt ${prova === p.id ? 'sel' : ''}`} style={{ opacity: p.ativo ? 1 : 0.55 }}>
              <span className="letra">{p.glifo}</span>
              <span className="alt-body col" style={{ gap: 0 }}><b style={{ fontFamily: 'var(--font-title)', fontWeight: 600, fontSize: 18 }}>{p.nome}</b><span className="muted">{p.sub}</span></span>
            </button>
          ))}
        </div>
        <div className="col"><span className="kicker">Língua estrangeira</span>
          <Segmentado rotulo="Língua estrangeira" valor={lingua} mudar={setLingua} opcoes={[{ v: 'Inglês', nome: 'Inglês' }, { v: 'Espanhol', nome: 'Espanhol' }]} />
        </div>
        <div className="col"><span className="kicker">Meta diária</span>
          <Segmentado rotulo="Meta diária" valor={String(meta)} mudar={(v) => setMeta(Number(v))} opcoes={METAS.map((m) => ({ v: String(m.xp), nome: m.nome }))} />
          <span className="muted">{METAS.find((m) => m.xp === meta)?.xp} XP por dia · cerca de {METAS.find((m) => m.xp === meta)?.min} min</span>
        </div>
        <label className="col"><span className="kicker">Data da prova (opcional)</span>
          <input className="input" type="date" value={data} onChange={(e) => setData(e.target.value)} />
        </label>
        <button className="btn" onClick={salvar}>Continuar</button>
      </div>
    </div>
  );
}
