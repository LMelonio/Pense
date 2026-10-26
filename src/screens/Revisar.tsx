// Revisar: treino dos erros. Um botão principal, sem mostrar respostas.
// A revisão do dia tem os erros que venceram e as questões dominadas que voltaram para confirmar; sem nada vencido,
// dá para adiantar a revisão dos erros guardados (treino, sem XP).
import { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { BannerDemo, BarraNav, Stats, corDe } from '../components/Base';
import { IcSeta, Mascote } from '../components/Icones';
import { QUESTOES_POR_REVISAO, XP_REVISAO, chaveTema, revisaoPendente, revisaoVencida, vidaPelaRevisao, vidaPeloTreino } from '../domain/regras';
import { catalogo } from '../domain/catalogo';
import { plural } from '../lib/texto';

export default function Revisar() {
  const { dados, conteudo } = useDados();
  const { vencidas, lista } = useMemo(() => {
    const vencidas = revisaoVencida(dados);
    return { vencidas, lista: vencidas.length ? vencidas : revisaoPendente(dados) };
  }, [dados]);
  const erros = vencidas.filter((r) => r.status === 'pendente').length;
  const confirmar = vencidas.length - erros; // dominadas que voltaram
  const vida = vencidas.length ? vidaPelaRevisao(dados) : vidaPeloTreino(dados);
  const grupos = useMemo(() => {
    // Agrupa por matéria + assunto: "Interpretação de texto" de Inglês e de Português são grupos diferentes.
    const cat = catalogo(conteudo);
    const m = new Map<string, { chave: string; assunto: string; recorte_id: string; recorte: string; cor: string; erros: number; confirmar: number }>();
    for (const r of lista) {
      const q = cat.questao(r.questao_id);
      if (!q) continue;
      const rc = cat.recorte(q.recorte_id);
      const chave = chaveTema(q.recorte_id, q.assunto);
      const g = m.get(chave) ?? { chave, assunto: q.assunto, recorte_id: q.recorte_id, recorte: rc?.nome ?? '', cor: rc?.cor ?? 'lav', erros: 0, confirmar: 0 };
      if (r.status === 'dominada') g.confirmar++; else g.erros++;
      m.set(chave, g);
    }
    return [...m.values()].sort((a, b) => b.erros + b.confirmar - (a.erros + a.confirmar));
  }, [lista, conteudo]);
  const minutos = Math.max(1, Math.round(Math.min(lista.length, QUESTOES_POR_REVISAO) * 0.7));

  return (
    <div className="app">
      <BannerDemo />
      <main className="screen with-nav">
        <header className="row entre">
          <div className="col gap-0"><h1 className="title">Revisar</h1><span className="muted">Seus erros viram acertos aqui</span></div>
          <Stats />
        </header>

        <section className="card a-rise col revanche">
          <span aria-hidden="true" className="bolha bolha-lav" />
          <span aria-hidden="true" className="bolha bolha-primaria" />
          <div className="relativa"><Mascote largura={150} /></div>
          {lista.length ? <>
            <h2 className="title fs-28 relativa">{lista.length} {lista.length === 1 ? 'questão pedindo' : 'questões pedindo'} revanche</h2>
            {confirmar > 0 && <span className="pill pilula-lav alta-28 relativa">{plural(erros, 'erro', 'erros')} · {confirmar} para confirmar</span>}
            <p className="small texto2 relativa largura-300">
              {vencidas.length
                ? `Você vai refazer as que errou, sem ver a resposta antes. Acertou de primeira e sem dica, ela sai da lista.${confirmar ? ' As que você já tinha recuperado voltam para confirmar.' : ''}`
                : vida ? 'Nada vence hoje. Adiante a revisão: é treino, sem XP, mas nesta primeira vez, acertando pelo menos 1, você recupera 1 vida.'
                : 'Nada vence hoje. Se quiser, adiante a revisão: é treino, sem XP, e as questões voltam amanhã, valendo.'}
            </p>
            <div className="row relativa gap-8 quebra just-centro">
              <span className="pill pilula-bg alta-30">~{minutos} min</span>
              {vencidas.length
                ? <span className="pill pilula-lav alta-30">+{XP_REVISAO[0]} XP por acerto</span>
                : <span className="pill pilula-lav alta-30">treino, sem XP</span>}
              {vida && <span className="pill pilula-coral alta-30">+1 vida no fim</span>}
            </div>
            <Link to={vencidas.length ? '/refazer' : '/refazer?todas=1'} className="btn relativa">{vencidas.length ? 'Revisar agora' : 'Adiantar revisão'}</Link>
          </> : <>
            <h2 className="title fs-26 relativa">Nenhum erro para revisar</h2>
            <p className="small texto2 relativa">Quando você errar uma questão, ela aparece aqui no dia seguinte.</p>
            <Link to="/inicio" className="btn relativa">Fazer uma lição</Link>
          </>}
        </section>

        {grupos.length > 0 && (
          <section className="col gap-10" aria-label="De onde vêm seus erros">
            <h2 className="h2 fs-18">De onde vêm seus erros</h2>
            <div className="list-card">
              {grupos.map((g) => (
                <Link key={g.chave} to={`/refazer?recorte=${encodeURIComponent(g.recorte_id)}&tema=${encodeURIComponent(g.assunto)}${vencidas.length ? '' : '&todas=1'}`} className="list-row">
                  <span aria-hidden="true" className="ponto-materia" style={{ background: corDe(g.cor).barra }} />
                  <span className="col spacer gap-0"><span className="peso-600">{g.assunto}</span><span className="muted">{g.recorte}</span></span>
                  <span className="row gap-3" role="img" aria-label={[g.erros && plural(g.erros, 'erro', 'erros'), g.confirmar && `${g.confirmar} para confirmar`].filter(Boolean).join(' e ')}>
                    {Array.from({ length: Math.min(g.erros + g.confirmar, 6) }, (_, i) => <span key={i} className={i < g.erros ? 'bolinha' : 'bolinha lav'} />)}
                  </span>
                  <IcSeta color="var(--text3)" size={18} />
                </Link>
              ))}
            </div>
            <span className="muted">{confirmar ? 'Cada bolinha é uma questão: vermelha, um erro; roxa, uma para confirmar.' : 'Cada bolinha é uma questão para refazer.'} Toque num tema para treinar só ele.</span>
          </section>
        )}
      </main>
      <BarraNav />
    </div>
  );
}
