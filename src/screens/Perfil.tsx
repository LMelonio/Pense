import { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { BannerDemo, BarraNav, Folha, Interruptor, Segmentado, corDe } from '../components/Base';
import { IcAlvo, IcBroto, IcCalendario, IcChama, IcCheck, IcCoroa, IcEngrenagem, IcEstrela, IcIdioma, IcLampada, IcLivro, IcRaio, IcRevisar, IcSeta, IcSino, IcTrofeu } from '../components/Icones';
import { CONQUISTAS, METAS, areasDoExame, nivel, progressoConquista, recortesVisiveis, sequenciaAtual, temasDoRecorte, chaveTema } from '../domain/regras';

const ICONES: Record<string, (p: { color?: string; size?: number }) => JSX.Element> = {
  seed: IcBroto, flame: (p) => <IcChama size={p.size} />, star: IcEstrela, refresh: IcRevisar, target: IcAlvo, crown: () => <IcCoroa size={30} fill="#fff" stroke="#fff" />, book: IcLivro, calendar: IcCalendario
};

export default function Perfil() {
  const { dados, conteudo, atualizar } = useDados();
  const [folha, setFolha] = useState<null | 'meta' | 'lingua' | string>(null);
  const p = dados.perfil; const prefs = dados.prefs;
  const nv = nivel(p.xp_total);
  const exame = conteudo.exames.find((e) => e.id === prefs.exame_id);
  const recortes = useMemo(() => recortesVisiveis(conteudo, prefs.exame_id, prefs.lingua), [conteudo, prefs.exame_id, prefs.lingua]);
  const areas = useMemo(() => areasDoExame(conteudo, prefs.exame_id), [conteudo, prefs.exame_id]);
  const acerto = p.questoes_feitas ? Math.round((p.acertos_total / p.questoes_feitas) * 100) : 0;
  const temas = Object.values(dados.temas);
  const coroas = [1, 2, 3].map((c) => temas.filter((t) => t.coroa === c).length);

  const dominios = useMemo(() => recortes.map((r) => {
    const ts = temasDoRecorte(conteudo, r.id, prefs.lingua);
    const tot = ts.reduce((s, t) => s + t.total, 0);
    const soma = ts.reduce((s, t) => s + (dados.temas[chaveTema(r.id, t.assunto)]?.dominio ?? 0) * t.total, 0);
    return { r, pct: tot ? Math.round(soma / tot) : 0 };
  }), [recortes, conteudo, prefs.lingua, dados.temas]);

  const salvarPrefs = (mud: Partial<typeof prefs>) => atualizar((d) => ({ ...d, prefs: { ...d.prefs, ...mud } }), { prefs: true });

  async function lembrete(v: boolean) {
    if (v && 'Notification' in window && Notification.permission === 'default') {
      try { await Notification.requestPermission(); } catch { /* ignorado */ }
    }
    salvarPrefs({ lembrete_ativo: v });
  }

  const conq = folha && CONQUISTAS.find((c) => c.codigo === folha);
  const metaAtual = METAS.find((m) => m.xp === prefs.meta_xp) ?? METAS[2];

  return (
    <div className="app">
      <BannerDemo />
      <div className="screen with-nav">
        <header className="row" style={{ justifyContent: 'space-between' }}>
          <h1 className="title">Perfil</h1>
          <Link to="/config" aria-label="Configurações" className="chip" style={{ width: 42, height: 42, justifyContent: 'center', color: 'var(--text2)' }}><IcEngrenagem /></Link>
        </header>

        <section className="card a-rise col" style={{ gap: 16 }}>
          <div className="row" style={{ gap: 14 }}>
            <div style={{ position: 'relative' }}>
              <div aria-hidden="true" style={{ width: 76, height: 76, borderRadius: '50%', background: 'var(--mascot)', display: 'grid', placeItems: 'center', fontFamily: 'var(--font-title)', fontWeight: 700, fontSize: 32, color: '#12302C', border: '3px solid var(--card)', boxShadow: '0 0 0 3px var(--mascot)' }}>{(p.nome || 'E')[0]}</div>
              <span style={{ position: 'absolute', right: -6, bottom: -4, minWidth: 30, height: 30, padding: '0 6px', borderRadius: 99, background: 'var(--lav)', border: '3px solid var(--card)', color: '#fff', fontFamily: 'var(--font-title)', fontWeight: 700, fontSize: 14, display: 'grid', placeItems: 'center' }}>{nv.nivel}</span>
            </div>
            <div className="col" style={{ gap: 3 }}>
              <span className="title" style={{ fontSize: 23 }}>{p.nome}</span>
              <span className="muted">{p.usuario ? `@${p.usuario}` : 'Estudante do Pense'}</span>
              <span className="pill" style={{ background: 'var(--primary-soft)', color: 'var(--primary-dark)', alignSelf: 'flex-start' }}>Foco: {exame?.nome}</span>
            </div>
          </div>
          <div className="col" style={{ gap: 6 }}>
            <div className="row" style={{ justifyContent: 'space-between' }}><span className="h2" style={{ fontSize: 17 }}>Nível {nv.nivel} · {nv.nome}</span><span className="muted">{p.xp_total.toLocaleString('pt-BR')}/{nv.prox.toLocaleString('pt-BR')} XP</span></div>
            <div className="bar" style={{ height: 12, background: 'var(--lav-soft)' }}><span style={{ width: `${nv.pct}%`, background: 'var(--lav)' }} /></div>
            <span className="muted">Faltam {(nv.prox - p.xp_total).toLocaleString('pt-BR')} XP para o nível {nv.nivel + 1}</span>
          </div>
        </section>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10 }}>
          {[
            [<IcChama size={20} />, `${sequenciaAtual(p)} dias`, `sequência · recorde ${p.sequencia_recorde}`, 'var(--amber-soft)'],
            [<IcRaio size={18} />, p.xp_total.toLocaleString('pt-BR'), 'XP no total', 'var(--lav-soft)'],
            [<IcCheck color="var(--primary)" size={20} />, String(p.questoes_feitas), 'questões feitas', 'var(--primary-soft)'],
            [<IcAlvo color="#2F5DBF" size={20} />, `${acerto}%`, 'de acerto geral', '#E1EAFB']
          ].map(([ic, v, l, bg], k) => (
            <div key={k} className="card row a-rise" style={{ gap: 10, padding: '12px 14px' }}>
              <span style={{ width: 38, height: 38, borderRadius: 12, background: bg as string, display: 'grid', placeItems: 'center', flexShrink: 0 }}>{ic}</span>
              <span className="col" style={{ gap: 0, minWidth: 0 }}><span className="big" style={{ fontSize: 19 }}>{v}</span><span className="muted" style={{ fontSize: 12 }}>{l}</span></span>
            </div>
          ))}
        </div>

        <section className="card col" style={{ gap: 12 }} aria-label="Domínio por matéria">
          <div className="row" style={{ justifyContent: 'space-between' }}><h2 className="h2" style={{ fontSize: 18 }}>Domínio por matéria</h2>
            <span className="row" style={{ gap: 8, fontSize: 12, fontWeight: 600 }}><span style={{ color: '#8A6608' }}>Ouro {coroas[2]}</span><span style={{ color: '#5F6F76' }}>Prata {coroas[1]}</span><span style={{ color: '#8A4F27' }}>Bronze {coroas[0]}</span></span>
          </div>
          {dominios.map(({ r, pct }) => {
            const c = corDe(r.cor);
            return <div key={r.id} style={{ display: 'grid', gridTemplateColumns: '112px 1fr 40px', alignItems: 'center', gap: 10 }}>
              <span className="small" style={{ fontWeight: 600, color: c.forte }}>{r.nome}</span>
              <span className="bar" style={{ height: 12, background: c.suave }}><span style={{ width: `${pct}%`, background: c.barra }} /></span>
              <span className="small" style={{ fontWeight: 600, textAlign: 'right' }}>{pct}%</span>
            </div>;
          })}
        </section>

        <section className="col" style={{ gap: 10 }} aria-label="Conquistas">
          <div className="row" style={{ justifyContent: 'space-between' }}><h2 className="h2" style={{ fontSize: 18 }}>Conquistas</h2><span className="muted">{Object.keys(dados.conquistas).length} de {CONQUISTAS.length}</span></div>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 10 }}>
            {CONQUISTAS.map((c) => {
              const ok = !!dados.conquistas[c.codigo];
              const meta = c.codigo === 'quatro_areas' ? areas.total : c.meta;
              const prog = Math.min(100, (progressoConquista(c.codigo, dados, areas) / meta) * 100);
              const Ic = ICONES[c.icone] ?? IcTrofeu;
              return (
                <button key={c.codigo} onClick={() => setFolha(c.codigo)} className="col" style={{ alignItems: 'center', gap: 6, background: 'none', border: 0, cursor: 'pointer', padding: 0 }}>
                  <span style={{ position: 'relative', width: 64, height: 64, borderRadius: 20, background: ok ? c.cor : 'var(--line2)', borderBottom: `4px solid ${ok ? 'rgba(0,0,0,.18)' : 'var(--line)'}`, display: 'grid', placeItems: 'center', overflow: 'hidden' }}>
                    <Ic color={ok ? '#fff' : '#9AAFAA'} size={30} />
                    {!ok && <span style={{ position: 'absolute', left: 6, right: 6, bottom: 6, height: 5, borderRadius: 99, background: 'rgba(255,255,255,.7)' }}><span style={{ display: 'block', height: '100%', width: `${prog}%`, background: '#7C918D', borderRadius: 99 }} /></span>}
                  </span>
                  <span style={{ fontSize: 11, lineHeight: 1.2, textAlign: 'center', color: ok ? 'var(--text)' : 'var(--text3)' }}>{c.nome}</span>
                </button>
              );
            })}
          </div>
        </section>

        <section className="col" style={{ gap: 10 }} aria-label="Como você estuda">
          <h2 className="h2" style={{ fontSize: 18 }}>Como você estuda</h2>
          <div className="list-card">
            <button className="list-row" onClick={() => setFolha('lingua')}><Icone bg="#E1EAFB"><IcIdioma color="#2F5DBF" size={20} /></Icone><Linha t="Língua estrangeira" s={`${prefs.lingua} · nas lições, na trilha e na revisão`} /><IcSeta color="var(--text3)" size={18} /></button>
            <button className="list-row" onClick={() => setFolha('meta')}><Icone bg="var(--primary-soft)"><IcAlvo color="var(--primary)" size={20} /></Icone><Linha t="Meta diária" s={`${metaAtual.xp} XP por dia · ~${metaAtual.min} min · ${metaAtual.nome}`} /><IcSeta color="var(--text3)" size={18} /></button>
            <div className="list-row col" style={{ alignItems: 'stretch', cursor: 'default' }}>
              <div className="row"><Icone bg="var(--amber-soft)"><IcSino color="#B8781A" size={20} /></Icone><Linha t="Lembrete diário" s={prefs.lembrete_ativo ? `Todo dia às ${prefs.lembrete_hora}` : 'Desligado'} /><Interruptor rotulo="Lembrete diário" ligado={prefs.lembrete_ativo} mudar={lembrete} /></div>
              {prefs.lembrete_ativo && <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 6 }}>
                {['07:00', '12:00', '19:00', '21:00'].map((h) => <button key={h} className={`btn ghost sm`} style={{ width: '100%', borderColor: prefs.lembrete_hora === h ? 'var(--primary)' : undefined, background: prefs.lembrete_hora === h ? 'var(--selected)' : undefined }} onClick={() => salvarPrefs({ lembrete_hora: h })}>{h}</button>)}
              </div>}
            </div>
            <div className="list-row" style={{ cursor: 'default' }}><Icone bg="var(--ok-soft)"><IcLampada color="var(--ok-text)" size={20} /></Icone><Linha t="Explicação de cada questão" s={prefs.explicacao_imediata ? 'Aparece logo depois de responder' : 'Só no resultado e na revisão'} /><Interruptor rotulo="Explicação de cada questão" ligado={prefs.explicacao_imediata} mudar={(v) => salvarPrefs({ explicacao_imediata: v })} /></div>
          </div>
        </section>
      </div>
      <BarraNav />

      <Folha aberta={folha === 'meta'} fechar={() => setFolha(null)} titulo="Meta diária">
        <span className="title" style={{ fontSize: 24 }}>Meta diária</span>
        <p className="small">Quanto você quer estudar por dia? Dá para mudar quando quiser.</p>
        {METAS.map((m) => <button key={m.xp} className={`alt ${prefs.meta_xp === m.xp ? 'sel' : ''}`} onClick={() => salvarPrefs({ meta_xp: m.xp })}><span className="alt-body" style={{ fontWeight: 600 }}>{m.nome}</span><span className="muted">{m.xp} XP · ~{m.min} min</span></button>)}
        <button className="btn" onClick={() => setFolha(null)}>Salvar</button>
      </Folha>
      <Folha aberta={folha === 'lingua'} fechar={() => setFolha(null)} titulo="Língua estrangeira">
        <span className="title" style={{ fontSize: 24 }}>Língua estrangeira</span>
        <p className="small">Escolha a língua que você vai fazer na prova. Ela aparece como matéria no Início e na Trilha.</p>
        <Segmentado rotulo="Língua estrangeira" valor={prefs.lingua} mudar={(v) => salvarPrefs({ lingua: v })} opcoes={[{ v: 'Inglês', nome: 'Inglês' }, { v: 'Espanhol', nome: 'Espanhol' }]} />
        <button className="btn" onClick={() => setFolha(null)}>Pronto</button>
      </Folha>
      <Folha aberta={!!conq} fechar={() => setFolha(null)} titulo={conq ? conq.nome : ''}>
        {conq && (() => {
          const ok = dados.conquistas[conq.codigo];
          const meta = conq.codigo === 'quatro_areas' ? areas.total : conq.meta;
          const Ic = ICONES[conq.icone] ?? IcTrofeu;
          return <div className="col" style={{ alignItems: 'center', textAlign: 'center', gap: 10 }}>
            <span style={{ width: 96, height: 96, borderRadius: 30, background: ok ? conq.cor : 'var(--line2)', display: 'grid', placeItems: 'center', borderBottom: '6px solid rgba(0,0,0,.15)' }}><Ic color={ok ? '#fff' : '#9AAFAA'} size={46} /></span>
            <span className="title" style={{ fontSize: 22 }}>{conq.nome}</span>
            <span className="small">{conq.descricao}</span>
            <span className="pill" style={{ background: ok ? 'var(--ok-soft)' : 'var(--line2)', color: ok ? 'var(--ok-text)' : 'var(--text2)', height: 28 }}>
              {ok ? `Conquistada em ${new Date(ok).toLocaleDateString('pt-BR')}` : `Progresso: ${Math.min(meta, progressoConquista(conq.codigo, dados, areas))} de ${meta}`}
            </span>
            <button className="linkbtn" onClick={() => setFolha(null)}>Fechar</button>
          </div>;
        })()}
      </Folha>
    </div>
  );
}

function Icone({ bg, children }: { bg: string; children: React.ReactNode }) {
  return <span aria-hidden="true" style={{ width: 36, height: 36, flexShrink: 0, borderRadius: 12, background: bg, display: 'grid', placeItems: 'center' }}>{children}</span>;
}
function Linha({ t, s }: { t: string; s: string }) {
  return <span className="col spacer" style={{ gap: 1, minWidth: 0 }}><span style={{ fontWeight: 600, fontSize: 15 }}>{t}</span><span className="muted" style={{ fontSize: 12 }}>{s}</span></span>;
}
