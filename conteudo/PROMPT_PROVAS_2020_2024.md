# PROMPT_PROVAS_2020_2024 · Inserir as provas do ENEM no Pense

> **Para o Lucas (não vai para a IA)**
>
> 1. Salve este arquivo em `pense-app/conteudo/PROMPT_PROVAS_2020_2024.md`.
> 2. Os PDFs precisam estar em `pense-app/conteudo/provas/`.
> 3. Instale o Python (python.org, marcando "Add to PATH") e rode `python -m pip install pymupdf pillow`. Sem ele, as questões com figura ficam guardadas para depois (seção 4).
> 4. No chat do Claude Code, **uma mensagem por prova e dia**, nesta ordem:
>    - `Siga @conteudo/PROMPT_PROVAS_2020_2024.md. Prova 2023 dia 1.`
>    - `Siga @conteudo/PROMPT_PROVAS_2020_2024.md. Prova 2023 dia 2.`
>    - depois 2022, 2021 e 2020, sempre dia 1 e dia 2.
>    - opcional, no fim: `Siga @conteudo/PROMPT_PROVAS_2020_2024.md. Revisão 2024.`
> 5. Se a conversa for interrompida, mande a mesma mensagem de novo: a IA continua do lote que falta.

---

Você vai inserir no app **Pense** as questões das provas do ENEM de 2020 a 2023 e, se pedido, revisar as de 2024. Use as regras das **seções 5 a 10 de `@conteudo/PROMPT_PENSE.md`** (colunas, ids, matérias e assuntos, transcrição, dicas, explicação, dificuldade, conferência). Este documento diz **o que** processar e **em que ordem**.

## 1. Situação das provas

| Ano | Situação | Questões que entram |
|---|---|---|
| 2024 | Já está no app (184). Gabaritos conferidos: 100% iguais ao oficial | só revisão, se pedida (seção 6) |
| 2023 | Falta entrar | 95 + 89 = 184 |
| 2022 | Falta entrar | 95 + 89 = 184 |
| 2021 | Falta entrar | 95 + 89 = 184 |
| 2020 | Falta entrar | 95 + 88 = 183 |

O dia 1 tem 95 linhas porque as questões 1 a 5 existem em Inglês e em Espanhol. Total novo: **735 questões**.

## 2. Arquivos (em `conteudo/provas/`)

O gabarito muda conforme a cor do caderno; cada prova abaixo já está com o gabarito do mesmo caderno.

| Ano | Dia | Prova | Gabarito | Linhas esperadas | Anuladas (ficam fora) |
|---|---|---|---|---|---|
| 2023 | 1 | `2023_PV_impresso_D1_CD2.pdf` | `2023_GB_impresso_D1_CD2.pdf` | 95 | nenhuma |
| 2023 | 2 | `2023_PV_impresso_D2_CD5.pdf` | `2023_GB_impresso_D2_CD5.pdf` | 89 | 177 |
| 2022 | 1 | `2022_PV_impresso_D1_CD2.pdf` | `2022_GB_impresso_D1_CD2.pdf` | 95 | nenhuma |
| 2022 | 2 | `2022_PV_impresso_D2_CD5.pdf` | `2022_GB_impresso_D2_CD5.pdf` | 89 | 175 |
| 2021 | 1 | `2021_PV_impresso_D1_CD1.pdf` | `2021_GB_impresso_D1_CD1.pdf` | 95 | nenhuma |
| 2021 | 2 | `2021_PV_impresso_D2_CD7.pdf` | `2021_GB_impresso_D2_CD7.pdf` | 89 | 138 |
| 2020 | 1 | `2020_PV_impresso_D1_CD4.pdf` | `2020_GB_impresso_D1_CD4.pdf` | 95 | nenhuma |
| 2020 | 2 | `2020_PV_impresso_D2_CD8.pdf` | `2020_GB_impresso_D2_CD8.pdf` | 88 | 94, 143 |

## 3. Gabaritos oficiais

Extraídos dos PDFs de gabarito e conferidos (os de 2024 batem 100% com o app). `X` = anulada: não entra. Mesmo assim, confira cada letra no PDF ao montar o lote; se algo divergir, vale o PDF e você avisa.

**2024 · dia 1** (`2024_GB_impresso_D1_CD1.pdf`)
- 1–5 Inglês: C A A A E
- 1–5 Espanhol: C D D D A
- 6–15: E C B E C E D D C B
- 16–25: D E D D C E C B D C
- 26–35: B C E A D B B D B D
- 36–45: D C B E D A D E E B
- 46–55: C E C E B E B C D B
- 56–65: A D D E B B A B C D
- 66–75: C A E C E D A D B A
- 76–85: E A B E A D C E D A
- 86–90: D A C B C
- Anuladas: nenhuma

**2024 · dia 2** (`2024_GB_impresso_D2_CD7.pdf`)
- 91–100: B C E A A C D E D C
- 101–110: A A E D D D E B B D
- 111–120: D B E C C A E D B B
- 121–130: A A A C C A E E X C
- 131–140: B B C E D A B B A B
- 141–150: B A D D D B B C E C
- 151–160: E A D C E B C C C D
- 161–170: B A D C B E D A E C
- 171–180: A D A C D B C E C E
- Anuladas: 129

**2023 · dia 1** (`2023_GB_impresso_D1_CD2.pdf`)
- 1–5 Inglês: B B B D A
- 1–5 Espanhol: A B A E A
- 6–15: C C E E E D E A C B
- 16–25: C A C A A C A A C A
- 26–35: A A E C B B E D B C
- 36–45: C A D B D E D D A C
- 46–55: D B A A D E A D C D
- 56–65: C A B A B C D D E B
- 66–75: A E A B A E C A B A
- 76–85: A C E C D A E C B D
- 86–90: A A B C D
- Anuladas: nenhuma

**2023 · dia 2** (`2023_GB_impresso_D2_CD5.pdf`)
- 91–100: C A A A D C C C C D
- 101–110: D D A B D C A C D B
- 111–120: E E E D C E D A E E
- 121–130: C C D B E A B D B A
- 131–140: B B A E B D C E C A
- 141–150: C C B D E C B E E A
- 151–160: B E A B D D A A D D
- 161–170: A B B B C C B C C D
- 171–180: D A E B D A X E E B
- Anuladas: 177

**2022 · dia 1** (`2022_GB_impresso_D1_CD2.pdf`)
- 1–5 Inglês: D E C D B
- 1–5 Espanhol: D C E A A
- 6–15: D D B C A B E D C A
- 16–25: A A D C C E C E E B
- 26–35: A B E E A A A B D B
- 36–45: C C C A B E E C B B
- 46–55: E C B A B C D D A A
- 56–65: E C B C B E C A E B
- 66–75: A E A C D E E D A B
- 76–85: B C D D E A B C E D
- 86–90: A A A D B
- Anuladas: nenhuma

**2022 · dia 2** (`2022_GB_impresso_D2_CD5.pdf`)
- 91–100: E A C D D E B E A C
- 101–110: C C D A B C E E C B
- 111–120: B C C A E B E D A B
- 121–130: E A D B A D D C B D
- 131–140: D A A E B D B A A A
- 141–150: C E B E D A E C C B
- 151–160: E C D E E C B D C A
- 161–170: B E C B E A B D D C
- 171–180: C D B D X C B A A C
- Anuladas: 175

**2021 · dia 1** (`2021_GB_impresso_D1_CD1.pdf`)
- 1–5 Inglês: C A A B B
- 1–5 Espanhol: C A E A A
- 6–15: B D C D E A D C E D
- 16–25: B E D D D A B B B B
- 26–35: D E B C E A D A B D
- 36–45: B A C A C D C D D C
- 46–55: B A D C B A D B C E
- 56–65: D D E B B A D B C A
- 66–75: B E E C C A E A B E
- 76–85: B A A E C B B A B A
- 86–90: A E E B B
- Anuladas: nenhuma

**2021 · dia 2** (`2021_GB_impresso_D2_CD7.pdf`)
- 91–100: E D E C A B E D A B
- 101–110: C B E B A C C D C B
- 111–120: B E E B B C B D A A
- 121–130: E C D C B D C D B B
- 131–140: B A D C D E E X E B
- 141–150: A B D D C E C C B C
- 151–160: C E C D C A E B A D
- 161–170: E A B B D B D E D C
- 171–180: E D C C A D D C A B
- Anuladas: 138

**2020 · dia 1** (`2020_GB_impresso_D1_CD4.pdf`)
- 1–5 Inglês: A A C D E
- 1–5 Espanhol: E E E C A
- 6–15: D B B C A A A D B A
- 16–25: D E A B E B A A A D
- 26–35: E B A D A D A E B D
- 36–45: A C A A C B B E C E
- 46–55: B D D B E C E C B A
- 56–65: C D B D E E B D E D
- 66–75: D A E C D D C C A D
- 76–85: E C B C C C B B E D
- 86–90: A B C D E
- Anuladas: nenhuma

**2020 · dia 2** (`2020_GB_impresso_D2_CD8.pdf`)
- 91–100: D C D X D C C A E B
- 101–110: A D C B A A E A C C
- 111–120: B C E D D C B D D D
- 121–130: A E D D C D E C C E
- 131–140: D B D D D B A E C D
- 141–150: B B X C C C B D B A
- 151–160: C C D B E E E B C C
- 161–170: A A B C C A C E A C
- 171–180: C E D B C A B C D A
- Anuladas: 94, 143

## 4. Como processar uma prova e dia

1. **Retomada**: liste `conteudo/lotes/`. Pule os lotes desta prova que já existem e já foram importados (os ids estão no `public/data/conteudo.json`). Comece pelo primeiro que falta.
2. **Python**: rode `python --version`. Se não funcionar (no Windows pode ser o atalho da Microsoft Store), siga sem recortar figuras: as questões com figura vão para `conteudo/lotes/pendentes-figura-{ano}-D{dia}.json`, completas, com o caminho da imagem preenchido e `obs_revisao = "recortar figura: página N, região X"`. **Esse arquivo não é importado** até as imagens existirem.
3. Para cada lote da seção 5, em ordem:
   1. Leia as páginas do PDF da prova que têm as questões do lote (o Read lê PDF por páginas, até 20 por vez).
   2. Monte as questões seguindo as seções 5 a 9 do PROMPT_PENSE.md. Gabarito: seção 3 deste documento, conferido no PDF.
   3. Figuras: `python scripts/figura.py pagina ...` → meça na grade → `python scripts/figura.py recortar ...` → abra o WebP e confira.
   4. Grave o lote no arquivo da seção 5.
   5. `npm run importar-excel -- conteudo/lotes/<arquivo>.json --conferir`. Corrija **todos** os erros; leia os avisos (imagem não encontrada só é aceitável se a questão foi para o arquivo de pendentes).
   6. Importe: `npm run importar-excel -- conteudo/lotes/<arquivo>.json`.
   7. Responda em uma linha: lote, questões que entraram, anuladas puladas, pendências.
4. Texto compartilhado por várias questões (ex.: "Texto para as questões 6 a 10"): vai em `textos_base` do primeiro lote que o usa.
5. Ao terminar o dia: `npm run exportar-excel`, `npm run typecheck`, e o relatório da seção 7.
6. Não rode `npm run seed`, não faça commit nem push. Isso é com o Lucas.

## 5. Lotes e arquivos

Um lote por linha. Não junte lotes: a qualidade cai em lotes maiores.

| Ano | Dia | Questões | Arquivo | Feito |
|---|---|---|---|---|
| 2023 | 1 | 1 a 5, Inglês e Espanhol (10 linhas) | `conteudo/lotes/2023-D1-01-05.json` | ☐ |
| 2023 | 1 | 6 a 20 | `conteudo/lotes/2023-D1-006-020.json` | ☐ |
| 2023 | 1 | 21 a 35 | `conteudo/lotes/2023-D1-021-035.json` | ☐ |
| 2023 | 1 | 36 a 45 | `conteudo/lotes/2023-D1-036-045.json` | ☐ |
| 2023 | 1 | 46 a 60 | `conteudo/lotes/2023-D1-046-060.json` | ☐ |
| 2023 | 1 | 61 a 75 | `conteudo/lotes/2023-D1-061-075.json` | ☐ |
| 2023 | 1 | 76 a 90 | `conteudo/lotes/2023-D1-076-090.json` | ☐ |
| 2023 | 2 | 91 a 105 | `conteudo/lotes/2023-D2-091-105.json` | ☐ |
| 2023 | 2 | 106 a 120 | `conteudo/lotes/2023-D2-106-120.json` | ☐ |
| 2023 | 2 | 121 a 135 | `conteudo/lotes/2023-D2-121-135.json` | ☐ |
| 2023 | 2 | 136 a 150 | `conteudo/lotes/2023-D2-136-150.json` | ☐ |
| 2023 | 2 | 151 a 165 | `conteudo/lotes/2023-D2-151-165.json` | ☐ |
| 2023 | 2 | 166 a 180 | `conteudo/lotes/2023-D2-166-180.json` | ☐ |
| 2022 | 1 | 1 a 5, Inglês e Espanhol (10 linhas) | `conteudo/lotes/2022-D1-01-05.json` | ☐ |
| 2022 | 1 | 6 a 20 | `conteudo/lotes/2022-D1-006-020.json` | ☐ |
| 2022 | 1 | 21 a 35 | `conteudo/lotes/2022-D1-021-035.json` | ☐ |
| 2022 | 1 | 36 a 45 | `conteudo/lotes/2022-D1-036-045.json` | ☐ |
| 2022 | 1 | 46 a 60 | `conteudo/lotes/2022-D1-046-060.json` | ☐ |
| 2022 | 1 | 61 a 75 | `conteudo/lotes/2022-D1-061-075.json` | ☐ |
| 2022 | 1 | 76 a 90 | `conteudo/lotes/2022-D1-076-090.json` | ☐ |
| 2022 | 2 | 91 a 105 | `conteudo/lotes/2022-D2-091-105.json` | ☐ |
| 2022 | 2 | 106 a 120 | `conteudo/lotes/2022-D2-106-120.json` | ☐ |
| 2022 | 2 | 121 a 135 | `conteudo/lotes/2022-D2-121-135.json` | ☐ |
| 2022 | 2 | 136 a 150 | `conteudo/lotes/2022-D2-136-150.json` | ☐ |
| 2022 | 2 | 151 a 165 | `conteudo/lotes/2022-D2-151-165.json` | ☐ |
| 2022 | 2 | 166 a 180 | `conteudo/lotes/2022-D2-166-180.json` | ☐ |
| 2021 | 1 | 1 a 5, Inglês e Espanhol (10 linhas) | `conteudo/lotes/2021-D1-01-05.json` | ☐ |
| 2021 | 1 | 6 a 20 | `conteudo/lotes/2021-D1-006-020.json` | ☐ |
| 2021 | 1 | 21 a 35 | `conteudo/lotes/2021-D1-021-035.json` | ☐ |
| 2021 | 1 | 36 a 45 | `conteudo/lotes/2021-D1-036-045.json` | ☐ |
| 2021 | 1 | 46 a 60 | `conteudo/lotes/2021-D1-046-060.json` | ☐ |
| 2021 | 1 | 61 a 75 | `conteudo/lotes/2021-D1-061-075.json` | ☐ |
| 2021 | 1 | 76 a 90 | `conteudo/lotes/2021-D1-076-090.json` | ☐ |
| 2021 | 2 | 91 a 105 | `conteudo/lotes/2021-D2-091-105.json` | ☐ |
| 2021 | 2 | 106 a 120 | `conteudo/lotes/2021-D2-106-120.json` | ☐ |
| 2021 | 2 | 121 a 135 | `conteudo/lotes/2021-D2-121-135.json` | ☐ |
| 2021 | 2 | 136 a 150 | `conteudo/lotes/2021-D2-136-150.json` | ☐ |
| 2021 | 2 | 151 a 165 | `conteudo/lotes/2021-D2-151-165.json` | ☐ |
| 2021 | 2 | 166 a 180 | `conteudo/lotes/2021-D2-166-180.json` | ☐ |
| 2020 | 1 | 1 a 5, Inglês e Espanhol (10 linhas) | `conteudo/lotes/2020-D1-01-05.json` | ☐ |
| 2020 | 1 | 6 a 20 | `conteudo/lotes/2020-D1-006-020.json` | ☐ |
| 2020 | 1 | 21 a 35 | `conteudo/lotes/2020-D1-021-035.json` | ☐ |
| 2020 | 1 | 36 a 45 | `conteudo/lotes/2020-D1-036-045.json` | ☐ |
| 2020 | 1 | 46 a 60 | `conteudo/lotes/2020-D1-046-060.json` | ☐ |
| 2020 | 1 | 61 a 75 | `conteudo/lotes/2020-D1-061-075.json` | ☐ |
| 2020 | 1 | 76 a 90 | `conteudo/lotes/2020-D1-076-090.json` | ☐ |
| 2020 | 2 | 91 a 105 | `conteudo/lotes/2020-D2-091-105.json` | ☐ |
| 2020 | 2 | 106 a 120 | `conteudo/lotes/2020-D2-106-120.json` | ☐ |
| 2020 | 2 | 121 a 135 | `conteudo/lotes/2020-D2-121-135.json` | ☐ |
| 2020 | 2 | 136 a 150 | `conteudo/lotes/2020-D2-136-150.json` | ☐ |
| 2020 | 2 | 151 a 165 | `conteudo/lotes/2020-D2-151-165.json` | ☐ |
| 2020 | 2 | 166 a 180 | `conteudo/lotes/2020-D2-166-180.json` | ☐ |

Questões de um lote que forem anuladas simplesmente não entram (ex.: o lote 166–180 de 2023 tem 14 linhas, sem a 177).

## 6. Revisão 2024 (só quando pedida)

As 184 questões de 2024 já estão no app e os gabaritos estão certos. Revise por lotes de 15, na ordem da prova (`2024_PV_impresso_D1_CD1.pdf` e `2024_PV_impresso_D2_CD7.pdf`), seguindo a seção 2.2 do PROMPT_PENSE.md: fidelidade do texto ao PDF, formatação, matéria e assunto, dicas que entregam a resposta, explicação e descrição das figuras. Só entra no lote o que mudou, com `acao = "alterar"` e `obs_revisao`. Arquivos: `conteudo/lotes/revisao-2024-D{dia}-{primeira}-{última}.json`.

## 7. Relatório ao fim de cada prova e dia

- Linhas inseridas × esperadas (seção 2).
- Quantas por matéria e quais assuntos novos foram criados.
- Figuras recortadas e figuras pendentes (com o arquivo de pendentes).
- Divergências de gabarito entre a seção 3 e o PDF, se houver.
- Questões com dúvida de transcrição (cite o id).
