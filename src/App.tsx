import { HashRouter, Navigate, Route, Routes } from 'react-router-dom';
import type { ReactElement } from 'react';
import { AppProvider, useApp } from './state/AppContext';
import { Mascote } from './components/Icones';
import Entrar from './screens/Entrar';
import PrimeiroAcesso from './screens/PrimeiroAcesso';
import Inicio from './screens/Inicio';
import Licao from './screens/Licao';
import Resultado from './screens/Resultado';
import Trilha from './screens/Trilha';
import Revisar from './screens/Revisar';
import Refazer from './screens/Refazer';
import Perfil from './screens/Perfil';
import Configuracoes from './screens/Configuracoes';
import NovaSenha from './screens/NovaSenha';
import Pro from './screens/Pro';
import { voltouDaRecuperacao } from './data/repo';

function Carregando({ texto = 'Carregando…' }: { texto?: string }) {
  return (
    <div className="app"><div className="screen" style={{ alignItems: 'center', justifyContent: 'center', textAlign: 'center' }}>
      <Mascote largura={130} /><p className="muted">{texto}</p>
    </div></div>
  );
}

function TelaErro() {
  const { erro, recarregar } = useApp();
  return (
    <div className="app"><div className="screen" style={{ alignItems: 'center', justifyContent: 'center', textAlign: 'center' }}>
      <Mascote largura={120} humor="triste" />
      <h1 className="title">Não deu para abrir o Pense</h1>
      <p className="small" style={{ color: 'var(--text2)', maxWidth: 300 }}>{erro}</p>
      <button className="btn" onClick={recarregar}>Tentar de novo</button>
    </div></div>
  );
}

/** Rotas que exigem conta e dados carregados. */
function Protegida({ children, permitirSemOnboarding = false }: { children: ReactElement; permitirSemOnboarding?: boolean }) {
  const { usuario, dados, conteudo, carregando, erro } = useApp();
  if (carregando) return <Carregando />;
  if (!usuario) return <Navigate to="/entrar" replace />;
  if (!dados || !conteudo) return erro ? <TelaErro /> : <Carregando texto="Preparando seu progresso…" />;
  if (!dados.prefs.onboarding_ok && !permitirSemOnboarding) return <Navigate to="/primeiro-acesso" replace />;
  return children;
}

function Rotas() {
  const { usuario, carregando, erro } = useApp();
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
      <Route path="/refazer" element={<Protegida><Refazer /></Protegida>} />
      <Route path="/perfil" element={<Protegida><Perfil /></Protegida>} />
      <Route path="/config" element={<Protegida><Configuracoes /></Protegida>} />
      <Route path="/nova-senha" element={<Protegida permitirSemOnboarding><NovaSenha /></Protegida>} />
      <Route path="*" element={<Navigate to={voltouDaRecuperacao() ? '/nova-senha' : '/inicio'} replace />} />
    </Routes>
  );
}

export default function App() {
  return (
    <AppProvider>
      <HashRouter future={{ v7_startTransition: true, v7_relativeSplatPath: true }}>
        <Rotas />
      </HashRouter>
    </AppProvider>
  );
}
