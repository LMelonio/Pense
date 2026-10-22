// Gera os arquivos SQL de carga das questões (supabase/seed/*.sql) a partir de public/data/conteudo.json.
// Uso: npm run gerar-sql   → depois cole cada arquivo no SQL Editor do Supabase, em ordem.
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';

const c = JSON.parse(readFileSync(new URL('../public/data/conteudo.json', import.meta.url), 'utf8'));
const q = (v) => (v === null || v === undefined ? 'null' : typeof v === 'number' || typeof v === 'boolean' ? String(v) : `'${String(v).replace(/'/g, "''")}'`);
const dir = new URL('../supabase/seed/', import.meta.url);
mkdirSync(dir, { recursive: true });

const linhasTB = Object.entries(c.textos_base).map(([id, texto]) => `(${q(id)}, 'enem', ${q(texto)})`);
writeFileSync(new URL('01_textos_base.sql', dir),
  `-- Textos-base compartilhados\ninsert into public.textos_base (id, exame_id, texto) values\n${linhasTB.join(',\n')}\non conflict (id) do update set texto = excluded.texto;\n`);

const porRecorte = {};
for (const x of c.questoes) (porRecorte[x.recorte_id] ??= []).push(x);
let n = 2;
for (const [rec, qs] of Object.entries(porRecorte)) {
  const cols = 'id, exame_id, recorte_id, banca, orgao, cargo, nivel, ano, numero, formato, disciplina, assunto, topico, lingua, texto_base_id, texto_apoio, comando, gabarito, dica1, dica2, explicacao, dificuldade';
  const vals = qs.map((x) => `(${[x.id, x.exame_id, x.recorte_id, x.banca, x.orgao, x.cargo, 'Médio', x.ano, x.numero, x.formato, x.disciplina, x.assunto, x.topico, x.lingua, x.texto_base_id, x.texto_apoio, x.comando, x.gabarito, x.dica1, x.dica2, x.explicacao, x.dificuldade].map(q).join(', ')})`);
  const alts = qs.flatMap((x) => x.alternativas.map((a) => `(${[x.id, a.letra, a.texto, a.imagem].map(q).join(', ')})`));
  const figs = qs.flatMap((x) => x.figuras.map((f, i) => `(${[x.id, i + 1, f.imagem, f.descricao].map(q).join(', ')})`));
  let sql = `-- Questões de ${rec} (${qs.length})\nbegin;\ninsert into public.questoes (${cols}) values\n${vals.join(',\n')}\non conflict (id) do update set ${cols.split(', ').slice(1).map((k) => `${k} = excluded.${k}`).join(', ')};\n`;
  sql += `delete from public.alternativas where questao_id in (${qs.map((x) => q(x.id)).join(', ')});\n`;
  sql += `insert into public.alternativas (questao_id, letra, texto, imagem) values\n${alts.join(',\n')};\n`;
  sql += `delete from public.questao_figuras where questao_id in (${qs.map((x) => q(x.id)).join(', ')});\n`;
  if (figs.length) sql += `insert into public.questao_figuras (questao_id, ordem, imagem, descricao) values\n${figs.join(',\n')};\n`;
  sql += 'commit;\n';
  const nome = `${String(n).padStart(2, '0')}_questoes_${rec.replace('enem-', 'enem_')}.sql`;
  writeFileSync(new URL(nome, dir), sql);
  console.log(nome, qs.length, 'questões', (sql.length / 1024).toFixed(0) + ' KB');
  n++;
}
