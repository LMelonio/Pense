// Entrada: Google, e-mail (entrar, criar conta, esqueci a senha) ou sem login, para testar.
import { useEffect, useState } from 'react';
import type { FormEvent } from 'react';
import { repo } from '../lib/config';
import { erroDoRetorno, limparRetornoDaUrl, voltouDaRecuperacao } from '../data/repo';
import { IcGoogle, Mascote } from '../components/Icones';
import { useApp } from '../state/AppContext';
import { BannerDemo, CampoSenha } from '../components/Base';

type Modo = 'inicio' | 'entrar' | 'criar' | 'recuperar';

const TITULOS: Record<Exclude<Modo, 'inicio'>, string> = { entrar: 'Entrar com e-mail', criar: 'Criar conta', recuperar: 'Esqueci minha senha' };
const BOTOES: Record<Exclude<Modo, 'inicio'>, string> = { entrar: 'Entrar', criar: 'Criar conta', recuperar: 'Enviar link' };

// Sem sessão na volta do link de nova senha = link vencido ou aberto em outro navegador.
const erroInicial = () => erroDoRetorno() ?? (voltouDaRecuperacao() ? 'O link para criar uma nova senha expirou ou foi aberto em outro navegador. Peça um novo.' : null);

export default function Entrar() {
  const { avisar } = useApp();
  const [modo, setModo] = useState<Modo>('inicio');
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [nome, setNome] = useState('');
  const [erro, setErro] = useState<string | null>(erroInicial);
  const [enviado, setEnviado] = useState(false);
  const [ocupado, setOcupado] = useState(false);

  useEffect(() => {
    if (location.search) limparRetornoDaUrl();
    repo.provedores(); // já deixa a consulta pronta para o primeiro clique
  }, []);

  async function rodar(f: () => Promise<unknown>) {
    setErro(null); setOcupado(true);
    try { await f(); } catch (e) { setErro((e as Error).message); } finally { setOcupado(false); }
  }

  function trocar(m: Modo) { setModo(m); setErro(null); setEnviado(false); }

  // Confere no servidor antes: com o provedor desligado, o Supabase mostraria uma página de erro crua.
  const google = () => rodar(async () => {
    if (!(await repo.provedores()).google) throw new Error('O login com Google ainda não está disponível. Use o e-mail ou entre sem login.');
    await repo.entrarGoogle();
  });

  const semLogin = () => rodar(async () => {
    if (!(await repo.provedores()).anonimo) throw new Error('O acesso sem login está desligado no momento. Entre com Google ou e-mail.');
    await repo.entrarAnonimo();
  });

  const emailOk = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim());

  function enviar(e: FormEvent) {
    e.preventDefault();
    if (!emailOk) { setErro('Digite um e-mail válido.'); return; }
    if (modo === 'recuperar') {
      rodar(async () => { await repo.recuperarSenha(email.trim()); setEnviado(true); });
      return;
    }
    if (senha.length < 6) { setErro('A senha precisa de pelo menos 6 caracteres.'); return; }
    rodar(async () => {
      if (modo === 'entrar') await repo.entrarEmail(email.trim(), senha);
      else {
        const r = await repo.cadastrarEmail(email.trim(), senha, nome.trim() || 'Estudante');
        if (r.confirmarEmail) avisar('Enviamos um link de confirmação para o seu e-mail.');
      }
    });
  }

  return (
    <div className="app">
      <BannerDemo />
      <div className="screen" style={{ justifyContent: 'space-between', paddingBottom: 26 }}>
        <div className="col" style={{ alignItems: 'center', gap: 6, marginTop: modo === 'inicio' ? 24 : 8 }}>
          <Mascote largura={modo === 'inicio' ? 170 : 110} faisca />
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
            <button className="btn google" disabled={ocupado} onClick={google}><IcGoogle />Continuar com Google</button>
            <button className="btn" disabled={ocupado} onClick={() => trocar('entrar')}>Entrar com e-mail</button>
            <div className="divisor">ou</div>
            <button className="btn ghost" disabled={ocupado} onClick={semLogin}>Entrar sem login</button>
            <p className="muted" style={{ textAlign: 'center' }}>Bom para testar. O progresso fica salvo e dá para criar uma conta depois sem perder nada.</p>
            {erro && <p className="erro-msg" role="alert">{erro}</p>}
          </div>
        ) : (
          <form className="col" style={{ gap: 12 }} onSubmit={enviar} noValidate>
            <h1 className="title" style={{ fontSize: 24 }}>{TITULOS[modo]}</h1>
            {modo === 'recuperar' && <p className="small" style={{ color: 'var(--text2)' }}>Digite o e-mail da sua conta. Enviamos um link para você criar uma senha nova.</p>}
            {modo === 'criar' && <input className="input" placeholder="Seu nome" aria-label="Seu nome" value={nome} onChange={(e) => setNome(e.target.value)} autoComplete="name" maxLength={40} />}
            <input className="input" type="email" placeholder="voce@email.com" value={email} onChange={(e) => setEmail(e.target.value)} autoComplete="email" aria-label="E-mail" />
            {modo !== 'recuperar' && <CampoSenha valor={senha} mudar={setSenha} rotulo={modo === 'criar' ? 'Senha (6 ou mais caracteres)' : 'Senha'} nova={modo === 'criar'} />}
            {erro && <p className="erro-msg" role="alert">{erro}</p>}
            {enviado && <p className="ok-msg" role="status">Se houver uma conta com este e-mail, o link chega em alguns minutos. Confira também o spam.</p>}
            <button className="btn" type="submit" disabled={ocupado}>{BOTOES[modo]}</button>
            {modo === 'entrar' && <button type="button" className="linkbtn" onClick={() => trocar('recuperar')}>Esqueci minha senha</button>}
            <div className="row" style={{ justifyContent: 'space-between' }}>
              <button type="button" className="linkbtn" onClick={() => trocar('inicio')}>Voltar</button>
              {modo === 'entrar' && <button type="button" className="linkbtn" onClick={() => trocar('criar')}>Criar uma conta</button>}
              {modo === 'criar' && <button type="button" className="linkbtn" onClick={() => trocar('entrar')}>Já tenho conta</button>}
              {modo === 'recuperar' && <button type="button" className="linkbtn" onClick={() => trocar('entrar')}>Lembrei a senha</button>}
            </div>
          </form>
        )}
        <p className="muted" style={{ textAlign: 'center', fontSize: 12 }}>Ao continuar, você concorda com os Termos de uso e a Política de privacidade.</p>
      </div>
    </div>
  );
}
