// Nova senha: aberta pelo link de "Esqueci minha senha" ou por "Alterar senha" nas configurações.
import { useState } from 'react';
import type { FormEvent } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { repo } from '../lib/config';
import { limparRetornoDaUrl, voltouDaRecuperacao } from '../data/repo';
import { useApp } from '../state/AppContext';
import { CampoSenha } from '../components/Base';
import { IcVoltar, Mascote } from '../components/Icones';

export default function NovaSenha() {
  const { avisar } = useApp();
  const nav = useNavigate();
  const [recuperacao] = useState(voltouDaRecuperacao);
  const [senha, setSenha] = useState('');
  const [conf, setConf] = useState('');
  const [erro, setErro] = useState<string | null>(null);
  const [ocupado, setOcupado] = useState(false);
  const destino = recuperacao ? '/inicio' : '/config';

  async function salvar(e: FormEvent) {
    e.preventDefault();
    if (senha.length < 6) { setErro('A senha precisa de pelo menos 6 caracteres.'); return; }
    if (senha !== conf) { setErro('As duas senhas não estão iguais.'); return; }
    setErro(null); setOcupado(true);
    try {
      await repo.definirSenha(senha);
      limparRetornoDaUrl();
      avisar('Senha alterada.');
      nav(destino, { replace: true });
    } catch (e) {
      setErro((e as Error).message);
    } finally {
      setOcupado(false);
    }
  }

  return (
    <div className="app">
      <header className="row" style={{ padding: '14px 16px 10px', borderBottom: '1.5px solid var(--line)', gap: 8 }}>
        <Link to={destino} replace onClick={limparRetornoDaUrl} aria-label="Voltar" style={{ color: 'var(--text)', display: 'grid', placeItems: 'center', width: 42, height: 42 }}><IcVoltar /></Link>
        <h1 className="title" style={{ fontSize: 22 }}>{recuperacao ? 'Criar nova senha' : 'Alterar senha'}</h1>
      </header>
      <form className="screen" onSubmit={salvar} noValidate>
        <div className="col" style={{ alignItems: 'center' }}><Mascote largura={110} /></div>
        <p className="small" style={{ color: 'var(--text2)' }}>Escolha uma senha com 6 ou mais caracteres. Ela vale para entrar com o seu e-mail.</p>
        <CampoSenha valor={senha} mudar={setSenha} rotulo="Nova senha" nova />
        <CampoSenha valor={conf} mudar={setConf} rotulo="Repita a nova senha" nova />
        {erro && <p className="erro-msg" role="alert">{erro}</p>}
        <button className="btn" type="submit" disabled={ocupado}>Salvar nova senha</button>
      </form>
    </div>
  );
}
