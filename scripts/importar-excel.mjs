// Importa a planilha-mestre de questões (ou um JSON de linhas no mesmo formato) para public/data/conteudo.json.
// Uso:
//   npm run importar-excel -- conteudo/Pense_Questoes.xlsx           → valida e grava
//   npm run importar-excel -- conteudo/Pense_Questoes.xlsx --conferir → só valida (não grava nada)
//   npm run importar-excel -- novas_2023_D1.json                      → linhas em JSON (mesmas colunas da aba Questoes)
// Regras: a planilha é mesclada ao conteudo.json pelo id. acao = excluir tira a questão do JSON e entra no SQL de
// desativação (supabase/seed/99_ativar_desativar.sql), que preserva o histórico dos alunos. Depois rode `npm run gerar-sql`.
import { readFileSync, writeFileSync, existsSync } from 'node:fs';
import { resolve } from 'node:path';
import ExcelJS from 'exceljs';

const args = process.argv.slice(2);
const so_conferir = args.includes('--conferir');
const arquivo = args.find((a) => !a.startsWith('--')) ?? 'conteudo/Pense_Questoes.xlsx';
if (!existsSync(arquivo)) { console.error(`Arquivo não encontrado: ${arquivo}`); process.exit(1); }

const raiz = new URL('../', import.meta.url);
const caminhoJson = new URL('public/data/conteudo.json', raiz);
const conteudo = JSON.parse(readFileSync(caminhoJson, 'utf8'));

const DISCIPLINA = {
  'enem-POR': 'Língua Portuguesa', 'enem-LIT': 'Literatura', 'enem-ING': 'Inglês', 'enem-ESP': 'Espanhol',
  'enem-ART': 'Artes', 'enem-EDF': 'Educação Física', 'enem-TIC': 'Tecnologias da Informação e Comunicação',
  'enem-HIS': 'História', 'enem-GEO': 'Geografia', 'enem-FIL': 'Filosofia', 'enem-SOC': 'Sociologia',
  'enem-BIO': 'Biologia', 'enem-QUI': 'Química', 'enem-FIS': 'Física', 'enem-MAT': 'Matemática'
};
const ACOES = ['manter', 'alterar', 'nova', 'excluir'];
const LETRAS = ['A', 'B', 'C', 'D', 'E'];

// ---------- leitura

/** Valor de célula do exceljs como texto (ou null). Mantém o texto como está, só troca \r\n por \n. */
function texto(v) {
  if (v === null || v === undefined) return null;
  if (typeof v === 'object') {
    if (v.richText) v = v.richText.map((p) => p.text).join('');
    else if ('result' in v) v = v.result;
    else if ('text' in v) v = v.text;
    else if (v instanceof Date) v = v.toISOString().slice(0, 10);
    else v = String(v);
  }
  if (v === null || v === undefined) return null;
  const s = String(v).replace(/\r\n?/g, '\n');
  return s.trim() === '' ? null : s;
}
const id_ = (v) => texto(v)?.trim() ?? null;
const inteiro = (v) => { const s = id_(v); return s === null ? null : Number.parseInt(s, 10); };

async function lerPlanilha(arq) {
  const wb = new ExcelJS.Workbook();
  await wb.xlsx.readFile(arq);
  const aba = (nome) => {
    const ws = wb.getWorksheet(nome);
    if (!ws) return [];
    const cab = [];
    ws.getRow(1).eachCell({ includeEmpty: false }, (c, n) => { cab[n] = id_(c.value); });
    const linhas = [];
    ws.eachRow({ includeEmpty: false }, (row, n) => {
      if (n === 1) return;
      const o = { _linha: n };
      cab.forEach((h, i) => { if (h) o[h] = row.getCell(i).value; });
      linhas.push(o);
    });
    return linhas;
  };
  return { questoes: aba('Questoes'), textos: aba('Textos_base'), materias: aba('Materias_Assuntos') };
}

let entrada;
if (arquivo.toLowerCase().endsWith('.json')) {
  const j = JSON.parse(readFileSync(arquivo, 'utf8'));
  const qs = Array.isArray(j) ? j : j.questoes ?? [];
  entrada = { questoes: qs.map((o, i) => ({ _linha: i + 1, ...o })), textos: (j.textos_base ?? []).map((o, i) => ({ _linha: i + 1, ...o })), materias: [] };
} else {
  entrada = await lerPlanilha(arquivo);
}

// ---------- validação

const erros = [];
const avisos = [];
const onde = (l, id) => `linha ${l._linha}${id ? ` (${id})` : ''}`;

const assuntosValidos = new Set(entrada.materias.map((m) => `${id_(m.recorte_id)}|${id_(m.assunto)}`));
if (!assuntosValidos.size) for (const q of conteudo.questoes) assuntosValidos.add(`${q.recorte_id}|${q.assunto}`);

// textos-base
const textos = { ...conteudo.textos_base };
const textosExcluidos = [];
for (const l of entrada.textos) {
  const id = id_(l.id); const acao = id_(l.acao) ?? 'manter';
  if (!id) continue;
  if (!ACOES.includes(acao)) { erros.push(`Textos_base ${onde(l, id)}: acao "${acao}" inválida.`); continue; }
  if (acao === 'excluir') { delete textos[id]; textosExcluidos.push(id); continue; }
  const t = texto(l.texto);
  if (!t) { erros.push(`Textos_base ${onde(l, id)}: texto vazio.`); continue; }
  if (acao === 'nova' && conteudo.textos_base[id]) erros.push(`Textos_base ${onde(l, id)}: acao = nova, mas o id já existe.`);
  textos[id] = t;
}

const existentes = new Map(conteudo.questoes.map((q) => [q.id, q]));
const vistos = new Set();
const novas = new Map();
const excluir = [];
const cont = { nova: 0, alterar: 0, manter: 0, excluir: 0, mudou: 0 };

function idEsperado(ano, aplic, dia, numero, lingua) {
  const suf = lingua === 'Inglês' ? '-ING' : lingua === 'Espanhol' ? '-ESP' : '';
  return `${ano}${aplic === 2 ? '-A2' : ''}-D${dia}-Q${String(numero).padStart(3, '0')}${suf}`;
}

/** Cifrões sem barra que abrem fórmula: "R$ 5" vira LaTeX quebrado. */
function confereDolar(campo, s, ctx) {
  if (!s) return;
  if (/(^|[^\\\w])R\$\s*\d/.test(s)) erros.push(`${ctx}: ${campo} tem "R$" sem barra. Escreva R\\$ (senão vira fórmula).`);
  const soltos = (s.replace(/\\\$/g, '').match(/\$/g) ?? []).length;
  if (soltos % 2) erros.push(`${ctx}: ${campo} tem um $ sem par (fórmula LaTeX aberta).`);
}

for (const l of entrada.questoes) {
  const id = id_(l.id);
  const acao = id_(l.acao) ?? (id && existentes.has(id) ? 'manter' : 'nova');
  if (!id && !id_(l.comando)) continue; // linha vazia
  const ctx = `Questoes ${onde(l, id)}`;
  if (!id) { erros.push(`${ctx}: sem id.`); continue; }
  if (vistos.has(id)) { erros.push(`${ctx}: id repetido na planilha.`); continue; }
  vistos.add(id);
  if (!ACOES.includes(acao)) { erros.push(`${ctx}: acao "${acao}" inválida (use ${ACOES.join(', ')}).`); continue; }
  if (acao === 'excluir') { if (existentes.has(id)) excluir.push(id); cont.excluir++; continue; }
  if (acao === 'nova' && existentes.has(id)) { erros.push(`${ctx}: acao = nova, mas a questão já existe no app. Use alterar.`); continue; }
  if (acao !== 'nova' && !existentes.has(id)) { erros.push(`${ctx}: acao = ${acao}, mas o id não existe no app. Use nova.`); continue; }
  cont[acao]++;

  const ano = inteiro(l.ano), aplic = inteiro(l.aplicacao) ?? 1, dia = inteiro(l.dia), numero = inteiro(l.numero);
  const lingua = id_(l.lingua), recorte = id_(l.recorte_id), assunto = id_(l.assunto);
  const gabarito = id_(l.gabarito)?.toUpperCase() ?? null;
  const dificuldade = id_(l.dificuldade);
  const tb = id_(l.texto_base_id);

  if (!ano || ano < 1998 || ano > 2100) erros.push(`${ctx}: ano inválido.`);
  if (![1, 2].includes(aplic)) erros.push(`${ctx}: aplicacao deve ser 1 ou 2.`);
  if (![1, 2].includes(dia)) erros.push(`${ctx}: dia deve ser 1 ou 2.`);
  if (!numero || numero < 1 || numero > 180) erros.push(`${ctx}: numero inválido.`);
  else if (dia === 1 && numero > 90 || dia === 2 && numero <= 90) erros.push(`${ctx}: número ${numero} não é do dia ${dia} (dia 1 = 1–90, dia 2 = 91–180).`);
  if (lingua && !['Inglês', 'Espanhol'].includes(lingua)) erros.push(`${ctx}: lingua deve ser Inglês, Espanhol ou vazio.`);
  if (dia === 1 && numero <= 5 && !lingua) erros.push(`${ctx}: questões 1 a 5 do dia 1 são de língua estrangeira; preencha lingua.`);
  if (lingua && !(dia === 1 && numero <= 5)) erros.push(`${ctx}: só as questões 1 a 5 do dia 1 têm lingua.`);
  if (lingua === 'Inglês' && recorte !== 'enem-ING' || lingua === 'Espanhol' && recorte !== 'enem-ESP') erros.push(`${ctx}: questão de ${lingua} deve ter recorte_id ${lingua === 'Inglês' ? 'enem-ING' : 'enem-ESP'}.`);
  if (!DISCIPLINA[recorte]) erros.push(`${ctx}: recorte_id "${recorte}" inválido.`);
  if (!assunto) erros.push(`${ctx}: assunto vazio.`);
  else if (!assuntosValidos.has(`${recorte}|${assunto}`)) avisos.push(`${ctx}: assunto novo "${assunto}" em ${recorte} (vira um tema novo na trilha).`);
  if (ano && dia && numero) {
    const esp = idEsperado(ano, aplic, dia, numero, lingua);
    if (esp !== id) erros.push(`${ctx}: id deveria ser ${esp}.`);
  }
  if (!['A', 'B', 'C', 'D', 'E'].includes(gabarito)) erros.push(`${ctx}: gabarito deve ser A, B, C, D ou E.`);
  if (dificuldade && !['fácil', 'média', 'difícil'].includes(dificuldade)) erros.push(`${ctx}: dificuldade deve ser fácil, média ou difícil.`);
  if (!dificuldade) (acao === 'nova' ? erros : avisos).push(`${ctx}: sem dificuldade.`);
  if (tb && !textos[tb]) erros.push(`${ctx}: texto_base_id "${tb}" não existe na aba Textos_base.`);

  const comando = texto(l.comando);
  if (!comando) erros.push(`${ctx}: comando vazio.`);
  const textoApoio = texto(l.texto_apoio) ?? '';

  const figuras = [];
  for (let i = 1; i <= 9; i++) {
    const img = id_(l[`fig${i}_imagem`]); const desc = texto(l[`fig${i}_descricao`]);
    if (!img && !desc) continue;
    if (!img) { erros.push(`${ctx}: fig${i}_descricao sem fig${i}_imagem.`); continue; }
    if (!desc) erros.push(`${ctx}: fig${i}_imagem sem descrição (acessibilidade).`);
    if (figuras.length !== i - 1) erros.push(`${ctx}: figuras devem ser numeradas sem buracos (fig1, fig2…).`);
    figuras.push({ imagem: img, descricao: desc ?? '' });
  }
  for (const m of textoApoio.matchAll(/\{\{figura:(\d+)\}\}/g)) if (!figuras[Number(m[1]) - 1]) erros.push(`${ctx}: texto_apoio cita {{figura:${m[1]}}}, mas não há fig${m[1]}_imagem.`);

  const alternativas = LETRAS.map((letra) => ({ letra, texto: texto(l[`alt_${letra}`]), imagem: id_(l[`alt_${letra}_img`]) }));
  for (const a of alternativas) if (!a.texto && !a.imagem) erros.push(`${ctx}: alternativa ${a.letra} vazia.`);

  const dica1 = texto(l.dica1), dica2 = texto(l.dica2), explicacao = texto(l.explicacao);
  for (const [k, v] of [['dica1', dica1], ['dica2', dica2], ['explicacao', explicacao]]) if (!v) (acao === 'nova' ? erros : avisos).push(`${ctx}: ${k} vazia.`);
  if (explicacao && gabarito && !new RegExp(`\\b${gabarito}\\b`).test(explicacao)) avisos.push(`${ctx}: a explicação não cita a letra ${gabarito}.`);
  for (const [k, v] of [['texto_apoio', textoApoio], ['comando', comando], ['dica1', dica1], ['dica2', dica2], ['explicacao', explicacao], ...alternativas.map((a) => [`alt_${a.letra}`, a.texto])]) confereDolar(k, v, ctx);

  for (const img of [...figuras.map((f) => f.imagem), ...alternativas.map((a) => a.imagem).filter(Boolean)]) {
    if (!/^imagens\/[\w-]+\/D[12]\/[\w.-]+\.(webp|png|jpg|svg)$/.test(img)) avisos.push(`${ctx}: caminho de imagem fora do padrão: ${img}`);
    if (!existsSync(new URL(`public/${img}`, raiz))) avisos.push(`${ctx}: imagem não encontrada em public/${img}`);
  }

  const q = {
    id, exame_id: 'enem', recorte_id: recorte, banca: 'INEP', orgao: aplic === 2 ? '2ª aplicação' : null, cargo: null,
    ano, numero, formato: '5_alternativas', disciplina: DISCIPLINA[recorte] ?? null, assunto, topico: texto(l.topico),
    lingua: lingua ?? null, texto_base_id: tb, texto_apoio: textoApoio, comando, figuras, alternativas, gabarito,
    dica1, dica2, explicacao, dificuldade: dificuldade ?? null
  };
  if (existentes.has(id) && JSON.stringify(existentes.get(id)) !== JSON.stringify(q)) cont.mudou++;
  novas.set(id, q);
}

// Questões do app que não estão na planilha continuam como estão.
const fora = conteudo.questoes.filter((q) => !vistos.has(q.id));
if (fora.length && !arquivo.toLowerCase().endsWith('.json')) avisos.push(`${fora.length} questões do app não aparecem na planilha e foram mantidas sem mudança (ex.: ${fora.slice(0, 3).map((q) => q.id).join(', ')}).`);
for (const id of textosExcluidos) {
  const usam = [...novas.values(), ...fora].filter((q) => q.texto_base_id === id).map((q) => q.id);
  if (usam.length) erros.push(`Textos_base: "${id}" foi excluído, mas ainda é usado por ${usam.join(', ')}.`);
}

// ---------- relatório

console.log(`\nPlanilha: ${resolve(arquivo)}`);
console.log(`Questões: ${cont.nova} novas · ${cont.alterar} marcadas como alterar · ${cont.manter} manter · ${cont.excluir} excluir · ${cont.mudou} existentes com texto diferente do app`);
if (avisos.length) { console.log(`\nAvisos (${avisos.length}):`); avisos.slice(0, 200).forEach((a) => console.log('  · ' + a)); if (avisos.length > 200) console.log(`  … e mais ${avisos.length - 200}`); }
if (erros.length) {
  console.log(`\nErros (${erros.length}) — nada foi gravado:`); erros.slice(0, 300).forEach((e) => console.log('  ✗ ' + e));
  process.exit(1);
}
if (so_conferir) { console.log('\nSem erros. Modo --conferir: nada foi gravado.'); process.exit(0); }

// ---------- gravação

const ordemLingua = { 'Inglês': 0, 'Espanhol': 1 };
const chave = (q) => [q.ano, q.orgao ? 1 : 0, q.numero > 5 || !q.lingua ? 1 : 0, ordemLingua[q.lingua] ?? 2, q.numero];
const cmp = (a, b) => { const x = chave(a), y = chave(b); for (let i = 0; i < x.length; i++) if (x[i] !== y[i]) return x[i] - y[i]; return 0; };
const questoes = [...fora, ...novas.values()].sort(cmp);

const usados = new Set(questoes.map((q) => q.texto_base_id).filter(Boolean));
for (const id of Object.keys(textos)) if (!usados.has(id)) avisos.push(`Texto-base sem questão: ${id}`);

const saida = { versao: new Date().toLocaleDateString('en-CA'), exames: conteudo.exames, recortes: conteudo.recortes, textos_base: textos, questoes };
writeFileSync(caminhoJson, JSON.stringify(saida));

const lista = (ids) => ids.map((i) => `'${i.replace(/'/g, "''")}'`).join(', ');
// O banco espelha o JSON: fica ativa só a questão que está no conteudo.json (as excluídas saem da lição, mas o
// histórico dos alunos continua no banco).
let sql = '-- Gerado por npm run importar-excel. Rode depois dos arquivos 01 a 16.\n';
if (excluir.length) sql += `-- Excluídas nesta importação: ${excluir.join(', ')}\n`;
sql += `update public.questoes set ativa = (id in (${lista(questoes.map((q) => q.id))})) where exame_id = 'enem';\n`;
writeFileSync(new URL('supabase/seed/99_ativar_desativar.sql', raiz), sql);

console.log(`\n✓ public/data/conteudo.json: ${questoes.length} questões, ${Object.keys(textos).length} textos-base.`);
console.log(`✓ supabase/seed/99_ativar_desativar.sql (${excluir.length} desativadas).`);
console.log('Próximo passo: npm run gerar-sql (arquivos do SQL Editor) ou npm run seed (carga direta).');
