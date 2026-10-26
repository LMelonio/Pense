import { NavLink } from 'react-router-dom';
import { memo, useEffect, useRef, useState } from 'react';
import type { ReactNode } from 'react';
import { IcChama, IcCoracao, IcHome, IcPerfil, IcRaio, IcRevisar, IcTrilha } from './Icones';
import { useProgresso } from '../state/AppContext';
import { sequenciaAtual, vidasAgora } from '../domain/regras';
import { supabaseConfigurado } from '../lib/config';
import type { Recorte } from '../data/types';

/** Cores de cada matéria (variáveis --rc-* do global.css, que mudam no modo noturno).
 * forte: texto e bordas · suave: fundo claro · fundo: cor sólida sob texto branco · barra: progresso. */
export interface CorRecorte { forte: string; suave: string; fundo: string; barra: string }
const cor = (k: string): CorRecorte => ({ forte: `var(--rc-${k}-forte)`, suave: `var(--rc-${k}-suave)`, fundo: `var(--rc-${k}-fundo)`, barra: `var(--rc-${k}-barra)` });
export const CORES_RECORTE: Record<string, CorRecorte> = { mt: cor('mt'), lc: cor('lc'), ch: cor('ch'), cn: cor('cn'), lav: cor('lav') };
export const corDe = (c: string | null | undefined) => (c && CORES_RECORTE[c]) || CORES_RECORTE.lav;

const ITENS_NAV = [
  { to: '/inicio', nome: 'Início', Ic: IcHome },
  { to: '/trilha', nome: 'Trilha', Ic: IcTrilha },
  { to: '/revisar', nome: 'Revisar', Ic: IcRevisar },
  { to: '/perfil', nome: 'Perfil', Ic: IcPerfil }
];

/** Sem props: não re-renderiza quando os dados do aluno mudam. */
export const BarraNav = memo(function BarraNav() {
  return (
    <nav className="nav" aria-label="Navegação principal">
      {ITENS_NAV.map(({ to, nome, Ic }) => (
        <NavLink key={to} to={to} className={({ isActive }) => (isActive ? 'active' : '')}>
          <span className="ico"><Ic /></span>{nome}
        </NavLink>
      ))}
    </nav>
  );
});

export function Stats() {
  const { dados } = useProgresso();
  if (!dados) return null;
  const { vidas } = vidasAgora(dados.perfil);
  return (
    <div className="row stats gap-6">
      <span className="chip" title="Sequência de dias"><IcChama />{sequenciaAtual(dados.perfil)}</span>
      <span className="chip" title="Pontos de experiência"><IcRaio />{dados.perfil.xp_total.toLocaleString('pt-BR')}</span>
      <span className="chip" title="Vidas"><IcCoracao />{vidas}</span>
    </div>
  );
}

/** Abas das matérias (Início e Trilha). No computador, a rodinha do mouse rola a faixa de lado; a aba escolhida
 * fica sempre à vista. */
export function SeletorMaterias({ recortes, valor, mudar }: { recortes: Recorte[]; valor: string | undefined; mudar: (id: string) => void }) {
  const ref = useRef<HTMLDivElement>(null);
  useEffect(() => {
    const faixa = ref.current;
    if (!faixa) return;
    function rodinha(e: WheelEvent) {
      if (!faixa || Math.abs(e.deltaY) <= Math.abs(e.deltaX) || faixa.scrollWidth <= faixa.clientWidth) return;
      const antes = faixa.scrollLeft;
      faixa.scrollLeft += e.deltaY;
      if (faixa.scrollLeft !== antes) e.preventDefault(); // nas pontas, a rodinha volta a rolar a tela
    }
    faixa.addEventListener('wheel', rodinha, { passive: false });
    return () => faixa.removeEventListener('wheel', rodinha);
  }, []);
  useEffect(() => { // só de lado: scrollIntoView rolaria também a tela
    const faixa = ref.current;
    const aba = faixa?.querySelector<HTMLElement>('[aria-selected="true"]');
    if (!faixa || !aba) return;
    const f = faixa.getBoundingClientRect(), a = aba.getBoundingClientRect(), margem = 28;
    if (a.left < f.left + margem) faixa.scrollLeft -= f.left + margem - a.left;
    else if (a.right > f.right - margem) faixa.scrollLeft += a.right - (f.right - margem);
  }, [valor]);
  return (
    <div className="tabs" role="tablist" aria-label="Matérias" ref={ref}>
      {recortes.map((r) => {
        const c = corDe(r.cor); const on = r.id === valor;
        return <button key={r.id} role="tab" aria-selected={on} className="tab" onClick={() => mudar(r.id)} style={on ? { borderColor: c.forte, background: c.suave, color: c.forte } : undefined}><span className="dot" style={{ background: c.barra }} />{r.nome}</button>;
      })}
    </div>
  );
}

export function Anel({ pct, tam = 72, esp = 9, cor = '#2BA28F', trilho = 'var(--line2)', children }: { pct: number; tam?: number; esp?: number; cor?: string; trilho?: string; children?: ReactNode }) {
  const r = (tam - esp) / 2;
  const c = 2 * Math.PI * r;
  return (
    <div style={{ position: 'relative', width: tam, height: tam, flexShrink: 0 }}>
      <svg width={tam} height={tam} className="anel-svg" aria-hidden="true">
        <circle cx={tam / 2} cy={tam / 2} r={r} fill="none" stroke={trilho} strokeWidth={esp} />
        <circle cx={tam / 2} cy={tam / 2} r={r} fill="none" stroke={cor} strokeWidth={esp} strokeLinecap="round" strokeDasharray={c} strokeDashoffset={c * (1 - Math.min(1, Math.max(0, pct / 100)))} className="anel-progresso" />
      </svg>
      <div className="anel-centro">{children}</div>
    </div>
  );
}

const FOCAVEIS = 'button:not([disabled]), a[href], input:not([disabled]), select, textarea, [tabindex]:not([tabindex="-1"])';
const dialogosAbertos: object[] = []; // só o do topo responde ao teclado (ex.: anúncio aberto de dentro de uma folha)

/** Prende o foco dentro do elemento enquanto aberto, fecha com Esc e devolve o foco ao fechar. */
export function useDialogo(aberto: boolean, fechar: () => void) {
  const ref = useRef<HTMLDivElement>(null);
  const fecharRef = useRef(fechar);
  fecharRef.current = fechar;
  useEffect(() => {
    if (!aberto) return;
    const eu = {};
    dialogosAbertos.push(eu);
    const antes = document.activeElement as HTMLElement | null;
    const focaveis = () => [...(ref.current?.querySelectorAll<HTMLElement>(FOCAVEIS) ?? [])];
    (focaveis()[0] ?? ref.current)?.focus();
    function tecla(e: KeyboardEvent) {
      if (dialogosAbertos[dialogosAbertos.length - 1] !== eu) return;
      if (e.key === 'Escape') { e.preventDefault(); fecharRef.current(); return; }
      if (e.key !== 'Tab') return;
      const f = focaveis();
      if (!f.length) return;
      if (e.shiftKey && document.activeElement === f[0]) { e.preventDefault(); f[f.length - 1].focus(); }
      else if (!e.shiftKey && document.activeElement === f[f.length - 1]) { e.preventDefault(); f[0].focus(); }
    }
    document.addEventListener('keydown', tecla);
    return () => {
      document.removeEventListener('keydown', tecla);
      dialogosAbertos.splice(dialogosAbertos.indexOf(eu), 1);
      antes?.focus?.();
    };
  }, [aberto]);
  return ref;
}

export function Folha({ aberta, fechar, titulo, children }: { aberta: boolean; fechar: () => void; titulo: string; children: ReactNode }) {
  const ref = useDialogo(aberta, fechar);
  if (!aberta) return null;
  return (
    <>
      <div className="scrim" onClick={fechar} />
      <div className="sheet" role="dialog" aria-modal="true" aria-label={titulo} tabIndex={-1} ref={ref}>
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
  return <aside className="banner-demo" aria-label="Modo demonstração">Modo demonstração: o progresso fica só neste navegador. Configure o Supabase para contas reais.</aside>;
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
