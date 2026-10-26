// Tipos do conteúdo (multi-prova) e do progresso do aluno.

export type TipoExame = 'exame_nacional' | 'vestibular' | 'concurso' | 'processo_seletivo';
export type Formato = '5_alternativas' | '4_alternativas' | 'certo_errado';
export type Dificuldade = 'fácil' | 'média' | 'difícil';

export interface Exame { id: string; nome: string; tipo: TipoExame; organizador: string; ativo: boolean }
/** Matéria do exame (Português, Inglês, História…). area agrupa as matérias do ENEM (Linguagens, Humanas…). */
export interface Recorte { id: string; exame_id: string; sigla: string; nome: string; cor: string; ordem: number; area?: string | null }
export interface Figura { imagem: string; descricao: string }
export interface Alternativa { letra: string; texto: string | null; imagem: string | null }

export interface Questao {
  id: string;
  exame_id: string;
  recorte_id: string;
  banca: string | null;
  orgao: string | null;
  cargo: string | null;
  ano: number;
  numero: number | null;
  formato: Formato;
  disciplina: string | null;
  assunto: string;
  topico: string | null;
  lingua: string | null;
  texto_base_id: string | null;
  texto_apoio: string | null;
  comando: string;
  figuras: Figura[];
  alternativas: Alternativa[];
  gabarito: string;
  dica1: string | null;
  dica2: string | null;
  explicacao: string | null;
  dificuldade: Dificuldade | null;
}

export interface Conteudo {
  exames: Exame[];
  recortes: Recorte[];
  textos_base: Record<string, string>;
  questoes: Questao[];
}

export interface Perfil {
  id: string;
  nome: string;
  usuario: string | null;
  xp_total: number;
  vidas: number;
  vidas_atualizadas_em: string;
  sequencia_atual: number;
  sequencia_recorde: number;
  ultimo_dia_meta: string | null;
  questoes_feitas: number;
  acertos_total: number;
  revisoes_concluidas: number;
  /** Dia (AAAA-MM-DD, no fuso do aluno) em que a revisão já devolveu a vida: 1 por dia. */
  dia_vida_revisao: string | null;
}

export type Tema = 'claro' | 'escuro' | 'auto';
export type TamanhoTexto = 'padrao' | 'grande' | 'maior';

export interface Preferencias {
  exame_id: string;
  cargo: string | null;
  data_prova: string | null;
  lingua: 'Inglês' | 'Espanhol';
  meta_xp: number;
  lembrete_ativo: boolean;
  lembrete_hora: string;
  explicacao_imediata: boolean;
  tema: Tema;
  tamanho_texto: TamanhoTexto;
  sons: boolean;
  vibracao: boolean;
  reduzir_animacoes: boolean;
  ranking_visivel: boolean;
  responsavel_email: string | null;
  onboarding_ok: boolean;
}

export interface ProgressoTema {
  recorte_id: string;
  assunto: string;
  dominio: number; // 0 a 100
  coroa: number; // 0 novo, 1 bronze, 2 prata, 3 ouro
  licoes: number;
  historico: boolean[]; // últimas 10 respostas
  ultima_pratica: string | null;
}

export interface ItemRevisao {
  questao_id: string;
  vence_em: string;
  repeticoes: number;
  lapsos: number;
  status: 'pendente' | 'dominada';
  ultima_letra: string | null;
}

export interface Tentativa {
  questao_id: string;
  letra: string | null;
  correta: boolean;
  dicas_usadas: number;
  viu_resolucao: boolean;
  tempo_ms: number;
  origem: 'licao' | 'revisao' | 'desafio';
}

export interface Sessao {
  tipo: 'licao' | 'revisao' | 'desafio';
  exame_id: string;
  recorte_id: string | null;
  assunto: string | null;
  inicio: string;
  fim: string;
  acertos: number;
  total: number;
  xp: number;
  perfeita: boolean;
}

/** Início de uma lição, desafio ou revisão. Lição e desafio levam as questões montadas (o servidor confere a lista). */
export type NovaSessao = Pick<Sessao, 'tipo' | 'exame_id' | 'recorte_id' | 'assunto'> & { unidade: number | null; questoes: string[] | null };

/** Resultado de uma sessão: calculado pelo banco (concluir_sessao) ou, no modo demonstração, com as mesmas regras (domain/sessoes.ts). */
export interface ResumoSessao {
  acertos: number; total: number; xp: number; perfeita: boolean; aprovado: boolean | null;
  conquistas: string[]; coroaAntes: number; coroaDepois: number;
  /** Revisão: devolveu a vida do dia. */
  vidaGanha: boolean;
}

export interface DadosAluno {
  perfil: Perfil;
  prefs: Preferencias;
  temas: Record<string, ProgressoTema>; // chave: recorte_id|assunto
  revisao: Record<string, ItemRevisao>; // chave: questao_id
  xpDia: Record<string, number>; // chave: AAAA-MM-DD
  conquistas: Record<string, string>; // código -> data
  unidades: Record<string, boolean>; // recorte_id|n -> desafio concluído
  vistas: string[]; // questões já respondidas
  acertadas: string[]; // questões já acertadas (valem menos XP de novo)
  interessePro: string | null;
}

export const PREFS_PADRAO: Preferencias = {
  exame_id: 'enem',
  cargo: null,
  data_prova: null,
  lingua: 'Inglês',
  meta_xp: 30,
  lembrete_ativo: true,
  lembrete_hora: '19:00',
  explicacao_imediata: true,
  tema: 'claro',
  tamanho_texto: 'padrao',
  sons: true,
  vibracao: true,
  reduzir_animacoes: false,
  ranking_visivel: false,
  responsavel_email: null,
  onboarding_ok: false
};
