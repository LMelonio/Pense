import { NavLink } from 'react-router-dom';
import { useState } from 'react';
import type { ReactNode } from 'react';
import { IcChama, IcCoracao, IcHome, IcPerfil, IcRaio, IcRevisar, IcTrilha } from './Icones';
import { useDados } from '../state/AppContext';
import { sequenciaAtual, vidasAgora } from '../domain/regras';
import { supabaseConfigurado } from '../lib/config';

export const CORES_RECORTE: Record<string, { forte: string; suave: string; barra: string }> = {
  mt: { forte: '#2F5DBF', suave: '#E1EAFB', barra: '#4C7BD9' },
  lc: { forte: '#B44E25', suave: '#FCE7DD', barra: '#E07A4F' },
  ch: { forte: '#8A6608', suave: '#FBF0D3', barra: '#D8A93B' },
  cn: { forte: '#1C7A52', suave: '#DDF2E7', barra: '#3FA37A' },
  lav: { forte: '#4B3DB8', suave: '#ECE9FF', barra: '#6A5AE0' }
};
export const corDe = (cor: string) => CORES_RECORTE[cor] ?? CORES_RECORTE.lav;

export function BarraNav() {
  const itens = [
    { to: '/inicio', nome: 'Início', Ic: IcHome },
    { to: '/trilha', nome: 'Trilha', Ic: IcTrilha },
    { to: '/revisar', nome: 'Revisar', Ic: IcRevisar },
    { to: '/perfil', nome: 'Perfil', Ic: IcPerfil }
  ];
  return (
    <nav className="nav" aria-label="Navegação principal">
      {itens.map(({ to, nome, Ic }) => (
        <NavLink key={to} to={to} className={({ isActive }) => (isActive ? 'active' : '')}>
          <span className="ico"><Ic /></span>{nome}
        </NavLink>
      ))}
    </nav>
  );
}

export function Stats() {
  const { dados } = useDados();
  const { vidas } = vidasAgora(dados.perfil);
  return (
    <div className="row" style={{ gap: 6 }}>
      <span className="chip" title="Sequência de dias"><IcChama />{sequenciaAtual(dados.perfil)}</span>
      <span className="chip" title="Pontos de experiência"><IcRaio />{dados.perfil.xp_total.toLocaleString('pt-BR')}</span>
      <span className="chip" title="Vidas"><IcCoracao />{vidas}</span>
    </div>
  );
}

export function Anel({ pct, tam = 72, esp = 9, cor = '#2BA28F', trilho = 'var(--line2)', children }: { pct: number; tam?: number; esp?: number; cor?: string; trilho?: string; children?: ReactNode }) {
  const r = (tam - esp) / 2;
  const c = 2 * Math.PI * r;
  return (
    <div style={{ position: 'relative', width: tam, height: tam, flexShrink: 0 }}>
      <svg width={tam} height={tam} style={{ transform: 'rotate(-90deg)' }} aria-hidden="true">
        <circle cx={tam / 2} cy={tam / 2} r={r} fill="none" stroke={trilho} strokeWidth={esp} />
        <circle cx={tam / 2} cy={tam / 2} r={r} fill="none" stroke={cor} strokeWidth={esp} strokeLinecap="round" strokeDasharray={c} strokeDashoffset={c * (1 - Math.min(1, Math.max(0, pct / 100)))} style={{ transition: 'stroke-dashoffset 1s cubic-bezier(.3,.8,.3,1)' }} />
      </svg>
      <div style={{ position: 'absolute', inset: 0, display: 'grid', placeItems: 'center', textAlign: 'center' }}>{children}</div>
    </div>
  );
}

export function Folha({ aberta, fechar, titulo, children }: { aberta: boolean; fechar: () => void; titulo: string; children: ReactNode }) {
  if (!aberta) return null;
  return (
    <>
      <div className="scrim" onClick={fechar} />
      <div className="sheet" role="dialog" aria-label={titulo}>
        <span className="grab" aria-hidden="true" />
        {children}
      </div>
    </>
  );
}

export function Interruptor({ ligado, mudar, rotulo }: { ligado: boolean; mudar: (v: boolean) => void; rotulo: string }) {
  return <button type="button" role="switch" aria-checked={ligado} aria-label={rotulo} className="switch" onClick={() => mudar(!ligado)}><span /></button>;
}

export function Segmentado<T extends string>({ opcoes, valor, mudar, rotulo }: { opcoes: { v: T; nome: string }[]; valor: T; mudar: (v: T) => void; rotulo: string }) {
  return (
    <div className="seg" role="radiogroup" aria-label={rotulo} style={{ gridTemplateColumns: `repeat(${opcoes.length}, 1fr)` }}>
      {opcoes.map((o) => <button key={o.v} type="button" role="radio" aria-checked={valor === o.v} onClick={() => mudar(o.v)}>{o.nome}</button>)}
    </div>
  );
}

export function CampoSenha({ valor, mudar, rotulo = 'Senha', nova = false }: { valor: string; mudar: (v: string) => void; rotulo?: string; nova?: boolean }) {
  const [ver, setVer] = useState(false);
  return (
    <div className="campo-senha">
      <input className="input" type={ver ? 'text' : 'password'} placeholder={rotulo} aria-label={rotulo} value={valor} onChange={(e) => mudar(e.target.value)} autoComplete={nova ? 'new-password' : 'current-password'} />
      <button type="button" className="linkbtn" onClick={() => setVer(!ver)} aria-pressed={ver}>{ver ? 'Ocultar' : 'Mostrar'}</button>
    </div>
  );
}

export function BannerDemo() {
  if (supabaseConfigurado) return null;
  return <div className="banner-demo">Modo demonstração: o progresso fica só neste navegador. Configure o Supabase para contas reais.</div>;
}

// Sons curtos (Web Audio) e vibração, respeitando as preferências.
let ctx: AudioContext | null = null;
export function tocar(tipo: 'acerto' | 'erro' | 'fim', ligado: boolean) {
  if (!ligado) return;
  try {
    ctx = ctx ?? new AudioContext();
    const notas = tipo === 'acerto' ? [660, 880] : tipo === 'erro' ? [300, 220] : [523, 659, 784];
    notas.forEach((f, i) => {
      const o = ctx!.createOscillator(); const g = ctx!.createGain();
      o.frequency.value = f; o.type = 'sine';
      const t = ctx!.currentTime + i * 0.11;
      g.gain.setValueAtTime(0.0001, t); g.gain.exponentialRampToValueAtTime(0.12, t + 0.02); g.gain.exponentialRampToValueAtTime(0.0001, t + 0.18);
      o.connect(g).connect(ctx!.destination); o.start(t); o.stop(t + 0.2);
    });
  } catch { /* sem áudio */ }
}
export function vibrar(ligado: boolean, ms = 30) { if (ligado && navigator.vibrate) navigator.vibrate(ms); }
