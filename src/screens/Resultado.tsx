// Resultado: lição perfeita (subiu de coroa), resumo com erros, vidas esgotadas ou lição interrompida.
import { Link, Navigate, useLocation } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { CORES_COROA, IcChama, IcCoroa, IcRaio, IcRevisar, Mascote } from '../components/Icones';
import { Anel } from '../components/Base';
import { CONQUISTAS, NOMES_COROA, hoje, nivel, sequenciaAtual } from '../domain/regras';
import { plural } from '../lib/texto';
import type { EstadoResultado } from './Licao';

const CORES_CONFETE = ['#7CCFC2', '#6A5AE0', '#F2A93B', '#E5534B', '#4C7BD9', '#3FA37A'];

function Confete() {
  return (
    <div aria-hidden="true" style={{ position: 'absolute', inset: 0, overflow: 'hidden', pointerEvents: 'none' }}>
      {Array.from({ length: 18 }, (_, i) => (
        <span key={i} className="confete" style={{ left: `${(i * 53 + 17) % 100}%`, width: 8 + (i % 3) * 2, height: i % 2 ? 14 : 8, borderRadius: i % 4 === 0 ? '50%' : 3, background: CORES_CONFETE[i % 6], animationDelay: `${((i * 37) % 30) / 10}s`, animationDuration: `${2.8 + (i % 5) * 0.35}s` }} />
      ))}
    </div>
  );
}

export default function Resultado() {
  const { dados } = useDados();
  const loc = useLocation();
  const r = loc.state as EstadoResultado | null;
  if (!r) return <Navigate to="/inicio" replace />;
  const xpHoje = dados.xpDia[hoje()] ?? 0;
  const meta = dados.prefs.meta_xp;
  const seq = sequenciaAtual(dados.perfil);
  const nv = nivel(dados.perfil.xp_total);
  const min = Math.floor(r.segundos / 60), seg = String(r.segundos % 60).padStart(2, '0');
  const subiuCoroa = r.tipo === 'licao' && r.perfeita && r.coroaDepois > r.coroaAntes;
  const conquistas = r.conquistas.map((c) => CONQUISTAS.find((x) => x.codigo === c)?.nome).filter(Boolean);

  if (r.perfeita || subiuCoroa) {
    return (
      <div className="app" style={{ background: 'var(--fundo-festa)', color: '#fff' }}>
        <div className="screen" style={{ alignItems: 'stretch', justifyContent: 'space-between', paddingTop: 28, position: 'relative' }}>
          <Confete />
          <span className="pill" style={{ alignSelf: 'center', background: 'rgba(0,0,0,.15)', height: 30 }}>Lição perfeita · {r.acertos} de {r.total} certas</span>
          <div className="col" style={{ alignItems: 'center', gap: 4 }}>
            <IcCoroa size={100} fill={CORES_COROA[r.coroaDepois][0]} stroke={CORES_COROA[r.coroaDepois][1]} />
            <Mascote largura={170} humor="comemorando" />
            <h1 style={{ fontSize: 32, textAlign: 'center', marginTop: 10 }}>{subiuCoroa ? `Coroa de ${NOMES_COROA[r.coroaDepois]}!` : 'Lição perfeita!'}</h1>
            <p style={{ textAlign: 'center' }}>{subiuCoroa ? `${r.tema} subiu de ${NOMES_COROA[r.coroaAntes]} para ${NOMES_COROA[r.coroaDepois]}.` : `${r.tema}: nenhum erro.`}</p>
          </div>
          <div className="col" style={{ background: 'rgba(0,0,0,.15)', borderRadius: 22, padding: 16, gap: 10 }}>
            <div className="row" style={{ justifyContent: 'space-between' }}>
              <span className="row big" style={{ gap: 6, fontSize: 26 }}><IcRaio size={20} />+{r.xp} XP</span>
              <span className="small">Nível {nv.nivel} · {dados.perfil.xp_total.toLocaleString('pt-BR')}/{nv.prox.toLocaleString('pt-BR')}</span>
            </div>
            <div className="bar" style={{ height: 12, background: 'rgba(255,255,255,.18)' }}><span style={{ width: `${nv.pct}%`, background: '#F2C14E' }} /></div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
              <span style={{ background: 'rgba(0,0,0,.15)', borderRadius: 14, padding: '10px 12px' }} className="small"><b className="big" style={{ display: 'block', fontSize: 18 }}>{plural(seq, 'dia', 'dias')}</b>de sequência</span>
              <span style={{ background: 'rgba(0,0,0,.15)', borderRadius: 14, padding: '10px 12px' }} className="small"><b className="big" style={{ display: 'block', fontSize: 18 }}>+5 XP</b>bônus sem erros</span>
            </div>
            {conquistas.length > 0 && <span className="small">Nova conquista: <b>{conquistas.join(', ')}</b></span>}
          </div>
          <Link to="/inicio" className="btn white" replace>Continuar</Link>
        </div>
      </div>
    );
  }

  // Título e humor de acordo com como a lição terminou: só comemora quando houve acerto.
  const comemorar = r.acertos > 0 && r.motivo !== 'vidas' && (r.tipo === 'licao' || !!r.aprovado);
  const titulo = r.motivo === 'vidas' ? 'Suas vidas acabaram'
    : r.tipo === 'desafio' ? (r.aprovado ? 'Desafio vencido!' : 'Quase lá!')
    : r.acertos === 0 ? 'Não foi dessa vez'
    : r.motivo === 'saiu' ? 'Lição interrompida'
    : 'Lição concluída!';
  const aviso = r.motivo === 'vidas' ? 'A lição parou aqui. As vidas voltam com o tempo, com um anúncio ou com o Pense Pro.'
    : r.tipo === 'desafio' ? (r.aprovado ? 'A próxima unidade da trilha foi liberada.' : 'Acerte 7 de 10 para liberar a próxima unidade. Tente de novo quando quiser.')
    : r.acertos === 0 ? 'Leia as explicações na revisão de amanhã e tente de novo.'
    : null;

  return (
    <div className="app">
      <div className="screen" style={{ position: 'relative', paddingTop: 30 }}>
        {comemorar && <Confete />}
        <div className="col" style={{ alignItems: 'center', gap: 6 }}>
          <Mascote largura={170} humor={comemorar ? 'comemorando' : 'triste'} faisca={comemorar} />
          <h1 style={{ fontSize: 32, textAlign: 'center' }}>{titulo}</h1>
          <p className="muted" style={{ fontSize: 15 }}>{r.tema} · {plural(r.total, 'questão', 'questões')}</p>
          {aviso && <p className="small" style={{ textAlign: 'center' }}>{aviso}</p>}
        </div>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 8 }}>
          {[['XP', `+${r.xp}`, '#6A5AE0', 'var(--res-xp)'], ['Acertos', `${r.acertos}/${r.total}`, 'var(--ok-forte)', 'var(--res-acertos)'], ['Tempo', `${min}:${seg}`, 'var(--azul-forte)', 'var(--res-tempo)']].map(([n, v, borda, cor]) => (
            <div key={n} className="a-rise" style={{ borderRadius: 18, border: `2px solid ${borda}`, background: borda, overflow: 'hidden' }}>
              <span style={{ display: 'grid', placeItems: 'center', height: 26, fontSize: 12, fontWeight: 600, color: '#fff', textTransform: 'uppercase', letterSpacing: '.04em' }}>{n}</span>
              <span className="big" style={{ display: 'grid', placeItems: 'center', background: 'var(--card)', borderRadius: 15, padding: '12px 4px', fontSize: 24, color: cor }}>{v}</span>
            </div>
          ))}
        </div>
        <div className="card row" style={{ gap: 14 }}>
          <Anel pct={Math.min(100, (xpHoje / meta) * 100)} tam={48} esp={6} cor="#F2A93B" trilho="var(--amber-soft)"><IcChama size={20} /></Anel>
          <div className="col" style={{ gap: 2 }}>
            <span className="h2" style={{ fontSize: 17 }}>{xpHoje >= meta ? `Meta do dia batida · ${plural(seq, 'dia', 'dias')}` : `Meta do dia: ${xpHoje}/${meta} XP`}</span>
            <span className="muted">{xpHoje >= meta ? (seq === 1 ? 'Sua sequência começou!' : 'Sua sequência continua!') : `Faltam ${meta - xpHoje} XP para a meta.`}</span>
          </div>
        </div>
        {r.erros.length > 0 && (
          <div className="card soft-lav row" style={{ gap: 12 }}>
            <IcRevisar color="var(--lav)" />
            <span className="small spacer"><b>{plural(r.erros.length, 'questão', 'questões')}</b> {r.erros.length === 1 ? 'volta' : 'voltam'} amanhã na Revisão do dia.</span>
          </div>
        )}
        {conquistas.length > 0 && <div className="card soft-amber small">Nova conquista: <b>{conquistas.join(', ')}</b></div>}
        <div className="spacer" />
        <Link to="/inicio" className="btn" replace>Continuar</Link>
        {r.erros.length > 0 && <Link to={`/refazer?ids=${r.erros.join(',')}`} className="btn ghost" replace>{r.erros.length > 1 ? `Revisar os ${r.erros.length} erros agora` : 'Revisar o erro agora'}</Link>}
      </div>
    </div>
  );
}
