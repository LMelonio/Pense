// Revisar: treino dos erros. Um botão principal, sem mostrar respostas.
import { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { BannerDemo, BarraNav, Stats, corDe } from '../components/Base';
import { IcSeta, Mascote } from '../components/Icones';
import { revisaoPendente, revisaoVencida } from '../domain/regras';

export default function Revisar() {
  const { dados, conteudo } = useDados();
  const vencidas = revisaoVencida(dados);
  const pendentes = revisaoPendente(dados);
  const lista = vencidas.length ? vencidas : pendentes;
  const grupos = useMemo(() => {
    const m = new Map<string, { assunto: string; recorte: string; cor: string; n: number }>();
    for (const r of lista) {
      const q = conteudo.questoes.find((x) => x.id === r.questao_id);
      if (!q) continue;
      const rc = conteudo.recortes.find((x) => x.id === q.recorte_id);
      const g = m.get(q.assunto) ?? { assunto: q.assunto, recorte: rc?.nome ?? '', cor: rc?.cor ?? 'lav', n: 0 };
      g.n++; m.set(q.assunto, g);
    }
    return [...m.values()].sort((a, b) => b.n - a.n);
  }, [lista, conteudo]);
  const minutos = Math.max(1, Math.round(Math.min(lista.length, 10) * 0.7));

  return (
    <div className="app">
      <BannerDemo />
      <div className="screen with-nav">
        <header className="row" style={{ justifyContent: 'space-between' }}>
          <div className="col" style={{ gap: 0 }}><h1 className="title">Revisar</h1><span className="muted">Seus erros viram acertos aqui</span></div>
          <Stats />
        </header>

        <section className="card a-rise col" style={{ alignItems: 'center', textAlign: 'center', gap: 12, padding: '22px 20px 20px', position: 'relative', overflow: 'hidden' }}>
          <span aria-hidden="true" style={{ position: 'absolute', left: -40, top: -60, width: 200, height: 200, borderRadius: '50%', background: 'var(--lav-soft)' }} />
          <span aria-hidden="true" style={{ position: 'absolute', right: -50, bottom: -70, width: 180, height: 180, borderRadius: '50%', background: 'var(--primary-soft)' }} />
          <div style={{ position: 'relative' }}><Mascote largura={150} /></div>
          {lista.length ? <>
            <h2 className="title" style={{ fontSize: 28, position: 'relative' }}>{lista.length} {lista.length === 1 ? 'questão pedindo' : 'questões pedindo'} revanche</h2>
            <p className="small" style={{ color: 'var(--text2)', position: 'relative', maxWidth: 290 }}>
              {vencidas.length ? 'Você vai refazer as que errou, sem ver a resposta antes. Acertou, ela sai da lista.' : 'Nada vence hoje. Se quiser, adiante a revisão destas questões.'}
            </p>
            <div className="row" style={{ position: 'relative', gap: 8, flexWrap: 'wrap', justifyContent: 'center' }}>
              <span className="pill" style={{ background: 'var(--bg)', height: 30 }}>~{minutos} min</span>
              <span className="pill" style={{ background: 'var(--lav-soft)', color: 'var(--lav-dark)', height: 30 }}>+5 XP por acerto</span>
              <span className="pill" style={{ background: 'var(--coral-soft)', color: 'var(--coral-dark)', height: 30 }}>+1 vida no fim</span>
            </div>
            <Link to={vencidas.length ? '/refazer' : '/refazer?todas=1'} className="btn" style={{ position: 'relative' }}>{vencidas.length ? 'Começar revisão' : 'Adiantar revisão'}</Link>
          </> : <>
            <h2 className="title" style={{ fontSize: 26, position: 'relative' }}>Nenhum erro para revisar</h2>
            <p className="small" style={{ color: 'var(--text2)', position: 'relative' }}>Quando você errar uma questão, ela aparece aqui no dia seguinte.</p>
            <Link to="/inicio" className="btn" style={{ position: 'relative' }}>Fazer uma lição</Link>
          </>}
        </section>

        {grupos.length > 0 && (
          <section className="col" style={{ gap: 10 }} aria-label="De onde vêm seus erros">
            <h2 className="h2" style={{ fontSize: 18 }}>De onde vêm seus erros</h2>
            <div className="list-card">
              {grupos.map((g) => (
                <Link key={g.assunto} to={`/refazer?tema=${encodeURIComponent(g.assunto)}${vencidas.length ? '' : '&todas=1'}`} className="list-row">
                  <span aria-hidden="true" style={{ width: 10, height: 10, borderRadius: '50%', background: corDe(g.cor).barra, flexShrink: 0 }} />
                  <span className="col spacer" style={{ gap: 0 }}><span style={{ fontWeight: 600 }}>{g.assunto}</span><span className="muted">{g.recorte}</span></span>
                  <span className="row" style={{ gap: 3 }} aria-label={`${g.n} para refazer`}>{Array.from({ length: Math.min(g.n, 6) }, (_, i) => <span key={i} style={{ width: 8, height: 8, borderRadius: '50%', background: 'var(--coral)' }} />)}</span>
                  <IcSeta color="var(--text3)" size={18} />
                </Link>
              ))}
            </div>
            <span className="muted">Cada bolinha é uma questão para refazer. Toque num tema para treinar só ele.</span>
          </section>
        )}
      </div>
      <BarraNav />
    </div>
  );
}
