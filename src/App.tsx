import { HashRouter, Navigate, Route, Routes, useLocation } from 'react-router-dom';
import { Component, Suspense, lazy } from 'react';
import type { ComponentType, ReactElement, ReactNode } from 'react';
import { AppProvider, useConta, useConteudo, useProgresso } from './state/AppContext';
import { Mascote } from './components/Icones';
import Entrar from './screens/Entrar';
import PrimeiroAcesso from './screens/PrimeiroAcesso';
import Inicio from './screens/Inicio';
import Resultado from './screens/Resultado';
import Trilha from './screens/Trilha';
import Revisar from './screens/Revisar';
import Perfil from './screens/Perfil';
import Configuracoes from './screens/Configuracoes';
import NovaSenha from './screens/NovaSenha';
import Pro from './screens/Pro';
import { voltouDaRecuperacao } from './data/repo';

// Depois de uma publicação nova, a aba que ficou aberta pede o pedaço antigo da tela, que já não existe no servidor.
// Recarrega uma vez (no máximo uma por minuto) para pegar a versão nova; se não adiantar, o erro vai para PegaErro.
const RECARREGOU_EM = 'pense-recarregou-em';
function recarregarUmaVez() {
  try {
    if (Date.now() - Number(sessionStorage.getItem(RECARREGOU_EM) ?? 0) < 60_000) return false;
    sessionStorage.setItem(RECARREGOU_EM, String(Date.now()));
  } catch { return false; }
  location.reload();
  return true;
}
// T tem a mesma restrição do lazy do React. Enquanto recarrega, a promessa não termina: o Suspense segue em "Carregando…"
function telaSobDemanda<T extends ComponentType<any>>(carregar: () => Promise<{ default: T }>) {
  return lazy(() => carregar().catch((e) => (recarregarUmaVez() ? new Promise<{ default: T }>(() => undefined) : Promise.reject(e))));
}

// Lição e Refazer trazem o texto das questões (Markdown, fórmulas): só carregam quando o aluno abre uma questão.
const Licao = telaSobDemanda(() => import('./screens/Licao'));
const Refazer = telaSobDemanda(() => import('./screens/Refazer'));

function Carregando({ texto = 'Carregando…' }: { texto?: string }) {
  return (
    <div className="app"><main className="screen tela-centro">
      <Mascote largura={130} /><p className="muted">{texto}</p>
    </main></div>
  );
}

function TelaErro() {
  const { erro, recarregar } = useConta();
  return (
    <div className="app"><main className="screen tela-centro">
      <Mascote largura={120} humor="triste" />
      <h1 className="title">Não deu para abrir o Pense</h1>
      <p className="small texto2 largura-300">{erro}</p>
      <button className="btn" onClick={recarregar}>Tentar de novo</button>
    </main></div>
  );
}

/** Último recurso: um erro ao desenhar uma tela (por exemplo, uma parte do app que não carregou) mostra uma saída
 * em vez da tela em branco. */
class PegaErro extends Component<{ children: ReactNode }, { falhou: boolean }> {
  state = { falhou: false };
  static getDerivedStateFromError() { return { falhou: true }; }
  render() {
    if (!this.state.falhou) return this.props.children;
    return (
      <div className="app"><main className="screen tela-centro">
        <Mascote largura={120} humor="triste" />
        <h1 className="title">Esta tela não abriu</h1>
        <p className="small texto2 largura-300">Pode ser que o Pense tenha uma versão nova. Atualize para continuar: as respostas já enviadas estão guardadas.</p>
        <button className="btn" onClick={() => location.reload()}>Atualizar o app</button>
      </main></div>
    );
  }
}

/** Rotas que exigem conta e dados carregados. */
function Protegida({ children, permitirSemOnboarding = false }: { children: ReactElement; permitirSemOnboarding?: boolean }) {
  const { usuario, carregando, erro } = useConta();
  const { dados } = useProgresso();
  const conteudo = useConteudo();
  if (carregando) return <Carregando />;
  if (!usuario) return <Navigate to="/entrar" replace />;
  if (!dados || !conteudo) return erro ? <TelaErro /> : <Carregando texto="Preparando seu progresso…" />;
  if (!dados.prefs.onboarding_ok && !permitirSemOnboarding) return <Navigate to="/primeiro-acesso" replace />;
  return <Suspense fallback={<Carregando />}>{children}</Suspense>;
}

/** O Refazer monta a fila ao abrir: uma busca nova (outro tema, outra lista) começa uma revisão nova. */
function RefazerPorBusca() {
  const { search } = useLocation();
  return <Refazer key={search} />;
}

function Rotas() {
  const { usuario, carregando, erro } = useConta();
  if (erro && !carregando && !usuario) return <TelaErro />;
  return (
    <Routes>
      <Route path="/entrar" element={carregando ? <Carregando /> : usuario ? <Navigate to="/inicio" replace /> : <Entrar />} />
      <Route path="/primeiro-acesso" element={<Protegida permitirSemOnboarding><PrimeiroAcesso /></Protegida>} />
      <Route path="/pro" element={<Protegida><Pro /></Protegida>} />
      <Route path="/inicio" element={<Protegida><Inicio /></Protegida>} />
      <Route path="/licao/:recorte/:assunto" element={<Protegida><Licao /></Protegida>} />
      <Route path="/desafio/:recorte/:unidade" element={<Protegida><Licao desafio /></Protegida>} />
      <Route path="/resultado" element={<Protegida><Resultado /></Protegida>} />
      <Route path="/trilha" element={<Protegida><Trilha /></Protegida>} />
      <Route path="/revisar" element={<Protegida><Revisar /></Protegida>} />
      <Route path="/refazer" element={<Protegida><RefazerPorBusca /></Protegida>} />
      <Route path="/perfil" element={<Protegida><Perfil /></Protegida>} />
      <Route path="/config" element={<Protegida><Configuracoes /></Protegida>} />
      <Route path="/nova-senha" element={<Protegida permitirSemOnboarding><NovaSenha /></Protegida>} />
      <Route path="*" element={<Navigate to={voltouDaRecuperacao() ? '/nova-senha' : '/inicio'} replace />} />
    </Routes>
  );
}

export default function App() {
  return (
    <PegaErro>
      <AppProvider>
        <HashRouter future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
          <Rotas />
        </HashRouter>
      </AppProvider>
    </PegaErro>
  );
}
