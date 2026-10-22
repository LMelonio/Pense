// Lição (e mini-simulado da trilha): uma questão por vez, com retorno imediato.
import { useMemo, useRef, useState } from 'react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { useDados } from '../state/AppContext';
import { repo } from '../lib/config';
import { QuestaoView } from '../components/QuestaoView';
import type { EstadoAlt } from '../components/QuestaoView';
import { IcCoracao, IcX, Mascote } from '../components/Icones';
import { Texto } from '../components/Texto';
import { tocar, vibrar } from '../components/Base';
import {
  BONUS_PERFEITA, DESAFIO_MINIMO, XP_ACERTO, agendarErro, ajustarVidas, atualizarTema, chaveTema, hoje,
  montarDesafio, montarLicao, novasConquistas, somarXP, unidadesDoRecorte, vidasAgora
} from '../domain/regras';
import type { Tentativa } from '../data/types';

export interface EstadoResultado {
  tipo: 'licao' | 'desafio';
  tema: string; recorte_id: string; acertos: number; total: number; xp: number; perfeita: boolean;
  coroaAntes: number; coroaDepois: number; segundos: number; erros: string[]; aprovado?: boolean; conquistas: string[];
}

export default function Licao({ desafio = false }: { desafio?: boolean }) {
  const { recorte: recParam = '', assunto: assParam = '', unidade: uniParam = '0' } = useParams();
  const recorte_id = decodeURIComponent(recParam);
  const assunto = decodeURIComponent(assParam);
  const { dados, conteudo, atualizar } = useDados();
  const nav = useNavigate();
  const recorte = conteudo.recortes.find((r) => r.id === recorte_id);
  const exame = conteudo.exames.find((e) => e.id === recorte?.exame_id) ?? conteudo.exames[0];
  const unidadeIdx = Number(uniParam);

  const questoes = useMemo(() => {
    if (desafio) {
      const un = unidadesDoRecorte(conteudo, recorte_id, dados.prefs.lingua)[unidadeIdx] ?? [];
      return montarDesafio(conteudo, dados, un);
    }
    return montarLicao(conteudo, dados, recorte_id, assunto);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const [i, setI] = useState(0);
  const [sel, setSel] = useState<string | null>(null);
  const [verificada, setVerificada] = useState(false);
  const [respostas, setRespostas] = useState<Tentativa[]>([]);
  const inicio = useRef(Date.now());
  const inicioQ = useRef(Date.now());
  const vidas = vidasAgora(dados.perfil).vidas;

  if (!questoes.length) {
    return <div className="app"><div className="screen"><p>Não há questões para este tema ainda.</p><Link to="/inicio" className="btn">Voltar</Link></div></div>;
  }
  const q = questoes[i];
  const acertou = verificada && sel === q.gabarito;
  const semVidas = !desafio && vidas === 0;
  const ultima = i === questoes.length - 1 || (semVidas && verificada);

  const estados: Record<string, EstadoAlt> = {};
  for (const a of q.alternativas) {
    if (!verificada) estados[a.letra] = sel === a.letra ? 'sel' : 'neutra';
    else estados[a.letra] = a.letra === q.gabarito ? 'certa' : a.letra === sel ? 'errada' : 'apagada';
  }

  async function verificar() {
    if (!sel) return;
    setVerificada(true);
    const ok = sel === q.gabarito;
    tocar(ok ? 'acerto' : 'erro', dados.prefs.sons);
    vibrar(dados.prefs.vibracao, ok ? 20 : 60);
    setRespostas((r) => [...r, { questao_id: q.id, letra: sel, correta: ok, dicas_usadas: 0, viu_resolucao: false, tempo_ms: Date.now() - inicioQ.current, origem: desafio ? 'desafio' : 'licao' }]);
    if (!ok) {
      await atualizar((d) => ({
        ...d,
        perfil: desafio ? d.perfil : ajustarVidas(d.perfil, -1),
        revisao: { ...d.revisao, [q.id]: agendarErro(d.revisao[q.id], q.id, sel) }
      }), { perfil: !desafio, revisao: [q.id] });
    }
  }

  async function concluir(todas: Tentativa[]) {
    const acertos = todas.filter((t) => t.correta).length;
    const total = todas.length;
    const perfeita = !desafio && acertos === total && total >= Math.min(3, questoes.length);
    const xp = acertos * XP_ACERTO + (perfeita ? BONUS_PERFEITA : 0);
    const k = chaveTema(recorte_id, assunto);
    const coroaAntes = dados.temas[k]?.coroa ?? 0;
    const aprovado = desafio ? acertos / Math.max(1, total) >= DESAFIO_MINIMO : undefined;
    const recortesDoExame = conteudo.recortes.filter((r) => r.exame_id === exame.id).length;
    let ganhas: string[] = [];
    const temasTocados = desafio ? [...new Set(todas.map((t) => questoes.find((x) => x.id === t.questao_id)!.assunto))] : [assunto];
    const novo = await atualizar((d) => {
      let n = somarXP(d, xp);
      const temas = { ...n.temas };
      for (const nomeTema of temasTocados) {
        const kk = chaveTema(recorte_id, nomeTema);
        const resp = todas.filter((t) => questoes.find((x) => x.id === t.questao_id)?.assunto === nomeTema).map((t) => t.correta);
        temas[kk] = atualizarTema(temas[kk], recorte_id, nomeTema, resp, perfeita && nomeTema === assunto);
      }
      n = {
        ...n, temas,
        vistas: [...new Set([...n.vistas, ...todas.map((t) => t.questao_id)])],
        perfil: { ...n.perfil, questoes_feitas: n.perfil.questoes_feitas + total, acertos_total: n.perfil.acertos_total + acertos },
        unidades: desafio && aprovado ? { ...n.unidades, [`${recorte_id}|${unidadeIdx}`]: true } : n.unidades
      };
      ganhas = novasConquistas(n, recortesDoExame, { perfeita });
      const agora = new Date().toISOString();
      n = { ...n, conquistas: { ...n.conquistas, ...Object.fromEntries(ganhas.map((g) => [g, agora])) } };
      return n;
    }, {
      perfil: true, xpDia: [hoje()], temas: temasTocados.map((t) => chaveTema(recorte_id, t)), conquistas: ganhas,
      unidades: desafio && aprovado ? [`${recorte_id}|${unidadeIdx}`] : []
    });
    // conquistas calculadas dentro do atualizar: grava de novo se houve alguma
    if (novo && ganhas.length) await atualizar((d) => d, { conquistas: ganhas });
    repo.registrarSessao({
      tipo: desafio ? 'desafio' : 'licao', exame_id: exame.id, recorte_id, assunto: desafio ? null : assunto,
      inicio: new Date(inicio.current).toISOString(), fim: new Date().toISOString(), acertos, total, xp, perfeita
    }, todas).catch(() => undefined);
    tocar('fim', dados.prefs.sons);
    const estado: EstadoResultado = {
      tipo: desafio ? 'desafio' : 'licao', tema: desafio ? `Unidade ${unidadeIdx + 1} · ${recorte?.nome}` : assunto, recorte_id,
      acertos, total, xp, perfeita, coroaAntes, coroaDepois: novo?.temas[k]?.coroa ?? coroaAntes,
      segundos: Math.round((Date.now() - inicio.current) / 1000), erros: todas.filter((t) => !t.correta).map((t) => t.questao_id), aprovado, conquistas: ganhas
    };
    nav('/resultado', { replace: true, state: estado });
  }

  function proxima() {
    if (ultima) { concluir(respostas); return; }
    setI(i + 1); setSel(null); setVerificada(false); inicioQ.current = Date.now();
  }

  const pct = ((i + (verificada ? 1 : 0)) / questoes.length) * 100;
  return (
    <div className="app" style={{ background: 'var(--bg-licao)' }}>
      <header className="row" style={{ padding: '16px 18px 8px', gap: 12 }}>
        <Link to={desafio ? '/trilha' : '/inicio'} aria-label="Sair" style={{ color: 'var(--icon)', display: 'grid', placeItems: 'center', width: 40, height: 40 }}><IcX /></Link>
        <div className="bar spacer" style={{ height: 14 }} role="progressbar" aria-valuemin={0} aria-valuemax={questoes.length} aria-valuenow={i}><span style={{ width: `${pct}%`, background: 'var(--ok)' }} /></div>
        {desafio ? <span className="pill" style={{ background: 'var(--lav-soft)', color: 'var(--lav-dark)' }}>Desafio</span>
          : <span className="row" style={{ gap: 4, fontFamily: 'var(--font-title)', fontWeight: 600, color: 'var(--coral-dark)' }}><IcCoracao size={22} />{vidas}</span>}
      </header>
      <div className="screen licao" style={{ paddingBottom: verificada ? 260 : 120 }}>
        <QuestaoView key={q.id} q={q} recorte={recorte} nomeExame={exame.nome} textoBase={q.texto_base_id ? conteudo.textos_base[q.texto_base_id] : null}
          estados={estados} escolher={(l) => !verificada && setSel(l)} bloqueado={verificada} />
      </div>
      {!verificada ? (
        <div className="footer-cta" style={{ position: 'sticky' }}>
          <button className="btn" disabled={!sel} onClick={verificar}>Verificar</button>
        </div>
      ) : (
        <div className={`feedback ${acertou ? 'ok' : 'erro'}`} role="status">
          <div className="row" style={{ gap: 12 }}>
            <Mascote largura={58} humor={acertou ? 'comemorando' : 'triste'} />
            <div className="col" style={{ gap: 2 }}>
              <span style={{ fontFamily: 'var(--font-title)', fontWeight: 700, fontSize: 22 }}>{acertou ? 'Mandou bem!' : 'Quase lá'}</span>
              <span className="small" style={{ fontWeight: 600 }}>{acertou ? `+${XP_ACERTO} XP` : `Resposta certa: ${q.gabarito}${desafio ? '' : ' · −1 vida'}`}</span>
            </div>
          </div>
          {dados.prefs.explicacao_imediata && q.explicacao && <Texto md={q.explicacao} className="texto-questao small" />}
          {semVidas && !acertou && <p className="small" style={{ fontWeight: 600 }}>Suas vidas acabaram. A lição termina aqui; revise para ganhar uma vida.</p>}
          <button className={`btn ${acertou ? '' : 'coral'}`} onClick={proxima}>{ultima ? 'Ver resultado' : acertou ? 'Continuar' : 'Entendi'}</button>
        </div>
      )}
    </div>
  );
}
