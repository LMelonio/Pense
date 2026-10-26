// Resultado: lição perfeita (subiu de coroa), resumo com erros, vidas esgotadas ou lição interrompida.
import { Link, Navigate, useLocation } from 'react-router-dom';
import type { CSSProperties } from 'react';
import { useDados } from '../state/AppContext';
import { CORES_COROA, IcChama, IcCoroa, IcRaio, IcRevisar, Mascote } from '../components/Icones';
import { Anel } from '../components/Base';
import { BONUS_PERFEITA, CONQUISTAS, NOMES_COROA, hoje, nivel, sequenciaAtual, vidaPelaRevisao, vidaPeloTreino, vidasAgora } from '../domain/regras';
import { plural } from '../lib/texto';
import type { EstadoResultado } from './Licao';

const CORES_CONFETE = ['#7CCFC2', '#6A5AE0', '#F2A93B', '#E5534B', '#4C7BD9', '#3FA37A'];

function Confete() {
  return (
    <div aria-hidden="true" className="confetes">
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
  const semVidas = vidasAgora(dados.perfil).vidas === 0;
  const revisar = r.erros.length ? `/refazer?ids=${r.erros.join(',')}` : null; // os erros desta lição: treino até amanhã
  // Onde revisar devolve 1 vida agora: a revisão vencida (a vida do dia) ou, na 1ª vez sem vidas, o treino destes erros
  const vidaRevisando = vidaPelaRevisao(dados) ? '/refazer' : vidaPeloTreino(dados) ? (revisar ?? '/refazer?todas=1') : null;

  if (r.perfeita || subiuCoroa) {
    return (
      <div className="app app-festa">
        <main className="screen festa">
          <Confete />
          <span className="pill pilula-festa">Lição perfeita · {r.acertos} de {r.total} certas</span>
          <div className="col alinha-centro gap-4">
            <IcCoroa size={100} fill={CORES_COROA[r.coroaDepois][0]} stroke={CORES_COROA[r.coroaDepois][1]} />
            <Mascote largura={170} humor="comemorando" />
            <h1 className="festa-titulo">{subiuCoroa ? `Coroa de ${NOMES_COROA[r.coroaDepois]}!` : 'Lição perfeita!'}</h1>
            <p className="centro">{subiuCoroa ? `${r.tema} subiu de ${NOMES_COROA[r.coroaAntes]} para ${NOMES_COROA[r.coroaDepois]}.` : `${r.tema}: nenhum erro.`}</p>
          </div>
          <div className="col caixa-festa">
            <div className="row entre">
              <span className="row big gap-6 fs-26"><IcRaio size={20} />+{r.xp} XP</span>
              <span className="small">Nível {nv.nivel} · {dados.perfil.xp_total.toLocaleString('pt-BR')}/{nv.prox.toLocaleString('pt-BR')}</span>
            </div>
            <div className="bar barra-festa"><span style={{ width: `${nv.pct}%` }} /></div>
            <div className="grade-2">
              <span className="small caixinha-festa"><b className="big bloco fs-18">{plural(seq, 'dia', 'dias')}</b>de sequência</span>
              <span className="small caixinha-festa"><b className="big bloco fs-18">+{BONUS_PERFEITA} XP</b>bônus sem erros</span>
            </div>
            {conquistas.length > 0 && <span className="small">Nova conquista: <b>{conquistas.join(', ')}</b></span>}
          </div>
          <Link to="/inicio" className="btn white" replace>Continuar</Link>
        </main>
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
  const aviso = r.motivo === 'vidas' ? `A lição parou aqui. As vidas voltam com o tempo${vidaRevisando ? ', com a revisão do dia' : ''}, com um anúncio ou com o Pense Pro.`
    : r.tipo === 'desafio' ? (r.aprovado ? 'A próxima unidade da trilha foi liberada.' : 'Acerte 7 de 10 para liberar a próxima unidade. Tente de novo quando quiser.')
    : r.acertos === 0 ? 'Leia as explicações na revisão de amanhã e tente de novo.'
    : null;

  return (
    <div className="app">
      <main className="screen resultado">
        {comemorar && <Confete />}
        <div className="col alinha-centro gap-6">
          <Mascote largura={170} humor={comemorar ? 'comemorando' : 'triste'} faisca={comemorar} />
          <h1 className="resultado-titulo">{titulo}</h1>
          <p className="muted fs-15">{r.tema} · {plural(r.total, 'questão', 'questões')}</p>
          {aviso && <p className="small centro">{aviso}</p>}
        </div>
        {!r.salvo && <p className="card soft-amber small" role="alert">O resultado não foi salvo: confira a internet. As respostas que chegaram ao servidor continuam valendo.</p>}
        <div className="grade-3">
          {[['XP', `+${r.xp}`, '#6A5AE0', 'var(--res-xp)'], ['Acertos', `${r.acertos}/${r.total}`, 'var(--ok-forte)', 'var(--res-acertos)'], ['Tempo', `${min}:${seg}`, 'var(--azul-forte)', 'var(--res-tempo)']].map(([n, v, borda, cor]) => (
            <div key={n} className="a-rise numero-card" style={{ '--cor': borda, '--cor-valor': cor } as CSSProperties}>
              <span className="numero-rotulo">{n}</span>
              <span className="big numero-valor">{v}</span>
            </div>
          ))}
        </div>
        <div className="card row gap-14">
          <Anel pct={Math.min(100, (xpHoje / meta) * 100)} tam={48} esp={6} cor="#F2A93B" trilho="var(--amber-soft)"><IcChama size={20} /></Anel>
          <div className="col gap-2">
            <span className="h2 fs-17">{xpHoje >= meta ? `Meta do dia batida · ${plural(seq, 'dia', 'dias')}` : `Meta do dia: ${xpHoje}/${meta} XP`}</span>
            <span className="muted">{xpHoje >= meta ? (seq === 1 ? 'Sua sequência começou!' : 'Sua sequência continua!') : `Faltam ${meta - xpHoje} XP para a meta.`}</span>
          </div>
        </div>
        {r.erros.length > 0 && (
          <div className="card soft-lav row gap-12">
            <IcRevisar color="var(--lav-ink)" />
            <span className="small spacer"><b>{plural(r.erros.length, 'questão', 'questões')}</b> {r.erros.length === 1 ? 'foi para a sua Revisão: volta amanhã, valendo XP. Se quiser, treine agora.' : 'foram para a sua Revisão: voltam amanhã, valendo XP. Se quiser, treine agora.'}</span>
          </div>
        )}
        {conquistas.length > 0 && <div className="card soft-amber small">Nova conquista: <b>{conquistas.join(', ')}</b></div>}
        <div className="spacer" />
        {semVidas && vidaRevisando ? <>
          <Link to={vidaRevisando} className="btn" replace>Revisar e recuperar 1 vida</Link>
          <Link to="/inicio" className="btn ghost" replace>Continuar</Link>
        </> : <>
          <Link to="/inicio" className="btn" replace>Continuar</Link>
          {revisar && <Link to={revisar} className="btn ghost" replace>{r.erros.length > 1 ? `Revisar os ${r.erros.length} erros agora` : 'Revisar o erro agora'}</Link>}
        </>}
      </main>
    </div>
  );
}
