// Ciclo de vida de uma sessão (lição, desafio ou revisão) do lado do app. Interface pequena:
//   responder(t)          → registra a resposta no servidor (em ordem, sem travar a tela)
//   abrirDica(questao, n) → registra a dica aberta (revisão)
//   concluir(respostas)   → fecha no servidor, relê os dados do aluno e devolve o resumo oficial (null se falhar)
// Por dentro: abre a sessão só no primeiro uso, mantém a fila em ordem e reenvia as respostas que falharam por rede
// (o servidor ignora as repetidas). No modo demonstração, o "servidor" é o demoRepo, com as mesmas regras.
import { useCallback, useRef } from 'react';
import { repo } from '../lib/config';
import { falhaDeRede } from '../data/repo';
import type { NovaSessao, ResumoSessao, Tentativa } from '../data/types';
import { useAviso, useProgresso } from './AppContext';

export function useSessaoEstudo(nova: () => NovaSessao, rotulo: string) {
  const { sincronizar } = useProgresso();
  const avisar = useAviso();
  const idRef = useRef<Promise<string> | null>(null);
  const filaRef = useRef<Promise<void>>(Promise.resolve());
  const falhou = useRef(false);
  const novaRef = useRef(nova);
  novaRef.current = nova;

  const sessao = useCallback(() => {
    idRef.current ??= repo.iniciarSessao(novaRef.current()).catch((e) => { idRef.current = null; throw e; });
    return idRef.current;
  }, []);

  const enfileirar = useCallback((f: (id: string) => Promise<void>) => {
    filaRef.current = filaRef.current.then(async () => { await f(await sessao()); }).catch(() => { falhou.current = true; });
  }, [sessao]);

  const responder = useCallback((t: Tentativa) => enfileirar((id) => repo.responder(id, t)), [enfileirar]);
  const abrirDica = useCallback((questao_id: string, n: number) => enfileirar((id) => repo.abrirDica(id, questao_id, n)), [enfileirar]);

  /** Fecha a sessão. Sem nenhuma resposta, não chama o servidor. Uma falha vira aviso e devolve null. */
  const concluir = useCallback(async (respostas: Tentativa[]): Promise<ResumoSessao | null> => {
    if (!respostas.length) return null;
    try {
      await filaRef.current;
      // Reenvio: o servidor ignora as repetidas e recusa a que veio depois da resolução; só a falha de rede interrompe.
      if (falhou.current) {
        for (const t of respostas.filter((x) => x.letra)) {
          await repo.responder(await sessao(), t).catch((e) => { if (falhaDeRede(e)) throw e; });
        }
      }
      const resumo = await repo.concluirSessao(await sessao());
      await sincronizar();
      return resumo;
    } catch (e) {
      avisar(`Não deu para salvar ${rotulo}. ${(e as Error).message}`);
      sincronizar();
      return null;
    }
  }, [avisar, rotulo, sessao, sincronizar]);

  return { responder, abrirDica, concluir };
}
