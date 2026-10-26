// Trilha: unidades de 6 subconteúdos por matéria, revisão rápida e mini-simulado no fim.
import { useMemo, useState } from 'react';
import type { CSSProperties } from 'react';
import { useNavigate } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { BannerDemo, BarraNav, Folha, SeletorMaterias, Stats, corDe } from '../components/Base';
import { CORES_COROA, IcCheck, IcCoroa, IcLivro, IcLock, IcRevisar, IcEstrela, IcTrofeu, Mascote } from '../components/Icones';
import { SemVidas } from '../components/SemVidas';
import { DESAFIO_QTD, NOMES_COROA, QUESTOES_POR_REVISAO, chaveTema, chaveUnidade, desafioLiberado, recortesVisiveis, revisaoPendente, temaFeito, unidadeAtual, unidadesDoRecorte, vidasAgora } from '../domain/regras';
import { catalogo } from '../domain/catalogo';
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
  const atual = recorte ? unidadeAtual(dados, unidades, recorte.id) : 0;
  const temas = unidades[atual] ?? [];
  const feitos = temas.filter((t) => temaFeito(dados, t)).length;
  const errosNaUnidade = revisaoPendente(dados).filter((r) => {
    const q = catalogo(conteudo).questao(r.questao_id);
    return q && q.recorte_id === recorte?.id && temas.some((t) => t.assunto === q.assunto);
  }).length;
  // Revisão rápida: só os erros dos temas desta unidade (uma sessão leva até QUESTOES_POR_REVISAO)
  const naSessao = Math.min(errosNaUnidade, QUESTOES_POR_REVISAO);
  const textoRevisaoRapida = errosNaUnidade === 1 ? 'Revisar o erro da unidade'
    : naSessao < errosNaUnidade ? `Revisar ${naSessao} dos ${errosNaUnidade} erros da unidade`
    : `Revisar os ${errosNaUnidade} erros da unidade`;
  const urlRevisaoRapida = recorte ? `/refazer?todas=1&recorte=${encodeURIComponent(recorte.id)}&temas=${encodeURIComponent(temas.map((t) => t.assunto).join('|'))}` : '/refazer?todas=1';

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
  const temaAtual = nos.find((n) => n.tipo === 'atual')?.tema;
  const titulo = !temas.length ? 'Sem temas'
    : temaAtual ? `Agora: ${temaAtual.assunto}`
    : recorte && dados.unidades[chaveUnidade(recorte.id, atual)] ? 'Unidade concluída'
    : 'Desafio liberado';

  const estilo = (n: No) => {
    if (n.tipo === 'feito') return { bg: cor.barra, borda: cor.fundo, ic: <IcCheck color="#fff" size={30} /> };
    if (n.tipo === 'atual') return { bg: cor.fundo, borda: '#0b2a4f33', ic: <IcEstrela color="#fff" size={30} /> };
    if (n.tipo === 'revisao') return { bg: '#6A5AE0', borda: '#4B3DB8', ic: <IcRevisar color="#fff" size={30} /> };
    if (n.tipo === 'desafio') return desafioAberto ? { bg: '#F2A93B', borda: '#B8781A', ic: <IcTrofeu color="#fff" size={30} /> } : { bg: 'var(--line2)', borda: 'var(--line)', ic: <IcTrofeu color="#9AAFAA" size={30} /> };
    return { bg: 'var(--line2)', borda: 'var(--line)', ic: <IcLock color="#9AAFAA" size={28} /> };
  };

  return (
    <div className="app">
      <BannerDemo />
      <main className="screen with-nav">
        <header className="row entre">
          <div className="col gap-0"><h1 className="title">Trilha</h1><span className="muted">Um tema leva ao próximo</span></div>
          <Stats />
        </header>
        <SeletorMaterias recortes={recortes} valor={recorte?.id} mudar={setRecId} />
        <section className="a-rise unidade" style={{ background: cor.fundo }}>
          <div className="row entre alinha-topo">
            <div className="col gap-2">
              <span className="kicker branco">Unidade {atual + 1} de {unidades.length} · {recorte?.nome}</span>
              <span className="h2 fs-22">{titulo}</span>
            </div>
            <span className="unidade-icone"><IcLivro color="#fff" /></span>
          </div>
          <div className="row"><span className="bar spacer barra-unidade"><span style={{ width: `${(feitos / Math.max(1, temas.length)) * 100}%` }} /></span><span className="small peso-600">{feitos} de {plural(temas.length, 'tema', 'temas')}</span></div>
        </section>

        <div className="caminho" style={{ '--cor-forte': cor.forte, '--cor-barra': cor.barra } as CSSProperties}>
          {nos.length > 3 && <div className="caminho-mascote" style={{ top: Math.min(300, (nos.length - 3) * 100) }}><Mascote largura={92} /></div>}
          {nos.map((n, i) => {
            const e = estilo(n);
            return (
              <div key={i} className="no" style={{ transform: `translateX(${OFF[i % OFF.length]}px)` }}>
                {n.tipo === 'atual' && <>
                  <span className="a-bob no-comecar">Começar</span>
                  <span className="a-halo no-halo" aria-hidden="true" />
                </>}
                <button onClick={() => setSel(n)} aria-label={n.tema?.assunto ?? (n.tipo === 'revisao' ? 'Revisão rápida' : 'Desafio da unidade')}
                  className="no-botao" style={{ borderBottom: `6px solid ${e.borda}`, background: e.bg }}>
                  {e.ic}
                  {n.tipo === 'feito' && <span className="no-coroa"><IcCoroa size={24} fill={CORES_COROA[n.coroa ?? 1][0]} stroke={CORES_COROA[n.coroa ?? 1][1]} /></span>}
                </button>
              </div>
            );
          })}
        </div>
        {atual < unidades.length - 1 && (
          <div className="row aviso-unidade">
            <IcLock color="#9AAFAA" /><span className="small">Unidade {atual + 2} libera quando você vencer o desafio desta unidade.</span>
          </div>
        )}
      </main>
      <BarraNav />
      <Folha aberta={!!sel} fechar={() => setSel(null)} titulo="Ponto da trilha">
        {sel && (() => {
          if (sel.tipo === 'revisao') return <>
            <span className="kicker tinta-lav">Revisão da unidade</span>
            <span className="title fs-24">Revisão rápida</span>
            <p className="small">Refaça os erros dos temas desta unidade, com dicas.</p>
            {errosNaUnidade ? <button className="btn lav" onClick={() => nav(urlRevisaoRapida)}>{textoRevisaoRapida}</button> : <p className="muted">Você ainda não tem erros nesta unidade.</p>}
          </>;
          if (sel.tipo === 'desafio') return <>
            <span className="kicker">Desafio da unidade</span>
            <span className="title fs-24">Mini-simulado</span>
            <p className="small">Até {DESAFIO_QTD} questões dos temas da unidade. Acerte 70% para liberar a próxima unidade. Não gasta vidas.</p>
            {desafioAberto ? <button className="btn" onClick={() => nav(`/desafio/${encodeURIComponent(recorte.id)}/${atual}`)}>Começar desafio</button>
              : <p className="muted">Faça todos os temas da unidade para liberar.</p>}
          </>;
          const t = sel.tema!;
          return <>
            <span className="kicker" style={{ color: cor.forte }}>{recorte.nome} · {plural(t.total, 'questão', 'questões')}{sel.tipo === 'feito' ? ` · Coroa ${NOMES_COROA[sel.coroa ?? 1]}` : ''}</span>
            <span className="title fs-24">{t.assunto}</span>
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
