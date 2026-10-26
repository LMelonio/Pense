// Folha com as capturas da bateria, para conferir de uma vez. Com --antes, põe cada tela antes × depois, marca em
// vermelho os pixels que mudaram e calcula quanto mudou (útil para refatorar estilos sem mudar a aparência).
// As contas de pixels rodam no Chrome do agent-browser (sem depender de Python ou de bibliotecas de imagem).
//
// Uso: node scripts/qa/montagem.mjs <pasta> [--antes <pasta-de-antes>]
//      ex.: node scripts/qa/montagem.mjs qa-saida --antes qa-saida-antes
// Saída: <pasta>/montagem.png (folha) e, com --antes, <pasta>/diferencas.json (% de pixels diferentes por tela).
// O agent-browser vem do PATH ou da variável AGENT_BROWSER.
import { execSync } from 'node:child_process';
import { existsSync, readFileSync, readdirSync, writeFileSync } from 'node:fs';
import path from 'node:path';
import { pathToFileURL } from 'node:url';

const args = process.argv.slice(2);
const pasta = args.find((a, i) => !a.startsWith('--') && args[i - 1] !== '--antes');
const antes = args.includes('--antes') ? args[args.indexOf('--antes') + 1] : null;
if (!pasta) {
  console.error('Uso: node scripts/qa/montagem.mjs <pasta> [--antes <pasta-de-antes>]');
  process.exit(2);
}

const capturas = (p) => (existsSync(path.join(p, 'telas')) ? readdirSync(path.join(p, 'telas')).filter((f) => f.endsWith('.png')).sort() : []);
const dataUrl = (arquivo) => `data:image/png;base64,${readFileSync(arquivo).toString('base64')}`;
const telas = capturas(pasta);
if (!telas.length) { console.error(`Nenhuma captura em ${pasta}/telas`); process.exit(1); }
const itens = telas.map((f) => ({
  nome: f.replace(/\.png$/, ''),
  depois: dataUrl(path.join(pasta, 'telas', f)),
  antes: antes && existsSync(path.join(antes, 'telas', f)) ? dataUrl(path.join(antes, 'telas', f)) : null
}));

const html = `<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Pense · montagem</title>
<style>
  body { margin: 0; padding: 20px; background: #EEF4F2; font: 14px system-ui, sans-serif; color: #12302C; }
  h1 { font-size: 18px; margin: 0 0 16px; }
  .grade { display: grid; grid-template-columns: repeat(${antes ? 2 : 5}, max-content); gap: 18px; }
  .tela { background: #fff; border-radius: 12px; padding: 10px; }
  .tela b { display: block; margin-bottom: 6px; }
  .tela .linha { display: flex; gap: 8px; align-items: flex-start; }
  img, canvas { width: ${antes ? 200 : 230}px; height: auto; border: 1px solid #D3E2DE; border-radius: 6px; display: block; }
  .pct { font-weight: 600; } .zero { color: #1C7A52; } .mudou { color: #A3302A; }
</style>
<h1>Pense · ${itens.length} capturas${antes ? ' · antes × depois (vermelho = pixel diferente)' : ''}</h1>
<div class="grade" id="grade"></div>
<script>
  const itens = ${JSON.stringify(itens)};
  const comparar = ${antes ? 'true' : 'false'};
  const carregar = (src) => new Promise((ok, falha) => { const i = new Image(); i.onload = () => ok(i); i.onerror = falha; i.src = src; });
  (async () => {
    const resultado = [];
    for (const it of itens) {
      const caixa = document.createElement('div'); caixa.className = 'tela';
      const titulo = document.createElement('b'); titulo.textContent = it.nome; caixa.append(titulo);
      const linha = document.createElement('div'); linha.className = 'linha'; caixa.append(linha);
      const depois = await carregar(it.depois);
      if (comparar && it.antes) {
        const a = await carregar(it.antes);
        const w = Math.max(a.width, depois.width), h = Math.max(a.height, depois.height);
        const ler = (img) => { const c = new OffscreenCanvas(w, h); const x = c.getContext('2d'); x.drawImage(img, 0, 0); return x.getImageData(0, 0, w, h).data; };
        const pa = ler(a), pd = ler(depois);
        const dif = document.createElement('canvas'); dif.width = w; dif.height = h;
        const cx = dif.getContext('2d'); cx.drawImage(depois, 0, 0); cx.fillStyle = 'rgba(255,255,255,.7)'; cx.fillRect(0, 0, w, h);
        const marca = cx.getImageData(0, 0, w, h);
        let diferentes = 0;
        for (let p = 0; p < pa.length; p += 4) {
          if (Math.abs(pa[p] - pd[p]) + Math.abs(pa[p + 1] - pd[p + 1]) + Math.abs(pa[p + 2] - pd[p + 2]) > 24) {
            diferentes++; marca.data[p] = 229; marca.data[p + 1] = 83; marca.data[p + 2] = 75; marca.data[p + 3] = 255;
          }
        }
        cx.putImageData(marca, 0, 0);
        const pct = (100 * diferentes) / (w * h);
        resultado.push({ tela: it.nome, pixels: diferentes, pct: Number(pct.toFixed(3)), tamanhoIgual: a.width === depois.width && a.height === depois.height });
        linha.append(a, depois, dif);
        const r = document.createElement('span'); r.className = 'pct ' + (diferentes ? 'mudou' : 'zero');
        r.textContent = diferentes ? pct.toFixed(2) + '% dos pixels mudaram' : 'igual'; caixa.append(r);
      } else {
        linha.append(depois);
        if (comparar) resultado.push({ tela: it.nome, pixels: null, pct: null, nova: true });
      }
      document.getElementById('grade').append(caixa);
    }
    window.__resultado = resultado;
    document.body.dataset.pronto = '1';
  })();
</script></html>`;

const arquivoHtml = path.resolve(pasta, 'montagem.html');
writeFileSync(arquivoHtml, html);

const AB = process.env.AGENT_BROWSER || 'agent-browser';
const sessao = process.env.AGENT_BROWSER_SESSION || 'pense-montagem';
const ab = (comando) => execSync(`"${AB}" --session ${sessao} ${comando}`, { encoding: 'utf8', stdio: ['ignore', 'pipe', 'inherit'] });
try {
  ab(`open "${pathToFileURL(arquivoHtml).href}"`);
  ab('set viewport 1400 900');
  ab('wait --fn "document.body.dataset.pronto === \'1\'"');
  ab(`screenshot --full "${path.resolve(pasta, 'montagem.png')}"`);
  if (antes) {
    const resultado = JSON.parse(ab('eval "window.__resultado"')); // o eval devolve o valor em JSON
    writeFileSync(path.resolve(pasta, 'diferencas.json'), JSON.stringify(resultado, null, 2));
    for (const r of resultado) console.log(`${r.tela.padEnd(24)} ${r.nova ? 'nova' : r.pixels ? `${r.pct}% diferente${r.tamanhoIgual ? '' : ' (tamanho mudou)'}` : 'igual'}`);
    const max = Math.max(0, ...resultado.map((r) => r.pct ?? 0));
    console.log(`\nMaior diferença: ${max}%`);
  }
  console.log(`Folha: ${path.resolve(pasta, 'montagem.png')}`);
} finally {
  try { ab('close'); } catch { /* já fechado */ }
}
