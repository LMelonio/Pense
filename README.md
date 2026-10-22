# Pense · app de estudos para provas, concursos e seleções

React + Vite + TypeScript, banco no Supabase e publicação no GitHub Pages.
Primeiro conteúdo: 366 questões do ENEM 2024/2025, com dicas, resposta e explicação.

---

## 1. Rodar no VS Code (5 min)

Pré-requisito: [Node.js 20+](https://nodejs.org).

```bash
npm install
npm run dev
```

O navegador abre em `http://localhost:5173`.

Sem as chaves do Supabase, o app roda em **modo demonstração**: tudo funciona e o progresso fica salvo no navegador.

## 2. Criar o banco no Supabase (10 min)

1. Crie um projeto em [supabase.com](https://supabase.com) (plano Free) e escolha a região **São Paulo**.
2. Abra o **SQL Editor** e rode `supabase/setup_completo.sql`. Ele cria as tabelas, as regras de acesso (RLS), os gatilhos e os dados base.
3. Carregue as questões. Escolha **um** caminho:
   - **SQL Editor:** rode os arquivos de `supabase/seed/` em ordem, de `01` a `05`.
   - **Terminal:** preencha `.env.local` (veja o passo 4) e rode `npm run seed`.
4. Copie `.env.example` para `.env.local` e preencha:
   - **URL e anon key:** em *Project Settings › API*, copie a **Project URL** e a **anon public key**.
   - **service_role:** só é necessária para o `npm run seed`. **Nunca vai para o GitHub.**
5. Em *Authentication › Sign In / Providers*:
   - ative **Allow anonymous sign-ins**. É o botão "Começar agora".
   - ative **Email**.
   - opcional: ative **Google**, com o Client ID e o Secret do Google Cloud.
6. Em *Authentication › URL Configuration*, coloque em **Site URL** e **Redirect URLs**:
   - `http://localhost:5173`
   - `https://SEU-USUARIO.github.io/NOME-DO-REPO/`
7. Rode `npm run dev` de novo. O aviso amarelo de demonstração some.

Para conferir o conteúdo carregado:

```sql
select * from v_resumo_conteudo;
```

Deve mostrar LC 100, CH 90, CN 87 e MT 89.

## 3. Publicar no GitHub Pages

```bash
git init
git add .
git commit -m "Pense v0.1"
git branch -M main
git remote add origin https://github.com/SEU-USUARIO/NOME-DO-REPO.git
git push -u origin main
```

No GitHub:

1. Em **Settings › Pages › Source**, escolha **GitHub Actions**.
2. Em **Settings › Secrets and variables › Actions**, crie `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY`.
3. Em **Actions**, rode de novo o workflow "Deploy no GitHub Pages". Ele também roda sozinho a cada push na `main`.

O endereço fica `https://SEU-USUARIO.github.io/NOME-DO-REPO/`.

A anon key pode ficar no app publicado, porque o acesso é protegido pelo RLS: cada aluno só lê e grava os próprios dados. A service_role não pode ficar.

## 4. Estrutura

```
src/
  screens/      telas: Entrar, ProvaAlvo, Inicio, Licao, Resultado, Trilha, Revisar, Refazer, Perfil, Configuracoes
  components/   ícones, mascote, barra de navegação, questão, renderização de texto e fórmulas
  domain/       regras.ts (XP, vidas, coroas, sequência, revisão espaçada, conquistas)
  data/         repo.ts (contrato), supabaseRepo.ts (banco), demoRepo.ts (navegador)
  state/        AppContext (usuário, dados, tema)
  styles/       global.css (cores, tipografia, modo noturno)
public/data/    conteudo.json (questões empacotadas, usadas também como reserva offline)
public/imagens/ figuras das questões
supabase/       migrations, seed e setup_completo.sql
scripts/        gerar-seed-sql.mjs e seed-supabase.mjs
```

## 5. Banco de dados

| Grupo | Tabelas |
|---|---|
| Conteúdo (leitura pública) | exames, editais, recortes, edital_conteudo, textos_base, questoes, alternativas, questao_figuras, conquistas |
| Aluno (só o dono, via RLS) | perfis, preferencias, xp_diario, sessoes_estudo, tentativas, progresso_tema, fila_revisao, progresso_unidade, usuario_conquistas, interesse_pro, assinaturas |
| Funções | gatilho que cria o perfil no cadastro, `excluir_minha_conta()` (LGPD), `v_ranking_semana`, `v_resumo_conteudo` |

Para adicionar um concurso, cadastre-o em `exames` (com `ativo = true`), as matérias em `recortes` e as questões em `questoes` e `alternativas`.

## 6. Comandos

| Comando | O que faz |
|---|---|
| `npm run dev` | ambiente local |
| `npm run build` | gera a pasta `dist` |
| `npm run preview` | testa o build |
| `npm run typecheck` | checa os tipos |
| `npm run seed` | carrega as questões no Supabase (precisa da service_role no `.env.local`) |
| `npm run gerar-sql` | regera `supabase/seed/*.sql` a partir do `conteudo.json` |
