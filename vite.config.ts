import { defineConfig, loadEnv } from 'vite';
import type { Plugin } from 'vite';
import react from '@vitejs/plugin-react';

// Política de segurança de conteúdo (CSP) no app publicado. Só no build: o servidor de desenvolvimento injeta
// scripts inline. Estilo inline é liberado porque o app e o KaTeX usam atributos style. As fontes vêm do próprio app.
// Com o CAPTCHA ligado (VITE_TURNSTILE_SITE_KEY), libera o script e o quadro do Cloudflare Turnstile.
// A mesma política vai numa <meta> (GitHub Pages) e no arquivo _headers (Cloudflare Pages e Netlify), que também
// impede o app de abrir dentro de iframes de outros sites (frame-ancestors só vale como cabeçalho).
function politicaDeSeguranca(turnstile: boolean): Plugin {
  const cloudflare = turnstile ? ' https://challenges.cloudflare.com' : '';
  const politica = [
    "default-src 'self'",
    `script-src 'self'${cloudflare}`,
    "style-src 'self' 'unsafe-inline'",
    "font-src 'self' data:",
    "img-src 'self' data: blob:",
    "connect-src 'self' https://*.supabase.co wss://*.supabase.co",
    ...(turnstile ? [`frame-src${cloudflare}`] : []),
    "worker-src 'self'",
    "manifest-src 'self'",
    "object-src 'none'",
    "base-uri 'self'",
    "form-action 'self'"
  ].join('; ');
  const cabecalhos = [
    '/*',
    `  Content-Security-Policy: ${politica}; frame-ancestors 'none'`,
    '  X-Frame-Options: DENY',
    '  X-Content-Type-Options: nosniff',
    '  Referrer-Policy: strict-origin-when-cross-origin',
    '  Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=()',
    '',
    // assets/ tem hash no nome (o conteúdo nunca muda): o navegador guarda por 1 ano. O resto revalida a cada visita.
    '/assets/*',
    '  Cache-Control: public, max-age=31536000, immutable',
    ''
  ].join('\n');
  return {
    name: 'pense-csp',
    apply: 'build',
    transformIndexHtml: (html) => html.replace('<meta charset="UTF-8" />', `<meta charset="UTF-8" />\n    <meta http-equiv="Content-Security-Policy" content="${politica}" />`),
    generateBundle() { this.emitFile({ type: 'asset', fileName: '_headers', source: cabecalhos }); }
  };
}

// No build do Cloudflare (WORKERS_CI), sem as variáveis do Supabase o app sairia em modo demonstração por cima do app
// de verdade, e com o endereço errado sairia sem banco. Melhor o build falhar: o app de antes continua no ar.
// No computador, o build sem .env continua gerando o modo demonstração.
function conferirSupabase(env: Record<string, string>) {
  const erros: string[] = [];
  const url = env.VITE_SUPABASE_URL ?? '';
  if (!/^https:\/\/[a-z0-9]+\.supabase\.co$/.test(url)) erros.push(`VITE_SUPABASE_URL deve ser https://<id-do-projeto>.supabase.co (veio "${url}")`);
  if (!/^(sb_publishable_|eyJ)/.test(env.VITE_SUPABASE_ANON_KEY ?? '')) erros.push('VITE_SUPABASE_ANON_KEY deve ser a chave publishable (sb_publishable_…) ou a anon legada (eyJ…)');
  if (erros.length) throw new Error(`Confira as variáveis do build no Cloudflare (Settings › Build › Variables and secrets):\n- ${erros.join('\n- ')}`);
}

// base './' faz o app funcionar na raiz do domínio (Cloudflare Pages) e numa subpasta (usuario.github.io/repositorio/)
export default defineConfig(({ command, mode }) => {
  const env = loadEnv(mode, process.cwd(), 'VITE_');
  if (command === 'build' && process.env.WORKERS_CI) conferirSupabase(env);
  return {
    plugins: [react(), politicaDeSeguranca(!!env.VITE_TURNSTILE_SITE_KEY)],
    base: './',
    server: { port: 5173, open: true },
    build: {
      rollupOptions: {
        output: {
          manualChunks: {
            react: ['react', 'react-dom', 'react-router-dom'],
            supabase: ['@supabase/supabase-js'],
            texto: ['katex', 'marked', 'dompurify']
          }
        }
      }
    }
  };
});
