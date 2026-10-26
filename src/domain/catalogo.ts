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
