import { useState } from 'react';
import { repo } from '../lib/config';
import { Mascote } from '../components/Icones';
import { useApp } from '../state/AppContext';
import { BannerDemo } from '../components/Base';

export default function Entrar() {
  const { avisar } = useApp();
  const [modo, setModo] = useState<'inicio' | 'entrar' | 'criar'>('inicio');
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [nome, setNome] = useState('');
  const [erro, setErro] = useState<string | null>(null);
  const [ocupado, setOcupado] = useState(false);

  async function rodar(f: () => Promise<unknown>) {
    setErro(null); setOcupado(true);
    try { await f(); } catch (e) { setErro((e as Error).message); } finally { setOcupado(false); }
  }

  const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());

  return (
    <div className="app">
      <BannerDemo />
      <div className="screen" style={{ justifyContent: 'space-between', paddingBottom: 26 }}>
        <div className="col" style={{ alignItems: 'center', gap: 6, marginTop: modo === 'inicio' ? 40 : 8 }}>
          <Mascote largura={modo === 'inicio' ? 190 : 120} faisca />
          <span style={{ fontFamily: 'var(--font-title)', fontWeight: 700, fontSize: modo === 'inicio' ? 52 : 36, lineHeight: 1 }}>Pense<span style={{ color: 'var(--lav)' }}>.</span></span>
          <p style={{ textAlign: 'center', color: 'var(--text2)', fontSize: 17, maxWidth: 300 }}>Estude um pouco por dia para a sua prova: ENEM, vestibular, concurso ou seleção.</p>
          {modo === 'inicio' && (
            <div className="col" style={{ alignItems: 'center', marginTop: 12, gap: 8 }}>
              {['Questões reais de provas', 'Revisão no momento certo', 'Dicas antes da resposta'].map((t) => (
                <span key={t} className="pill" style={{ background: 'var(--card)', border: '1.5px solid var(--line)', height: 32, fontSize: 13 }}>✓ {t}</span>
              ))}
            </div>
          )}
        </div>

        {modo === 'inicio' ? (
          <div className="col" style={{ gap: 12 }}>
            <button className="btn" disabled={ocupado} onClick={() => rodar(() => repo.entrarAnonimo())}>Começar agora</button>
            <p className="muted" style={{ textAlign: 'center' }}>A primeira lição não precisa de cadastro.</p>
            <button className="btn ghost" onClick={() => setModo('entrar')}>Já tenho uma conta</button>
            {erro && <p className="erro-msg" role="alert">{erro}</p>}
          </div>
        ) : (
          <form className="col" style={{ gap: 12 }} onSubmit={(e) => {
            e.preventDefault();
            if (!emailOk) { setErro('Digite um e-mail válido.'); return; }
            if (senha.length < 6) { setErro('A senha precisa de pelo menos 6 caracteres.'); return; }
            rodar(async () => {
              if (modo === 'entrar') await repo.entrarEmail(email.trim(), senha);
              else {
                const r = await repo.cadastrarEmail(email.trim(), senha, nome.trim() || 'Estudante');
                if (r.confirmarEmail) avisar('Enviamos um link de confirmação para o seu e-mail.');
              }
            });
          }}>
            <h1 className="title" style={{ fontSize: 24 }}>{modo === 'entrar' ? 'Entrar na sua conta' : 'Criar conta'}</h1>
            {modo === 'criar' && <input className="input" placeholder="Seu nome" value={nome} onChange={(e) => setNome(e.target.value)} autoComplete="name" />}
            <input className="input" type="email" placeholder="voce@email.com" value={email} onChange={(e) => setEmail(e.target.value)} autoComplete="email" aria-label="E-mail" />
            <input className="input" type="password" placeholder="Senha" value={senha} onChange={(e) => setSenha(e.target.value)} autoComplete={modo === 'entrar' ? 'current-password' : 'new-password'} aria-label="Senha" />
            {erro && <p className="erro-msg" role="alert">{erro}</p>}
            <button className="btn" type="submit" disabled={ocupado}>{modo === 'entrar' ? 'Entrar' : 'Criar conta'}</button>
            <button className="btn ghost" type="button" disabled={ocupado} onClick={() => rodar(() => repo.entrarGoogle())}>Continuar com Google</button>
            <div className="row" style={{ justifyContent: 'space-between' }}>
              <button type="button" className="linkbtn" onClick={() => { setModo('inicio'); setErro(null); }}>Voltar</button>
              <button type="button" className="linkbtn" onClick={() => { setModo(modo === 'entrar' ? 'criar' : 'entrar'); setErro(null); }}>{modo === 'entrar' ? 'Criar uma conta' : 'Já tenho conta'}</button>
            </div>
          </form>
        )}
        <p className="muted" style={{ textAlign: 'center', fontSize: 12 }}>Ao continuar, você concorda com os Termos de uso e a Política de privacidade.</p>
      </div>
    </div>
  );
}
