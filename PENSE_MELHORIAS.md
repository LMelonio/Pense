# Pense · plano de melhorias (compilado de 26/10/2026)

> Este arquivo reúne **todas** as melhorias levantadas para o app Pense: avaliação de UX e design, bateria de QA com agent-browser, auditoria de acessibilidade e revisão de arquitetura (*deep modules*).
> Foi escrito para ser seguido dentro do VS Code, por você ou por um agente (Copilot, Claude Code etc.), **na ordem das fases**.
> Base: repositório `lmelonio/Pense`, commit `52626d7`, mais as alterações locais que existiam em 26/10/2026.

---

## Como usar

1. Abra o repositório do Pense no VS Code e deixe este arquivo na raiz (ex.: `PENSE_MELHORIAS.md`).
2. Siga as **fases em ordem**. Cada tarefa tem um código (ex.: `F1-03`), os arquivos envolvidos, os passos e os critérios de aceite.
3. Marque `[x]` ao concluir. Ao fim de cada fase, rode a **verificação** dela.
4. Para usar com um agente, mande, por exemplo: *"Leia PENSE_MELHORIAS.md e execute a tarefa F2-01, respeitando as Regras de ouro. Ao fim, rode a verificação da fase."*

## Regras de ouro (valem para todas as tarefas)

- **Nunca leia, imprima nem faça commit do `.env`.** Para testar, rode em **modo demonstração**. Com as variáveis vazias, o Vite ignora o `.env` e o app não toca o Supabase de produção:
  `VITE_SUPABASE_URL= VITE_SUPABASE_ANON_KEY= npm run dev` (ou `bash scripts/qa/subir_demo.sh . 5173`).
- **Toda regra de jogo existe em dois lugares**: `src/domain/regras.ts` e `src/domain/sessoes.ts` (app) **e** as funções do banco em `supabase/migrations/` (servidor).
  - Mude os dois juntos, sempre com uma **migration nova** (nunca edite migration já aplicada).
  - Confirme com `npm test`: o teste de paridade compara app e banco.
- **Não apague questões nem histórico.** Para tirar uma questão do ar, use `ativa = false`.
- **Preserve a identidade visual**: teal `#237A70`, mascote "cérebro-nuvem", Fredoka/Lexend e botões com borda "3D". Refine, não redesenhe.
- **Contraste AA (4,5:1) nos dois temas** (claro e noturno). Texto colorido no escuro usa os tokens `--primary-ink`, `--lav-ink` e `--rc-*`.
- **Público inclui menores (ECA Digital)**: sem publicidade por perfil, sem caixas de recompensa e sem chamadas a terceiros desnecessárias.
- **Nada de `npm run build` com o `.env` para servir localmente.** O build embute o banco real.

## Visão geral

| Fase | O que é | Situação |
|---|---|---|
| **F0** | Aplicar as melhorias já prontas (patches) | **Feito** em 26/10/2026, à mão (os patches não estavam disponíveis), já na forma da F3 |
| **F1** | Ajustes de UX e texto que não mexem em regra de jogo | **Feito** (F1-01 a F1-10) |
| **F2** | Regras da revisão e das vidas (app + banco, migration `0009`) | **Feito**, com as decisões abaixo; falta rodar a `0009` no Supabase antes de publicar |
| **F3** | Arquitetura: módulos mais profundos e menos duplicação | **Feito** (F3-01 a F3-06) |
| **F4** | Publicação aberta: e-mail, CAPTCHA, hospedagem, termos | Código pronto (F4-02 widget, F4-03 textos, F4-04 `_headers`); o resto é configuração fora do código |

> **Registro de 26/10/2026**
>
> - **Decisões da F2:** F2-01 = A, e a revisão adiantada também não dá XP (é treino, fechando o laço de XP do "Adiantar revisão"); F2-02 = A (só questão vencida, 1 vida por dia, e só quando falta vida); F2-05 = A (a 1ª lição não gasta vida); F2-06 = sim (a 2ª tentativa conta como uma dica a mais no XP).
> - **Ordem:** a F0-02 foi feita direto na forma final da F3 (`useSessaoEstudo` sem o parâmetro `fechar`, `demoRepo` como servidor simulado, tempo injetável, tipos em `types.ts`), para as regras da F2 nascerem com a suíte de contrato. A F3-05 ficou por último, com a interface estável.
> - **Bateria de QA:** usa o agent-browser também para o axe (embutido) e para a folha antes × depois, que virou `scripts/qa/montagem.mjs` (Node) no lugar do `montagem.py`, porque esta máquina não tem Python.
> - **Verificação final:** typecheck, 77 testes, build de conferência e bateria com 19 telas sem violações do axe (claro e escuro), sem erros no console e sem chamadas a outros domínios.
> - **Decisões depois da revisão 3 (migration `0010`):** a 1ª lição grátis vale só até a primeira resposta (sair no meio não deixa a próxima grátis); acertar só na 2ª tentativa não domina (volta em 3 dias, como com dica); na primeira vez sem vidas e sem nada vencido, a revisão adiantada devolve 1 vida (sem XP, uma vez só). Os três casos estão na paridade (e falham no banco sem a `0010`).
> - **Revisão 3 (C1–C9):** o `pense-correcoes-revisao.patch` não veio junto; as correções foram refeitas à mão a partir do `PENSE_REVISAO_3.md`: CAPTCHA recomeça ao trocar de formulário (C1); "Sem vidas" oferece **Revisar agora** quando há vencidas e a vida do dia já veio, e só oferece **Adiantar** sem nada vencido (C2); aviso e **Tentar de novo** quando o Turnstile não carrega (C3); tela **Atualizar o app** para erro de tela, recarga automática (1 vez por minuto) quando falta um pedaço do app depois de publicar e service worker v3, que não entrega HTML no lugar de script (C4); Refazer filtrado vazio leva a **Ver a revisão** (C5); só a alternativa riscada fica riscada, não o rótulo "sua tentativa" (C6); treino "volta amanhã, valendo" (C7); `QUESTOES_POR_REVISAO = 10` em `regras.ts` (Refazer, Revisar e Trilha; C8); faixa "Modo demonstração" (C9). Também: região "Resta 1 tentativa" sempre montada, `useMemo` da Revisar, CSS sem classes mortas, termos e privacidade com o tema do app (`public/tema.js`) e o Cloudflare Turnstile na lista de operadores da privacidade.

---

## F0 · Aplicar o que já está pronto

As rodadas de 26/10 já implementaram e testaram as melhorias abaixo. Use **um** destes caminhos:

- `pense-completo.patch` (as duas rodadas, sobre o código original): `git apply pense-completo.patch`
- `pense-melhorias.patch` + `pense-refatoracao.patch` (em sequência)
- ou copie a pasta `pense-app-alterados/` por cima do repositório.

Depois:

```bash
npm install                                                   # fontes @fontsource, vitest, @types/node
npm run typecheck
npm install --no-save @electric-sql/pglite@0.2.17 && npm test  # 22 testes, incluindo a paridade app × banco
```

### F0-01 · UX e design (rodada 1)

- [x] **Cartão "próximo passo" no Início.** Leva à lição com um toque, na cor da matéria e com o mascote. Ordem de prioridade:
  1. revisão vencida;
  2. sem vidas com erros guardados → "Revise N erros e recupere 1 vida";
  3. próximo tema da Trilha, ou o desafio da unidade.

  Arquivos: `src/domain/regras.ts` (`proximoPasso`), `src/screens/Inicio.tsx` e `.proximo` no CSS.
- [x] **Sem vidas: revisar vira o caminho principal.**
  - **Resultado:** o botão principal é "Revisar os erros agora".
  - **`SemVidas`** (folha do tema e Trilha) oferece "Revisar N erros e recuperar 1 vida".
  - **Textos:** sempre com a condição "acertando pelo menos 1".
- [x] **Resposta errada:** a tela rola até a alternativa certa, que fica visível acima do painel de explicação (`Licao.tsx`).
- [x] **Refazer:**
  - "Nada vence hoje" + **Adiantar revisão**, em vez de "Nada para revisar" quando há erros guardados;
  - a tela remonta quando a busca muda (`key={search}`);
  - o resultado de cada questão rola até a área visível.
- [x] **Modo noturno com contraste AA:** tokens `--primary-ink`, `--lav-ink`, `--ouro/prata/bronze-ink` e `--rc-*`. O teal dos botões fica `#237A70` (5,1:1). `CORES_RECORTE` passa a ter `forte` (texto, muda no escuro) e `fundo` (cor sólida sob texto branco).
- [x] **Fontes servidas pelo app** (`@fontsource/fredoka` e `@fontsource/lexend` em `main.tsx`). Saem os links do Google Fonts no `index.html` e da CSP no `vite.config.ts`.
- [x] **Acessibilidade:**
  - `<main>` em todas as telas;
  - `h1` no Início e `h1.sr-only` na Lição e na Revisão;
  - aviso do modo demonstração como `<aside>`.
- [x] **Computador:**
  - a faixa de matérias rola com a rodinha do mouse, com as bordas esmaecidas;
  - a página não ganha barra de rolagem.
- [x] **Limpeza:**
  - sai a sigla "POR" repetida nas linhas de tema;
  - sai o cartão vazio "Nada vencido hoje";
  - a folha do tema mostra a matéria do tema, não a da aba aberta.
- [x] **Bateria de QA versionada** em `scripts/qa/`: `subir_demo.sh`, `jornada.sh`, `montagem.py`, `responder.js` e `axe-run.js`.

### F0-02 · Arquitetura (rodada 2)

- [x] **`src/state/useSessaoEstudo.ts`.** Ciclo de vida da sessão: abrir no primeiro uso, fila em ordem, reenvio e fechamento. Usado pela Lição e pelo Refazer.
- [x] **`src/domain/sessoes.ts`.** `fecharLicao`, `fecharRevisao`, `registrarErro` e `registrarRevisao` como funções puras, com o mesmo cálculo de `concluir_sessao`.
- [x] **`Mudancas` reduzido a `nome`, `prefs` e `interessePro`.** O parâmetro de `atualizar` ficou opcional; as outras 7 chaves eram ignoradas pelos dois adaptadores.
- [x] **`src/domain/catalogo.ts`** (índice por id) e cache em `temasDoRecorte`.
- [x] **`<SeletorMaterias>`**, `chaveUnidade()` e `unidadeAtual()`, no lugar de código repetido.
- [x] **`React.lazy`** para Lição e Refazer: o JS inicial cai de cerca de 251 para 144 kB gzip.
- [x] **Testes:**
  - `src/domain/regras.test.ts` (19 testes) e `src/domain/paridade.test.ts` (3 testes, app × banco via PGlite);
  - `npm test` entra no `.github/workflows/testes.yml`;
  - `tsconfig.test.json` para os tipos dos testes.

> Se não puder aplicar o patch, o **Anexo A** traz o código completo dos três módulos novos e o **Anexo B** lista as mudanças por arquivo.

**Verificação da F0:**

```bash
npm run typecheck && npm test
bash scripts/qa/subir_demo.sh . 5173
bash scripts/qa/jornada.sh http://127.0.0.1:5173/ qa-saida
# esperado: 19 capturas em qa-saida/telas, axe.json sem violações, console.txt sem erros
```

---

## F1 · Ajustes de UX e texto (sem mudar regra de jogo)

### F1-01 · Refazer: dizer quantas tentativas restam

- **Por quê:** depois do 1º erro, a alternativa fica riscada, mas o app não diz que resta 1 tentativa.
- **Arquivo:** `src/screens/Refazer.tsx`.
- **Passos:** quando `erradas.length === 1` e a questão não terminou, mostre uma linha curta acima do botão: "Resta 1 tentativa. Se quiser, abra uma dica." O botão já muda para "Tentar de novo"; mantenha.
- **Aceite:** a mensagem aparece só entre a 1ª e a 2ª tentativa e some ao terminar a questão.

### F1-02 · Refazer: painel de dicas depois que a questão termina

- **Por quê:** "Precisa de uma ajuda? +0 XP" continua visível com a questão encerrada.
- **Passos:** com `terminou === true`:
  - troque o cabeçalho do painel por "Dicas desta questão";
  - esconda o "+N XP";
  - deixe todas as dicas abertas para leitura.
- **Aceite:** depois de terminar, nenhum texto fala em "reduz o XP".

### F1-03 · Refazer: rótulo "sua resposta antes"

- **Por quê:** o rótulo usa `ultima_letra` da fila e não acompanha as tentativas feitas na própria revisão.
- **Passos:** em `rotuloAntes`, ignore a letra se ela já estiver em `erradas`, como hoje, **e** também se a questão terminou. Depois de tentar de novo, mostre "sua tentativa" na letra atual riscada.
- **Aceite:** nunca aparecem dois rótulos ao mesmo tempo, e o rótulo não aponta para uma letra que o aluno já trocou.

### F1-04 · Revisão rápida da Trilha só com erros da unidade

- **Por quê:** o botão "Revisar" do nó "Revisão rápida" abre `/refazer?todas=1`, que traz erros de **todas** as matérias.
- **Arquivo:** `src/screens/Trilha.tsx` (folha do nó `revisao`). Hoje: `nav('/refazer?todas=1')`.
- **Passos:** leve a matéria e os temas da unidade, por exemplo `/refazer?todas=1&recorte=<id>&temas=<t1>|<t2>…`. Em `Refazer.tsx`, aceite `temas` (lista separada por `|`) além de `tema`.
- **Aceite:** com erros em Português e Matemática, a revisão rápida da unidade 1 de Português só traz questões dos 6 temas dessa unidade.

### F1-05 · Um nome só para a mesma ação

- **Por quê:** a mesma ação aparece com 8 nomes: Revisar, Revisão do dia, Revisão rápida, Começar revisão, Adiantar revisão, revanche, refazer, Ver.
- **Passos:** padronize assim:
  - **Revisar** é a aba e o verbo dos botões ("Revisar agora", "Revisar os 3 erros");
  - **Adiantar revisão** só quando nada venceu;
  - **Revisão rápida** só na Trilha;
  - os botões não usam "revanche", que fica só no título da aba Revisar;
  - nenhum botão diz só "Ver" ou "N min".
- **Aceite:** um `grep` por `>Ver<` e por botões só com tempo (`min</`) não acha nada nos botões de revisão.

### F1-06 · Título da unidade na Trilha

- **Por quê:** o título "Gêneros textuais e mais" é vago.
- **Arquivo:** `src/screens/Trilha.tsx`, `{temas[0]?.assunto}{temas.length > 1 ? ' e mais' : ''}`.
- **Passos:** use o tema atual. O título vira "Agora: <tema do nó atual>". Com todos feitos: "Desafio liberado" ou "Unidade concluída".
- **Aceite:** o título muda conforme o aluno avança.

### F1-07 · Saudação em telas estreitas (320 px)

- **Por quê:** em 320 px o nome vira "O…".
- **Arquivos:** `src/screens/Inicio.tsx` (cabeçalho) e `.chip` no CSS.
- **Passos:** abaixo de 360 px:
  - esconda o "Oi," e mostre só o nome;
  - reduza o `padding` dos chips para 6 px;
  - ou mova os chips para uma 2ª linha.
- **Aceite:** em 320×640 o primeiro nome aparece inteiro (até 10 letras).

### F1-08 · "XP possível" honesto

- **Por quê:** a folha do tema e o cartão mostram "+50 XP", mas a lição perfeita dá 55 (bônus de 5).
- **Arquivo:** `src/screens/Inicio.tsx` (`QUESTOES_POR_LICAO * XP_ACERTO`, em 2 lugares).
- **Passos:** use `QUESTOES_POR_LICAO * XP_ACERTO + BONUS_PERFEITA` e escreva "até 55 XP".
- **Aceite:** o número bate com o Resultado de uma lição perfeita.

### F1-09 · Folha sem vidas: sem repetição

- **Por quê:** a folha do tema mostra o bloco "3 vidas" (ou "0 vidas") e, logo abaixo, os corações vazios do `SemVidas`.
- **Passos:** com `vidas === 0`, esconda a grade "+XP / questões / vidas" da folha e mostre só o `SemVidas`.
- **Aceite:** as vidas aparecem uma vez só na folha.

### F1-10 · Termos de uso e Política de privacidade como links

- **Arquivo:** `src/screens/Entrar.tsx`. Hoje: `<p>Ao continuar, você concorda com os Termos de uso e a Política de privacidade.</p>` (texto sem link).
- **Passos:**
  - crie `public/termos.html` e `public/privacidade.html`, ou rotas `/termos` e `/privacidade`;
  - transforme o texto em links;
  - o conteúdo precisa citar LGPD e ECA Digital e explicar a exclusão de conta (ver F4-03).
- **Aceite:** os dois links abrem as páginas e funcionam offline (service worker).

**Verificação da F1:** `npm run typecheck && npm test`. Depois, a bateria `scripts/qa/jornada.sh`, olhando as capturas `10-refazer`, `11-refazer-dica` e `08-trilha`.

---

## F2 · Regras da revisão e das vidas (app + banco)

> Cada item muda o que o banco grava. **Para cada tarefa:**
>
> 1. escreva o caso em `src/domain/paridade.test.ts` (ou em `src/domain/banco.test.ts`, que substituiu o `scripts/testar-banco.mjs`) e veja-o **falhar**;
> 2. crie `supabase/migrations/0009_regras_revisao.sql` com as funções ajustadas;
> 3. ajuste `regras.ts`/`sessoes.ts`;
> 4. rode `npm test` (app, banco e paridade).
>
> No Supabase, aplique a 0009 pelo SQL Editor **antes** de publicar o app.
> Os itens marcados **[Decisão]** pedem sua escolha. A opção recomendada vem primeiro.

### F2-01 · [Decisão] Revisão logo depois da lição não deve "dominar" por memória

- **Problema:** a lição mostra a letra certa e a explicação. Revisando na hora, o aluno acerta por memória e a questão vira **dominada** (sai da lista e só volta em 7 dias).
- **Opções:**
  - **A (recomendada):** na revisão adiantada (questão ainda não vencida), acerto sem dica vira `pendente`, com vencimento em 1 dia, e não `dominada`. Só domina quem acerta numa revisão **vencida**.
  - **B:** bloquear "Adiantar revisão" por 1 hora depois da lição.
- **Onde:**
  - app: `reagendar()` em `src/domain/regras.ts` e `registrarRevisao()` em `src/domain/sessoes.ts` (passar se o item estava vencido);
  - banco: `concluir_sessao`, no trecho `status = case when v_tema.acertou and v_tema.dicas = 0 then 'dominada' else 'pendente' end` (migration 0007, cerca da linha 250).
- **Aceite:** errar na lição, revisar na hora e acertar deixa a questão `pendente`, vencendo amanhã, nos dois lados (teste de paridade).

### F2-02 · [Decisão] Vidas em série pela revisão

- **Problema:** cada revisão com 1 acerto devolve 1 vida. Repetindo revisões, o aluno vai de 0 a 3 vidas em menos de 1 minuto. O banco limita a 5 por 24 h (acima do máximo de 3); o app não limita.
- **Opções:**
  - **A (recomendada):** a vida da revisão só vale para **revisão de questões vencidas**, no máximo **1 por dia**;
  - **B:** manter, mas limitar a 2 por dia.
- **Onde:**
  - app: `fecharRevisao()` em `src/domain/sessoes.ts` (precisa saber se a sessão era vencida e quantas vidas de revisão já vieram hoje; guarde `vidas_revisao_dia` em `DadosAluno` ou conte pelo registro);
  - banco: `concluir_sessao`, em `select count(*) from vidas_ganhas where … origem = 'revisao' and criado_em > now() - interval '24 hours') < 5` (0007, cerca da linha 259).
- **Textos:** ajuste "recupere 1 vida" no Início, no Resultado e no `SemVidas` para a regra escolhida.
- **Aceite:** duas revisões seguidas devolvem no máximo 1 vida no dia, nos dois lados.

### F2-03 · Questão dominada precisa voltar (7 → 21 → 60 dias)

- **Problema:** `reagendar()` agenda a volta da dominada, mas `revisaoVencida()`/`revisaoPendente()` (app) e `iniciar_sessao`/`responder` (banco) só aceitam `status = 'pendente'`. A dominada nunca volta.
- **Passos:**
  1. App: `revisaoVencida()` passa a incluir `status = 'dominada'` com `vence_em <= agora`. O `revisaoPendente()` continua só com as pendentes (é a "lista de erros").
  2. Banco: em `responder` (0007, cerca das linhas 94 e 132), aceite também `dominada` vencida. Em `concluir_sessao`, uma dominada acertada sem dica avança para o próximo passo (21, depois 60 dias); errada volta a `pendente`.
  3. Textos: na tela Revisar, separe "erros" (pendentes) de "para confirmar" (dominadas que venceram).
- **Aceite:** ao avançar o relógio 7 dias no teste, a questão volta na revisão do dia nos dois lados.

### F2-04 · "Recuperada" com dica: o texto bate com a regra

- **Problema:** a tela diz "Acertou, ela sai da lista", mas o acerto com dica volta em 3 dias e continua `pendente`.
- **Passos:** no Refazer, depois de acertar com dica, mostre "Recuperada com dica: volta em 3 dias para confirmar" (já existe parecido; confira). Na tela Revisar, troque "Acertou, ela sai da lista" por "Acertou sem dica, ela sai da lista".
- **Aceite:** nenhum texto promete tirar da lista uma questão que continua nela.

### F2-05 · [Decisão] Primeira sessão sem perder vida

- **Problema:** um aluno novo que erra 3 questões de ENEM seguidas fica sem vidas na 1ª lição (recarga de 2 h). É risco alto de abandono.
- **Opções:**
  - **A (recomendada):** a **1ª lição** do aluno não gasta vida (`perfil.questoes_feitas = 0` no início da sessão);
  - **B:** o 1º dia inteiro sem gastar vida;
  - **C:** manter.
- **Onde:**
  - app: `registrarErro(d, id, letra, gastaVida)`, chamado em `Licao.tsx` (`!desafio` → `!desafio && !primeiraLicao`), e o texto do feedback ("−1 vida");
  - banco: em `responder`, o ponto onde a lição gasta vida (`sem_vidas`/decremento) passa a considerar `perfis.questoes_feitas = 0` no início da sessão (guarde em `sessoes_estudo`).
- **Aceite:** um aluno novo que erra 5 de 5 termina a 1ª lição com 3 vidas, nos dois lados. Na 2ª lição, gasta normalmente.

### F2-06 · Acerto na 2ª tentativa da revisão (opcional)

- **Problema:** acertar na 2ª tentativa vale os mesmos +5 de acertar de primeira.
- **Proposta:** 2ª tentativa vale o XP de "1 dica" (4). Mude `XP_REVISAO` e a função do banco juntos.

**Verificação da F2:**

```bash
npm test                         # regras, banco (banco.test.ts) e paridade, com os casos novos
bash scripts/qa/jornada.sh http://127.0.0.1:5173/ qa-saida
```

Atualize o `PENSE_FUNCIONAMENTO.md` (seções 5.4, 5.6 e 14).

---

## F3 · Arquitetura (módulos mais profundos, menos duplicação)

> Vocabulário:
>
> - **módulo profundo:** muito comportamento atrás de uma interface pequena;
> - **seam:** onde a interface mora;
> - **adaptador:** quem preenche o seam.
>
> O mapa atual está em `docs/ARQUITETURA.md`.

### F3-01 · Adaptador de demonstração como "servidor simulado"

- **Por quê:** hoje `demoRepo.concluirSessao()` devolve `null` e as telas passam um `fechar` (cálculo local) para o hook. Se o demo fizer o papel do servidor, a interface encolhe e o teste de paridade vira teste de contrato do seam `Repo`.
- **Passos:**
  1. `demoRepo` guarda as sessões em `localStorage` (`pense:demo:sessoes:<id>`). `iniciarSessao` cria, `responder` registra, `abrirDica` registra e `concluirSessao` chama `fecharLicao`/`fecharRevisao` sobre os dados guardados, grava e **devolve o `ResumoSessao`**.
  2. `Repo.concluirSessao` passa a devolver sempre `ResumoSessao` (sem `| null`).
  3. `useSessaoEstudo.concluir(respostas)` perde o parâmetro `fechar`: chama o servidor e depois `sincronizar()`. As telas mantêm só a reação imediata de cada questão (`registrarErro`/`registrarRevisao`).
  4. `paridade.test.ts`: rode a **mesma suíte** contra `demoRepo` (com `localStorage` falso) e contra o banco (PGlite).
- **Aceite:** `Licao.tsx` e `Refazer.tsx` não importam mais `fecharLicao`/`fecharRevisao`, e a suíte de contrato passa nos dois adaptadores.

### F3-02 · Unificar os testes do banco no vitest

- **Por quê:** `scripts/testar-banco.mjs` tem uma **3ª cópia** de `temas`, `unidades` e `licaoDe` (linhas ~65–90), que pode divergir de `regras.ts`.
- **Passos:**
  - mova o arquivo para `src/domain/banco.test.ts`, que importa `temasDoRecorte`, `unidadesDoRecorte` e `montarLicao` de `regras.ts` (com uma versão sem embaralhar, para o teste);
  - mantenha os mesmos códigos de caso (`N01a`, `RP27`…);
  - extraia o preparo do PGlite, que hoje está repetido em `paridade.test.ts`, para `src/domain/testes/banco.ts`.
- **Aceite:** `npm test` roda tudo; o CI deixa de chamar `node scripts/testar-banco.mjs`.

### F3-03 · Dividir o `AppContext`

- **Por quê:** cada `atualizar` re-renderiza todas as telas que leem o contexto, e o contexto mistura conta, progresso, conteúdo e aviso.
- **Passos:** separe em três provedores, mantendo `useApp()`/`useDados()` como fachada no início para não quebrar as telas:
  - `ContaContext`: usuário, entrar, sair, carregando;
  - `ProgressoContext`: dados, atualizar, sincronizar;
  - `ConteudoContext`: conteúdo, carregado uma vez.

  O toast vira um `AvisoContext` pequeno.
- **Aceite:** abrir uma dica no Refazer não re-renderiza a `BarraNav` (confira com o React DevTools Profiler).

### F3-04 · Tempo injetável no domínio

- **Por quê:** `hoje()`, `ajustarVidas`, `agendarErro`, `reagendar` e `vidasAgora` leem `Date.now()` por dentro. Os testes precisam de relógio falso.
- **Passos:** acrescente um parâmetro opcional `agora = Date.now()` (ou `agora: Date`) e passe-o adiante. As telas continuam chamando sem o parâmetro.
- **Aceite:** `regras.test.ts` não usa mais `vi.useFakeTimers`.

### F3-05 · Estilos inline → classes

- **Por quê:** há cerca de 300 `style={{…}}` nos componentes. Os padrões se repetem (cartão de número do Resultado, pílulas, cabeçalho de tela com `Stats`, ícone em quadrado arredondado).
- **Passos:**
  - crie em `global.css` as classes `.tela-cabecalho`, `.numero-card`, `.icone-quadrado` e `.pilula-<cor>`;
  - troque um padrão por vez, conferindo com a bateria `scripts/qa` + `montagem.py --antes` (diferença de pixels ≈ 0).
- **Aceite:** menos de 120 `style={{` no `src/`, e as capturas da bateria iguais às de antes.

### F3-06 · Tipos de resultado no lugar certo

- **Passos:**
  - mova `ResumoSessao` e `NovaSessao` de `src/data/repo.ts` para `src/data/types.ts`, porque o domínio (`sessoes.ts`) depende deles;
  - troque `EstadoResultado` (Licao → Resultado) para `ResumoSessao & { tipo, tema, recorte_id, segundos, erros, motivo }`, sem repetir campo por campo.
- **Aceite:** `src/domain/*` não importa nada de `src/data/repo.ts`.

**Verificação da F3:** `npm run typecheck && npm test`. Depois, a bateria `scripts/qa`, comparando as telas com `montagem.py --antes`.

---

## F4 · Antes de abrir ao público (configuração)

| Código | Tarefa | Onde |
|---|---|---|
| F4-01 | **SMTP próprio** (Resend, Brevo ou SES) + **confirmação de e-mail** | Supabase › Authentication › Emails / SMTP |
| F4-02 | **CAPTCHA** (Cloudflare Turnstile) no cadastro e no "Entrar sem login" | Supabase › Authentication › Attack Protection + widget em `Entrar.tsx` (liberar o domínio do Turnstile na CSP) |
| F4-03 | **Termos de uso e Política de privacidade** (LGPD + ECA Digital): coleta, finalidade, exclusão de conta, responsável | `public/` ou rotas (ver F1-10) |
| F4-04 | **Hospedagem com cabeçalhos de segurança** (Cloudflare Pages ou Netlify): `Content-Security-Policy` com `frame-ancestors 'none'`, `X-Content-Type-Options`, `Referrer-Policy` | `_headers` / `netlify.toml`; ajustar Site URL e Redirect URLs no Supabase |
| F4-05 | **Login com Google** ligado (cliente OAuth) | Supabase › Providers |
| F4-06 | **Lembrete diário** de verdade (a preferência é gravada, mas nada é enviado) | Web Push ou e-mail agendado (Edge Function + cron) |
| F4-07 | **Anúncio premiado real** ou remoção da opção (hoje é um espaço reservado de 15 s) | `src/components/AnuncioPremiado.tsx`, CSP e `ads.txt` (domínio próprio). Respeitar o ECA: sem publicidade por perfil |
| F4-08 | **Limpar usuários de teste** das auditorias no Supabase | Com a sua autorização |

---

## Verificação final (depois de todas as fases)

```bash
npm run typecheck
npm install --no-save @electric-sql/pglite@0.2.17 && npm test
VITE_SUPABASE_URL= VITE_SUPABASE_ANON_KEY= npm run build   # build de conferência, sem banco real
bash scripts/qa/subir_demo.sh . 5173 && bash scripts/qa/jornada.sh http://127.0.0.1:5173/ qa-saida
```

- [x] `axe.json` sem violações (claro e escuro)
- [x] `console.txt` sem erros
- [x] Nenhuma chamada a domínios externos ao abrir o app (só o Supabase, no modo real)
- [x] `PENSE_FUNCIONAMENTO.md` e `docs/ARQUITETURA.md` atualizados

---

## Anexo A · Código dos módulos novos (F0-02), caso não use o patch

### `src/domain/catalogo.ts`

```ts
// Índice do conteúdo: busca por id em tempo constante, montado uma vez por carga de conteúdo.
// Substitui os `conteudo.questoes.find(...)` dentro de laços (Revisar, Trilha, Refazer), que crescem com cada prova nova.
import type { Conteudo, Exame, Questao, Recorte } from '../data/types';

export interface Catalogo {
  questao(id: string): Questao | undefined;
  recorte(id: string | null | undefined): Recorte | undefined;
  exame(id: string | null | undefined): Exame | undefined;
}

const cache = new WeakMap<Conteudo, Catalogo>();

export function catalogo(c: Conteudo): Catalogo {
  let cat = cache.get(c);
  if (!cat) {
    const qs = new Map(c.questoes.map((q) => [q.id, q]));
    const rs = new Map(c.recortes.map((r) => [r.id, r]));
    const es = new Map(c.exames.map((e) => [e.id, e]));
    cat = { questao: (id) => qs.get(id), recorte: (id) => (id ? rs.get(id) : undefined), exame: (id) => (id ? es.get(id) : undefined) };
    cache.set(c, cat);
  }
  return cat;
}
```

### `src/domain/sessoes.ts`

```ts
// Fechamento de lição, desafio e revisão: o mesmo cálculo que o banco faz em concluir_sessao (migrations 0006/0007).
// Funções puras: recebem os dados do aluno e devolvem os dados novos + o resumo. No modo demonstração este é o
// resultado oficial; no Supabase serve para a tela reagir na hora, até o servidor devolver o resumo dele.
import type { Conteudo, DadosAluno, Questao, Tentativa } from '../data/types';
import type { ResumoSessao } from '../data/repo';
import {
  BONUS_PERFEITA, DESAFIO_MINIMO, agendarErro, ajustarVidas, areasDoExame, atualizarTema, chaveTema, chaveUnidade, novasConquistas,
  reagendar, somarXP, xpDoAcerto
} from './regras';

export interface Fechamento { dados: DadosAluno; resumo: ResumoSessao }

const resumoVazio = (coroa = 0): ResumoSessao => ({ acertos: 0, total: 0, xp: 0, perfeita: false, aprovado: null, conquistas: [], coroaAntes: coroa, coroaDepois: coroa });

function comConquistas(d: DadosAluno, ganhas: string[]): DadosAluno {
  const agora = new Date().toISOString();
  return { ...d, conquistas: { ...d.conquistas, ...Object.fromEntries(ganhas.map((g) => [g, agora])) } };
}

/** Errou numa lição ou desafio: a questão vai para a revisão; na lição também gasta 1 vida. */
export function registrarErro(d: DadosAluno, questao_id: string, letra: string | null, gastaVida: boolean): DadosAluno {
  return {
    ...d,
    perfil: gastaVida ? ajustarVidas(d.perfil, -1) : d.perfil,
    revisao: { ...d.revisao, [questao_id]: agendarErro(d.revisao[questao_id], questao_id, letra) }
  };
}

/** Terminou uma questão no Refazer: reagenda conforme acerto e dicas. */
export function registrarRevisao(d: DadosAluno, questao_id: string, acertou: boolean, dicas: number): DadosAluno {
  const atual = d.revisao[questao_id] ?? agendarErro(undefined, questao_id, null);
  return { ...d, revisao: { ...d.revisao, [questao_id]: reagendar(atual, acertou, dicas) } };
}

export interface EntradaLicao {
  tipo: 'licao' | 'desafio';
  exame_id: string;
  recorte_id: string;
  /** Tema da lição ('' no desafio, que mistura os temas da unidade). */
  assunto: string;
  unidade: number;
  /** Questões da sessão (para saber o tema de cada resposta). */
  questoes: Questao[];
  tentativas: Tentativa[];
}

/** Fecha uma lição ou desafio: XP (com bônus de lição perfeita), domínio e coroa por tema, unidade, contadores e conquistas. */
export function fecharLicao(d: DadosAluno, c: Conteudo, e: EntradaLicao): Fechamento {
  const k = chaveTema(e.recorte_id, e.assunto);
  const coroaAntes = d.temas[k]?.coroa ?? 0;
  const { tentativas: todas } = e;
  if (!todas.length) return { dados: d, resumo: resumoVazio(coroaAntes) };

  const assuntoDe = new Map(e.questoes.map((q) => [q.id, q.assunto]));
  const acertos = todas.filter((t) => t.correta).length;
  const total = todas.length;
  const perfeita = e.tipo === 'licao' && total >= 3 && acertos === total;
  const xp = todas.reduce((s, t) => s + (t.correta ? xpDoAcerto(d, t.questao_id) : 0), 0) + (perfeita ? BONUS_PERFEITA : 0);
  const aprovado = e.tipo === 'desafio' ? acertos / total >= DESAFIO_MINIMO : null;

  let n = somarXP(d, xp);
  const temas = { ...n.temas };
  for (const nomeTema of new Set(todas.map((t) => assuntoDe.get(t.questao_id) ?? e.assunto))) {
    const kk = chaveTema(e.recorte_id, nomeTema);
    const resp = todas.filter((t) => (assuntoDe.get(t.questao_id) ?? e.assunto) === nomeTema).map((t) => t.correta);
    temas[kk] = atualizarTema(temas[kk], e.recorte_id, nomeTema, resp, perfeita && nomeTema === e.assunto);
  }
  n = {
    ...n, temas,
    vistas: [...new Set([...n.vistas, ...todas.map((t) => t.questao_id)])],
    acertadas: [...new Set([...n.acertadas, ...todas.filter((t) => t.correta).map((t) => t.questao_id)])],
    perfil: { ...n.perfil, questoes_feitas: n.perfil.questoes_feitas + total, acertos_total: n.perfil.acertos_total + acertos },
    unidades: aprovado ? { ...n.unidades, [chaveUnidade(e.recorte_id, e.unidade)]: true } : n.unidades
  };
  const ganhas = novasConquistas(n, areasDoExame(c, e.exame_id), { perfeita });
  n = comConquistas(n, ganhas);
  return { dados: n, resumo: { acertos, total, xp, perfeita, aprovado, conquistas: ganhas, coroaAntes, coroaDepois: n.temas[k]?.coroa ?? coroaAntes } };
}

/** Fecha uma revisão: soma o XP de cada questão terminada e devolve 1 vida se recuperou pelo menos uma. */
export function fecharRevisao(d: DadosAluno, c: Conteudo, exame_id: string, xpPorQuestao: number[]): Fechamento {
  const total = xpPorQuestao.length;
  if (!total) return { dados: d, resumo: resumoVazio() };
  const xp = xpPorQuestao.reduce((s, x) => s + x, 0);
  const recuperadas = xpPorQuestao.filter((x) => x > 0).length;
  let n = somarXP(d, xp);
  const perfil = recuperadas > 0 ? ajustarVidas(n.perfil, +1) : n.perfil;
  n = { ...n, perfil: { ...perfil, revisoes_concluidas: n.perfil.revisoes_concluidas + 1, questoes_feitas: n.perfil.questoes_feitas + total, acertos_total: n.perfil.acertos_total + recuperadas } };
  const ganhas = novasConquistas(n, areasDoExame(c, exame_id));
  n = comConquistas(n, ganhas);
  return { dados: n, resumo: { ...resumoVazio(), acertos: recuperadas, total, xp, conquistas: ganhas } };
}
```

### `src/state/useSessaoEstudo.ts`

```ts
// Ciclo de vida de uma sessão (lição, desafio ou revisão) do lado do app. Interface pequena:
//   responder(t)            → registra a resposta no servidor (em ordem, sem travar a tela)
//   abrirDica(questao, n)   → registra a dica aberta (revisão)
//   concluir(respostas, fechar) → aplica o fechamento local, fecha no servidor e devolve o resumo que vale
// Por dentro: abre a sessão só no primeiro uso, mantém a fila em ordem, reenvia as respostas que falharam por rede
// (o servidor ignora repetidas) e, no Supabase, troca o resumo local pelo oficial.
import { useCallback, useRef } from 'react';
import { repo } from '../lib/config';
import { falhaDeRede } from '../data/repo';
import type { NovaSessao, ResumoSessao } from '../data/repo';
import type { DadosAluno, Tentativa } from '../data/types';
import type { Fechamento } from '../domain/sessoes';
import { useDados } from './AppContext';

export function useSessaoEstudo(nova: () => NovaSessao, rotulo: string) {
  const { dados, atualizar, sincronizar, avisar } = useDados();
  const idRef = useRef<Promise<string> | null>(null);
  const filaRef = useRef<Promise<void>>(Promise.resolve());
  const falhou = useRef(false);
  const novaRef = useRef(nova);
  novaRef.current = nova;

  const sessao = useCallback(() => {
    idRef.current ??= repo.iniciarSessao(novaRef.current()).catch((e) => { idRef.current = null; throw e; });
    return idRef.current;
  }, []);

  const enfileirar = useCallback((f: (id: string) => Promise<void>) => {
    filaRef.current = filaRef.current.then(async () => { await f(await sessao()); }).catch(() => { falhou.current = true; });
  }, [sessao]);

  const responder = useCallback((t: Tentativa) => enfileirar((id) => repo.responder(id, t)), [enfileirar]);
  const abrirDica = useCallback((questao_id: string, n: number) => enfileirar((id) => repo.abrirDica(id, questao_id, n)), [enfileirar]);

  /**
   * Fecha a sessão. `fechar` calcula o resultado local a partir dos dados atuais (domain/sessoes.ts).
   * Sem nenhuma resposta, não grava nada nem chama o servidor. Uma falha no servidor vira aviso; vale o resumo local.
   */
  const concluir = useCallback(async (respostas: Tentativa[], fechar: (d: DadosAluno) => Fechamento): Promise<ResumoSessao> => {
    if (!respostas.length) return fechar(dados).resumo;
    const caixa: { local?: ResumoSessao } = {};
    await atualizar((d) => { const f = fechar(d); caixa.local = f.resumo; return f.dados; });
    let oficial: ResumoSessao | null = null;
    try {
      await filaRef.current;
      // Reenvio: o servidor ignora as repetidas e recusa a que veio depois da resolução; só a falha de rede interrompe.
      if (falhou.current) {
        for (const t of respostas.filter((x) => x.letra)) {
          await repo.responder(await sessao(), t).catch((e) => { if (falhaDeRede(e)) throw e; });
        }
      }
      oficial = await repo.concluirSessao(await sessao());
    } catch (e) {
      avisar(`Não deu para salvar ${rotulo}. ${(e as Error).message}`);
    }
    sincronizar();
    return oficial ?? caixa.local ?? fechar(dados).resumo;
  }, [atualizar, avisar, dados, rotulo, sessao, sincronizar]);

  return { responder, abrirDica, concluir };
}
```

## Anexo B · Mudanças por arquivo (F0), para conferência

| Arquivo | O que muda |
|---|---|
| `index.html` | Remove os links do Google Fonts |
| `vite.config.ts` | CSP sem `fonts.googleapis.com`/`fonts.gstatic.com` |
| package.json / package-lock.json | + `@fontsource/fredoka`, `@fontsource/lexend`; dev: `vitest`, `@types/node`; scripts `test` e `typecheck` (app + testes) |
| tsconfig.json / tsconfig.test.json | Testes fora do build do app; `tsconfig.test.json` com tipos do Node para os testes |
| `.gitignore` | + `qa-saida/` |
| `.github/workflows/testes.yml` | + `npm run typecheck` e `npm test` antes de `testar-banco.mjs` |
| `src/main.tsx` | Importa as fontes `@fontsource` (latin 500/600/700 e 400/500/600) |
| `src/App.tsx` | `React.lazy` para Lição e Refazer; `Suspense` com a tela "Carregando" nas rotas protegidas |
| `src/styles/global.css` | Tokens `--primary-ink`, `--lav-ink`, `--ouro/prata/bronze-ink`, `--rc-*` (claro e escuro); `--primary` escuro = `#237A70`; `.proximo`, `.lembrete-revisao`, `.sr-only`; máscara de esmaecer `.tabs`; `body{overflow:hidden}` ≥ 600 px; contraste de links, `.btn.ghost` e `.alt.sel` no escuro; chips mais compactos |
| `src/components/Base.tsx` | `CORES_RECORTE` com `forte`/`suave`/`fundo`/`barra` via CSS vars; `SeletorMaterias` (rodinha do mouse + aba à vista); `BannerDemo` como `<aside>`; chips de `Stats` sem encolher |
| `src/components/QuestaoView.tsx` | "Ler/Recolher" com `--primary-ink` |
| `src/components/SemVidas.tsx` | Opção "Revisar N erros e recuperar 1 vida" quando há erros; Pro como link "(em breve)" |
| `src/domain/regras.ts` | `proximoPasso`, `chaveUnidade`, `unidadeAtual`; cache em `temasDoRecorte` |
| `src/domain/sessoes.ts` | **Novo.** Fechamento de lição, desafio e revisão (Anexo A) |
| `src/domain/catalogo.ts` | **Novo.** Índice por id (Anexo A) |
| `src/domain/regras.test.ts / paridade.test.ts` | **Novos.** 19 testes de regras + 3 de paridade app × banco |
| `src/state/useSessaoEstudo.ts` | **Novo.** Ciclo de vida da sessão (Anexo A) |
| `src/state/AppContext.tsx` | `atualizar(fn, m?)`, com `m` opcional |
| `src/data/repo.ts` | `Mudancas` só com `nome`, `prefs`, `interessePro` |
| `src/screens/Inicio.tsx` | Cartão do próximo passo; `h1` "Oi, Nome"; lembrete de erros guardados; `SeletorMaterias`; sem a sigla nas linhas; folha com a matéria do tema; textos de vida com condição |
| `src/screens/Licao.tsx` | Usa `useSessaoEstudo` + `fecharLicao`/`registrarErro`; rola até a alternativa certa ao errar; `<main>` + `h1.sr-only` |
| `src/screens/Refazer.tsx` | Usa `useSessaoEstudo` + `fecharRevisao`/`registrarRevisao`; remonta por `key={search}`; "Nada vence hoje" + Adiantar; rola até o resultado da questão; `--lav-ink`; `<main>` + `h1.sr-only` |
| `src/screens/Resultado.tsx` | Sem vidas: botão principal "Revisar os erros agora"; textos sem contradição ("foram para a sua Revisão"); `<main>` |
| `src/screens/Revisar.tsx / Trilha.tsx` | `catalogo`, `chaveTema`, `unidadeAtual`, `SeletorMaterias`; cores sólidas com `fundo`; `--lav-ink`; `<main>` |
| `src/screens/Perfil.tsx / Configuracoes.tsx / Entrar.tsx / PrimeiroAcesso.tsx` | `<main>`; ícones e pílulas com `--primary-ink`; Ouro/Prata/Bronze com tokens |
| `scripts/qa/*` | **Novos.** Bateria de QA (modo demonstração, jornada com agent-browser, axe, folha antes × depois) |
| `docs/ARQUITETURA.md` | **Novo.** Mapa dos módulos, seams e propostas |
