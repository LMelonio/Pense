/** Número com a palavra no singular ou no plural: plural(1, 'questão', 'questões') → "1 questão". */
export const plural = (n: number, um: string, varios: string) => `${n.toLocaleString('pt-BR')} ${n === 1 ? um : varios}`;
