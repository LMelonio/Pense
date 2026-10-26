// Roda DENTRO da página (agent-browser eval --stdin), na Lição ou no Refazer: escolhe a alternativa certa ou uma
// errada da questão na tela e toca em Verificar (ou Tentar de novo). O gabarito vem do conteúdo do próprio app
// (data/conteudo.json), pela questão marcada em [data-questao]. A jornada embrulha o script num bloco com o modo:
//   { const MODO = 'certo'; <este arquivo> }   // ou 'errado' (a primeira errada ainda disponível)
(async () => {
  const grupo = document.querySelector('[data-questao]');
  if (!grupo) throw new Error('Nenhuma questão na tela.');
  const id = grupo.getAttribute('data-questao');
  window.__penseConteudo ??= await (await fetch('./data/conteudo.json')).json();
  const q = window.__penseConteudo.questoes.find((x) => x.id === id);
  if (!q) throw new Error(`Questão ${id} não está no conteúdo.`);
  const letra = (b) => b.querySelector('.letra')?.textContent?.trim();
  const livres = [...grupo.querySelectorAll('button.alt:not([disabled])')];
  const alvo = MODO === 'certo' ? livres.find((b) => letra(b) === q.gabarito) : livres.find((b) => letra(b) !== q.gabarito);
  if (!alvo) throw new Error(`Sem alternativa ${MODO} disponível na questão ${id}.`);
  alvo.click();
  await new Promise((r) => setTimeout(r, 60));
  const botao = [...document.querySelectorAll('button')].find((b) => /^(Verificar|Tentar de novo)$/.test(b.textContent.trim()) && !b.disabled);
  if (!botao) throw new Error('Botão Verificar não encontrado.');
  botao.click();
  return `${id}: ${letra(alvo)} (${MODO})`;
})();
