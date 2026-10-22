// Renderiza o texto das questões: Markdown + LaTeX (KaTeX) + figuras ({{figura:N}}) + citações ("Fonte:").
import { useMemo } from 'react';
import { marked } from 'marked';
import katex from 'katex';
import 'katex/dist/katex.min.css';
import type { Figura } from '../data/types';

marked.setOptions({ gfm: true, breaks: false });

const esc = (s: string) => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

export function renderizar(md: string, figuras: Figura[] = []) {
  const formulas: string[] = [];
  const guardar = (tex: string, display: boolean) => {
    try { formulas.push(katex.renderToString(tex, { displayMode: display, throwOnError: false, strict: 'ignore' })); }
    catch { formulas.push(esc(tex)); }
    return `@@F${formulas.length - 1}@@`;
  };
  let s = md.replace(/\\\$/g, '@@DOLAR@@');
  s = s.replace(/\$\$([\s\S]+?)\$\$/g, (_, t) => guardar(t, true));
  s = s.replace(/\$([^$\n]+?)\$/g, (_, t) => guardar(t, false));
  s = s.replace(/\{\{figura:(\d+)\}\}/g, (_, n) => {
    const f = figuras[Number(n) - 1];
    return f ? `\n\n<img src="./${esc(f.imagem)}" alt="${esc(f.descricao)}" loading="lazy">\n\n` : '';
  });
  let html = marked.parse(s, { async: false }) as string;
  html = html.replace(/@@F(\d+)@@/g, (_, i) => formulas[Number(i)]).replace(/@@DOLAR@@/g, '$');
  html = html.replace(/<p>Fonte:/g, '<p class="fonte">Fonte:');
  return html;
}

export function Texto({ md, figuras, className = 'texto-questao' }: { md: string | null | undefined; figuras?: Figura[]; className?: string }) {
  const html = useMemo(() => renderizar(md ?? '', figuras), [md, figuras]);
  // Conteúdo vem do banco curado (não de usuários); ainda assim só aceitamos o que o marked gera.
  return <div className={className} dangerouslySetInnerHTML={{ __html: html }} />;
}

/** Figuras que não foram posicionadas no texto aparecem no fim. */
export function figurasSoltas(md: string | null, figuras: Figura[]) {
  const usadas = new Set([...(md ?? '').matchAll(/\{\{figura:(\d+)\}\}/g)].map((m) => Number(m[1])));
  return figuras.filter((_, i) => !usadas.has(i + 1));
}
