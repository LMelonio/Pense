import { HashRouter, Navigate, Route, Routes } from 'react-router-dom';
import type { ReactElement } from 'react';
import { AppProvider, useApp } from './state/AppContext';
import { Mascote } from './components/Icones';
import Entrar from './screens/Entrar';
import ProvaAlvo from './screens/ProvaAlvo';
import Inicio from './screens/Inicio';
import Licao from './screens/Licao';
import Resultado from './screens/Resultado';
import Trilha from './screens/Trilha';
import Revisar from './screens/Revisar';
import Refazer from './screens/Refazer';
import Perfil from './screens/Perfil';
import Configuracoes from './screens/Configuracoes';
import NovaSenha from './screens/NovaSenha';
import { voltouDaRecuperacao } from './data/repo';

function Carregando({ texto = 'Carregando…' }: { texto?: string }) {
  return (
    <div className="app"><div className="screen" style={{ alignItems: 'center', justifyContent: 'center', textAlign: 'center' }}>
      <Mascote largura={130} /><p className="muted">{texto}</p>
    </div></div>
  );
}

/** Rotas que exigem conta e dados carregados. */
function Protegida({ children, permitirSemOnboarding = false }: { children: ReactElement; permitirSemOnboarding?: boolean }) {
  const { usuario, dados, carregando } = useApp();
  if (carregando) return <Carregando />;
  if (!usuario) return <Navigate to="/entrar" replace />;
  if (!dados) return <Carregando texto="Preparando seu progresso…" />;
  if (!dados.prefs.onboarding_ok && !permitirSemOnboarding) return <Navigate to="/prova" replace />;
  return children;
}

function Rotas() {
  const { usuario, carregando, erro, recarregar } = useApp();
  if (erro && !carregando && !usuario) {
    return <div className="app"><div className="screen" style={{ justifyContent: 'center' }}><h1 className="title">Algo deu errado</h1><p className="small">{erro}</p><button className="btn" onClick={recarregar}>Tentar de novo</button></div></div>;
  }
  return (
    <Routes>
      <Route path="/entrar" element={carregando ? <Carregando /> : usuario ? <Navigate to="/inicio" replace /> : <Entrar />} />
      <Route path="/prova" element={<Protegida permitirSemOnboarding><ProvaAlvo /></Protegida>} />
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
      <HashRouter>
        <Rotas />
      </HashRouter>
    </AppProvider>
  );
}
