// Trilha: unidades de 6 subconteúdos por matéria, revisão rápida e mini-simulado no fim.
import { useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { BannerDemo, BarraNav, Folha, Stats, corDe } from '../components/Base';
import { CORES_COROA, IcCheck, IcCoroa, IcLivro, IcLock, IcRevisar, IcEstrela, IcTrofeu, Mascote } from '../components/Icones';
import { SemVidas } from '../components/SemVidas';
import { DESAFIO_QTD, NOMES_COROA, chaveTema, desafioLiberado, recortesVisiveis, revisaoPendente, temaFeito, unidadesDoRecorte, vidasAgora } from '../domain/regras';
import { plural } from '../lib/texto';
import type { InfoTema } from '../domain/regras';

type No = { tipo: 'feito' | 'atual' | 'bloqueado' | 'revisao' | 'desafio'; tema?: InfoTema; coroa?: number };
const OFF = [0, 60, 90, 60, 0, -60, -90, -60];

export default function Trilha() {
  const { dados, conteudo } = useDados();
  const nav = useNavigate();
  const recortes = useMemo(() => recortesVisiveis(conteudo, dados.prefs.exame_id, dados.prefs.lingua), [conteudo, dados.prefs.exame_id, dados.prefs.lingua]);
  const [recId, setRecId] = useState(recortes[0]?.id);
  const [sel, setSel] = useState<No | null>(null);
  const recorte = recortes.find((r) => r.id === recId) ?? recortes[0];
  const cor = corDe(recorte?.cor);
  const unidades = useMemo(() => (recorte ? unidadesDoRecorte(conteudo, recorte.id, dados.prefs.lingua) : []), [conteudo, recorte, dados.prefs.lingua]);
  let atual = unidades.findIndex((_, i) => !dados.unidades[`${recorte?.id}|${i}`]);
  if (atual < 0) atual = unidades.length - 1;
  const temas = unidades[atual] ?? [];
  const feitos = temas.filter((t) => temaFeito(dados, t)).length;
  const temErrosNaUnidade = revisaoPendente(dados).some((r) => {
    const q = conteudo.questoes.find((x) => x.id === r.questao_id);
    return q && q.recorte_id === recorte?.id && temas.some((t) => t.assunto === q.assunto);
  });

  const nos: No[] = [];
  let achouAtual = false;
  temas.forEach((t, i) => {
    const p = dados.temas[chaveTema(t.recorte_id, t.assunto)];
    if (temaFeito(dados, t)) nos.push({ tipo: 'feito', tema: t, coroa: p?.coroa });
    else if (!achouAtual) { nos.push({ tipo: 'atual', tema: t }); achouAtual = true; }
    else nos.push({ tipo: 'bloqueado', tema: t });
    if (i === 2) nos.push({ tipo: 'revisao' });
  });
  nos.push({ tipo: 'desafio' });
  const desafioAberto = !!recorte && desafioLiberado(dados, unidades, recorte.id, atual);
  const { vidas } = vidasAgora(dados.perfil);

  const estilo = (n: No) => {
    if (n.tipo === 'feito') return { bg: cor.barra, borda: cor.forte, ic: <IcCheck color="#fff" size={30} /> };
    if (n.tipo === 'atual') return { bg: cor.forte, borda: '#0b2a4f33', ic: <IcEstrela color="#fff" size={30} /> };
    if (n.tipo === 'revisao') return { bg: '#6A5AE0', borda: '#4B3DB8', ic: <IcRevisar color="#fff" size={30} /> };
    if (n.tipo === 'desafio') return desafioAberto ? { bg: '#F2A93B', borda: '#B8781A', ic: <IcTrofeu color="#fff" size={30} /> } : { bg: 'var(--line2)', borda: 'var(--line)', ic: <IcTrofeu color="#9AAFAA" size={30} /> };
    return { bg: 'var(--line2)', borda: 'var(--line)', ic: <IcLock color="#9AAFAA" size={28} /> };
  };

  return (
    <div className="app">
      <BannerDemo />
      <div className="screen with-nav">
        <header className="row" style={{ justifyContent: 'space-between' }}>
          <div className="col" style={{ gap: 0 }}><h1 className="title">Trilha</h1><span className="muted">Um tema leva ao próximo</span></div>
          <Stats />
        </header>
        <div className="tabs" role="tablist">
          {recortes.map((r) => {
            const c = corDe(r.cor); const on = r.id === recorte?.id;
            return <button key={r.id} role="tab" aria-selected={on} className="tab" onClick={() => setRecId(r.id)} style={on ? { borderColor: c.forte, background: c.suave, color: c.forte } : undefined}><span className="dot" style={{ background: c.barra }} />{r.nome}</button>;
          })}
        </div>
        <section className="a-rise" style={{ background: cor.forte, color: '#fff', borderRadius: 22, padding: '16px 18px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          <div className="row" style={{ justifyContent: 'space-between', alignItems: 'flex-start' }}>
            <div className="col" style={{ gap: 2 }}>
              <span className="kicker" style={{ color: 'rgba(255,255,255,.8)' }}>Unidade {atual + 1} de {unidades.length} · {recorte?.nome}</span>
              <span className="h2" style={{ fontSize: 22 }}>{temas[0]?.assunto ?? 'Sem temas'}{temas.length > 1 ? ' e mais' : ''}</span>
            </div>
            <span style={{ width: 44, height: 44, borderRadius: 14, background: 'rgba(255,255,255,.18)', display: 'grid', placeItems: 'center' }}><IcLivro color="#fff" /></span>
          </div>
          <div className="row"><span className="bar spacer" style={{ height: 10, background: 'rgba(255,255,255,.22)' }}><span style={{ width: `${(feitos / Math.max(1, temas.length)) * 100}%`, background: '#fff' }} /></span><span className="small" style={{ fontWeight: 600 }}>{feitos} de {plural(temas.length, 'tema', 'temas')}</span></div>
        </section>

        <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 14, padding: '10px 0' }}>
          {nos.length > 3 && <div style={{ position: 'absolute', right: 6, top: Math.min(300, (nos.length - 3) * 100) }}><Mascote largura={92} /></div>}
          {nos.map((n, i) => {
            const e = estilo(n);
            return (
              <div key={i} style={{ position: 'relative', transform: `translateX(${OFF[i % OFF.length]}px)`, height: 86, display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                {n.tipo === 'atual' && <>
                  <span className="a-bob" style={{ position: 'absolute', top: -34, zIndex: 2, whiteSpace: 'nowrap', height: 30, padding: '0 12px', borderRadius: 10, background: 'var(--card)', border: `2px solid ${cor.forte}`, color: cor.forte, fontFamily: 'var(--font-title)', fontWeight: 600, display: 'inline-flex', alignItems: 'center' }}>Começar</span>
                  <span className="a-halo" aria-hidden="true" style={{ position: 'absolute', top: 0, width: 72, height: 72, borderRadius: '50%', background: cor.barra }} />
                </>}
                <button onClick={() => setSel(n)} aria-label={n.tema?.assunto ?? (n.tipo === 'revisao' ? 'Revisão rápida' : 'Desafio da unidade')}
                  style={{ position: 'relative', width: 72, height: 72, borderRadius: '50%', border: 0, borderBottom: `6px solid ${e.borda}`, background: e.bg, display: 'grid', placeItems: 'center', cursor: 'pointer' }}>
                  {e.ic}
                  {n.tipo === 'feito' && <span style={{ position: 'absolute', right: -6, top: -8 }}><IcCoroa size={24} fill={CORES_COROA[n.coroa ?? 1][0]} stroke={CORES_COROA[n.coroa ?? 1][1]} /></span>}
                </button>
              </div>
            );
          })}
        </div>
        {atual < unidades.length - 1 && (
          <div className="row" style={{ gap: 12, background: 'var(--card)', border: '1.5px dashed var(--off)', borderRadius: 18, padding: '14px 16px' }}>
            <IcLock color="#9AAFAA" /><span className="small">Unidade {atual + 2} libera quando você vencer o desafio desta unidade.</span>
          </div>
        )}
      </div>
      <BarraNav />
      <Folha aberta={!!sel} fechar={() => setSel(null)} titulo="Ponto da trilha">
        {sel && (() => {
          if (sel.tipo === 'revisao') return <>
            <span className="kicker" style={{ color: 'var(--lav-dark)' }}>Revisão da unidade</span>
            <span className="title" style={{ fontSize: 24 }}>Revisão rápida</span>
            <p className="small">Refaça os erros dos temas desta unidade, com dicas.</p>
            {temErrosNaUnidade ? <button className="btn lav" onClick={() => nav('/refazer?todas=1')}>Revisar</button> : <p className="muted">Você ainda não tem erros nesta unidade.</p>}
          </>;
          if (sel.tipo === 'desafio') return <>
            <span className="kicker">Desafio da unidade</span>
            <span className="title" style={{ fontSize: 24 }}>Mini-simulado</span>
            <p className="small">Até {DESAFIO_QTD} questões dos temas da unidade. Acerte 70% para liberar a próxima unidade. Não gasta vidas.</p>
            {desafioAberto ? <button className="btn" onClick={() => nav(`/desafio/${encodeURIComponent(recorte.id)}/${atual}`)}>Começar desafio</button>
              : <p className="muted">Faça todos os temas da unidade para liberar.</p>}
          </>;
          const t = sel.tema!;
          return <>
            <span className="kicker" style={{ color: cor.forte }}>{recorte.nome} · {plural(t.total, 'questão', 'questões')}{sel.tipo === 'feito' ? ` · Coroa ${NOMES_COROA[sel.coroa ?? 1]}` : ''}</span>
            <span className="title" style={{ fontSize: 24 }}>{t.assunto}</span>
            {sel.tipo === 'bloqueado' ? <p className="muted">Conclua o tema anterior para liberar.</p>
              : vidas === 0 ? <SemVidas esperar={() => setSel(null)} />
              : <button className="btn" onClick={() => nav(`/licao/${encodeURIComponent(t.recorte_id)}/${encodeURIComponent(t.assunto)}`)}>{sel.tipo === 'feito' ? 'Praticar de novo' : 'Começar'}</button>}
          </>;
        })()}
        {!(sel?.tema && sel.tipo !== 'bloqueado' && vidas === 0) && <button className="linkbtn" onClick={() => setSel(null)}>Agora não</button>}
      </Folha>
    </div>
  );
}
