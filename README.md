# Pense · app de estudos para provas, concursos e seleções

React + Vite + TypeScript, banco no Supabase e publicação no Cloudflare.
Primeiro conteúdo: 366 questões do ENEM 2024/2025, com dicas, resposta e explicação.

App publicado: https://pense.lucas-melonio.workers.dev/ (o endereço antigo, https://lmelonio.github.io/Pense/, fica no ar até 25/11/2026)

---

## 1. Rodar no VS Code (5 min)

Pré-requisito: [Node.js 20+](https://nodejs.org).

```bash
npm install
npm run dev
```

O navegador abre em `http://localhost:5173`.

Sem as chaves do Supabase, o app roda em **modo demonstração**: tudo funciona e o progresso fica salvo no navegador.

## 2. Formas de entrar

| Botão | O que acontece |
|---|---|
| **Continuar com Google** | Conta Google. Precisa do passo 4 (login com Google). Enquanto não estiver configurado, o app avisa em vez de abrir a página de erro do Supabase. |
| **Entrar com e-mail** | Entrar, criar conta ou "Esqueci minha senha". |
| **Entrar sem login** | Usuário anônimo no Supabase, bom para testar. O progresso é gravado no banco como o de qualquer aluno. |

O visitante sem login pode, em *Perfil › Configurações*, **salvar o progresso com Google ou com e-mail**: a conta continua a mesma, com XP, sequência e coroas. Se sair sem salvar, o app pede confirmação e apaga o usuário de teste, para não deixar dados órfãos no banco.

Contas com e-mail podem trocar a senha em *Configurações › Alterar senha*. O link de "Esqueci minha senha" abre a tela de nova senha no app.

No primeiro acesso o aluno escolhe só a **língua estrangeira** (Inglês ou Espanhol) e a **frequência de estudo** (meta diária). As duas mudam depois em *Perfil › Como você estuda*.

### Matérias e vidas

- O conteúdo do ENEM é organizado por **matéria** (Português, Literatura, Inglês ou Espanhol, Artes, Educação Física, Tecnologia, História, Geografia, Filosofia, Sociologia, Biologia, Química, Física e Matemática). Dentro de cada matéria ficam os **subconteúdos** (ex.: Geografia › Urbanização). Início e Trilha usam as matérias nas abas.
- O aluno tem **3 vidas**; errar numa lição gasta 1 (a primeira lição do aluno não gasta, até ele responder a primeira questão), e 1 volta a cada 2 horas. Sem vidas, ele escolhe: **revisar e recuperar 1 vida** (quando há questões vencidas na revisão; na primeira vez sem vidas, também adiantando a revisão), **assistir a um anúncio** (+1 vida), **adiantar a revisão** como treino, **esperar** ou conhecer o **Pense Pro** (vidas ilimitadas, ainda "em breve"). A revisão devolve no máximo 1 vida por dia, por questão vencida recuperada (a exceção é a primeira vez sem vidas, quando o treino também devolve); o anúncio, até 5 em 24 horas.
- **Revisão:** a questão errada volta no dia seguinte. Revisar antes do dia ("Adiantar revisão") é treino, sem XP. Acertando no dia, de primeira e sem dica, ela sai da lista de erros e volta para confirmar em 7, 21 e 60 dias; com dica ou só na 2ª tentativa, volta em 3 dias (e a 2ª tentativa conta como uma dica a mais no XP).
- O anúncio ainda é um **espaço reservado** com contagem de 15 s (`src/components/AnuncioPremiado.tsx`). Para veicular anúncios de verdade, troque o miolo do componente pela chamada da rede de anúncios premiados (ex.: Google Ad Manager).

> **E-mails do Supabase:** o envio padrão do Supabase só entrega para os e-mails da equipe do projeto e tem limite de poucos envios por hora. Para "Esqueci minha senha" funcionar para qualquer aluno, configure um SMTP próprio (Resend, Brevo, SES…) em *Authentication › Emails › SMTP Settings*. Com "Confirm email" desligado, criar conta não depende de e-mail.

## 3. Criar o banco no Supabase (10 min)

1. Crie um projeto em [supabase.com](https://supabase.com) (plano Free).
2. Abra o **SQL Editor** e rode `supabase/setup_completo.sql`. Ele cria as tabelas, as regras de acesso (RLS), os gatilhos e os dados base (é a soma das migrations `0001` a `0010`; num banco que já existe, rode só as migrations que faltam).
3. Copie `.env.example` para `.env` e preencha, com os dados de *Project Settings › API Keys*:
   - `VITE_SUPABASE_URL`: `https://<id-do-projeto>.supabase.co` (não o link do painel).
   - `VITE_SUPABASE_ANON_KEY`: a chave **publishable** (`sb_publishable_…`) ou a **anon** legada (`eyJ…`).
   - `SUPABASE_SERVICE_ROLE_KEY`: a chave **secret** (`sb_secret_…`) ou a **service_role** legada. Só serve para o `npm run seed`. **Nunca vai para o GitHub.**
4. Carregue as questões. Escolha **um** caminho:
   - **Terminal:** `npm run seed`.
   - **SQL Editor:** rode os arquivos de `supabase/seed/` em ordem, de `01` a `16`.
5. Em *Authentication › Sign In / Providers*:
   - ligue **Allow anonymous sign-ins** (botão "Entrar sem login");
   - ligue **Email** e, para testes, desligue **Confirm email**;
   - ligue **Allow manual linking** (o visitante salvar o progresso com Google).
6. Em *Authentication › URL Configuration*:
   - **Site URL:** `https://pense.lucas-melonio.workers.dev/`
   - **Redirect URLs:** `http://localhost:5173/**`, `https://pense.lucas-melonio.workers.dev/**` e, até 25/11/2026, `https://lmelonio.github.io/Pense/**`
7. Rode `npm run dev` de novo. O aviso amarelo de demonstração some.

Para conferir o conteúdo carregado:

```sql
select * from v_resumo_conteudo;
```

Deve mostrar as 15 matérias somando 366 questões (Português 37, Literatura 17, Inglês 10, Espanhol 10, Artes 10, Educação Física 10, Tecnologia 6, História 26, Geografia 28, Filosofia 22, Sociologia 14, Biologia 33, Química 27, Física 27, Matemática 89).

## 4. Login com Google

O Google exige um cliente OAuth no Google Cloud; o Supabase faz o resto.

1. Em [console.cloud.google.com](https://console.cloud.google.com), crie (ou escolha) um projeto.
2. Em *Google Auth Platform › Branding*, preencha nome do app (Pense), e-mail de suporte e, em **Authorized domains**, `<id-do-projeto>.supabase.co`, `lucas-melonio.workers.dev` (o Google pede o domínio sem o `pense.`, porque `workers.dev` é sufixo público) e, até 25/11/2026, `lmelonio.github.io`.
3. Em *Audience*, escolha **External**. Em modo **Testing**, só os e-mails cadastrados em *Test users* conseguem entrar; para liberar para todos, clique em **Publish app** (com os escopos básicos de nome e e-mail não há revisão do Google).
4. Em *Clients › Create client*, tipo **Web application**:
   - **Authorized JavaScript origins:** `https://pense.lucas-melonio.workers.dev`, `http://localhost:5173` e, até 25/11/2026, `https://lmelonio.github.io`
   - **Authorized redirect URIs:** `https://<id-do-projeto>.supabase.co/auth/v1/callback`
5. Copie o **Client ID** e o **Client secret** e cole no Supabase em *Authentication › Sign In / Providers › Google*, ligando o provedor.

Pronto: o botão "Continuar com Google" passa a funcionar no app local e no publicado, sem mudar código.

## 5. Publicar

Endereço: **https://pense.lucas-melonio.workers.dev/**, no Cloudflare (subdomínio gratuito `workers.dev`). Até **25/11/2026** (30 dias depois da mudança), o app continua também no GitHub Pages, em https://lmelonio.github.io/Pense/, para quem ainda usa o endereço antigo.

A chave publishable/anon pode ficar no app publicado, porque o acesso é protegido pelo RLS: cada aluno só lê e grava os próprios dados. A secret/service_role não pode.

### Cloudflare

O `wrangler.jsonc` publica a pasta `dist` como arquivos estáticos (Workers com assets). Não tem `main`, porque nenhum código roda no servidor, nem `not_found_handling`, porque as rotas do app ficam depois do `#`: o servidor só entrega arquivos que existem.

O Worker `pense` já existe na conta do Cloudflare. Para publicar do próprio computador, com o `.env` preenchido:

```bash
npx wrangler login     # uma vez por máquina
npm run build
npx wrangler deploy
```

Para publicar sozinho a cada push na `main`:

1. No Cloudflare, abra o Worker `pense` › *Settings › Build › Git repository › Connect* e escolha `LMelonio/Pense`, branch `main`.
2. **Build command:** `npm run build`. **Deploy command:** `npx wrangler deploy`.
3. Nas variáveis do **build** (*Settings › Build › Variables and secrets*, não as do Worker), crie `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY` e, com o CAPTCHA, `VITE_TURNSTILE_SITE_KEY`. O Vite grava esses valores no app durante o build: **sem eles, o build publica o modo demonstração por cima do app de verdade.** Se o build reclamar da versão do Node, crie também `NODE_VERSION` = `22`.

No Supabase, *Authentication › URL Configuration* fica como na seção 3 (Site URL no endereço novo e os dois endereços nos Redirect URLs). No Google, os domínios da seção 4.

Para trocar por um domínio próprio depois: ligue-o em *Settings › Domains & Routes* e troque `pense.lucas-melonio.workers.dev` no `index.html` (og:url e og:image), neste README, no `PENSE_FUNCIONAMENTO.md`, no Supabase, no Google e no Turnstile. Quem usa sem login perde o progresso na mudança (veja abaixo).

O build gera `dist/_headers`, que o Cloudflare aplica: a CSP, os cabeçalhos de segurança e o cache de 1 ano para `assets/` (arquivos com hash no nome; o resto revalida a cada visita).

Cuidados:

- **Quem entrou sem login** tem a sessão guardada no navegador, no endereço antigo. No endereço novo, essa pessoa começa do zero. Antes de trocar, ela precisa salvar o progresso com e-mail ou Google (*Perfil › Configurações*).
- **CAPTCHA:** ligue no Supabase (*Attack Protection*) só quando todas as versões publicadas mandarem o token. O GitHub Pages não tem a `VITE_TURNSTILE_SITE_KEY`: com o CAPTCHA ligado no Supabase, o login por lá para de funcionar. No Turnstile, cadastre `pense.lucas-melonio.workers.dev` como hostname.
- Deixe desligados o **Web Analytics** e o **Rocket Loader** do Cloudflare. A CSP bloqueia os scripts deles, e a política de privacidade promete não usar ferramentas de análise de terceiros.

### GitHub Pages (até 25/11/2026)

O workflow `.github/workflows/deploy.yml` publica a cada push na `main`.

1. Em **Settings › Pages › Source**, escolha **GitHub Actions**.
2. Em **Settings › Secrets and variables › Actions**, crie `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` (os mesmos valores do `.env`).
3. Em **Actions**, rode de novo o workflow "Deploy no GitHub Pages" para usar os secrets.

> **Lembrete: desligar o GitHub Pages em 25/11/2026.**
> 1. Apague `.github/workflows/deploy.yml` e, em *Settings › Pages*, despublique o site.
> 2. No Supabase, tire `https://lmelonio.github.io/Pense/**` dos Redirect URLs. No Google, tire `lmelonio.github.io` dos domínios e das origens.
> 3. Em `public/privacidade.html`, tire o GitHub Pages da lista de quem recebe dados e atualize a data da política.
> 4. Neste README, tire o endereço antigo do topo e as menções "até 25/11/2026".

## 6. Estrutura

```
src/
  screens/      telas: Entrar, NovaSenha, PrimeiroAcesso, Inicio, Licao, Resultado, Trilha, Revisar, Refazer, Perfil, Configuracoes, Pro
  components/   ícones, mascote, barra de navegação, campo de senha, questão, texto e fórmulas, sem vidas, anúncio premiado, cartão do Pro
  domain/       regras.ts (XP, vidas, coroas, sequência, revisão espaçada, conquistas), sessoes.ts (fechamento das
                sessões, com as contas do banco), catalogo.ts (índice por id) e os testes (*.test.ts)
  data/         repo.ts (contrato e erros em português), supabaseRepo.ts (banco), demoRepo.ts (modo demonstração:
                faz o papel do servidor no navegador)
  state/        AppContext (conta, conteúdo, progresso e aviso), useSessaoEstudo (ciclo de uma sessão)
  styles/       global.css (cores, tipografia, modo noturno)
public/data/    conteudo.json (questões empacotadas, usadas também como reserva offline)
public/imagens/ figuras das questões
supabase/       migrations, seed e setup_completo.sql
scripts/        gerar-seed-sql.mjs, seed-supabase.mjs e qa/ (bateria de QA no modo demonstração)
docs/           ARQUITETURA.md (mapa dos módulos, seams e testes)
```

## 7. Banco de dados

| Grupo | Tabelas |
|---|---|
| Conteúdo (leitura pública) | exames, editais, recortes, edital_conteudo, textos_base, questoes, alternativas, questao_figuras, conquistas |
| Aluno (só o dono, via RLS) | perfis, preferencias, xp_diario, sessoes_estudo, tentativas, progresso_tema, fila_revisao, progresso_unidade, usuario_conquistas, interesse_pro, assinaturas |
| Funções do jogo | `iniciar_sessao`, `responder` (confere o gabarito, gasta a vida, agenda a revisão), `concluir_sessao` (XP, sequência, coroas, unidade e conquistas), `ganhar_vida_anuncio`, `garantir_perfil` |
| Outras funções | gatilho que cria o perfil no cadastro (inclusive Google e sem login), `excluir_minha_conta()` (LGPD), `v_ranking_semana`, `v_resumo_conteudo` |

Usuários novos não precisam ser criados à mão: o cadastro no app (ou *Authentication › Users › Add user* no painel) dispara o gatilho, que cria o perfil e as preferências.

Em `recortes` ficam as **matérias** de cada exame; a coluna `area` agrupa as do ENEM (Linguagens, Humanas, Natureza, Matemática). O `assunto` da questão é o subconteúdo dentro da matéria.

Para adicionar um concurso, cadastre-o em `exames` (com `ativo = true`), as matérias em `recortes` e as questões em `questoes` e `alternativas`.

### Pontuação no servidor

XP, vidas, sequência, coroas, revisão, unidades e conquistas são calculados pelas funções do banco a partir das respostas (migration `0006`). O app mostra o resultado na hora com as mesmas regras (`src/domain/regras.ts`), mas a palavra final é do servidor:

- o aluno só grava direto o **nome**, as **preferências** e o **interesse no Pro**; tentar gravar XP, sequência, coroas ou conquistas pela API dá `permission denied`;
- clique repetido em Verificar ou em Ver resultado não duplica nada (uma resposta por questão; concluir de novo devolve o mesmo resumo);
- com 0 vidas o servidor recusa a resposta na lição; questão que o aluno já acertou antes vale 5 XP, em vez de 10;
- Bronze exige pelo menos um acerto.

A migration `0007` faz o servidor conferir também o que o app manda nas sessões:

- **lição e desafio** abrem com a lista de questões montada pelo app, e o servidor só aceita respostas dessas questões. A lição tem até 5 questões da matéria, com as do subconteúdo primeiro (outras só completam um subconteúdo com menos de 5); o desafio tem as questões dos 6 subconteúdos da unidade (10, ou todas se forem menos);
- o **desafio** só abre com o desafio da unidade anterior vencido e todos os subconteúdos da unidade com coroa, e só é aprovado com todas as questões respondidas e 70% de acertos. A divisão em unidades é a mesma no app (`unidadesDoRecorte`) e no banco (`_temas_da_unidade`): mudar uma exige mudar a outra;
- a **revisão** só aceita questões pendentes na fila do aluno (até 10 por sessão), no máximo 2 tentativas por questão, e nada depois de acertar ou de ver a resolução. As dicas são registradas no banco quando o aluno abre cada uma (`abrir_dica`);
- o aluno não apaga a própria linha de preferências, e o app grava só os campos que mudaram.

A migration `0009` muda as regras da revisão e das vidas (decisões de 26/10/2026): revisão adiantada é treino (sem XP, sem domínio, sem vida); a vida da revisão vem só de questão vencida, 1 por dia; a questão dominada volta para confirmar; a primeira lição não gasta vida; acertar na 2ª tentativa conta como uma dica a mais. A `0010` ajusta três pontos (mesmo dia): a primeira lição grátis acaba quando o aluno responde a primeira questão, mesmo sem concluir; acertar só na 2ª tentativa também não domina (volta em 3 dias); e, na primeira vez sem vidas e sem nada vencido, a revisão adiantada devolve 1 vida (sem XP, uma vez só). **Rode a `0009` e a `0010` no SQL Editor, nessa ordem, antes de publicar esta versão do app.**

No modo demonstração (sem Supabase), o `demoRepo` faz o papel do servidor com as mesmas contas (`src/domain/sessoes.ts`), e o progresso fica no navegador. A suíte `src/domain/paridade.test.ts` roda as mesmas sessões contra os dois lados.

### Segurança: o que ainda depende de configuração

- **Confirmação de e-mail e CAPTCHA:** para abrir para alunos, ligue *Confirm email* (precisa de SMTP próprio, veja a seção 2) e o CAPTCHA (Cloudflare Turnstile) em *Authentication › Attack Protection*, que protege o cadastro e o acesso sem login. O widget já está no app: ponha a chave de site em `VITE_TURNSTILE_SITE_KEY` (no `.env` e nos secrets do deploy); sem ela, nada é carregado do Cloudflare.
- **Cabeçalhos:** o build publica a política de segurança de conteúdo (CSP) numa `<meta>` e gera `dist/_headers` com a mesma política, `frame-ancestors 'none'`, `X-Content-Type-Options`, `Referrer-Policy` e o cache de `assets/`. O Cloudflare aplica esse arquivo; o GitHub Pages o ignora (lá vale só a `<meta>`).
- **Termos de uso e Política de privacidade:** `public/termos.html` e `public/privacidade.html`, ligados na entrada e nas Configurações. Antes de abrir ao público, preencha o responsável pelos dados e o e-mail de contato (marcados com `PREENCHER`).

## 8. Comandos

| Comando | O que faz |
|---|---|
| `npm run dev` | ambiente local |
| `npm run build` | gera a pasta `dist` |
| `npm run preview` | testa o build |
| `npm run typecheck` | checa os tipos (app e testes) |
| `npm test` | regras do app, regras do banco num Postgres local (PGlite) e paridade app × banco; antes, uma vez: `npm install --no-save @electric-sql/pglite@0.2.17`. Roda sozinho no GitHub a cada push (`.github/workflows/testes.yml`) |
| `bash scripts/qa/subir_demo.sh . 5173` e `bash scripts/qa/jornada.sh http://127.0.0.1:5173/ qa-saida` | bateria de QA no modo demonstração, sem tocar no banco real: 19 capturas, axe, console e rede (precisa do [agent-browser](https://agent-browser.dev)); `node scripts/qa/montagem.mjs qa-saida --antes <pasta>` compara as capturas |
| `npm run seed` | carrega as questões no Supabase (precisa da chave secret no `.env`) |
| `npm run gerar-sql` | regera `supabase/seed/*.sql` a partir do `conteudo.json` |
| `npm run importar-excel -- <arquivo>` | importa a planilha ou um lote JSON de questões para o `conteudo.json` (com `--conferir`, só valida) |
| `npm run exportar-excel` | regera a planilha de revisão `conteudo/Pense_Questoes.xlsx` a partir do `conteudo.json` |

## 9. Atualizar e adicionar questões

As regras de transcrição, dicas, explicação e assuntos estão em `conteudo/PROMPT_PENSE.md`.

1. O conteúdo entra **só** pelo importador: `npm run importar-excel -- conteudo/Pense_Questoes.xlsx` (planilha) ou `npm run importar-excel -- conteudo/lotes/<lote>.json` (lote de questões novas ou corrigidas). Com `--conferir`, ele só valida e não grava nada; sem erros, grava `public/data/conteudo.json` e `supabase/seed/99_ativar_desativar.sql`. Nunca edite o `conteudo.json` à mão.
2. `npm run exportar-excel` regera `conteudo/Pense_Questoes.xlsx` para revisar no Excel (id em vermelho quando não bate com ano, dia e número; assunto em amarelo quando não existe na matéria).
3. Depois, leve ao banco: `npm run seed` (carga direta) ou `npm run gerar-sql` e rode no SQL Editor os arquivos de `supabase/seed/`, do `01` até o `99`.
4. Questão retirada usa `acao = excluir`: sai do app e fica `ativa = false` no banco, preservando o histórico dos alunos. Nunca apague questão nem mude o id de uma existente.
5. Imagens ficam em `public/imagens/{ano}/D{dia}/` (2ª aplicação: `public/imagens/{ano}-A2/D{dia}/`). Para recortar figuras dos PDFs de `conteudo/provas/` (fora do GitHub), use `python scripts/figura.py` (precisa de `python -m pip install pymupdf pillow`).
