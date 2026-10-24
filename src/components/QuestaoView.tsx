import { useState } from 'react';
import type { Questao, Recorte } from '../data/types';
import { Texto, figurasSoltas } from './Texto';
import { IcCheck, IcX } from './Icones';
import { corDe } from './Base';

export type EstadoAlt = 'neutra' | 'sel' | 'certa' | 'errada' | 'riscada' | 'apagada';

export function origemDe(q: Questao, nomeExame: string) {
  const partes = [nomeExame];
  if (q.orgao) partes.push(q.orgao);
  if (q.cargo) partes.push(q.cargo);
  partes.push(String(q.ano));
  if (q.numero) partes.push(`Questão ${q.numero}`);
  return partes.join(' · ');
}

export function QuestaoView({ q, recorte, nomeExame, textoBase, estados, escolher, bloqueado, rotuloExtra }: {
  q: Questao; recorte?: Recorte; nomeExame: string; textoBase?: string | null;
  estados: Record<string, EstadoAlt>; escolher: (letra: string) => void; bloqueado: boolean;
  rotuloExtra?: Record<string, string>;
}) {
  const [baseAberta, setBaseAberta] = useState(true);
  const cor = corDe(recorte?.cor ?? 'lav');
  const soltas = figurasSoltas(q.texto_apoio, q.figuras);
  return (
    <>
      <div className="row" style={{ flexWrap: 'wrap', gap: 8 }}>
        <span className="pill" style={{ background: cor.suave, color: cor.forte }}>{recorte ? `${recorte.nome} · ${q.assunto}` : q.assunto}</span>
        <span className="muted">{origemDe(q, nomeExame)}</span>
      </div>
      {textoBase && (
        <div className="card" style={{ padding: 0, overflow: 'hidden' }}>
          <button type="button" className="list-row" style={{ background: 'var(--bg-licao)' }} onClick={() => setBaseAberta(!baseAberta)} aria-expanded={baseAberta}>
            <span className="spacer small" style={{ fontWeight: 600, color: 'var(--text2)' }}>Texto-base</span>
            <span className="small" style={{ color: 'var(--primary)', fontWeight: 600 }}>{baseAberta ? 'Recolher' : 'Ler'}</span>
          </button>
          {baseAberta && <div style={{ padding: '4px 16px 16px' }}><Texto md={textoBase} /></div>}
        </div>
      )}
      {(q.texto_apoio || soltas.length > 0) && (
        <div className="card a-rise">
          <Texto md={q.texto_apoio} figuras={q.figuras} />
          {soltas.map((f) => <img key={f.imagem} src={`./${f.imagem}`} alt={f.descricao} style={{ maxWidth: '100%', borderRadius: 10, marginTop: 8 }} loading="lazy" />)}
        </div>
      )}
      <div style={{ fontWeight: 600, fontSize: '1.1em', lineHeight: 1.4 }}><Texto md={q.comando} className="" /></div>
      <div role="radiogroup" aria-label="Alternativas" className="col" style={{ gap: 10 }}>
        {q.alternativas.map((a) => {
          const e = estados[a.letra] ?? 'neutra';
          const cls = e === 'neutra' ? '' : e;
          const anim = e === 'errada' ? ' a-shake' : e === 'certa' ? ' a-pop' : '';
          return (
            <button key={a.letra} type="button" role="radio" aria-checked={e === 'sel'} className={`alt ${cls}${anim}`} disabled={bloqueado || e === 'riscada'} onClick={() => escolher(a.letra)}>
              <span className="letra">{a.letra}</span>
              <span className="alt-body">
                {a.texto ? <Texto md={a.texto} className="" /> : a.imagem ? <img src={`./${a.imagem}`} alt={`Alternativa ${a.letra}`} /> : null}
              </span>
              {rotuloExtra?.[a.letra] && <span style={{ fontSize: 11, fontWeight: 600, color: 'var(--coral-dark)', whiteSpace: 'nowrap', textDecoration: 'none' }}>{rotuloExtra[a.letra]}</span>}
              {e === 'certa' && <IcCheck color="var(--ok-text)" />}
              {e === 'errada' && <IcX color="var(--coral-dark)" size={20} />}
            </button>
          );
        })}
      </div>
    </>
  );
}
