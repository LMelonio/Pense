import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react';
import type { ReactNode } from 'react';
import { repo } from '../lib/config';
import { erroDoRetorno, limparRetornoDaUrl } from '../data/repo';
import type { Mudancas, Usuario } from '../data/repo';
import type { Conteudo, DadosAluno } from '../data/types';

interface Ctx {
  conteudo: Conteudo | null;
  usuario: Usuario | null;
  dados: DadosAluno | null;
  carregando: boolean;
  erro: string | null;
  atualizar: (fn: (d: DadosAluno) => DadosAluno, m: Mudancas) => Promise<DadosAluno | null>;
  avisar: (msg: string) => void;
  recarregar: () => Promise<void>;
}

const AppCtx = createContext<Ctx | null>(null);

export function useApp() {
  const c = useContext(AppCtx);
  if (!c) throw new Error('useApp fora do AppProvider');
  return c;
}

/** Dados garantidos (usar só em telas protegidas). */
export function useDados() {
  const c = useApp();
  return { ...c, dados: c.dados!, conteudo: c.conteudo! };
}

function aplicarAparencia(d: DadosAluno | null) {
  const root = document.documentElement;
  const tema = d?.prefs.tema ?? 'claro';
  const escuro = tema === 'escuro' || (tema === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches);
  root.dataset.theme = escuro ? 'dark' : 'light';
  root.dataset.size = d?.prefs.tamanho_texto ?? 'padrao';
  root.dataset.motion = d?.prefs.reduzir_animacoes ? 'reduce' : 'full';
}

export function AppProvider({ children }: { children: ReactNode }) {
  const [conteudo, setConteudo] = useState<Conteudo | null>(null);
  const [usuario, setUsuario] = useState<Usuario | null>(null);
  const [dados, setDados] = useState<DadosAluno | null>(null);
  const [carregando, setCarregando] = useState(true);
  const [erro, setErro] = useState<string | null>(null);
  const [toast, setToast] = useState<string | null>(null);
  const dadosRef = useRef<DadosAluno | null>(null);
  const timer = useRef<number>();

  const avisar = useCallback((msg: string) => {
    setToast(msg);
    window.clearTimeout(timer.current);
    timer.current = window.setTimeout(() => setToast(null), 3200);
  }, []);

  const carregarUsuario = useCallback(async (u: Usuario | null) => {
    setUsuario(u);
    if (!u) { dadosRef.current = null; setDados(null); return; }
    try {
      const d = await repo.carregarDados(u);
      dadosRef.current = d; setDados(d);
    } catch (e) {
      setErro((e as Error).message);
    }
  }, []);

  const recarregar = useCallback(async () => {
    setCarregando(true);
    try {
      const [c, u] = await Promise.all([repo.carregarConteudo(), repo.usuarioAtual()]);
      setConteudo(c);
      await carregarUsuario(u);
      setErro(null);
      // Já logado e voltou com erro na URL (ex.: a conta Google já é de outro usuário). Sem login, a tela Entrar mostra.
      const erroUrl = u && erroDoRetorno();
      if (erroUrl) { avisar(erroUrl); limparRetornoDaUrl(); }
    } catch (e) {
      setErro((e as Error).message);
    } finally {
      setCarregando(false);
    }
  }, [carregarUsuario, avisar]);

  useEffect(() => {
    recarregar();
    return repo.aoMudarUsuario((u) => {
      if (u?.id !== dadosRef.current?.perfil.id || !u) carregarUsuario(u);
      else setUsuario(u);
    });
  }, [recarregar, carregarUsuario]);

  useEffect(() => aplicarAparencia(dados), [dados]);

  const atualizar = useCallback(async (fn: (d: DadosAluno) => DadosAluno, m: Mudancas) => {
    const atual = dadosRef.current;
    if (!atual) return null;
    const novo = fn(atual);
    dadosRef.current = novo; setDados(novo);
    try { await repo.salvar(novo, m); } catch (e) { avisar('Não deu para salvar agora: ' + (e as Error).message); }
    return novo;
  }, [avisar]);

  // Visitante que salvou o progresso com o Google: o perfil passa a usar o nome da conta Google.
  const nomeConta = usuario && !usuario.anonimo && usuario.nome && usuario.nome !== 'Estudante' ? usuario.nome : null;
  useEffect(() => {
    if (nomeConta && dados?.perfil.nome === 'Estudante') atualizar((d) => ({ ...d, perfil: { ...d.perfil, nome: nomeConta } }), { perfil: true });
  }, [nomeConta, dados?.perfil.nome, atualizar]);

  return (
    <AppCtx.Provider value={{ conteudo, usuario, dados, carregando, erro, atualizar, avisar, recarregar }}>
      {children}
      {toast && <div className="toast" role="status">{toast}</div>}
    </AppCtx.Provider>
  );
}
