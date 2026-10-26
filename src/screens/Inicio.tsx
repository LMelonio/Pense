import { useMemo, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import type { CSSProperties } from 'react';
import { useDados } from '../state/AppContext';
import { Anel, BannerDemo, BarraNav, Folha, SeletorMaterias, Stats, corDe } from '../components/Base';
import { CORES_COROA, IcCheck, IcCoracao, IcCoroa, IcSeta, Mascote } from '../components/Icones';
import { SemVidas } from '../components/SemVidas';
import {
  BONUS_PERFEITA, NOMES_COROA, VIDAS_MAX, chaveTema, hoje, proximoPasso, recortesVisiveis, revisaoPendente, sequenciaAtual, temasDoRecorte,
  vidaPelaRevisao, vidaPeloTreino, vidasAgora, QUESTOES_POR_LICAO, XP_ACERTO
} from '../domain/regras';
import type { InfoTema, ProximoPasso } from '../domain/regras';
import { catalogo } from '../domain/catalogo';
import { duracao, plural } from '../lib/texto';

const DIAS = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
const DIA = 86400000;
/** O máximo de uma lição: todas certas, com o bônus de lição perfeita. */
const XP_LICAO = QUESTOES_POR_LICAO * XP_ACERTO + BONUS_PERFEITA;

const urlLicao = (t: InfoTema) => `/licao/${encodeURIComponent(t.recorte_id)}/${encodeURIComponent(t.assunto)}`;

/** Quando volta o erro guardado que vence primeiro: amanhã, em 3 dias… */
function quandoVolta(vence: string[], agora: number) {
  const primeiro = Math.min(...vence.map((v) => new Date(v).getTime()));
  const dias = Math.max(1, Math.round((new Date(hoje(primeiro) + 'T12:00').getTime() - new Date(hoje(agora) + 'T12:00').getTime()) / DIA));
  return dias === 1 ? 'amanhã' : `em ${dias} dias`;
}

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

  const agora = Date.now();
  const xpHoje = dados.xpDia[hoje()] ?? 0;
  const pctMeta = Math.min(100, (xpHoje / dados.prefs.meta_xp) * 100);
  const { vidas, proximaEmMin } = vidasAgora(dados.perfil);
  const seq = sequenciaAtual(dados.perfil);
  const diasAteProva = dados.prefs.data_prova ? Math.ceil((new Date(dados.prefs.data_prova + 'T12:00').getTime() - Date.now()) / DIA) : null;
  const passo = proximoPasso(dados, conteudo, recortes, agora);
  const guardados = revisaoPendente(dados).filter((r) => new Date(r.vence_em).getTime() > agora);

  // semana (seg a dom) com os dias em que a meta foi batida
  const semana = useMemo(() => {
    const d = new Date(); const dow = (d.getDay() + 6) % 7;
    return DIAS.map((l, i) => {
      const dia = new Date(d.getTime() - (dow - i) * DIA);
      const k = hoje(dia);
      return { l, feito: (dados.xpDia[k] ?? 0) >= dados.prefs.meta_xp, hoje: i === dow };
    });
  }, [dados.xpDia, dados.prefs.meta_xp]);

  const nome = dados.perfil.nome?.split(' ')[0] || 'Estudante';
  const recorteSel = sel ? catalogo(conteudo).recorte(sel.recorte_id) : undefined;
  return (
    <div className="app">
      <BannerDemo />
      <main className="screen with-nav">
        <header className="row saudacao entre">
          <div className="row encolhe">
            <div aria-hidden="true" className="avatar avatar-p">{nome[0]}</div>
            <div className="col gap-0 encolhe">
              <h1 className="saudacao-nome"><span className="saudacao-oi">Oi, </span>{nome}</h1>
              <span className="muted">{diasAteProva != null && diasAteProva >= 0 ? `${exame.nome} em ${plural(diasAteProva, 'dia', 'dias')}` : exame.nome}</span>
            </div>
          </div>
          <Stats />
        </header>

        <section className="card a-rise col gap-14" aria-label="Meta de hoje">
          <div className="row gap-16">
            <Anel pct={pctMeta}><span className="big fs-17">{Math.round(pctMeta)}%</span></Anel>
            <div className="col gap-2">
              <span className="kicker">Meta de hoje</span>
              <span className="big">{xpHoje} de {dados.prefs.meta_xp} XP</span>
              <span className="muted">{xpHoje >= dados.prefs.meta_xp ? `Meta batida! Sequência de ${plural(seq, 'dia', 'dias')}.` : `Mais ${dados.prefs.meta_xp - xpHoje} XP e a sequência chega a ${seq + 1}.`}</span>
            </div>
          </div>
          <div className="semana">
            {semana.map((s, i) => (
              <div key={i} className={`dia${s.feito ? ' feito' : ''}${s.hoje ? ' hoje' : ''}`}>
                <span className="dia-letra">{s.l}</span>
                <span className="dia-marca">{s.feito && <IcCheck size={14} color="#fff" />}</span>
              </div>
            ))}
          </div>
          <div className="row entre linha-vidas">
            <div className="row gap-3" role="img" aria-label={`${vidas} de ${VIDAS_MAX} vidas`}>
              {Array.from({ length: VIDAS_MAX }, (_, i) => <IcCoracao key={i} size={20} bater={false} cor={i < vidas ? '#E5534B' : 'var(--line)'} />)}
            </div>
            <span className="muted direita">{vidas >= VIDAS_MAX ? 'Vidas cheias' : `Mais 1 vida em ${duracao(proximaEmMin)}${vidaPelaRevisao(dados) || vidaPeloTreino(dados) ? ', ou já, acertando 1 na revisão' : ''}`}</span>
          </div>
        </section>

        {passo && <CartaoProximo passo={passo} vidas={vidas} proximaEmMin={proximaEmMin} />}
        {guardados.length > 0 && (passo?.tipo === 'tema' || passo?.tipo === 'desafio' || !passo) && (
          <p className="lembrete-revisao">
            <span className="spacer">Você tem {plural(guardados.length, 'erro guardado', 'erros guardados')}. {guardados.length === 1 ? 'Ele volta' : 'O primeiro volta'} {quandoVolta(guardados.map((r) => r.vence_em), agora)} na revisão.</span>
            <Link to="/refazer?todas=1">Adiantar revisão</Link>
          </p>
        )}

        <section className="col gap-12" aria-label="Escolha o tema">
          <div className="row entre">
            <h2 className="title fs-22">Escolha o tema</h2>
            <span className="muted">{plural(temas.reduce((s, t) => s + t.total, 0), 'questão', 'questões')}</span>
          </div>
          <SeletorMaterias recortes={recortes} valor={recorte?.id} mudar={setRecId} />
          <div className="col gap-10">
            {temas.map((t, i) => {
              const p = dados.temas[chaveTema(t.recorte_id, t.assunto)];
              const coroa = p?.coroa ?? 0;
              return (
                <button key={t.assunto} className="list-row linha-tema a-rise" onClick={() => setSel(t)} style={{ animationDelay: `${Math.min(i, 8) * 40}ms` }}>
                  <span className="col spacer gap-5 encolhe">
                    <span className="tema-nome">{t.assunto}</span>
                    <span className="muted">{plural(t.total, 'questão', 'questões')} · {p ? `${p.dominio}% dominado` : 'ainda não começou'}</span>
                    <span className="bar" aria-hidden="true"><span style={{ width: `${p?.dominio ?? 0}%`, background: cor.barra }} /></span>
                  </span>
                  <span className="coroa-tema">
                    <IcCoroa size={26} fill={CORES_COROA[coroa][0]} stroke={CORES_COROA[coroa][1]} />
                    <span className="coroa-nome">{NOMES_COROA[coroa]}</span>
                  </span>
                </button>
              );
            })}
          </div>
        </section>
      </main>
      <BarraNav />
      <Folha aberta={!!sel} fechar={() => setSel(null)} titulo={sel?.assunto ?? ''}>
        {sel && (
          <>
            <span className="kicker" style={{ color: corDe(recorteSel?.cor).forte }}>{recorteSel?.nome}</span>
            <span className="title fs-24">{sel.assunto}</span>
            {vidas === 0 ? <SemVidas esperar={() => setSel(null)} /> : (
              <>
                <div className="grade-3">
                  <div className="card soft-lav celula"><div className="big">até {XP_LICAO}</div><span className="small">XP possível</span></div>
                  <div className="card celula celula-primaria"><div className="big">{QUESTOES_POR_LICAO}</div><span className="small">questões</span></div>
                  <div className="card celula celula-coral"><div className="big">{vidas}</div><span className="small">{vidas === 1 ? 'vida' : 'vidas'}</span></div>
                </div>
                <button className="btn" onClick={() => nav(urlLicao(sel))}>Começar</button>
                <button className="linkbtn" onClick={() => setSel(null)}>Agora não</button>
              </>
            )}
          </>
        )}
      </Folha>
    </div>
  );
}

/** O próximo passo, num toque: revisão vencida, adiantar a revisão (sem vidas), próximo tema da trilha ou o desafio. */
function CartaoProximo({ passo, vidas, proximaEmMin }: { passo: ProximoPasso; vidas: number; proximaEmMin: number }) {
  let para: string, cor: string, kicker: string, titulo: string, detalhe: string, acao: string;
  switch (passo.tipo) {
    case 'revisao':
      para = '/refazer'; cor = 'var(--rc-lav-fundo)'; kicker = 'Revisão do dia';
      titulo = `${plural(passo.n, 'questão volta', 'questões voltam')} hoje`;
      detalhe = passo.vida ? 'Acertando pelo menos 1, você recupera 1 vida.' : 'Refaça os erros sem ver a resposta antes.';
      acao = 'Revisar agora';
      break;
    case 'adiantar':
      para = '/refazer?todas=1'; cor = 'var(--coral-forte)'; kicker = 'Sem vidas';
      titulo = `A próxima vida chega em ${duracao(proximaEmMin)}`;
      detalhe = passo.vida
        ? `Ou já: revise ${passo.n === 1 ? 'o erro guardado' : `os ${passo.n} erros guardados`} e, acertando pelo menos 1, recupere 1 vida (sem XP).`
        : `Enquanto isso, adiante a revisão ${passo.n === 1 ? 'do erro guardado' : `dos ${passo.n} erros guardados`}: é treino, sem XP.`;
      acao = passo.vida ? 'Revisar e recuperar 1 vida' : 'Adiantar revisão';
      break;
    case 'tema':
      para = urlLicao(passo.tema); cor = corDe(passo.recorte.cor).fundo; kicker = `Próximo passo · ${passo.recorte.nome}`;
      titulo = passo.tema.assunto;
      detalhe = vidas === 0 ? `Unidade ${passo.unidade + 1} da trilha · a próxima vida chega em ${duracao(proximaEmMin)}` : `Unidade ${passo.unidade + 1} da trilha · ${QUESTOES_POR_LICAO} questões · até ${XP_LICAO} XP`;
      acao = 'Começar';
      break;
    case 'desafio':
      para = `/desafio/${encodeURIComponent(passo.recorte.id)}/${passo.unidade}`; cor = corDe(passo.recorte.cor).fundo; kicker = `Desafio liberado · ${passo.recorte.nome}`;
      titulo = `Mini-simulado da unidade ${passo.unidade + 1}`;
      detalhe = 'Acerte 70% para liberar a próxima unidade. Não gasta vidas.';
      acao = 'Começar desafio';
      break;
  }
  return (
    <Link to={para} className="proximo a-rise" style={{ '--cor-passo': cor } as CSSProperties}>
      <span className="proximo-texto">
        <span className="kicker">{kicker}</span>
        <span className="proximo-titulo">{titulo}</span>
        <span className="small">{detalhe}</span>
        <span className="proximo-acao">{acao}<IcSeta size={16} /></span>
      </span>
      <Mascote largura={78} humor={passo.tipo === 'adiantar' ? 'triste' : 'feliz'} />
    </Link>
  );
}
