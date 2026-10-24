// Renderiza o texto das questões: Markdown + LaTeX (KaTeX) + figuras ({{figura:N}}) + citações ("Fonte:").
import { useMemo } from 'react';
import { marked } from 'marked';
import katex from 'katex';
import DOMPurify from 'dompurify';
import 'katex/dist/katex.min.css';
import type { Figura } from '../data/types';

// breaks: true → uma quebra simples vira quebra de linha (versos, letras de canção, linhas numeradas de texto-base).
// Parágrafo novo continua sendo linha em branco.
marked.setOptions({ gfm: true, breaks: true });

// O que o KaTeX gera (MathML e SVG) e as imagens das questões passam; scripts, eventos e links javascript: não.
const LIMPEZA = { USE_PROFILES: { html: true, svg: true, mathMl: true }, ADD_TAGS: ['semantics', 'annotation'], ADD_ATTR: ['loading', 'encoding'] };

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
  return DOMPurify.sanitize(html, LIMPEZA);
}

export function Texto({ md, figuras, className = 'texto-questao' }: { md: string | null | undefined; figuras?: Figura[]; className?: string }) {
  const html = useMemo(() => renderizar(md ?? '', figuras), [md, figuras]);
  // HTML já limpo pelo DOMPurify em renderizar (o conteúdo vem do banco, mas não confiamos nele às cegas).
  return <div className={className} dangerouslySetInnerHTML={{ __html: html }} />;
}

/** Figuras que não foram posicionadas no texto aparecem no fim. */
export function figurasSoltas(md: string | null, figuras: Figura[]) {
  const usadas = new Set([...(md ?? '').matchAll(/\{\{figura:(\d+)\}\}/g)].map((m) => Number(m[1])));
  return figuras.filter((_, i) => !usadas.has(i + 1));
}
