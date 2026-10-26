import { useMemo, useState } from 'react';
import type { CSSProperties } from 'react';
import { Link } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { BannerDemo, BarraNav, Folha, Interruptor, Segmentado, corDe } from '../components/Base';
import { IcAlvo, IcBroto, IcCalendario, IcChama, IcCheck, IcCoroa, IcEngrenagem, IcEstrela, IcIdioma, IcLampada, IcLivro, IcRaio, IcRevisar, IcSeta, IcSino, IcTrofeu } from '../components/Icones';
import { plural } from '../lib/texto';
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

  const salvarPrefs = (mud: Partial<typeof prefs>) => atualizar((d) => ({ ...d, prefs: { ...d.prefs, ...mud } }), { prefs: Object.keys(mud) as (keyof typeof prefs)[] });

  const conq = folha && CONQUISTAS.find((c) => c.codigo === folha);
  const metaAtual = METAS.find((m) => m.xp === prefs.meta_xp) ?? METAS[2];

  return (
    <div className="app">
      <BannerDemo />
      <main className="screen with-nav">
        <header className="row entre">
          <h1 className="title">Perfil</h1>
          <Link to="/config" aria-label="Configurações" className="chip chip-config"><IcEngrenagem /></Link>
        </header>

        <section className="card a-rise col gap-16">
          <div className="row gap-14">
            <div className="relativa">
              <div aria-hidden="true" className="avatar avatar-g">{(p.nome || 'E')[0]}</div>
              <span className="selo-nivel">{nv.nivel}</span>
            </div>
            <div className="col gap-3">
              <span className="title fs-23">{p.nome}</span>
              <span className="muted">{p.usuario ? `@${p.usuario}` : 'Estudante do Pense'}</span>
              <span className="pill pilula-primaria so-inicio">Foco: {exame?.nome}</span>
            </div>
          </div>
          <div className="col gap-6">
            <div className="row entre"><span className="h2 fs-17">Nível {nv.nivel} · {nv.nome}</span><span className="muted">{p.xp_total.toLocaleString('pt-BR')}/{nv.prox.toLocaleString('pt-BR')} XP</span></div>
            <div className="bar barra-nivel"><span style={{ width: `${nv.pct}%` }} /></div>
            <span className="muted">Faltam {(nv.prox - p.xp_total).toLocaleString('pt-BR')} XP para o nível {nv.nivel + 1}</span>
          </div>
        </section>

        <div className="grade-estatisticas">
          {[
            [<IcChama size={20} />, plural(sequenciaAtual(p), 'dia', 'dias'), `sequência · recorde ${p.sequencia_recorde}`, 'var(--amber-soft)'],
            [<IcRaio size={18} />, p.xp_total.toLocaleString('pt-BR'), 'XP no total', 'var(--lav-soft)'],
            [<IcCheck color="var(--primary-ink)" size={20} />, String(p.questoes_feitas), 'questões feitas', 'var(--primary-soft)'],
            [<IcAlvo color="var(--rc-mt-forte)" size={20} />, `${acerto}%`, 'de acerto geral', 'var(--rc-mt-suave)']
          ].map(([ic, v, l, bg], k) => (
            <div key={k} className="card row a-rise estatistica">
              <span className="estatistica-icone" style={{ background: bg as string }}>{ic}</span>
              <span className="col gap-0 encolhe"><span className="big fs-19">{v}</span><span className="muted fs-12">{l}</span></span>
            </div>
          ))}
        </div>

        <section className="card col gap-12" aria-label="Domínio por matéria">
          <div className="row entre"><h2 className="h2 fs-18">Domínio por matéria</h2>
            <span className="row gap-8 fs-12 peso-600"><span className="tinta-ouro">Ouro {coroas[2]}</span><span className="tinta-prata">Prata {coroas[1]}</span><span className="tinta-bronze">Bronze {coroas[0]}</span></span>
          </div>
          {dominios.map(({ r, pct }) => {
            const c = corDe(r.cor);
            return <div key={r.id} className="dominio" style={{ '--rc-forte': c.forte, '--rc-suave': c.suave, '--rc-barra': c.barra } as CSSProperties}>
              <span className="small peso-600 dominio-nome">{r.nome}</span>
              <span className="bar dominio-barra"><span style={{ width: `${pct}%` }} /></span>
              <span className="small peso-600 direita">{pct}%</span>
            </div>;
          })}
        </section>

        <section className="col gap-10" aria-label="Conquistas">
          <div className="row entre"><h2 className="h2 fs-18">Conquistas</h2><span className="muted">{Object.keys(dados.conquistas).length} de {CONQUISTAS.length}</span></div>
          <div className="grade-conquistas">
            {CONQUISTAS.map((c) => {
              const ok = !!dados.conquistas[c.codigo];
              const meta = c.codigo === 'quatro_areas' ? areas.total : c.meta;
              const prog = Math.min(100, (progressoConquista(c.codigo, dados, areas) / meta) * 100);
              const Ic = ICONES[c.icone] ?? IcTrofeu;
              return (
                <button key={c.codigo} onClick={() => setFolha(c.codigo)} className={ok ? 'conquista ok' : 'conquista'}>
                  <span className="conquista-icone" style={{ '--cor-conquista': c.cor } as CSSProperties}>
                    <Ic color={ok ? '#fff' : '#9AAFAA'} size={30} />
                    {!ok && <span className="conquista-progresso"><span style={{ width: `${prog}%` }} /></span>}
                  </span>
                  <span className="conquista-nome">{c.nome}</span>
                </button>
              );
            })}
          </div>
        </section>

        <section className="col gap-10" aria-label="Como você estuda">
          <h2 className="h2 fs-18">Como você estuda</h2>
          <div className="list-card">
            <button className="list-row" onClick={() => setFolha('lingua')}><Icone bg="var(--rc-mt-suave)"><IcIdioma color="var(--rc-mt-forte)" size={20} /></Icone><Linha t="Língua estrangeira" s={`${prefs.lingua} · nas lições, na trilha e na revisão`} /><IcSeta color="var(--text3)" size={18} /></button>
            <button className="list-row" onClick={() => setFolha('meta')}><Icone bg="var(--primary-soft)"><IcAlvo color="var(--primary-ink)" size={20} /></Icone><Linha t="Meta diária" s={`${metaAtual.xp} XP por dia · ~${metaAtual.min} min · ${metaAtual.nome}`} /><IcSeta color="var(--text3)" size={18} /></button>
            <div className="list-row estatica"><Icone bg="var(--amber-soft)"><IcSino color="var(--amber-ink)" size={20} /></Icone><Linha t="Lembrete diário" s="Um aviso por dia para não perder a sequência" /><span className="pill pilula-ambar">Em breve</span></div>
            <div className="list-row estatica"><Icone bg="var(--ok-soft)"><IcLampada color="var(--ok-text)" size={20} /></Icone><Linha t="Explicação de cada questão" s={prefs.explicacao_imediata ? 'Aparece logo depois de responder' : 'Só no resultado e na revisão'} /><Interruptor rotulo="Explicação de cada questão" ligado={prefs.explicacao_imediata} mudar={(v) => salvarPrefs({ explicacao_imediata: v })} /></div>
          </div>
        </section>
      </main>
      <BarraNav />

      <Folha aberta={folha === 'meta'} fechar={() => setFolha(null)} titulo="Meta diária">
        <span className="title fs-24">Meta diária</span>
        <p className="small">Quanto você quer estudar por dia? Dá para mudar quando quiser.</p>
        {METAS.map((m) => <button key={m.xp} className={`alt ${prefs.meta_xp === m.xp ? 'sel' : ''}`} onClick={() => salvarPrefs({ meta_xp: m.xp })}><span className="alt-body peso-600">{m.nome}</span><span className="muted">{m.xp} XP · ~{m.min} min</span></button>)}
        <button className="btn" onClick={() => setFolha(null)}>Salvar</button>
      </Folha>
      <Folha aberta={folha === 'lingua'} fechar={() => setFolha(null)} titulo="Língua estrangeira">
        <span className="title fs-24">Língua estrangeira</span>
        <p className="small">Escolha a língua que você vai fazer na prova. Ela aparece como matéria no Início e na Trilha.</p>
        <Segmentado rotulo="Língua estrangeira" valor={prefs.lingua} mudar={(v) => salvarPrefs({ lingua: v })} opcoes={[{ v: 'Inglês', nome: 'Inglês' }, { v: 'Espanhol', nome: 'Espanhol' }]} />
        <button className="btn" onClick={() => setFolha(null)}>Pronto</button>
      </Folha>
      <Folha aberta={!!conq} fechar={() => setFolha(null)} titulo={conq ? conq.nome : ''}>
        {conq && (() => {
          const ok = dados.conquistas[conq.codigo];
          const meta = conq.codigo === 'quatro_areas' ? areas.total : conq.meta;
          const Ic = ICONES[conq.icone] ?? IcTrofeu;
          return <div className="col alinha-centro centro gap-10">
            <span className={ok ? 'conquista-grande ok' : 'conquista-grande'} style={{ '--cor-conquista': conq.cor } as CSSProperties}><Ic color={ok ? '#fff' : '#9AAFAA'} size={46} /></span>
            <span className="title fs-22">{conq.nome}</span>
            <span className="small">{conq.descricao}</span>
            <span className={`pill alta-28 ${ok ? 'pilula-ok' : 'pilula-cinza'}`}>
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
  return <span aria-hidden="true" className="icone-linha" style={{ background: bg }}>{children}</span>;
}
function Linha({ t, s }: { t: string; s: string }) {
  return <span className="col spacer gap-1 encolhe"><span className="linha-titulo">{t}</span><span className="muted fs-12">{s}</span></span>;
}
