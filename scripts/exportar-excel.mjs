// Gera a planilha de revisão (conteudo/Pense_Questoes.xlsx) a partir de public/data/conteudo.json.
// Uso: npm run exportar-excel   (ou: npm run exportar-excel -- outro/caminho.xlsx)
// A planilha volta para o app com: npm run importar-excel -- conteudo/Pense_Questoes.xlsx
import { readFileSync, mkdirSync } from 'node:fs';
import { dirname } from 'node:path';
import ExcelJS from 'exceljs';

const destino = process.argv.slice(2).find((a) => !a.startsWith('--')) ?? 'conteudo/Pense_Questoes.xlsx';
const c = JSON.parse(readFileSync(new URL('../public/data/conteudo.json', import.meta.url), 'utf8'));

const DISCIPLINA = {
  'enem-POR': 'Língua Portuguesa', 'enem-LIT': 'Literatura', 'enem-ING': 'Inglês', 'enem-ESP': 'Espanhol',
  'enem-ART': 'Artes', 'enem-EDF': 'Educação Física', 'enem-TIC': 'Tecnologias da Informação e Comunicação',
  'enem-HIS': 'História', 'enem-GEO': 'Geografia', 'enem-FIL': 'Filosofia', 'enem-SOC': 'Sociologia',
  'enem-BIO': 'Biologia', 'enem-QUI': 'Química', 'enem-FIS': 'Física', 'enem-MAT': 'Matemática'
};
const COR = { id: '44546A', prova: '2F5597', didatico: '548235', imagem: 'BF8F00', controle: '7030A0' };
const COLS = [
  ['acao', 'controle', 11], ['id', 'id', 20], ['ano', 'id', 7], ['aplicacao', 'id', 9], ['dia', 'id', 5], ['numero', 'id', 8],
  ['lingua', 'id', 10], ['recorte_id', 'id', 11], ['assunto', 'id', 28], ['topico', 'id', 30], ['dificuldade', 'id', 10],
  ['texto_base_id', 'prova', 18], ['texto_apoio', 'prova', 50], ['comando', 'prova', 45],
  ['alt_A', 'prova', 30], ['alt_B', 'prova', 30], ['alt_C', 'prova', 30], ['alt_D', 'prova', 30], ['alt_E', 'prova', 30], ['gabarito', 'prova', 9],
  ['dica1', 'didatico', 45], ['dica2', 'didatico', 45], ['explicacao', 'didatico', 60],
  ['fig1_imagem', 'imagem', 30], ['fig1_descricao', 'imagem', 40], ['fig2_imagem', 'imagem', 30], ['fig2_descricao', 'imagem', 40],
  ['fig3_imagem', 'imagem', 30], ['fig3_descricao', 'imagem', 40],
  ['alt_A_img', 'imagem', 28], ['alt_B_img', 'imagem', 28], ['alt_C_img', 'imagem', 28], ['alt_D_img', 'imagem', 28], ['alt_E_img', 'imagem', 28],
  ['obs_revisao', 'controle', 40]
];
const LIMITE = 3000; // linhas com validação
const col = Object.fromEntries(COLS.map(([n], i) => [n, i + 1]));
const letra = (n) => { let s = ''; for (let x = col[n]; x > 0; x = Math.floor((x - 1) / 26)) s = String.fromCharCode(65 + ((x - 1) % 26)) + s; return s; };
const fonte = { name: 'Arial', size: 10 };
const cabecalho = (ws, defs) => {
  ws.columns = defs.map(([h, , w]) => ({ header: h, key: h, width: w }));
  ws.getRow(1).eachCell((cel, i) => {
    cel.font = { ...fonte, bold: true, color: { argb: 'FFFFFFFF' } };
    cel.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FF' + COR[defs[i - 1][1]] } };
    cel.alignment = { horizontal: 'center', vertical: 'middle' };
  });
};
const lista = (ws, coluna, valores) => {
  for (let r = 2; r <= LIMITE; r++) ws.getCell(`${coluna}${r}`).dataValidation = { type: 'list', allowBlank: true, formulae: [valores], showErrorMessage: true, error: 'Escolha um valor da lista.' };
};

const wb = new ExcelJS.Workbook();

// LEIA-ME
const leia = wb.addWorksheet('LEIA-ME');
leia.getColumn(1).width = 150;
[
  ['Pense · Planilha de questões', 16],
  ['Gerada a partir de public/data/conteudo.json (npm run exportar-excel). Volta para o app com npm run importar-excel -- conteudo/Pense_Questoes.xlsx.'],
  ['acao: manter (sem mudança), alterar (corrigida), nova (questão nova), excluir (sai do app; no banco fica ativa = false e o histórico dos alunos é preservado).'],
  ['Nunca mude o id de uma questão existente. As regras de texto, dicas e explicação estão em conteudo/PROMPT_PENSE.md.'],
  ['Cores dos cabeçalhos: cinza = identificação · azul = texto da prova · verde = dicas e explicação · amarelo-escuro = imagens · roxo = controle.']
].forEach(([t, tam], i) => { const cel = leia.getCell(i + 1, 1); cel.value = t; cel.font = { ...fonte, size: tam ?? 10, bold: !!tam }; cel.alignment = { wrapText: true }; });

// Questoes
const wq = wb.addWorksheet('Questoes', { views: [{ state: 'frozen', xSplit: 2, ySplit: 1 }] });
cabecalho(wq, COLS);
for (const q of c.questoes) {
  const v = {
    acao: 'manter', id: q.id, ano: q.ano, aplicacao: q.orgao === '2ª aplicação' ? 2 : 1, dia: Number(q.id.match(/-D(\d)-/)[1]),
    numero: q.numero, lingua: q.lingua, recorte_id: q.recorte_id, assunto: q.assunto, topico: q.topico, dificuldade: q.dificuldade,
    texto_base_id: q.texto_base_id, texto_apoio: q.texto_apoio || null, comando: q.comando, gabarito: q.gabarito,
    dica1: q.dica1, dica2: q.dica2, explicacao: q.explicacao
  };
  for (const a of q.alternativas) { v[`alt_${a.letra}`] = a.texto; v[`alt_${a.letra}_img`] = a.imagem; }
  q.figuras.forEach((f, i) => { v[`fig${i + 1}_imagem`] = f.imagem; v[`fig${i + 1}_descricao`] = f.descricao; });
  const row = wq.addRow(Object.fromEntries(Object.entries(v).filter(([, x]) => x !== null && x !== undefined && x !== '')));
  row.font = fonte;
  row.alignment = { vertical: 'top' };
}
wq.autoFilter = { from: 'A1', to: { row: 1, column: COLS.length } };
lista(wq, letra('acao'), '"manter,alterar,nova,excluir"');
lista(wq, letra('aplicacao'), '"1,2"');
lista(wq, letra('dia'), '"1,2"');
lista(wq, letra('lingua'), '"Inglês,Espanhol"');
lista(wq, letra('dificuldade'), '"fácil,média,difícil"');
lista(wq, letra('gabarito'), '"A,B,C,D,E"');
lista(wq, letra('recorte_id'), `"${Object.keys(DISCIPLINA).join(',')}"`);
const [A, Ap, D, N, L, G, R, S] = ['ano', 'aplicacao', 'dia', 'numero', 'lingua', 'gabarito', 'recorte_id', 'assunto'].map((n) => `$${letra(n)}2`);
const esperado = `${A}&IF(${Ap}=2,"-A2","")&"-D"&${D}&"-Q"&TEXT(${N},"000")&IF(${L}="Inglês","-ING",IF(${L}="Espanhol","-ESP",""))`;
const vermelho = { type: 'pattern', pattern: 'solid', bgColor: { argb: 'FFF8CBAD' } };
const laranja = { type: 'pattern', pattern: 'solid', bgColor: { argb: 'FFFFE699' } };
wq.addConditionalFormatting({ ref: `B2:B${LIMITE}`, rules: [{ type: 'expression', formulae: [`AND($B2<>"",$B2<>${esperado})`], style: { fill: vermelho } }] });
wq.addConditionalFormatting({ ref: `${letra('gabarito')}2:${letra('gabarito')}${LIMITE}`, rules: [{ type: 'expression', formulae: [`AND($B2<>"",OR(${G}="",ISERROR(FIND(${G},"ABCDE"))))`], style: { fill: vermelho } }] });
wq.addConditionalFormatting({ ref: `${letra('assunto')}2:${letra('assunto')}${LIMITE}`, rules: [{ type: 'expression', formulae: [`AND(${S}<>"",COUNTIFS(Materias_Assuntos!$A:$A,${R},Materias_Assuntos!$F:$F,${S})=0)`], style: { fill: laranja } }] });

// Textos_base
const wt = wb.addWorksheet('Textos_base', { views: [{ state: 'frozen', xSplit: 2, ySplit: 1 }] });
cabecalho(wt, [['acao', 'controle', 11], ['id', 'id', 22], ['texto', 'prova', 120]]);
for (const [id, texto] of Object.entries(c.textos_base)) wt.addRow({ acao: 'manter', id, texto }).font = fonte;
lista(wt, 'A', '"manter,alterar,nova,excluir"');

// Materias_Assuntos
const wm = wb.addWorksheet('Materias_Assuntos', { views: [{ state: 'frozen', ySplit: 1 }] });
cabecalho(wm, [['recorte_id', 'id', 12], ['sigla', 'id', 7], ['materia', 'id', 16], ['disciplina', 'id', 36], ['area', 'id', 12], ['assunto', 'id', 38], ['questoes', 'id', 10]]);
for (const r of [...c.recortes].sort((a, b) => a.ordem - b.ordem)) {
  const conta = new Map();
  for (const q of c.questoes) if (q.recorte_id === r.id) conta.set(q.assunto, (conta.get(q.assunto) ?? 0) + 1);
  for (const [assunto, n] of [...conta].sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))) {
    wm.addRow({ recorte_id: r.id, sigla: r.sigla, materia: r.nome, disciplina: DISCIPLINA[r.id], area: r.area, assunto, questoes: n }).font = fonte;
  }
}

mkdirSync(dirname(destino), { recursive: true });
await wb.xlsx.writeFile(destino);
console.log(`✓ ${destino}: ${c.questoes.length} questões, ${Object.keys(c.textos_base).length} textos-base.`);
