# PROMPT_PENSE · Prompt único do banco de questões

> **Como usar no VS Code (para o Lucas, não para a IA)**
>
> 1. Salve este arquivo em `pense-app/conteudo/PROMPT_PENSE.md`.
> 2. Copie os PDFs da pasta "novas provas" para `pense-app/conteudo/provas/`.
> 3. No chat do Claude Code, **não anexe arquivos**: cite pelo caminho. Exemplo:
>    `Siga @conteudo/PROMPT_PENSE.md. Etapa 1.`
>    `Siga @conteudo/PROMPT_PENSE.md. Etapa 3, prova 2023 dia 1, questões 6 a 20.`
> 4. A planilha `.xlsx` não é aberta pela IA. Ela é só para você revisar no Excel. A IA trabalha com arquivos JSON e scripts.

---

Você é o desenvolvedor e o editor de conteúdo do **Pense**, app de estudos para o ENEM no estilo Duolingo (React + Vite + TypeScript, Supabase), usado por estudantes do ensino médio no celular. Você está na raiz do projeto `pense-app`. Leia este documento inteiro antes de agir e execute **só a etapa pedida** na mensagem. No fim de cada etapa, responda em poucas linhas: o que foi feito, o que ficou pendente e o resultado dos comandos de conferência.

## 0. Como o conteúdo funciona hoje

- `public/data/conteudo.json` é o conteúdo do app (JSON minificado): `{ versao, exames, recortes, textos_base, questoes }`. O tipo `Questao` está em `src/data/types.ts`. As matérias são os `recortes` (`enem-POR` … `enem-MAT`); o `assunto` é o subconteúdo (cada assunto vira um tema da trilha; uma lição tem 5 questões).
- O texto é renderizado por `src/components/Texto.tsx`: Markdown (marked) + LaTeX entre `$…$` e `$$…$$` (KaTeX) + figuras `{{figura:N}}` + parágrafo iniciado por `Fonte:` em letra pequena.
- `dica1`, `dica2` e `explicacao` aparecem na tela Refazer (revisão de questões erradas), em sequência. A `explicacao` também aparece logo depois de responder, na lição.
- O banco recebe o conteúdo por `npm run seed` (direto) ou `npm run gerar-sql` (arquivos para o SQL Editor). Alunos têm tentativas e revisões ligadas ao `id` da questão, com `on delete cascade`: **apagar uma questão do banco apaga o histórico dos alunos**. Por isso questão retirada fica com `ativa = false`.

## Regras que valem em todas as etapas

1. **Nunca mude o `id` de uma questão que já existe.**
2. Nunca edite `public/data/conteudo.json` à mão. Conteúdo entra **só** pelo `npm run importar-excel` (planilha ou JSON de lote).
3. Não apague questões; para retirar, `acao = "excluir"`.
4. Depois de qualquer mudança de conteúdo, rode `npm run importar-excel -- <arquivo> --conferir` e corrija **todos** os erros antes de gravar.
5. Escreva em português do Brasil.

---

# ETAPA 1 · Melhorias no código

Faça as mudanças abaixo, nesta ordem.

### 1.1 Dependência e comandos

- `npm install -D exceljs@4.4.0`
- Em `package.json`, nos `scripts`, acrescente:
  - `"importar-excel": "node scripts/importar-excel.mjs"`
  - `"exportar-excel": "node scripts/exportar-excel.mjs"`
- Em `.gitignore`, acrescente as linhas `conteudo/provas/` (os PDFs não vão para o GitHub) e `tmp/`.
- Para recortar figuras: `pip install pymupdf pillow` (ou `python -m pip install pymupdf pillow` no Windows).

### 1.2 Quebras de linha no texto (bug)

Hoje poemas, letras de canção, textos com linhas numeradas e equações em linhas próprias aparecem como um parágrafo corrido, porque o marked ignora a quebra simples. Em `src/components/Texto.tsx`, troque:

```ts
marked.setOptions({ gfm: true, breaks: false });
```

por:

```ts
// breaks: true → uma quebra simples vira quebra de linha (versos, letras de canção, linhas numeradas de texto-base).
// Parágrafo novo continua sendo linha em branco.
marked.setOptions({ gfm: true, breaks: true });
```

### 1.3 SQL com numeração estável (`scripts/gerar-seed-sql.mjs`)

Hoje o arquivo de cada matéria é numerado pela ordem em que ela aparece no JSON; com questões de outros anos, os nomes mudam e sobram arquivos velhos. Faça três mudanças:

1. Import: `import { readFileSync, writeFileSync, mkdirSync, readdirSync, unlinkSync } from 'node:fs';`
2. Logo depois de `mkdirSync(dir, { recursive: true });`:
```js
// Apaga os arquivos de questões antigos: a numeração segue a ordem das matérias e não pode deixar sobras.
for (const f of readdirSync(dir)) if (/^\d+_questoes_.*\.sql$/.test(f)) unlinkSync(new URL(f, dir));
```
3. Troque `for (const x of c.questoes) (porRecorte[x.recorte_id] ??= []).push(x);` por:
```js
// Um arquivo por matéria, na ordem das matérias (assim a numeração não muda quando entram questões de outros anos).
const ordem = Object.fromEntries(c.recortes.map((r) => [r.id, r.ordem]));
for (const x of [...c.questoes].sort((a, b) => (ordem[a.recorte_id] ?? 99) - (ordem[b.recorte_id] ?? 99))) (porRecorte[x.recorte_id] ??= []).push(x);
```

### 1.4 Carga direta desativa o que saiu (`scripts/seed-supabase.mjs`)

Antes da linha final `console.log('Carga concluída.');`, acrescente:

```js
// O banco espelha o conteudo.json: questão que saiu do JSON fica inativa (o histórico dos alunos é preservado).
const ids = new Set(c.questoes.map((x) => x.id));
const noBanco = [];
for (let de = 0; ; de += 1000) {
  const { data, error } = await sb.from('questoes').select('id, ativa').eq('exame_id', 'enem').range(de, de + 999);
  if (error) throw new Error(`questoes: ${error.message}`);
  noBanco.push(...data);
  if (data.length < 1000) break;
}
const desativar = noBanco.filter((x) => x.ativa && !ids.has(x.id)).map((x) => x.id);
const reativar = noBanco.filter((x) => !x.ativa && ids.has(x.id)).map((x) => x.id);
for (const [lista, ativa] of [[desativar, false], [reativar, true]]) {
  for (let i = 0; i < lista.length; i += 200) {
    const { error } = await sb.from('questoes').update({ ativa }).in('id', lista.slice(i, i + 200));
    if (error) throw new Error(`questoes (ativa): ${error.message}`);
  }
}
console.log(`✓ ativas: ${desativar.length} desativadas, ${reativar.length} reativadas`);
```

### 1.5 Importador: `scripts/importar-excel.mjs` (novo)

Lê a planilha **ou** um JSON de lote, valida tudo e só grava o `conteudo.json` se não houver erro. Mescla pelo `id`; questões que não aparecem no arquivo ficam como estão. Também grava `supabase/seed/99_ativar_desativar.sql`. O código está em `scripts/importar-excel.mjs` (criado na etapa 1).

### 1.6 Exportador: `scripts/exportar-excel.mjs` (novo)

Gera `conteudo/Pense_Questoes.xlsx` a partir do `conteudo.json`, para revisão humana no Excel (validações em lista, id em vermelho quando não bate com ano/dia/número, assunto em amarelo quando não existe na matéria). O código está em `scripts/exportar-excel.mjs` (criado na etapa 1).

### 1.7 Figuras das provas: `scripts/figura.py` (novo)

Gera a página do PDF com grade de 10% e recorta figuras em WebP. O código está em `scripts/figura.py` (criado na etapa 1). Uso:

```
python scripts/figura.py pagina conteudo/provas/2023_PV_impresso_D2_CD5.pdf 12 tmp/pag12.png
python scripts/figura.py recortar conteudo/provas/2023_PV_impresso_D2_CD5.pdf 12 0.52 0.10 0.95 0.38 public/imagens/2023/D2/q141_fig1.webp
```

### 1.8 README

No fim do `README.md`, acrescente a seção "9. Atualizar e adicionar questões" resumindo: conteúdo entra por `npm run importar-excel -- <planilha ou lote.json>` (com `--conferir` só valida); `npm run exportar-excel` regera a planilha de revisão; depois `npm run seed` ou `npm run gerar-sql` (rodando os arquivos de `supabase/seed/` até o `99`); questão excluída fica `ativa = false`; imagens em `public/imagens/{ano}/D{dia}/` (2ª aplicação: `{ano}-A2`); regras em `conteudo/PROMPT_PENSE.md`. Na tabela "8. Comandos", acrescente `importar-excel` e `exportar-excel`.

### 1.9 Conferência da etapa 1

```
npm run exportar-excel
npm run importar-excel -- conteudo/Pense_Questoes.xlsx --conferir
npm run typecheck
npm run build
```

A ida e volta tem de passar **sem erros**, exceto os 4 erros de `R$` da etapa 2 (eles são esperados aqui). Não grave nada no `conteudo.json` nesta etapa.

---

# ETAPA 2 · Correções no conteúdo existente

### 2.1 Correção obrigatória: "R$" sem barra

Se o `--conferir` da etapa 1 apontou esses erros, corrija. Nestas questões, `R$` sem barra faz o app tratar o trecho como fórmula e o texto aparece quebrado: **2024-D2-Q156** (explicacao), **2024-D2-Q177** (dica2 e explicacao), **2024-D2-Q179** (explicacao), **2025-D2-Q168** (explicacao).

Gere `conteudo/lotes/correcoes-rs.json` com essas 4 questões completas (todas as colunas da seção 5, a partir do `conteudo.json`), `acao = "alterar"`, trocando todo `R$` sem barra por `R\$` nos campos indicados, e `obs_revisao` dizendo o que mudou. Importe com `--conferir` e depois sem.

### 2.2 Revisão geral (quando pedida, por matéria ou por prova)

Revise em lotes de até 15 questões e confira, nesta ordem:
1. **Gabarito** contra o PDF do gabarito do mesmo caderno (`conteudo/provas/{ano}_GB_impresso_D{n}_CD{n}.pdf`).
2. **Fidelidade** do texto de apoio, comando e alternativas ao PDF da prova.
3. **Formatação** (seção 7).
4. **Matéria e assunto** (seção 6).
5. **Dicas**: a dica 1 não entrega a resposta; a dica 2 ajuda mais, mas não diz a letra.
6. **Explicação**: começa pela letra certa, justifica e comenta a armadilha principal.
7. **Figuras**: a descrição permite responder sem ver a imagem?

Só entra no lote a questão que mudou, com `acao = "alterar"` e uma frase em `obs_revisao`. Arquivo: `conteudo/lotes/revisao-{matéria ou prova}-{n}.json`.

---

# ETAPA 3 · Adicionar questões novas

### 3.1 Provas disponíveis em `conteudo/provas/`

| Ano | Aplicação | Dia | Arquivo da prova | Arquivo do gabarito | Anuladas (ficam de fora) |
|---|---|---|---|---|---|
| 2020 | 1 | 1 | 2020_PV_impresso_D1_CD4.pdf | 2020_GB_impresso_D1_CD4.pdf | — |
| 2020 | 1 | 2 | 2020_PV_impresso_D2_CD8.pdf | 2020_GB_impresso_D2_CD8.pdf | 94, 143 |
| 2021 | 1 | 1 | 2021_PV_impresso_D1_CD1.pdf | 2021_GB_impresso_D1_CD1.pdf | — |
| 2021 | 1 | 2 | 2021_PV_impresso_D2_CD7.pdf | 2021_GB_impresso_D2_CD7.pdf | 138 |
| 2022 | 1 | 1 | 2022_PV_impresso_D1_CD2.pdf | 2022_GB_impresso_D1_CD2.pdf | — |
| 2022 | 1 | 2 | 2022_PV_impresso_D2_CD5.pdf | 2022_GB_impresso_D2_CD5.pdf | 175 |
| 2023 | 1 | 1 | 2023_PV_impresso_D1_CD2.pdf | 2023_GB_impresso_D1_CD2.pdf | — |
| 2023 | 1 | 2 | 2023_PV_impresso_D2_CD5.pdf | 2023_GB_impresso_D2_CD5.pdf | 177 |
| 2025 | **2** | 1 | 2025_PV_impresso_D5_CD1.pdf | 2025_GB_impresso_D5_CD1.pdf | — |

2024 e 2025 (1ª aplicação) já estão no app: os PDFs desses anos servem só para a revisão da etapa 2. O arquivo `D5` de 2025 é o **dia 1 da 2ª aplicação** (questões 1–90): `aplicacao = 2`, `dia = 1`. O gabarito muda conforme a cor do caderno: use sempre o GB do mesmo `CD` do PV. Antes de usar a tabela, confira as anuladas no próprio gabarito (marcadas com `*`, "Anulada" ou "Anulado").

Total esperado por prova: dia 1 = 95 questões (90 + as 5 de língua em duas versões); dia 2 = 90 menos as anuladas.

### 3.2 Como trabalhar cada lote

1. Lote de até 15 questões, na ordem da prova. Antes, confira no `conteudo.json` se algum id já existe; se existir, avise e pule.
2. Leia as páginas do PDF da prova (o Read lê PDF por páginas, até 20 por vez) e o gabarito. Para conferir a transcrição, você pode extrair o texto com PyMuPDF (`page.get_text()`), mas o PDF visto é a referência final (o texto extraído troca a ordem de colunas e perde fórmulas).
3. Para cada figura: `python scripts/figura.py pagina <pdf> <página> tmp/pag.png`, abra o PNG (tem grade de 10%), meça o recorte e rode `python scripts/figura.py recortar <pdf> <página> x0 y0 x1 y1 public/imagens/...webp`. Abra o WebP gerado e confira: a figura inteira, sem o número da questão, sem texto corrido em volta, sem as letras das alternativas. Refaça se precisar. A pasta `tmp/` é descartável.
4. Grave o lote em `conteudo/lotes/{ano}[-A2]-D{dia}-{primeira}-{última}.json` (ex.: `2023-D1-006-020.json`) no formato da seção 8.
5. `npm run importar-excel -- conteudo/lotes/<arquivo>.json --conferir`; corrija todos os erros e revise os avisos; depois importe sem `--conferir`.
6. Responda: questões que entraram, anuladas puladas e algo que precise de olho humano.

Questões 1 a 5 do dia 1: são **10 linhas** (versões Inglês e Espanhol), cada uma com o gabarito da sua coluna.

---

# ETAPA 4 · Fechamento (depois de cada prova completa)

```
npm run exportar-excel
npm run importar-excel -- conteudo/Pense_Questoes.xlsx --conferir
npm run gerar-sql
npm run typecheck
npm run build
```

Relate: total de questões por ano e dia (compare com o esperado em 3.1), quantas por matéria, assuntos novos criados e figuras. Não rode `npm run seed` sem o Lucas pedir.

---

# 5. Colunas (planilha e JSON de lote)

| Coluna | O que vai | Exemplo |
|---|---|---|
| `acao` | `nova`, `alterar`, `manter` ou `excluir` | `nova` |
| `id` | Identificador (seção 5.1) | `2023-D1-Q012` |
| `ano` | Ano da prova | `2023` |
| `aplicacao` | `1` (regular) ou `2` (2ª aplicação) | `1` |
| `dia` | `1` (questões 1–90) ou `2` (91–180) | `1` |
| `numero` | Número da questão na prova | `12` |
| `lingua` | Só nas questões 1–5 do dia 1: `Inglês` ou `Espanhol`. Nas outras, não preencha | |
| `recorte_id` | Matéria (seção 6) | `enem-POR` |
| `assunto` | Subconteúdo, da lista da seção 6 | `Gêneros textuais` |
| `topico` | Tema específico, 2 a 6 palavras, inicial maiúscula, sem ponto | `Cartaz de campanha de doação` |
| `dificuldade` | `fácil`, `média` ou `difícil` (seção 9) | `média` |
| `texto_base_id` | Só para texto compartilhado (seção 7.6) | |
| `texto_apoio` | Texto(s), figuras e fontes antes do comando | |
| `comando` | A pergunta final, antes das alternativas | |
| `alt_A` … `alt_E` | Texto de cada alternativa, sem a letra | |
| `gabarito` | Letra certa, maiúscula | `D` |
| `dica1`, `dica2`, `explicacao` | Conteúdo didático (seção 8) | |
| `fig1_imagem`, `fig1_descricao` … `fig3_*` | Figuras do texto de apoio (seção 7.4) | |
| `alt_A_img` … `alt_E_img` | Só quando a alternativa é imagem | |
| `obs_revisao` | Nota para o revisor humano; não vai para o app | |

O importador preenche sozinho: exame `enem`, banca `INEP`, formato `5_alternativas`, disciplina (pela matéria) e, na 2ª aplicação, a origem "2ª aplicação" (aparece no app como "ENEM · 2ª aplicação · 2025 · Questão 12").

### 5.1 Identificadores e arquivos

**id** = `{ano}` + (`-A2` na 2ª aplicação) + `-D{dia}` + `-Q{número com 3 dígitos}` + (`-ING` / `-ESP` nas questões 1–5 do dia 1).

| Caso | id |
|---|---|
| Questão 46 de 2023 | `2023-D1-Q046` |
| Questão 3 de 2022, Inglês / Espanhol | `2022-D1-Q003-ING` / `2022-D1-Q003-ESP` |
| Questão 140 de 2021 | `2021-D2-Q140` |
| 2ª aplicação 2025, questão 12 | `2025-A2-D1-Q012` |

**Imagens** em `public/imagens/`, referenciadas sem o `public/`:
- Pasta `imagens/{ano}/D{dia}/` (2ª aplicação: `imagens/{ano}-A2/D{dia}/`).
- Figura: `q{NNN}_fig{n}.webp`; questão de língua: `q{NNN}-ing_fig1.webp` / `q{NNN}-esp_fig1.webp`; alternativa: `q{NNN}_alt_{Letra}.webp`.

**Texto-base compartilhado**: `{ano}-D{dia}-TB{primeira}-{última}` (ex.: `2025-D1-TB006-010`).

# 6. Matérias e assuntos

Use `recorte_id` e `assunto` **exatamente** como abaixo. Só crie assunto novo se nenhum servir, curto e no mesmo padrão, e escreva "assunto novo" em `obs_revisao`. Nunca crie variação de um assunto existente.

| recorte_id | Matéria | Assuntos aceitos |
|---|---|---|
| `enem-POR` | Português | Gêneros textuais · Variação linguística · Argumentação · Coesão e coerência · Figuras de linguagem · Interpretação de texto · Funções da linguagem · Gramática e semântica |
| `enem-LIT` | Literatura | Prosa e narrativa · Literatura contemporânea · Poesia · Movimentos literários |
| `enem-ING` | Inglês | Interpretação de texto |
| `enem-ESP` | Espanhol | Interpretação de texto |
| `enem-ART` | Artes | Artes visuais · Arte contemporânea e patrimônio · Música |
| `enem-EDF` | Educação Física | Esporte e jogos · Corpo, saúde e cultura corporal · Dança e lutas |
| `enem-TIC` | Tecnologia | Comunicação e tecnologia · Mídias digitais e redes |
| `enem-HIS` | História | Brasil República · Idade Moderna · Brasil Império · Idade Contemporânea · Antiguidade · Brasil Colônia · História da África e povos indígenas · Idade Média · Ditadura e redemocratização |
| `enem-GEO` | Geografia | Agropecuária e espaço rural · Biomas e questões ambientais · Clima e hidrografia · Urbanização · Geopolítica e globalização · Indústria e energia · População e migrações · Geologia e relevo · Cartografia |
| `enem-FIL` | Filosofia | Filosofia contemporânea · Filosofia antiga · Filosofia moderna · Ética e política |
| `enem-SOC` | Sociologia | Cultura e identidade · Movimentos sociais e desigualdade · Teoria sociológica · Estado, poder e cidadania · Trabalho e sociedade |
| `enem-BIO` | Biologia | Ecologia · Fisiologia humana e saúde · Zoologia · Microbiologia e doenças · Citologia · Genética e evolução · Biotecnologia |
| `enem-QUI` | Química | Química orgânica · Estequiometria · Química geral e atomística · Separação de misturas e materiais · Cinética e equilíbrio · Eletroquímica · Química ambiental · Soluções |
| `enem-FIS` | Física | Eletricidade e circuitos · Ondulatória e som · Termologia · Cinemática · Dinâmica e leis de Newton · Eletromagnetismo · Energia e trabalho · Física moderna · Hidrostática · Óptica |
| `enem-MAT` | Matemática | Aritmética e porcentagem · Geometria espacial · Razão, proporção e regra de três · Escalas, unidades e medidas · Geometria plana · Leitura de gráficos e tabelas · Estatística · Funções do 1º e 2º grau · Probabilidade · Análise combinatória · Exponencial e logaritmo · Progressões · Trigonometria · Equações, inequações e sistemas · Geometria analítica |

Em Linguagens (6–45):
- **Literatura**: o foco é a obra literária (poema, conto, romance, letra lida como poesia), estilo de época, autor, recurso estético.
- **Português**: uso da língua: gênero, finalidade, variação, argumentação, coesão, sentido.
- **Artes**: artes visuais, música, teatro, arquitetura, patrimônio.
- **Educação Física**: esporte, jogo, dança, luta, ginástica, corpo e saúde.
- **Tecnologia**: internet, redes sociais, mídias digitais.
- Questões 1–5 do dia 1: `enem-ING` / `enem-ESP`, assunto `Interpretação de texto`.

Em Humanas, Natureza e Matemática, a matéria é a do **conhecimento que resolve a questão**, não a do tema do texto.

# 7. Transcrição

Copie a prova **fielmente**: mesmas palavras, pontuação, aspas curvas (“ ”), itálicos e "(adaptado)". Não resuma, não corrija, não modernize.

### 7.1 Markdown
- Parágrafo novo: linha em branco (`\n\n`). Quebra dentro do parágrafo (verso, linha numerada, equação em linha própria): `\n`.
- Título do texto: `**Título**` em linha própria. Vários textos: `**TEXTO I**`, `**TEXTO II**`, cada um com a sua fonte.
- Itálico da prova: `*palavra*`. Listas: `- item`.
- Quadro ou tabela de texto e números: tabela Markdown com cabeçalho (`| A | B |` + `|---|---|`); cabeçalho de dois níveis vira um só (`Preços (R\$) — X`).
- O comando não repete o texto de apoio e não tem "QUESTÃO 12". Alternativas sem a letra no começo, com a pontuação final da prova.

### 7.2 Fonte
A referência em letra pequena vira um parágrafo próprio começando por `Fonte: `, com o título em negrito:
`Fonte: RIBEIRO, A. E. **Do punho ao pixel**. Disponível em: https://rascunho.com.br. Acesso em: 16 jan. 2024 (adaptado).`

### 7.3 Matemática, Física e Química
- Fórmulas e variáveis em LaTeX: `$f_0$`, `$v = \sqrt{50^2-30^2}$`; destaque: `$$ … $$` em parágrafo próprio. Vírgula decimal no LaTeX: `$2{,}5$`; multiplicação `\cdot`; fração `\frac{a}{b}`; unidade `\text{ m/s}`.
- **Todo cifrão de dinheiro leva barra: `R\$ 7,00`**, em todos os campos (no JSON: `"R\\$ 7,00"`). Todo `$` de fórmula tem par.
- Número fora de fórmula como na prova: `1 650`, `2,5 m`, `40%`.
- Química no texto da prova em Unicode, como no caderno: `Ca₅(PO₄)₃OH`, `H⁺`, `PO₄³⁻`, `→`, `⇌`, `H₂O (l)`. Nas explicações pode usar LaTeX (`$CH_3COO^-$`).

### 7.4 Figuras
- Use imagem para foto, pintura, cartaz, tirinha, mapa, gráfico, esquema, circuito, heredograma, figura geométrica. Tabela só de texto e números é transcrita, não vira imagem.
- Marque a posição com `{{figura:1}}` em parágrafo próprio; a `Fonte:` da imagem vem logo depois.
- `figN_descricao`: descrição objetiva com **toda a informação necessária para responder** (textos da imagem entre aspas, valores, eixos, legendas, cores que importam). É o que o leitor de tela lê.
- Alternativas em imagem: `alt_X` vazio e `alt_X_img` preenchido.

### 7.5 Língua estrangeira (1–5 do dia 1)
Texto de apoio na língua original; comando, alternativas, dicas e explicação em português, como na prova. Cite trechos do original entre aspas nas dicas e na explicação.

### 7.6 Texto compartilhado
Texto longo usado por várias questões ("Texto para as questões 6 a 10"): vai em `textos_base` do lote (`acao`, `id`, `texto` completo com fonte); as questões recebem `texto_base_id` e `texto_apoio` vazio (ou só o trecho específico). Linhas numeradas: número no começo de cada linha, uma linha por `\n`.

# 8. Conteúdo didático e formato do lote

Português do Brasil, falando com o aluno ("você", "veja", "compare"), frases curtas, sem emojis. O aluno que errou vê, em sequência, dica 1 → dica 2 → resolução.

**dica1 (30 a 160 caracteres)**: diz **onde olhar** ou **que pergunta fazer**. Nunca entrega a resposta, nunca cita letra, nunca descarta alternativa pelo nome.
- "Calcule o custo de um enfeite em cada loja, lembrando que ele usa 2 unidades de X e 1 de Y."

**dica2 (70 a 215 caracteres)**: ajuda mais forte: conceito, dado decisivo ou primeiro passo da conta; pode desmontar a armadilha. Ainda não diz a letra nem a resposta final.
- "O Texto II cita a placa de Nazca. Pense no que acontece quando essa placa oceânica mergulha sob a placa Sul-Americana e em quanto cada cidade está distante dessa borda."

**explicacao (150 a 520 caracteres)**:
1. Começa com `Resposta: D.` (ou "A resposta é D: …").
2. Justifica pelo texto ou pelo conceito.
3. Em cálculo, mostra a conta com os números da questão.
4. Fecha com **a armadilha principal**: a alternativa errada mais tentadora e por que não serve.
- "Resposta: C, zonas de subducção. Na costa chilena, a placa de Nazca mergulha sob a Sul-Americana, o que gera terremotos fortes como o de Valparaíso (5,9). No interior do Amazonas, mais longe da borda, os abalos são medianos (4,8). No interior de SP, no meio da placa, os tremores são pequenos (3,0). Planícies costeiras (A) só descrevem o relevo do litoral, não a origem dos sismos."

Antes de escrever, leia no `conteudo.json` pelo menos 5 questões da mesma matéria e siga o mesmo tom.

### Formato do arquivo de lote

JSON com as chaves da seção 5 (campos vazios podem ser omitidos). Exemplo com uma questão que já está no app:

```json
{
  "questoes": [
    {
      "acao": "nova",
      "id": "2024-D1-Q033",
      "ano": 2024,
      "aplicacao": 1,
      "dia": 1,
      "numero": 33,
      "recorte_id": "enem-POR",
      "assunto": "Gêneros textuais",
      "topico": "Cartaz de campanha de doação",
      "dificuldade": "fácil",
      "texto_apoio": "{{figura:1}}\n\nFonte: Disponível em: https://defesacivil.rs.gov.br. Acesso em: 11 mar. 2024 (adaptado).",
      "comando": "Nesse cartaz, a expressão “Vou deixar que você se vá”, em conjunto com os elementos não verbais utilizados, tem a finalidade de",
      "alt_A": "incentivar o descarte de itens defeituosos.",
      "alt_B": "promover a reciclagem de produtos usados.",
      "alt_C": "garantir a conservação de roupas de inverno.",
      "alt_D": "relacionar o gesto de doação à ideia de desapego.",
      "alt_E": "comparar a peça de roupa ao sentimento de despedida.",
      "gabarito": "D",
      "dica1": "Leia a frase do moletom junto com o restante do cartaz: de que campanha se trata?",
      "dica2": "“Vou deixar que você se vá” parece frase de despedida amorosa. No cartaz, quem “vai embora” é a roupa doada. Que atitude isso pede de quem doa?",
      "explicacao": "Resposta: D. O cartaz é da Campanha do Agasalho, e a mulher segura o moletom como quem se despede dele. A frase transforma a doação em um gesto de desapego: abrir mão de algo seu para aquecer quem precisa. A alternativa E é tentadora, mas a comparação com a despedida é só o recurso; a finalidade é estimular a doação ligada ao desapego.",
      "fig1_imagem": "imagens/2024/D1/q033_fig1.webp",
      "fig1_descricao": "Cartaz da Campanha do Agasalho, com fundo em tons de roxo e magenta e círculos concêntricos alaranjados. À esquerda, uma mulher sorridente de cabelos grisalhos segura à frente do corpo um moletom laranja estampado com os dizeres “VOU DEIXAR QUE VOCÊ SE VÁ”. À direita, os textos: “Deixe suas roupas aquecerem quem mais precisa.”; “CAMPANHA DO AGASALHO”; “Doe roupas, calçados e cobertores em bom estado. Sua doação ajuda muita gente.”"
    }
  ],
  "textos_base": []
}
```

# 9. Dificuldade

Pense num aluno típico do ensino médio.
- **fácil**: leitura direta ou um passo; o texto quase entrega a resposta.
- **média**: dois ou três passos, ou exige um conceito escolar além do texto.
- **difícil**: vários passos, conteúdo específico ou distrator muito forte.

Referência do banco atual: cerca de 40% fácil, 45% média, 15% difícil.

# 10. Conferência de cada questão

- [ ] id pela seção 5.1 e ainda inexistente (questão nova).
- [ ] Gabarito do PDF do mesmo caderno; anuladas fora.
- [ ] Texto, comando e alternativas iguais à prova.
- [ ] `recorte_id` e `assunto` da seção 6.
- [ ] Todo `R\$` com barra; todo `$` de fórmula com par.
- [ ] Cada `{{figura:N}}` com `figN_imagem` (arquivo existe) e `figN_descricao`.
- [ ] Dicas sem a letra; explicação começa pela letra certa e comenta uma armadilha.
- [ ] Tamanhos de dica1, dica2 e explicação dentro das faixas.
- [ ] `npm run importar-excel -- <lote> --conferir` sem erros.
