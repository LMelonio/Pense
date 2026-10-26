// Suíte de contrato do seam Repo: as mesmas sessões contra os dois adaptadores, com as mesmas expectativas.
//   - modo demonstração: o demoRepo, com localStorage falso (faz o papel do servidor com domain/sessoes.ts);
//   - banco: o supabaseRepo de verdade, com um cliente que fala com o PGlite (as funções das migrations).
// Se uma regra mudar só de um lado, esta suíte falha.
// Antes, uma vez: npm install --no-save @electric-sql/pglite@0.2.17
import { beforeAll, describe, expect, test, vi } from 'vitest';
import { clienteFalso, conteudo, criarAluno, criarBanco, passarDias } from './testes/banco';
import type { Banco } from './testes/banco';
import { criarSupabaseRepo } from '../data/supabaseRepo';
import { demoRepo } from '../data/demoRepo';
import type { Repo, Usuario } from '../data/repo';
import type { DadosAluno, Tentativa } from '../data/types';
import { chaveTema, chaveUnidade, hoje, montarDesafio, montarLicao, primeiraLicao, revisaoVencida, temasDoRecorte, unidadesDoRecorte, vidaPeloTreino, vidasAgora } from './regras';

const DIA = 86400000;

// O que o demoRepo usa do navegador
class Armazenamento {
  private m = new Map<string, string>();
  get length() { return this.m.size; }
  key(i: number) { return [...this.m.keys()][i] ?? null; }
  getItem(k: string) { return this.m.get(k) ?? null; }
  setItem(k: string, v: string) { this.m.set(k, String(v)); }
  removeItem(k: string) { this.m.delete(k); }
  clear() { this.m.clear(); }
}
vi.stubGlobal('localStorage', new Armazenamento());
vi.stubGlobal('fetch', async () => ({ ok: true, json: async () => conteudo }));

interface AlunoDeTeste {
  repo: Repo;
  dados(): Promise<DadosAluno>;
  /** O tempo passa: as datas guardadas do aluno recuam N dias. */
  passarDias(n: number): Promise<void>;
}

/** "Passa o tempo" no modo demonstração, como passarDias faz no banco. */
function passarDiasDemo(id: string, n: number) {
  const ms = n * DIA;
  const recua = (iso: string) => new Date(Date.parse(iso) - ms).toISOString();
  const recuaDia = (dia: string) => hoje(Date.parse(`${dia}T12:00:00`) - ms);
  const editar = <T,>(k: string, f: (v: T) => T) => { const v = localStorage.getItem(k); if (v) localStorage.setItem(k, JSON.stringify(f(JSON.parse(v) as T))); };
  editar<DadosAluno>(`pense:demo:dados:${id}`, (d) => ({
    ...d,
    perfil: {
      ...d.perfil, vidas_atualizadas_em: recua(d.perfil.vidas_atualizadas_em), ultimo_dia_meta: d.perfil.ultimo_dia_meta && recuaDia(d.perfil.ultimo_dia_meta),
      dia_vida_revisao: d.perfil.dia_vida_revisao && recuaDia(d.perfil.dia_vida_revisao)
    },
    xpDia: Object.fromEntries(Object.entries(d.xpDia).map(([dia, xp]) => [recuaDia(dia), xp])),
    revisao: Object.fromEntries(Object.entries(d.revisao).map(([q, r]) => [q, { ...r, vence_em: recua(r.vence_em) }]))
  }));
  editar<Record<string, { inicio: string }>>(`pense:demo:sessoes:${id}`, (s) => Object.fromEntries(Object.entries(s).map(([k, x]) => [k, { ...x, inicio: recua(x.inicio) }])));
  editar<number[]>(`pense:demo:anuncios:${id}`, (a) => a.map((t) => t - ms));
}

let db: Banco;
beforeAll(async () => { db = await criarBanco(); });

const ADAPTADORES: { nome: string; novoAluno: () => Promise<AlunoDeTeste> }[] = [
  {
    nome: 'modo demonstração (demoRepo)',
    novoAluno: async () => {
      await demoRepo.entrarAnonimo();
      const u = (await demoRepo.usuarioAtual())!;
      return { repo: demoRepo, dados: () => demoRepo.carregarDados(u), passarDias: async (n) => passarDiasDemo(u.id, n) };
    }
  },
  {
    nome: 'banco (supabaseRepo + PGlite)',
    novoAluno: async () => {
      const a = await criarAluno(db);
      const repo = criarSupabaseRepo(clienteFalso(db, a.id), 'http://banco-local', 'chave-local');
      const u: Usuario = { id: a.id, email: null, anonimo: true, nome: 'Estudante', provedor: 'anonimo' };
      return { repo, dados: () => repo.carregarDados(u), passarDias: (n) => passarDias(db, a.id, n) };
    }
  }
];

const semSorteio = <T,>(xs: T[]) => xs;
const gab = Object.fromEntries(conteudo.questoes.map((q) => [q.id, q.gabarito]));
const erradas = (id: string) => ['A', 'B', 'C', 'D', 'E'].filter((l) => l !== gab[id]);
const resposta = (questao_id: string, letra: string | null, origem: Tentativa['origem'], dicas_usadas = 0): Tentativa =>
  ({ questao_id, letra, correta: letra === gab[questao_id], dicas_usadas, viu_resolucao: !letra, tempo_ms: 1000, origem });
const diasAte = (iso: string) => Math.round((Date.parse(iso) - Date.now()) / DIA);
const meiaNoiteDeAmanha = () => { const d = new Date(); d.setHours(24, 0, 0, 0); return d.getTime(); };
const primeiroTema = (recorte: string) => temasDoRecorte(conteudo, recorte, 'Inglês')[0].assunto;
const MAT = 'enem-MAT', HIS = 'enem-HIS', SOC = 'enem-SOC', ING = 'enem-ING';

/** Uma lição como o app faz: monta (sem sorteio), abre a sessão, responde em ordem e conclui. */
async function licao(a: AlunoDeTeste, recorte_id: string, assunto: string, certas: number, quantas = 5) {
  const ids = montarLicao(conteudo, await a.dados(), recorte_id, assunto, 5, semSorteio).map((q) => q.id);
  const s = await a.repo.iniciarSessao({ tipo: 'licao', exame_id: 'enem', recorte_id, assunto, unidade: null, questoes: ids });
  for (const [i, id] of ids.slice(0, quantas).entries()) await a.repo.responder(s, resposta(id, i < certas ? gab[id] : erradas(id)[0], 'licao'));
  return { ids, s, resumo: await a.repo.concluirSessao(s) };
}
const revisao = (a: AlunoDeTeste) => a.repo.iniciarSessao({ tipo: 'revisao', exame_id: 'enem', recorte_id: null, assunto: null, unidade: null, questoes: null });

test('o fuso dos testes é o de Brasília (dia e "amanhã" iguais no app e no banco)', () => {
  expect(Intl.DateTimeFormat().resolvedOptions().timeZone).toBe('America/Sao_Paulo');
});

describe.each(ADAPTADORES)('$nome', ({ novoAluno }) => {
  test('lição perfeita: 55 XP, Prata direto, meta, sequência e conquistas', async () => {
    const a = await novoAluno();
    const tema = primeiroTema(MAT);
    const { ids, resumo } = await licao(a, MAT, tema, 5);
    expect({ ...resumo, conquistas: [...resumo.conquistas].sort() }) // a ordem das conquistas não importa
      .toEqual({ acertos: 5, total: 5, xp: 55, perfeita: true, aprovado: null, conquistas: ['licao_perfeita', 'primeiro_passo'], coroaAntes: 0, coroaDepois: 2, vidaGanha: false });
    const d = await a.dados();
    expect(d.perfil).toMatchObject({ xp_total: 55, questoes_feitas: 5, acertos_total: 5, sequencia_atual: 1, sequencia_recorde: 1, ultimo_dia_meta: hoje() });
    expect(d.xpDia[hoje()]).toBe(55);
    expect(d.temas[chaveTema(MAT, tema)]).toMatchObject({ coroa: 2, dominio: 100, licoes: 1, historico: [true, true, true, true, true] });
    expect(Object.keys(d.conquistas).sort()).toEqual(['licao_perfeita', 'primeiro_passo']);
    expect([...d.acertadas].sort()).toEqual([...ids].sort());
    expect([...d.vistas].sort()).toEqual([...ids].sort());
  });

  test('lição com erros: gasta vidas, a revisão vence amanhã à meia-noite e o acerto vale 10 XP', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids, resumo } = await licao(a, HIS, primeiroTema(HIS), 3);
    expect(resumo).toMatchObject({ acertos: 3, total: 5, xp: 30, perfeita: false, coroaAntes: 0 });
    const d = await a.dados();
    expect(vidasAgora(d.perfil).vidas).toBe(1);
    for (const id of ids.slice(3)) {
      expect(d.revisao[id]).toMatchObject({ status: 'pendente', repeticoes: 0, lapsos: 0, ultima_letra: erradas(id)[0] });
      expect(Date.parse(d.revisao[id].vence_em)).toBe(meiaNoiteDeAmanha());
    }
  });

  test('revisão vencida: 5 XP sem dica (domina), 4 XP com 1 dica (volta em 3 dias), errou duas vezes (volta amanhã)', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 2);
    await a.passarDias(1);
    const [x, y, z] = ids.slice(2);
    const s = await revisao(a);
    await a.repo.responder(s, resposta(x, gab[x], 'revisao'));
    await a.repo.abrirDica(s, y, 1);
    await a.repo.responder(s, resposta(y, gab[y], 'revisao', 0)); // a dica aberta conta mesmo se a tela mandar 0
    await a.repo.responder(s, resposta(z, erradas(z)[0], 'revisao'));
    await a.repo.responder(s, resposta(z, erradas(z)[1], 'revisao'));
    await expect(a.repo.responder(s, resposta(z, gab[z], 'revisao')), 'terceira tentativa').rejects.toThrow();
    const r = await a.repo.concluirSessao(s);
    expect(r).toMatchObject({ acertos: 2, total: 3, xp: 9, aprovado: null, vidaGanha: false }); // vidas cheias: a vida do dia fica guardada
    expect(await a.repo.concluirSessao(s), 'concluir de novo devolve o mesmo resumo').toEqual(r);
    const d = await a.dados();
    expect(d.revisao[x]).toMatchObject({ status: 'dominada', repeticoes: 1 });
    expect(diasAte(d.revisao[x].vence_em)).toBe(7);
    expect(d.revisao[y]).toMatchObject({ status: 'pendente', repeticoes: 1 });
    expect(diasAte(d.revisao[y].vence_em)).toBe(3);
    expect(d.revisao[z]).toMatchObject({ status: 'pendente', lapsos: 1 });
    expect(Date.parse(d.revisao[z].vence_em)).toBe(meiaNoiteDeAmanha());
    expect(d.perfil).toMatchObject({ revisoes_concluidas: 1, xp_total: 55 + 20 + 9 });
    await expect(a.repo.responder(s, resposta(z, gab[z], 'revisao')), 'responder depois de concluir').rejects.toThrow();
  });

  test('desafio: abre com os temas da unidade feitos; 70% com todas respondidas aprova e libera a unidade', async () => {
    const a = await novoAluno();
    const R = 'enem-TIC';
    const un = unidadesDoRecorte(conteudo, R, 'Inglês');
    const nova = (questoes: string[]) => ({ tipo: 'desafio' as const, exame_id: 'enem', recorte_id: R, assunto: null, unidade: 0, questoes });
    await expect(a.repo.iniciarSessao(nova(montarDesafio(conteudo, await a.dados(), un[0], semSorteio).map((q) => q.id))), 'bloqueado').rejects.toThrow();
    for (const t of un[0]) await licao(a, R, t.assunto, 5);
    const ids = montarDesafio(conteudo, await a.dados(), un[0], semSorteio).map((q) => q.id);
    const s = await a.repo.iniciarSessao(nova(ids));
    const certas = Math.ceil(ids.length * 0.7);
    for (const [i, id] of ids.entries()) await a.repo.responder(s, resposta(id, i < certas ? gab[id] : erradas(id)[0], 'desafio'));
    const r = await a.repo.concluirSessao(s);
    expect(r).toMatchObject({ aprovado: true, perfeita: false, total: ids.length, acertos: certas, coroaAntes: 0, coroaDepois: 0 });
    const d = await a.dados();
    expect(d.unidades[chaveUnidade(R, 0)]).toBe(true);
    expect(vidasAgora(d.perfil).vidas, 'o desafio não gasta vidas').toBe(3);
  });

  test('F2-05 · a primeira lição não gasta vida; a segunda gasta', async () => {
    const a = await novoAluno();
    const { resumo } = await licao(a, MAT, primeiroTema(MAT), 0);
    expect(resumo).toMatchObject({ acertos: 0, total: 5, xp: 0 });
    expect(vidasAgora((await a.dados()).perfil).vidas, '1ª lição com 5 erros').toBe(3);
    expect(Object.keys((await a.dados()).revisao), 'os erros vão para a revisão').toHaveLength(5);
    await licao(a, HIS, primeiroTema(HIS), 4);
    expect(vidasAgora((await a.dados()).perfil).vidas, '2ª lição com 1 erro').toBe(2);
  });

  test('F2-01 · revisão adiantada (questão que ainda não venceu): acerto é treino, sem XP, sem vida e volta amanhã', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 4);
    const x = ids[4];
    const s = await revisao(a);
    await a.repo.responder(s, resposta(x, gab[x], 'revisao'));
    const r = await a.repo.concluirSessao(s);
    expect(r).toMatchObject({ acertos: 1, total: 1, xp: 0, vidaGanha: false });
    const d = await a.dados();
    expect(d.revisao[x]).toMatchObject({ status: 'pendente', repeticoes: 0, lapsos: 0 });
    expect(Date.parse(d.revisao[x].vence_em)).toBe(meiaNoiteDeAmanha());
    expect(vidasAgora(d.perfil).vidas).toBe(2);
    expect(d.perfil.xp_total).toBe(55 + 40);
  });

  test('F2-02 · a vida da revisão vem só de questão vencida, no máximo 1 por dia', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 2); // 3 erros
    const [x, y, z] = ids.slice(2);
    await a.passarDias(1); // vencem (e as vidas recarregam)
    await licao(a, MAT, primeiroTema(MAT), 3); // 2 erros: 1 vida
    expect(vidasAgora((await a.dados()).perfil).vidas).toBe(1);
    const s1 = await revisao(a);
    await a.repo.responder(s1, resposta(x, gab[x], 'revisao'));
    expect(await a.repo.concluirSessao(s1), '1ª revisão do dia').toMatchObject({ acertos: 1, xp: 5, vidaGanha: true });
    expect(vidasAgora((await a.dados()).perfil).vidas).toBe(2);
    const s2 = await revisao(a);
    await a.repo.responder(s2, resposta(y, gab[y], 'revisao'));
    expect(await a.repo.concluirSessao(s2), '2ª revisão do dia').toMatchObject({ acertos: 1, xp: 5, vidaGanha: false });
    expect(vidasAgora((await a.dados()).perfil).vidas).toBe(2);
    await a.passarDias(1);
    await licao(a, ING, primeiroTema(ING), 3); // no dia seguinte: gasta 2 de novo
    const s3 = await revisao(a);
    await a.repo.responder(s3, resposta(z, gab[z], 'revisao'));
    expect(await a.repo.concluirSessao(s3), 'no dia seguinte, vale de novo').toMatchObject({ vidaGanha: true });
  });

  test('F2-03 · questão dominada volta depois de 7 dias para confirmar; acertando de novo, volta em 21', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 4);
    const x = ids[4];
    await a.passarDias(1);
    const s1 = await revisao(a);
    await a.repo.responder(s1, resposta(x, gab[x], 'revisao'));
    await a.repo.concluirSessao(s1);
    expect((await a.dados()).revisao[x]).toMatchObject({ status: 'dominada', repeticoes: 1 });
    expect(revisaoVencida(await a.dados()).map((r) => r.questao_id), 'antes dos 7 dias, não volta').not.toContain(x);
    await a.passarDias(7);
    expect(revisaoVencida(await a.dados()).map((r) => r.questao_id), 'com 7 dias, volta na revisão do dia').toContain(x);
    const s2 = await revisao(a);
    await a.repo.responder(s2, resposta(x, gab[x], 'revisao'));
    expect(await a.repo.concluirSessao(s2)).toMatchObject({ acertos: 1, xp: 5 });
    const d = await a.dados();
    expect(d.revisao[x]).toMatchObject({ status: 'dominada', repeticoes: 2 });
    expect(diasAte(d.revisao[x].vence_em)).toBe(21);
  });

  test('F2-03 · dominada que volta e é errada volta a ser pendente', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 4);
    const x = ids[4];
    await a.passarDias(1);
    const s1 = await revisao(a);
    await a.repo.responder(s1, resposta(x, gab[x], 'revisao'));
    await a.repo.concluirSessao(s1);
    await a.passarDias(7);
    const s2 = await revisao(a);
    await a.repo.responder(s2, resposta(x, erradas(x)[0], 'revisao'));
    await a.repo.responder(s2, resposta(x, erradas(x)[1], 'revisao'));
    expect(await a.repo.concluirSessao(s2)).toMatchObject({ acertos: 0, xp: 0 });
    const d = await a.dados();
    expect(d.revisao[x]).toMatchObject({ status: 'pendente', lapsos: 1 });
    expect(Date.parse(d.revisao[x].vence_em)).toBe(meiaNoiteDeAmanha());
  });

  test('F2-06 · acerto na 2ª tentativa conta como 1 dica: 4 XP sem dica, 3 XP com 1 dica, e volta em 3 dias', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 3);
    const [x, y] = ids.slice(3);
    await a.passarDias(1);
    const s = await revisao(a);
    await a.repo.responder(s, resposta(x, erradas(x)[0], 'revisao'));
    await a.repo.responder(s, resposta(x, gab[x], 'revisao'));
    await a.repo.abrirDica(s, y, 1);
    await a.repo.responder(s, resposta(y, erradas(y)[0], 'revisao', 1));
    await a.repo.responder(s, resposta(y, gab[y], 'revisao', 1));
    expect(await a.repo.concluirSessao(s)).toMatchObject({ acertos: 2, total: 2, xp: 4 + 3 });
    const d = await a.dados();
    expect(d.revisao[x], 'sem dica, mas na 2ª tentativa: não domina').toMatchObject({ status: 'pendente', repeticoes: 1 });
    expect(diasAte(d.revisao[x].vence_em)).toBe(3);
    expect(d.revisao[y], 'com dica, volta em 3 dias').toMatchObject({ status: 'pendente', repeticoes: 1 });
    expect(diasAte(d.revisao[y].vence_em)).toBe(3);
  });

  test('F2-05 · lição abandonada depois de responder: a próxima já gasta vida', async () => {
    const a = await novoAluno();
    const abrir = async (recorte_id: string) => {
      const ids = montarLicao(conteudo, await a.dados(), recorte_id, primeiroTema(recorte_id), 5, semSorteio).map((q) => q.id);
      return { ids, s: await a.repo.iniciarSessao({ tipo: 'licao', exame_id: 'enem', recorte_id, assunto: primeiroTema(recorte_id), unidade: null, questoes: ids }) };
    };
    await abrir(SOC); // abriu e fechou o app sem responder: continua sendo a 1ª lição
    expect(primeiraLicao(await a.dados())).toBe(true);
    const { ids, s } = await abrir(MAT);
    await a.repo.responder(s, resposta(ids[0], erradas(ids[0])[0], 'licao')); // errou e fechou o app, sem concluir
    const d = await a.dados();
    expect(vidasAgora(d.perfil).vidas, 'a 1ª lição não gastou').toBe(3);
    expect(primeiraLicao(d), 'o app também sabe que a próxima gasta').toBe(false);
    await licao(a, HIS, primeiroTema(HIS), 4);
    expect(vidasAgora((await a.dados()).perfil).vidas, 'a próxima gasta').toBe(2);
  });

  test('a saída do 1º dia: sem vidas e nada vencido, o primeiro treino devolve 1 vida; uma vez só', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    const { ids } = await licao(a, HIS, primeiroTema(HIS), 3); // 2 erros: 1 vida
    const [x, y] = ids.slice(3);
    const s1 = await revisao(a);
    await a.repo.responder(s1, resposta(x, gab[x], 'revisao'));
    expect(await a.repo.concluirSessao(s1), 'com vida sobrando, o treino não usa a exceção').toMatchObject({ acertos: 1, xp: 0, vidaGanha: false });
    const { ids: ids2 } = await licao(a, MAT, primeiroTema(MAT), 4); // 1 erro: sem vidas
    expect(vidaPeloTreino(await a.dados()), 'o app oferece a vida pelo treino').toBe(true);
    const s2 = await revisao(a);
    await a.repo.responder(s2, resposta(y, gab[y], 'revisao'));
    expect(await a.repo.concluirSessao(s2), '1ª vez sem vidas').toMatchObject({ acertos: 1, xp: 0, vidaGanha: true });
    let d = await a.dados();
    expect(vidasAgora(d.perfil).vidas).toBe(1);
    expect(d.perfil.dia_vida_revisao).toBe(hoje());
    expect(d.revisao[y], 'continua treino: volta amanhã').toMatchObject({ status: 'pendente', repeticoes: 0 });
    // No dia seguinte (vidas cheias), revisa tudo; depois perde as vidas com erros novos, sem nada vencido
    await a.passarDias(1);
    const s3 = await revisao(a);
    for (const id of [x, y, ids2[4]]) await a.repo.responder(s3, resposta(id, gab[id], 'revisao'));
    expect(await a.repo.concluirSessao(s3), 'vidas cheias: sem vida').toMatchObject({ acertos: 3, xp: 15, vidaGanha: false });
    const { ids: ids3 } = await licao(a, ING, primeiroTema(ING), 2); // 3 erros: sem vidas
    d = await a.dados();
    expect(vidasAgora(d.perfil).vidas).toBe(0);
    expect(revisaoVencida(d)).toHaveLength(0);
    expect(vidaPeloTreino(d), 'a exceção já foi usada').toBe(false);
    const s4 = await revisao(a);
    await a.repo.responder(s4, resposta(ids3[2], gab[ids3[2]], 'revisao'));
    expect(await a.repo.concluirSessao(s4), 'a exceção vale uma vez só').toMatchObject({ acertos: 1, xp: 0, vidaGanha: false });
  });

  test('anúncio: +1 vida na hora, até 5 em 24 horas', async () => {
    const a = await novoAluno();
    await licao(a, SOC, primeiroTema(SOC), 5);
    await licao(a, HIS, primeiroTema(HIS), 0, 3); // 3 erros: sem vidas
    expect(vidasAgora((await a.dados()).perfil).vidas).toBe(0);
    await a.repo.ganharVidaAnuncio();
    expect(vidasAgora((await a.dados()).perfil).vidas).toBe(1);
    for (let i = 0; i < 4; i++) await a.repo.ganharVidaAnuncio();
    await expect(a.repo.ganharVidaAnuncio()).rejects.toThrow(/5 vidas com anúncios/);
    await a.passarDias(1);
    await expect(a.repo.ganharVidaAnuncio(), 'no dia seguinte, de novo').resolves.toBeUndefined();
  });
});
