/** Número com a palavra no singular ou no plural: plural(1, 'questão', 'questões') → "1 questão". */
export const plural = (n: number, um: string, varios: string) => `${n.toLocaleString('pt-BR')} ${n === 1 ? um : varios}`;

/** Minutos em horas e minutos: duracao(117) → "1 h 57 min", duracao(120) → "2 h", duracao(45) → "45 min". */
export function duracao(min: number) {
  const h = Math.floor(min / 60), m = min % 60;
  return h ? (m ? `${h} h ${m} min` : `${h} h`) : `${m} min`;
}
