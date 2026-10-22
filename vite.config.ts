import { defineConfig } from 'vite';
import type { Plugin } from 'vite';
import react from '@vitejs/plugin-react';

// Política de segurança de conteúdo (CSP) no app publicado. Só no build: o servidor de desenvolvimento injeta
// scripts inline. Estilo inline é liberado porque o app e o KaTeX usam atributos style.
function politicaDeSeguranca(): Plugin {
  const politica = [
    "default-src 'self'",
    "script-src 'self'",
    "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com",
    "font-src 'self' data: https://fonts.gstatic.com",
    "img-src 'self' data: blob:",
    "connect-src 'self' https://*.supabase.co wss://*.supabase.co",
    "worker-src 'self'",
    "manifest-src 'self'",
    "object-src 'none'",
    "base-uri 'self'",
    "form-action 'self'"
  ].join('; ');
  return {
    name: 'pense-csp',
    apply: 'build',
    transformIndexHtml: (html) => html.replace('<meta charset="UTF-8" />', `<meta charset="UTF-8" />\n    <meta http-equiv="Content-Security-Policy" content="${politica}" />`)
  };
}

// base './' faz o app funcionar em qualquer caminho do GitHub Pages (usuario.github.io/repositorio/)
export default defineConfig({
  plugins: [react(), politicaDeSeguranca()],
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
});
