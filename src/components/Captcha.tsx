// CAPTCHA do Cloudflare Turnstile na entrada. Só existe com VITE_TURNSTILE_SITE_KEY e o Supabase configurado (ligue
// também em Supabase › Authentication › Attack Protection); sem a chave, o app não carrega nada do Cloudflare.
// Cada token vale para uma tentativa: depois de cada envio, remonte o componente (key) para pedir outro.
import { useEffect, useRef, useState } from 'react';
import { supabaseConfigurado } from '../lib/config';

const CHAVE = import.meta.env.VITE_TURNSTILE_SITE_KEY as string | undefined;
export const captchaLigado = !!CHAVE && supabaseConfigurado;

interface Turnstile {
  render(el: HTMLElement, opcoes: Record<string, unknown>): string;
  remove(id: string): void;
}
declare global { interface Window { turnstile?: Turnstile } }

let script: Promise<Turnstile> | null = null;
function carregarTurnstile() {
  script ??= new Promise<Turnstile>((ok, falha) => {
    const s = document.createElement('script');
    s.src = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit';
    s.async = true;
    s.onload = () => (window.turnstile ? ok(window.turnstile) : falha(new Error('Turnstile indisponível')));
    s.onerror = () => { script = null; s.remove(); falha(new Error('Turnstile indisponível')); };
    document.head.appendChild(s);
  });
  return script;
}

/** Mostra a verificação e avisa o token (ou null, quando expira ou falha). Se o script não carregar (rede,
 * bloqueador), explica e oferece tentar de novo, em vez de deixar os botões desligados sem motivo. */
export function Captcha({ aoMudar }: { aoMudar: (token: string | null) => void }) {
  const ref = useRef<HTMLDivElement>(null);
  const aoMudarRef = useRef(aoMudar);
  aoMudarRef.current = aoMudar;
  const [falhou, setFalhou] = useState(false);
  const [tentativa, setTentativa] = useState(0);
  useEffect(() => {
    if (!captchaLigado) return;
    let id: string | null = null;
    let ativo = true;
    carregarTurnstile().then((t) => {
      if (!ativo || !ref.current) return;
      id = t.render(ref.current, {
        sitekey: CHAVE, language: 'pt-br', theme: document.documentElement.dataset.theme === 'dark' ? 'dark' : 'light',
        callback: (token: string) => aoMudarRef.current(token),
        'expired-callback': () => aoMudarRef.current(null),
        'error-callback': () => aoMudarRef.current(null)
      });
    }).catch(() => { if (ativo) { setFalhou(true); aoMudarRef.current(null); } });
    return () => { ativo = false; if (id) window.turnstile?.remove(id); };
  }, [tentativa]);
  if (!captchaLigado) return null;
  if (falhou) {
    return (
      <div className="captcha-falhou" role="alert">
        <p className="small">Não deu para carregar a verificação de segurança. Confira a internet e, se usar bloqueador de anúncios, libere este site.</p>
        <button type="button" className="linkbtn" onClick={() => { setFalhou(false); setTentativa((n) => n + 1); }}>Tentar de novo</button>
      </div>
    );
  }
  return <div ref={ref} className="captcha" />;
}
