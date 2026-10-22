import { useMemo, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { Anel, BannerDemo, BarraNav, Folha, Stats, corDe } from '../components/Base';
import { CORES_COROA, IcCheck, IcCoracao, IcCoroa, IcRevisar } from '../components/Icones';
import { SemVidas } from '../components/SemVidas';
import { NOMES_COROA, VIDAS_MAX, chaveTema, hoje, recortesVisiveis, revisaoVencida, sequenciaAtual, temasDoRecorte, vidasAgora, QUESTOES_POR_LICAO, XP_ACERTO } from '../domain/regras';
import type { InfoTema } from '../domain/regras';

const DIAS = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

export default function Inicio() {
  const { dados, conteudo } = useDados();
  const nav = useNavigate();
  const exame = conteudo.exames.find((e) => e.id === dados.prefs.exame_id) ?? conteudo.exames[0];
  const recortes = useMemo(() => recortesVisiveis(conteudo, exame.id, dados.prefs.lingua), [conteudo, exame.id, dados.prefs.lingua]);
  const [recId, setRecId] = useState(recortes[0]?.id);
  const [sel, setSel] = useState<InfoTema | null>(null);
  const recorte = recortes.find((r) => r.id === recId) ?? recortes[0];
  const cor = corDe(recorte?.cor);
  const temas = useMemo(() => (recorte ? temasDoRecorte(conteudo, recorte.id, dados.prefs.lingua) : []), [conteudo, recorte, dados.prefs.lingua]);

  const xpHoje = dados.xpDia[hoje()] ?? 0;
  const pctMeta = Math.min(100, (xpHoje / dados.prefs.meta_xp) * 100);
  const { vidas, proximaEmMin } = vidasAgora(dados.perfil);
  const vencidas = revisaoVencida(dados).length;
  const seq = sequenciaAtual(dados.perfil);
  const diasAteProva = dados.prefs.data_prova ? Math.ceil((new Date(dados.prefs.data_prova + 'T12:00').getTime() - Date.now()) / 86400000) : null;

  // semana (seg a dom) com os dias em que a meta foi batida
  const semana = useMemo(() => {
    const d = new Date(); const dow = (d.getDay() + 6) % 7;
    return DIAS.map((l, i) => {
      const dia = new Date(d.getTime() - (dow - i) * 86400000);
      const k = hoje(dia);
      return { l, feito: (dados.xpDia[k] ?? 0) >= dados.prefs.meta_xp, hoje: i === dow };
    });
  }, [dados.xpDia, dados.prefs.meta_xp]);

  const nome = dados.perfil.nome?.split(' ')[0] || 'Estudante';
  return (
    <div className="app">
      <BannerDemo />
      <div className="screen with-nav">
        <header className="row" style={{ justifyContent: 'space-between' }}>
          <div className="row">
            <div aria-hidden="true" style={{ width: 42, height: 42, borderRadius: '50%', background: 'var(--mascot)', display: 'grid', placeItems: 'center', fontFamily: 'var(--font-title)', fontWeight: 700, color: '#12302C', border: '2.5px solid var(--card)', boxShadow: '0 0 0 2px var(--mascot)' }}>{nome[0]}</div>
            <div className="col" style={{ gap: 0 }}>
              <span style={{ fontFamily: 'var(--font-title)', fontWeight: 600, fontSize: 19 }}>Oi, {nome}</span>
              <span className="muted">{diasAteProva != null && diasAteProva >= 0 ? `${exame.nome} em ${diasAteProva} dias` : exame.nome}</span>
            </div>
          </div>
          <Stats />
        </header>

        <section className="card a-rise col" style={{ gap: 14 }} aria-label="Meta de hoje">
          <div className="row" style={{ gap: 16 }}>
            <Anel pct={pctMeta}><span className="big" style={{ fontSize: 17 }}>{Math.round(pctMeta)}%</span></Anel>
            <div className="col" style={{ gap: 2 }}>
              <span className="kicker">Meta de hoje</span>
              <span className="big">{xpHoje} de {dados.prefs.meta_xp} XP</span>
              <span className="muted">{xpHoje >= dados.prefs.meta_xp ? `Meta batida! Sequência de ${seq} dia${seq === 1 ? '' : 's'}.` : `Mais ${dados.prefs.meta_xp - xpHoje} XP e a sequência chega a ${seq + 1}.`}</span>
            </div>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: 6 }}>
            {semana.map((s, i) => (
              <div key={i} className="col" style={{ alignItems: 'center', gap: 4 }}>
                <span style={{ fontSize: 11, fontWeight: 600, color: s.hoje ? '#B8781A' : 'var(--text3)' }}>{s.l}</span>
                <span style={{ width: 30, height: 30, borderRadius: '50%', display: 'grid', placeItems: 'center', background: s.feito ? 'var(--amber)' : 'var(--card)', border: `2px solid ${s.feito || s.hoje ? 'var(--amber)' : 'var(--line)'}` }}>{s.feito && <IcCheck size={14} color="#fff" />}</span>
              </div>
            ))}
          </div>
          <div className="row" style={{ justifyContent: 'space-between', paddingTop: 12, borderTop: '1.5px dashed var(--line)' }}>
            <div className="row" style={{ gap: 3 }} aria-label={`${vidas} de ${VIDAS_MAX} vidas`}>
              {Array.from({ length: VIDAS_MAX }, (_, i) => <IcCoracao key={i} size={20} bater={false} cor={i < vidas ? '#E5534B' : 'var(--line)'} />)}
            </div>
            <span className="muted" style={{ textAlign: 'right' }}>{vidas >= VIDAS_MAX ? 'Vidas cheias' : `Mais 1 vida em ${proximaEmMin} min ou já, revisando`}</span>
          </div>
        </section>

        <section className="card soft-lav row a-rise" style={{ gap: 14 }} aria-label="Revisão do dia">
          <span style={{ width: 46, height: 46, borderRadius: 14, background: 'var(--card)', display: 'grid', placeItems: 'center' }}><IcRevisar color="var(--lav)" /></span>
          <div className="col spacer" style={{ gap: 2 }}>
            <span className="h2" style={{ fontSize: 17 }}>Revisão do dia</span>
            <span className="small">{vencidas ? `${vencidas} questão${vencidas > 1 ? 'ões' : ''} que você errou volta${vencidas > 1 ? 'm' : ''} hoje` : 'Nada vencido hoje'}</span>
          </div>
          <Link to={vencidas ? '/refazer' : '/revisar'} className="btn lav sm">{vencidas ? `${Math.max(1, Math.round(vencidas * 0.6))} min` : 'Ver'}</Link>
        </section>

        <section className="col" style={{ gap: 12 }} aria-label="Escolha o tema">
          <div className="row" style={{ justifyContent: 'space-between' }}>
            <h2 className="title" style={{ fontSize: 22 }}>Escolha o tema</h2>
            <span className="muted">{temas.reduce((s, t) => s + t.total, 0)} questões</span>
          </div>
          <div className="tabs" role="tablist">
            {recortes.map((r) => {
              const c = corDe(r.cor); const on = r.id === recorte?.id;
              return <button key={r.id} role="tab" aria-selected={on} className="tab" onClick={() => setRecId(r.id)} style={on ? { borderColor: c.forte, background: c.suave, color: c.forte } : undefined}><span className="dot" style={{ background: c.barra }} />{r.nome}</button>;
            })}
          </div>
          <div className="col" style={{ gap: 10 }}>
            {temas.map((t, i) => {
              const p = dados.temas[chaveTema(t.recorte_id, t.assunto)];
              const coroa = p?.coroa ?? 0;
              return (
                <button key={t.assunto} className="list-row a-rise" onClick={() => setSel(t)} style={{ border: '1.5px solid var(--line)', borderBottomWidth: 4, borderRadius: 18, background: 'var(--card)', animationDelay: `${Math.min(i, 8) * 40}ms` }}>
                  <span aria-hidden="true" style={{ width: 46, height: 46, borderRadius: 14, background: cor.suave, color: cor.forte, display: 'grid', placeItems: 'center', fontFamily: 'var(--font-title)', fontWeight: 700 }}>{recorte.sigla}</span>
                  <span className="col spacer" style={{ gap: 5, minWidth: 0 }}>
                    <span style={{ fontWeight: 600, lineHeight: 1.25 }}>{t.assunto}</span>
                    <span className="muted">{t.total} questões · {p ? `${p.dominio}% dominado` : 'ainda não começou'}</span>
                    <span className="bar" aria-hidden="true"><span style={{ width: `${p?.dominio ?? 0}%`, background: cor.barra }} /></span>
                  </span>
                  <span className="col" style={{ alignItems: 'center', gap: 2, minWidth: 52 }}>
                    <IcCoroa size={26} fill={CORES_COROA[coroa][0]} stroke={CORES_COROA[coroa][1]} />
                    <span style={{ fontSize: 11, fontWeight: 600, color: 'var(--text3)' }}>{NOMES_COROA[coroa]}</span>
                  </span>
                </button>
              );
            })}
          </div>
        </section>
      </div>
      <BarraNav />
      <Folha aberta={!!sel} fechar={() => setSel(null)} titulo={sel?.assunto ?? ''}>
        {sel && (
          <>
            <span className="kicker" style={{ color: cor.forte }}>{recorte.nome}</span>
            <span className="title" style={{ fontSize: 24 }}>{sel.assunto}</span>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 8 }}>
              <div className="card soft-lav" style={{ textAlign: 'center', padding: 10 }}><div className="big">+{Math.min(QUESTOES_POR_LICAO, sel.total) * XP_ACERTO}</div><span className="small">XP possível</span></div>
              <div className="card" style={{ textAlign: 'center', padding: 10, background: 'var(--primary-soft)', borderColor: 'transparent' }}><div className="big">{Math.min(QUESTOES_POR_LICAO, sel.total)}</div><span className="small">questões</span></div>
              <div className="card" style={{ textAlign: 'center', padding: 10, background: 'var(--coral-soft)', borderColor: 'transparent' }}><div className="big">{vidas}</div><span className="small">vidas</span></div>
            </div>
            {vidas === 0 ? <SemVidas esperar={() => setSel(null)} /> : (
              <>
                <button className="btn" onClick={() => nav(`/licao/${encodeURIComponent(sel.recorte_id)}/${encodeURIComponent(sel.assunto)}`)}>Começar</button>
                <button className="linkbtn" onClick={() => setSel(null)}>Agora não</button>
              </>
            )}
          </>
        )}
      </Folha>
    </div>
  );
}
