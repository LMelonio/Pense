import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// base './' faz o app funcionar em qualquer caminho do GitHub Pages (usuario.github.io/repositorio/)
export default defineConfig({
  plugins: [react()],
  base: './',
  server: { port: 5173, open: true },
  build: {
    rollupOptions: {
      output: {
        manualChunks: {
          react: ['react', 'react-dom', 'react-router-dom'],
          supabase: ['@supabase/supabase-js'],
          texto: ['katex', 'marked']
        }
      }
    }
  }
});
