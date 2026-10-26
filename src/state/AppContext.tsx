// Estado do app em quatro contextos pequenos, para cada parte da tela só re-renderizar com o que usa:
//   Conta (usuário, carregando, erro), Conteúdo (questões, carregado uma vez), Progresso (dados do aluno, atualizar,
//   sincronizar) e Aviso (o toast). useApp() e useDados() juntam os quatro, para as telas.
import { createContext, useCallback, useContext, useEffect, useMemo, useRef, useState } from 'react';
import type { Context, ReactNode } from 'react';
import { repo } from '../lib/config';
import { erroDoRetorno, limparRetornoDaUrl } from '../data/repo';
import type { Mudancas, Usuario } from '../data/repo';
import type { Conteudo, DadosAluno } from '../data/types';

interface Conta {
  usuario: Usuario | null;
  carregando: boolean; // conferindo a sessão e, se houver aluno, os dados dele
  erro: string | null; // falha ao carregar (a tela mostra "Tentar de novo")
  recarregar: () => Promise<void>;
}
interface Progresso {
  dados: DadosAluno | null;
  /** Mostra a mudança na hora. Com `m`, grava o nome, as preferências ou o interesse no Pro; o resto vem das sessões. */
  atualizar: (fn: (d: DadosAluno) => DadosAluno, m?: Mudancas) => Promise<DadosAluno | null>;
  /** Relê os dados do aluno no servidor (depois de uma sessão ou de uma gravação que falhou). */
  sincronizar: () => Promise<void>;
}
type Avisar = (msg: string) => void;

const ContaCtx = createContext<Conta | null>(null);
const ConteudoCtx = createContext<{ conteudo: Conteudo | null } | null>(null);
const ProgressoCtx = createContext<Progresso | null>(null);
const AvisoCtx = createContext<Avisar | null>(null);

function usar<T>(ctx: Context<T | null>, nome: string): T {
  const v = useContext(ctx);
  if (v === null) throw new Error(`${nome} fora do AppProvider`);
  return v;
}
export const useConta = () => usar(ContaCtx, 'useConta');
export const useConteudo = () => usar(ConteudoCtx, 'useConteudo').conteudo;
export const useProgresso = () => usar(ProgressoCtx, 'useProgresso');
export const useAviso = () => usar(AvisoCtx, 'useAviso');

/** Tudo junto (conta, conteúdo, progresso e aviso). */
export function useApp() {
  return { ...useConta(), ...useProgresso(), conteudo: useConteudo(), avisar: useAviso() };
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
  try { localStorage.setItem('pense-tema', root.dataset.theme); } catch { /* termos e privacidade seguem o sistema */ } // lido por public/tema.js
  root.dataset.size = d?.prefs.tamanho_texto ?? 'padrao';
  root.dataset.motion = d?.prefs.reduzir_animacoes ? 'reduce' : 'full';
}

/** Toast: o estado fica aqui dentro, então um aviso não re-renderiza as telas. */
function AvisoProvider({ children }: { children: ReactNode }) {
  const [toast, setToast] = useState<string | null>(null);
  const timer = useRef<number>();
  const avisar = useCallback((msg: string) => {
    setToast(msg);
    window.clearTimeout(timer.current);
    timer.current = window.setTimeout(() => setToast(null), 4000);
  }, []);
  return (
    <AvisoCtx.Provider value={avisar}>
      {children}
      <div role="status" className={toast ? 'toast' : 'sr-only'}>{toast}</div>
    </AvisoCtx.Provider>
  );
}

function EstadoProvider({ children }: { children: ReactNode }) {
  const avisar = useAviso();
  const [conteudo, setConteudo] = useState<Conteudo | null>(null);
  const [usuario, setUsuario] = useState<Usuario | null>(null);
  const [dados, setDados] = useState<DadosAluno | null>(null);
  const [carregando, setCarregando] = useState(true);
  const [erro, setErro] = useState<string | null>(null);
  const dadosRef = useRef<DadosAluno | null>(null);
  const conteudoRef = useRef<Conteudo | null>(null);
  const usuarioRef = useRef<Usuario | null>(null);
  const idCarregado = useRef<string | null | undefined>(undefined); // aluno cujos dados estão carregados ou carregando

  const definirDados = useCallback((d: DadosAluno | null) => { dadosRef.current = d; setDados(d); }, []);

  // Uma carga por aluno: o Supabase avisa o mesmo login várias vezes (sessão inicial, token renovado, dados alterados).
  const carregarUsuario = useCallback(async (u: Usuario | null) => {
    usuarioRef.current = u; setUsuario(u);
    const id = u?.id ?? null;
    if (id === idCarregado.current) return;
    idCarregado.current = id;
    if (!u) { definirDados(null); return; }
    try {
      const d = await repo.carregarDados(u);
      if (idCarregado.current === u.id) { definirDados(d); setErro(null); }
    } catch (e) {
      idCarregado.current = undefined; // permite tentar de novo
      throw e;
    }
  }, [definirDados]);

  // O conteúdo não segura a tela de entrada: carrega em paralelo (com reserva embutida se o banco demorar).
  const carregarConteudo = useCallback(async () => {
    if (conteudoRef.current) return;
    try {
      const c = await repo.carregarConteudo();
      conteudoRef.current = c; setConteudo(c);
    } catch (e) {
      setErro((e as Error).message);
    }
  }, []);

  const recarregar = useCallback(async () => {
    setCarregando(true); setErro(null);
    carregarConteudo();
    try {
      const u = await repo.usuarioAtual();
      await carregarUsuario(u);
      // Já logado e voltou com erro na URL (ex.: a conta Google já é de outro usuário). Sem login, a tela Entrar mostra.
      const erroUrl = u && erroDoRetorno();
      if (erroUrl) { avisar(erroUrl); limparRetornoDaUrl(); }
    } catch (e) {
      setErro((e as Error).message);
    } finally {
      setCarregando(false);
    }
  }, [carregarConteudo, carregarUsuario, avisar]);

  useEffect(() => {
    recarregar();
    return repo.aoMudarUsuario((u) => { carregarUsuario(u).catch((e) => setErro((e as Error).message)); });
  }, [recarregar, carregarUsuario]);

  useEffect(() => aplicarAparencia(dados), [dados]);

  const sincronizar = useCallback(async () => {
    const u = usuarioRef.current;
    if (!u) return;
    try {
      const d = await repo.carregarDados(u);
      if (idCarregado.current === u.id) definirDados(d);
    } catch (e) {
      console.warn('[Pense] Não deu para atualizar os dados agora:', (e as Error).message);
    }
  }, [definirDados]);

  // Mostra na hora e, se houver o que gravar, grava em seguida. Se a gravação falhar, avisa e relê do servidor,
  // para a tela não mostrar algo que não foi salvo.
  const atualizar = useCallback(async (fn: (d: DadosAluno) => DadosAluno, m?: Mudancas) => {
    const atual = dadosRef.current;
    if (!atual) return null;
    const novo = fn(atual);
    definirDados(novo);
    if (!m) return novo;
    try {
      await repo.salvar(novo, m);
    } catch (e) {
      avisar(`Não deu para salvar agora. ${(e as Error).message}`);
      sincronizar();
    }
    return novo;
  }, [avisar, definirDados, sincronizar]);

  // Visitante que salvou o progresso com o Google: o perfil passa a usar o nome da conta Google.
  const nomeConta = usuario && !usuario.anonimo && usuario.nome && usuario.nome !== 'Estudante' ? usuario.nome.slice(0, 40) : null;
  useEffect(() => {
    if (nomeConta && dados?.perfil.nome === 'Estudante') atualizar((d) => ({ ...d, perfil: { ...d.perfil, nome: nomeConta } }), { nome: true });
  }, [nomeConta, dados?.perfil.nome, atualizar]);

  const conta = useMemo(() => ({ usuario, carregando, erro, recarregar }), [usuario, carregando, erro, recarregar]);
  const valorConteudo = useMemo(() => ({ conteudo }), [conteudo]);
  const progresso = useMemo(() => ({ dados, atualizar, sincronizar }), [dados, atualizar, sincronizar]);
  return (
    <ContaCtx.Provider value={conta}>
      <ConteudoCtx.Provider value={valorConteudo}>
        <ProgressoCtx.Provider value={progresso}>{children}</ProgressoCtx.Provider>
      </ConteudoCtx.Provider>
    </ContaCtx.Provider>
  );
}

export function AppProvider({ children }: { children: ReactNode }) {
  return <AvisoProvider><EstadoProvider>{children}</EstadoProvider></AvisoProvider>;
}
