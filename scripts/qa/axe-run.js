// Junta a auditoria do axe de uma tela no relatório da bateria.
// A jornada roda `agent-browser --json a11y` (o axe-core vem embutido no agent-browser) e passa o resultado aqui.
// Uso: node scripts/qa/axe-run.js <nome-da-tela> <resultado-a11y.json> <axe.json>
// Em axe.json fica, por tela, cada violação com a regra, o impacto, a ajuda e os elementos que falharam.
import { existsSync, readFileSync, writeFileSync } from 'node:fs';

const [nome, entrada, relatorio] = process.argv.slice(2);
if (!nome || !entrada || !relatorio) {
  console.error('Uso: node scripts/qa/axe-run.js <nome-da-tela> <resultado-a11y.json> <axe.json>');
  process.exit(2);
}

const bruto = JSON.parse(readFileSync(entrada, 'utf8'));
if (!bruto.success) throw new Error(`a11y falhou na tela ${nome}: ${JSON.stringify(bruto.error)}`);
const violacoes = (bruto.data.violations ?? []).map((v) => ({
  regra: v.id, impacto: v.impact, ajuda: v.help, url: v.helpUrl,
  elementos: (v.nodes ?? []).map((n) => ({ alvo: n.target, html: n.html, resumo: n.failureSummary }))
}));

const todas = existsSync(relatorio) ? JSON.parse(readFileSync(relatorio, 'utf8')) : [];
todas.push({ tela: nome, url: bruto.data.url, violacoes });
writeFileSync(relatorio, JSON.stringify(todas, null, 2));
console.log(`  axe ${nome}: ${violacoes.length ? violacoes.map((v) => `${v.regra} (${v.elementos.length})`).join(', ') : 'sem violações'}`);
