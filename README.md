# Pense · app de estudos para provas, concursos e seleções

React + Vite + TypeScript, banco no Supabase e publicação no GitHub Pages.
Primeiro conteúdo: 366 questões do ENEM 2024/2025, com dicas, resposta e explicação.

App publicado: https://lmelonio.github.io/Pense/

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
- O aluno tem **3 vidas**; errar numa lição gasta 1, e 1 volta a cada 30 minutos. Sem vidas, ele escolhe: **esperar**, **assistir a um anúncio** (+1 vida) ou conhecer o **Pense Pro** (vidas ilimitadas, ainda "em breve"). Terminar uma revisão dos erros também devolve 1 vida.
- O anúncio ainda é um **espaço reservado** com contagem de 15 s (`src/components/AnuncioPremiado.tsx`). Para veicular anúncios de verdade, troque o miolo do componente pela chamada da rede de anúncios premiados (ex.: Google Ad Manager).

> **E-mails do Supabase:** o envio padrão do Supabase só entrega para os e-mails da equipe do projeto e tem limite de poucos envios por hora. Para "Esqueci minha senha" funcionar para qualquer aluno, configure um SMTP próprio (Resend, Brevo, SES…) em *Authentication › Emails › SMTP Settings*. Com "Confirm email" desligado, criar conta não depende de e-mail.

## 3. Criar o banco no Supabase (10 min)

1. Crie um projeto em [supabase.com](https://supabase.com) (plano Free).
2. Abra o **SQL Editor** e rode `supabase/setup_completo.sql`. Ele cria as tabelas, as regras de acesso (RLS), os gatilhos e os dados base (é a soma das migrations `0001` a `0005`; num banco que já existe, rode só as migrations que faltam).
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
   - **Site URL:** `https://lmelonio.github.io/Pense/`
   - **Redirect URLs:** `http://localhost:5173/**` e `https://lmelonio.github.io/Pense/**`
7. Rode `npm run dev` de novo. O aviso amarelo de demonstração some.

Para conferir o conteúdo carregado:

```sql
select * from v_resumo_conteudo;
```

Deve mostrar as 15 matérias somando 366 questões (Português 37, Literatura 17, Inglês 10, Espanhol 10, Artes 10, Educação Física 10, Tecnologia 6, História 26, Geografia 28, Filosofia 22, Sociologia 14, Biologia 33, Química 27, Física 27, Matemática 89).

## 4. Login com Google

O Google exige um cliente OAuth no Google Cloud; o Supabase faz o resto.

1. Em [console.cloud.google.com](https://console.cloud.google.com), crie (ou escolha) um projeto.
2. Em *Google Auth Platform › Branding*, preencha nome do app (Pense), e-mail de suporte e, em **Authorized domains**, `<id-do-projeto>.supabase.co` e `lmelonio.github.io`.
3. Em *Audience*, escolha **External**. Em modo **Testing**, só os e-mails cadastrados em *Test users* conseguem entrar; para liberar para todos, clique em **Publish app** (com os escopos básicos de nome e e-mail não há revisão do Google).
4. Em *Clients › Create client*, tipo **Web application**:
   - **Authorized JavaScript origins:** `https://lmelonio.github.io` e `http://localhost:5173`
   - **Authorized redirect URIs:** `https://<id-do-projeto>.supabase.co/auth/v1/callback`
5. Copie o **Client ID** e o **Client secret** e cole no Supabase em *Authentication › Sign In / Providers › Google*, ligando o provedor.

Pronto: o botão "Continuar com Google" passa a funcionar no app local e no publicado, sem mudar código.

## 5. Publicar no GitHub Pages

O workflow `.github/workflows/deploy.yml` publica a cada push na `main`.

1. Em **Settings › Pages › Source**, escolha **GitHub Actions**.
2. Em **Settings › Secrets and variables › Actions**, crie `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY` (os mesmos valores do `.env`).
3. Em **Actions**, rode de novo o workflow "Deploy no GitHub Pages" para usar os secrets.

A chave publishable/anon pode ficar no app publicado, porque o acesso é protegido pelo RLS: cada aluno só lê e grava os próprios dados. A secret/service_role não pode.

## 6. Estrutura

```
src/
  screens/      telas: Entrar, NovaSenha, PrimeiroAcesso, Inicio, Licao, Resultado, Trilha, Revisar, Refazer, Perfil, Configuracoes, Pro
  components/   ícones, mascote, barra de navegação, campo de senha, questão, texto e fórmulas, sem vidas, anúncio premiado, cartão do Pro
  domain/       regras.ts (XP, vidas, coroas, sequência, revisão espaçada, conquistas)
  data/         repo.ts (contrato e erros em português), supabaseRepo.ts (banco), demoRepo.ts (navegador)
  state/        AppContext (usuário, dados, tema)
  styles/       global.css (cores, tipografia, modo noturno)
public/data/    conteudo.json (questões empacotadas, usadas também como reserva offline)
public/imagens/ figuras das questões
supabase/       migrations, seed e setup_completo.sql
scripts/        gerar-seed-sql.mjs e seed-supabase.mjs
```

## 7. Banco de dados

| Grupo | Tabelas |
|---|---|
| Conteúdo (leitura pública) | exames, editais, recortes, edital_conteudo, textos_base, questoes, alternativas, questao_figuras, conquistas |
| Aluno (só o dono, via RLS) | perfis, preferencias, xp_diario, sessoes_estudo, tentativas, progresso_tema, fila_revisao, progresso_unidade, usuario_conquistas, interesse_pro, assinaturas |
| Funções | gatilho que cria o perfil no cadastro (inclusive Google e sem login), `excluir_minha_conta()` (LGPD), `v_ranking_semana`, `v_resumo_conteudo` |

Usuários novos não precisam ser criados à mão: o cadastro no app (ou *Authentication › Users › Add user* no painel) dispara o gatilho, que cria o perfil e as preferências.

Em `recortes` ficam as **matérias** de cada exame; a coluna `area` agrupa as do ENEM (Linguagens, Humanas, Natureza, Matemática). O `assunto` da questão é o subconteúdo dentro da matéria.

Para adicionar um concurso, cadastre-o em `exames` (com `ativo = true`), as matérias em `recortes` e as questões em `questoes` e `alternativas`.

## 8. Comandos

| Comando | O que faz |
|---|---|
| `npm run dev` | ambiente local |
| `npm run build` | gera a pasta `dist` |
| `npm run preview` | testa o build |
| `npm run typecheck` | checa os tipos |
| `npm run seed` | carrega as questões no Supabase (precisa da chave secret no `.env`) |
| `npm run gerar-sql` | regera `supabase/seed/*.sql` a partir do `conteudo.json` |
