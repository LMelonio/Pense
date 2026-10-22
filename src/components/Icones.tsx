// Ícones em SVG (traço 2.3, cantos arredondados) e o mascote do Pense.
import type { CSSProperties } from 'react';

type P = { size?: number; color?: string; className?: string; style?: CSSProperties };
const S = ({ size = 22, color = 'currentColor', className, style, children, fill = 'none', sw = 2.3 }: P & { children: React.ReactNode; fill?: string; sw?: number }) => (
  <svg width={size} height={size} viewBox="0 0 24 24" fill={fill} stroke={fill === 'none' ? color : 'none'} strokeWidth={sw} strokeLinecap="round" strokeLinejoin="round" aria-hidden="true" className={className} style={style}>{children}</svg>
);

export const IcHome = (p: P) => <S {...p}><path d="M3 11.5 12 4l9 7.5" /><path d="M5.5 10v9.5h13V10" /></S>;
export const IcTrilha = (p: P) => <S {...p}><circle cx="6" cy="18" r="2.5" /><circle cx="18" cy="6" r="2.5" /><path d="M8.5 18H15a3.5 3.5 0 0 0 0-7H9a3.5 3.5 0 0 1 0-7h6.5" /></S>;
export const IcRevisar = (p: P) => <S {...p}><path d="M21 12a9 9 0 1 1-3-6.7" /><path d="M21 4v5h-5" /></S>;
export const IcPerfil = (p: P) => <S {...p}><circle cx="12" cy="8" r="4" /><path d="M4 21a8 8 0 0 1 16 0" /></S>;
export const IcX = (p: P) => <S {...p} sw={2.6}><path d="M6 6l12 12M18 6 6 18" /></S>;
export const IcVoltar = (p: P) => <S {...p} sw={2.5}><path d="M15 5l-7 7 7 7" /></S>;
export const IcSeta = (p: P) => <S {...p} sw={2.4}><path d="M9 6l6 6-6 6" /></S>;
export const IcCheck = (p: P) => <S {...p} sw={3}><path d="M5 12.5l4.5 4.5L19 7.5" /></S>;
export const IcLock = (p: P) => <S {...p}><rect x="5" y="11" width="14" height="9" rx="2" /><path d="M8 11V8a4 4 0 0 1 8 0v3" /></S>;
export const IcLampada = (p: P) => <S {...p}><path d="M9 18h6M10 21h4" /><path d="M12 3a6 6 0 0 0-3.5 10.9c.6.5 1 1.2 1 2V16h5v-.1c0-.8.4-1.5 1-2A6 6 0 0 0 12 3z" /></S>;
export const IcEngrenagem = (p: P) => <S {...p} sw={2.1}><circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.7 1.7 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.7 1.7 0 0 0-1.8-.3 1.7 1.7 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1a1.7 1.7 0 0 0-1.1-1.5 1.7 1.7 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.7 1.7 0 0 0 .3-1.8 1.7 1.7 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1a1.7 1.7 0 0 0 1.5-1.1 1.7 1.7 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1a1.7 1.7 0 0 0 1.8.3H9a1.7 1.7 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.7 1.7 0 0 0 1 1.5 1.7 1.7 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.7 1.7 0 0 0-.3 1.8V9a1.7 1.7 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.7 1.7 0 0 0-1.5 1z" /></S>;
export const IcLivro = (p: P) => <S {...p}><path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v15H6.5A2.5 2.5 0 0 0 4 20.5z" /><path d="M4 20.5A2.5 2.5 0 0 1 6.5 18H20v3H6.5" /></S>;
export const IcEstrela = (p: P) => <S {...p} sw={2.4}><path d="M12 3l2.7 5.6 6.1.9-4.4 4.3 1 6.1L12 17l-5.4 2.9 1-6.1L3.2 9.5l6.1-.9z" /></S>;
export const IcTrofeu = (p: P) => <S {...p}><path d="M8 4h8v5a4 4 0 0 1-8 0zM8 6H4.5a3 3 0 0 0 3.5 4M16 6h3.5a3 3 0 0 1-3.5 4M12 13v4M8 20h8" /></S>;
export const IcSino = (p: P) => <S {...p}><path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9" /><path d="M10.3 21a1.9 1.9 0 0 0 3.4 0" /></S>;
export const IcAlvo = (p: P) => <S {...p}><circle cx="12" cy="12" r="9" /><circle cx="12" cy="12" r="5" /><circle cx="12" cy="12" r="1.5" /></S>;
export const IcGrupo = (p: P) => <S {...p}><circle cx="9" cy="8" r="3.5" /><path d="M2.5 20a6.5 6.5 0 0 1 13 0" /><path d="M16 4.5a3.5 3.5 0 0 1 0 7" /><path d="M18.5 14a6 6 0 0 1 3 6" /></S>;
export const IcCalendario = (p: P) => <S {...p}><path d="M4 6h16v14H4zM4 10h16M8 3v4M16 3v4" /></S>;
export const IcBroto = (p: P) => <S {...p}><path d="M12 21v-8M12 13c0-4 3-7 7-7 0 4-3 7-7 7zM12 15c0-3-2.5-5.5-6-5.5 0 3 2.5 5.5 6 5.5z" /></S>;
export const IcCoroa = ({ size = 22, fill = '#F2C14E', stroke = '#B8860B' }: { size?: number; fill?: string; stroke?: string }) => (
  <svg width={size} height={size * 0.85} viewBox="0 0 26 22" aria-hidden="true"><path d="M2 18 4 5l5.5 5L13 2l3.5 8L22 5l2 13z" fill={fill} stroke={stroke} strokeWidth="1.5" strokeLinejoin="round" /></svg>
);
export const IcChama = ({ size = 18 }: { size?: number }) => (
  <svg width={size} height={size} viewBox="0 0 24 24" aria-hidden="true"><path className="a-flame" d="M12 2c1 3.5 5 5.5 5 11a5 5 0 0 1-10 0c0-2.6 1.2-4.2 2.4-5.4.3 1.6 1 2.6 2 3.1C11 8.3 11.2 5 12 2z" fill="#F2A93B" /></svg>
);
export const IcRaio = ({ size = 16 }: { size?: number }) => (
  <svg width={size} height={size} viewBox="0 0 24 24" aria-hidden="true"><path d="M13 2 4 14h7l-1 8 9-12h-7z" fill="#6A5AE0" /></svg>
);
export const IcCoracao = ({ size = 16, cor = '#E5534B', bater = true }: { size?: number; cor?: string; bater?: boolean }) => (
  <svg width={size} height={size} viewBox="0 0 24 24" aria-hidden="true"><path className={bater ? 'a-beat' : undefined} d="M12 21s-7.5-4.6-9.6-9.2C.9 8.4 3 4.5 6.7 4.5c2.1 0 3.6 1.2 5.3 3.1 1.7-1.9 3.2-3.1 5.3-3.1 3.7 0 5.8 3.9 4.3 7.3C19.5 16.4 12 21 12 21z" fill={cor} /></svg>
);

export const CORES_COROA = [['#FFFFFF', '#B8C9C4'], ['#E4A774', '#A8673A'], ['#E3EAEE', '#8A9AA3'], ['#F2C14E', '#B8860B']];

/** Mascote "cérebro-nuvem". humor: feliz | comemorando | triste */
export function Mascote({ largura = 120, humor = 'feliz', flutuar = true, faisca = false }: { largura?: number; humor?: 'feliz' | 'comemorando' | 'triste'; flutuar?: boolean; faisca?: boolean }) {
  const boca = humor === 'comemorando' ? <path d="M70 96 q13 18 26 0 z" fill="#12302C" /> : humor === 'triste' ? <path d="M74 104 q9 -7 18 0" fill="none" stroke="#12302C" strokeWidth="3" strokeLinecap="round" /> : <path d="M74 99 q9 9 18 0" fill="none" stroke="#12302C" strokeWidth="3" strokeLinecap="round" />;
  return (
    <svg width={largura} height={largura * 0.875} viewBox="0 0 160 140" aria-hidden="true" className={flutuar ? (humor === 'comemorando' ? 'a-jump' : 'a-float') : undefined} style={{ flexShrink: 0 }}>
      <g fill="#7CCFC2"><circle cx="55" cy="70" r="38" /><circle cx="95" cy="60" r="40" /><circle cx="122" cy="86" r="30" /><circle cx="40" cy="96" r="28" /><circle cx="82" cy="100" r="34" /></g>
      <g fill="none" stroke="#2E9384" strokeWidth="3" strokeLinecap="round"><path d="M44 52 q10 -10 22 -2" /><path d="M96 38 q12 -4 18 8" /></g>
      {humor === 'comemorando'
        ? <g fill="none" stroke="#12302C" strokeWidth="4" strokeLinecap="round"><path d="M60 80 q8 -9 16 0" /><path d="M90 80 q8 -9 16 0" /></g>
        : <g className="a-blink"><ellipse cx="68" cy="80" rx="11" ry="12" fill="#fff" /><ellipse cx="98" cy="80" rx="11" ry="12" fill="#fff" /><circle cx="70" cy="82" r="5.5" fill="#12302C" /><circle cx="100" cy="82" r="5.5" fill="#12302C" /></g>}
      <circle cx="56" cy="98" r="5" fill="#F29A8E" opacity=".6" /><circle cx="112" cy="98" r="5" fill="#F29A8E" opacity=".6" />
      {boca}
      {faisca && <path d="M138 8 l4 10 l10 4 l-10 4 l-4 10 l-4 -10 l-10 -4 l10 -4 z" fill="#6A5AE0" />}
    </svg>
  );
}
