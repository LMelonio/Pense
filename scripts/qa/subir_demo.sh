#!/usr/bin/env bash
# Sobe o Pense em MODO DEMONSTRAÇÃO para a bateria de QA, sem tocar no Supabase de produção.
# As variáveis vazias valem mais que o .env (o Vite dá prioridade ao ambiente), então o app nem cria o cliente do banco.
# Gera um build de conferência (com a CSP e o service worker da versão publicada) em <app>/qa-saida/demo e o serve
# em http://127.0.0.1:<porta>/ em segundo plano.
#
# Uso:   bash scripts/qa/subir_demo.sh <pasta-do-app> <porta>      ex.: bash scripts/qa/subir_demo.sh . 5173
# Parar: kill "$(cat qa-saida/demo.pid)"
set -euo pipefail
APP="${1:-.}"
PORTA="${2:-5173}"
cd "$APP"
mkdir -p qa-saida

if [ -f qa-saida/demo.pid ] && kill -0 "$(cat qa-saida/demo.pid)" 2>/dev/null; then kill "$(cat qa-saida/demo.pid)" || true; fi

VITE_SUPABASE_URL= VITE_SUPABASE_ANON_KEY= node node_modules/vite/bin/vite.js build --outDir qa-saida/demo --emptyOutDir --logLevel warn

# Confere que é demonstração de verdade: o endereço de um projeto Supabase não pode estar no código gerado.
if grep -Eqs 'https://[a-z0-9]{20}\.supabase\.co' qa-saida/demo/assets/*.js; then
  echo "ERRO: o build de QA tem o endereço do Supabase. Confira as variáveis de ambiente." >&2
  exit 1
fi

node node_modules/vite/bin/vite.js preview --outDir qa-saida/demo --host 127.0.0.1 --port "$PORTA" --strictPort > qa-saida/demo.log 2>&1 &
echo $! > qa-saida/demo.pid

# Espera o servidor responder (até 30 s)
node -e '
  const url = process.argv[1];
  const fim = Date.now() + 30000;
  (async function tentar() {
    try { const r = await fetch(url); if (r.ok) { console.log("Pense (demonstração) em " + url); return; } } catch {}
    if (Date.now() > fim) { console.error("O servidor não respondeu: veja qa-saida/demo.log"); process.exit(1); }
    setTimeout(tentar, 300);
  })();
' "http://127.0.0.1:$PORTA/"
