#!/usr/bin/env bash
# Jornada de QA no modo demonstração: um aluno novo percorre o app (entrada, lição com acerto e erro, resultado,
# trilha, revisão com dica, perfil, configurações, modo noturno, sem vidas e tela de 320 px). Tira 19 capturas, roda
# o axe em cada tela e guarda o console e a rede.
#
# Uso:   bash scripts/qa/jornada.sh <url> <pasta-de-saída>    ex.: bash scripts/qa/jornada.sh http://127.0.0.1:5173/ qa-saida
# Antes: bash scripts/qa/subir_demo.sh . 5173
# Requer o agent-browser 0.39 ou mais novo (usa a11y, set media e wait --fn): npm i -g agent-browser && agent-browser install.
# Para usar o Chrome já instalado:
#   export AGENT_BROWSER_EXECUTABLE_PATH="C:/Program Files/Google/Chrome/Application/chrome.exe"
# Saída: <pasta>/telas/NN-nome.png, axe.json, console.txt, rede.txt e um resumo (sai com 1 se houver problema).
set -euo pipefail
URL="${1:?Uso: bash scripts/qa/jornada.sh <url> <pasta-de-saída>}"
SAIDA="${2:-qa-saida}"
QA="$(cd "$(dirname "$0")" && pwd)"
AB="${AGENT_BROWSER:-agent-browser}"
export AGENT_BROWSER_SESSION="${AGENT_BROWSER_SESSION:-pense-qa}"

mkdir -p "$SAIDA/telas"
rm -f "$SAIDA"/telas/*.png "$SAIDA/axe.json"
abs() { node -e 'console.log(require("path").resolve(process.argv[1]))' "$1"; } # caminho absoluto no formato do sistema
SAIDA_ABS="$(abs "$SAIDA")"

ab() { "$AB" "$@" > /dev/null; }
js() { "$AB" eval "$1" | tr -d '"\r'; }                                       # valor de uma expressão na página
rota() { ab wait --fn "location.hash.startsWith('#$1')"; }                    # espera a rota
clicar() { js "(() => { const el = [...document.querySelectorAll('button, a')].find((e) => e.textContent.trim() === '$1' && !e.disabled); if (!el) throw new Error('Não achei: $1'); el.click(); return 1; })()" > /dev/null; }
existe() { [ "$(js "[...document.querySelectorAll('button, a')].some((e) => e.textContent.trim() === '$1' && !e.disabled)")" = "true" ]; }
responder() { { echo "{ const MODO = '$1';"; cat "$QA/responder.js"; echo '}'; } | "$AB" eval --stdin > /dev/null; } # um bloco por chamada
feedback() { ab wait --fn "!!document.querySelector('.feedback')"; }
seguir() { js "(document.querySelector('.feedback .btn:not(.lav)').click(), 1)" > /dev/null; } # Continuar, Entendi, Ver resultado
tela() {                                                                       # captura e roda o axe na tela
  ab wait 350
  ab screenshot "$SAIDA_ABS/telas/$1.png"
  "$AB" --json a11y > "$SAIDA/.a11y.json"
  node "$QA/axe-run.js" "$1" "$SAIDA/.a11y.json" "$SAIDA/axe.json"
}

"$AB" close > /dev/null 2>&1 || true # navegador novo, sem dados de outra rodada
printf 'Math.random = () => 0;\n' > "$SAIDA/.deterministico.js" # a mesma lição em toda rodada (comparação antes × depois)
ab open --init-script "$(abs "$SAIDA/.deterministico.js")"
ab set viewport 390 844
ab set media light reduced-motion

echo "1. Entrada e primeiro acesso"
ab open "$URL"
ab wait --text "Entrar sem login"
tela 01-entrar
clicar "Entrar sem login"
ab wait --text "Vamos montar o seu ritmo de estudo"
tela 02-primeiro-acesso
clicar "Começar a estudar"
rota /inicio
ab wait --text "Escolha o tema"
tela 03-inicio

echo "2. Lição: acerto, erro (a tela rola até a certa) e resultado"
js "(document.querySelector('main button.list-row').click(), 1)" > /dev/null
ab wait --text "XP possível"
tela 04-folha-tema
clicar "Começar"
rota /licao
ab wait --text "Verificar"
tela 05-licao
responder certo; feedback; seguir
responder errado; feedback
tela 06-licao-erro
seguir
for modo in certo errado certo; do responder "$modo"; feedback; seguir; done
rota /resultado
tela 07-resultado

echo "3. Trilha e revisão com dica"
clicar "Continuar"; rota /inicio
clicar "Trilha"; rota /trilha
tela 08-trilha
clicar "Revisar"; rota /revisar
tela 09-revisar
if existe "Adiantar revisão"; then clicar "Adiantar revisão"; else clicar "Revisar agora"; fi
rota /refazer
ab wait --fn "!!document.querySelector('[data-questao]')"
tela 10-refazer
clicar "Abrir"
ab wait --fn "!!document.querySelector('section[aria-label=Dicas] .a-rise')"
js "(document.querySelector('section[aria-label=Dicas]').scrollIntoView({ block: 'start' }), 1)" > /dev/null
tela 11-refazer-dica
responder certo
ab wait --fn "!!document.querySelector('main [role=status]')"
tela 12-refazer-questao
while existe "Próxima questão"; do
  clicar "Próxima questão"
  responder errado; responder errado
done
clicar "Concluir revisão"
ab wait --text "Revisão feita!"
tela 13-refazer-fim

echo "4. Perfil, configurações e modo noturno"
clicar "Continuar"; rota /revisar
clicar "Perfil"; rota /perfil
tela 14-perfil
js "(document.querySelector('a[aria-label=\"Configurações\"]').click(), 1)" > /dev/null; rota /config
tela 15-config
clicar "Noturno"
ab wait --fn "document.documentElement.dataset.theme === 'dark'"
js "(document.querySelector('a[aria-label=\"Voltar para o perfil\"]').click(), 1)" > /dev/null; rota /perfil
clicar "Início"; rota /inicio
tela 16-inicio-escuro

echo "5. Lição no escuro até as vidas acabarem"
js "(document.querySelector('a.proximo').click(), 1)" > /dev/null
rota /licao
ab wait --text "Verificar"
tela 17-licao-escuro
for _ in 1 2 3 4 5; do # sem vidas (ou na última questão), o botão vira "Ver resultado"
  responder errado; feedback
  [ "$(js "document.querySelector('.feedback .btn:not(.lav)').textContent.trim()")" = "Ver resultado" ] && break
  seguir
done
seguir
rota /resultado
tela 18-sem-vidas

echo "6. Tela estreita (320 px)"
clicar "Continuar"; rota /inicio
ab set viewport 320 640
tela 19-inicio-320

"$AB" console > "$SAIDA/console.txt" 2>&1 || true
"$AB" errors >> "$SAIDA/console.txt" 2>&1 || true
"$AB" --json network requests > "$SAIDA/.rede.json"
ab close

# Resumo: capturas, violações do axe, erros no console e chamadas a outros domínios
node - "$SAIDA" "$URL" <<'EOF'
const fs = require('fs'), path = require('path');
const [saida, url] = process.argv.slice(2);
const telas = fs.readdirSync(path.join(saida, 'telas')).filter((f) => f.endsWith('.png'));
const axe = JSON.parse(fs.readFileSync(path.join(saida, 'axe.json'), 'utf8'));
const violacoes = axe.reduce((s, t) => s + t.violacoes.length, 0);
const consoleTxt = fs.readFileSync(path.join(saida, 'console.txt'), 'utf8');
const erros = consoleTxt.split('\n').filter((l) => /^\[(error|pageerror)\]|^\s*Error|Uncaught/i.test(l));
const rede = JSON.parse(fs.readFileSync(path.join(saida, '.rede.json'), 'utf8')).data?.requests ?? [];
const origem = new URL(url).origin;
const externas = [...new Set(rede.map((r) => r.url).filter((u) => /^https?:/.test(u) && new URL(u).origin !== origem))];
fs.writeFileSync(path.join(saida, 'rede.txt'), [`${rede.length} requisições; outros domínios: ${externas.length}`, ...externas].join('\n') + '\n');
console.log(`\nResumo: ${telas.length} capturas · axe: ${violacoes} violações · console: ${erros.length} erros · outros domínios: ${externas.length}`);
if (erros.length) console.log(erros.join('\n'));
if (externas.length) console.log(externas.join('\n'));
process.exit(telas.length === 19 && !violacoes && !erros.length && !externas.length ? 0 : 1);
EOF
