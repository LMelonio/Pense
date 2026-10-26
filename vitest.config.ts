// Testes das regras (src/domain) e do banco (PGlite). Fuso fixo: "hoje" e "amanhã" saem iguais em qualquer máquina.
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    include: ['src/**/*.test.ts'],
    environment: 'node',
    env: { TZ: 'America/Sao_Paulo' },
    testTimeout: 60000,
    hookTimeout: 120000
  }
});
