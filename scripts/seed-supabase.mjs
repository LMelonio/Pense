// Carrega as questões direto no Supabase usando a chave service_role (só no seu computador!).
// Uso: preencha VITE_SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY no .env.local e rode `npm run seed`.
import { readFileSync, existsSync } from 'node:fs';
import { createClient } from '@supabase/supabase-js';

for (const arq of ['.env.local', '.env']) {
  if (!existsSync(arq)) continue;
  for (const linha of readFileSync(arq, 'utf8').split(/\r?\n/)) {
    const m = linha.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
    if (m && !process.env[m[1]]) process.env[m[1]] = m[2].replace(/^['"]|['"]$/g, '');
  }
}
const url = process.env.VITE_SUPABASE_URL;
const chave = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !chave) {
  console.error('Defina VITE_SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY no .env.local');
  process.exit(1);
}
const sb = createClient(url, chave, { auth: { persistSession: false } });
const c = JSON.parse(readFileSync(new URL('../public/data/conteudo.json', import.meta.url), 'utf8'));

async function lote(tabela, linhas, conflito) {
  for (let i = 0; i < linhas.length; i += 200) {
    const { error } = await sb.from(tabela).upsert(linhas.slice(i, i + 200), { onConflict: conflito });
    if (error) throw new Error(`${tabela}: ${error.message}`);
  }
  console.log(`✓ ${tabela}: ${linhas.length}`);
}

await lote('textos_base', Object.entries(c.textos_base).map(([id, texto]) => ({ id, exame_id: 'enem', texto })), 'id');
await lote('questoes', c.questoes.map(({ alternativas, figuras, ...x }) => ({ ...x, nivel: 'Médio' })), 'id');
await lote('alternativas', c.questoes.flatMap((x) => x.alternativas.map((a) => ({ questao_id: x.id, ...a }))), 'questao_id,letra');
await lote('questao_figuras', c.questoes.flatMap((x) => x.figuras.map((f, i) => ({ questao_id: x.id, ordem: i + 1, ...f }))), 'questao_id,ordem');
console.log('Carga concluída.');
