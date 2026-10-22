import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useApp, useDados } from '../state/AppContext';
import { repo, supabaseConfigurado } from '../lib/config';
import { CampoSenha, Folha, Interruptor, Segmentado } from '../components/Base';
import { CartaoPro } from '../components/CartaoPro';
import { IcCheck, IcGoogle, IcSeta, IcVoltar, Mascote } from '../components/Icones';
import type { Preferencias, TamanhoTexto, Tema } from '../data/types';

export default function Configuracoes() {
  const { dados, conteudo, atualizar, avisar } = useDados();
  const { usuario } = useApp();
  const nav = useNavigate();
  const prefs = dados.prefs;
  const [excluir, setExcluir] = useState(false);
  const [editarNome, setEditarNome] = useState(false);
  const [nome, setNome] = useState(dados.perfil.nome);
  const [vincular, setVincular] = useState(false);
  const [confirmarSair, setConfirmarSair] = useState(false);
  const [nomeConta, setNomeConta] = useState(dados.perfil.nome === 'Estudante' ? '' : dados.perfil.nome);
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [ocupado, setOcupado] = useState(false);
  const [baixando, setBaixando] = useState<number | null>(null);

  const salvar = (m: Partial<Preferencias>) => atualizar((d) => ({ ...d, prefs: { ...d.prefs, ...m } }), { prefs: true });
  const visitante = !!usuario?.anonimo;
  const acesso = visitante ? 'Sem login (visitante)' : `${usuario?.provedor === 'google' ? 'Google' : 'E-mail'}${usuario?.email ? ` · ${usuario.email}` : ''}`;

  async function salvarComGoogle() {
    if (!(await repo.provedores()).google) { avisar('O login com Google ainda não está disponível. Salve com e-mail.'); return; }
    try { await repo.vincularGoogle(); } catch (e) { avisar((e as Error).message); }
  }

  async function salvarComEmail() {
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim())) { avisar('Digite um e-mail válido.'); return; }
    if (senha.length < 6) { avisar('A senha precisa de pelo menos 6 caracteres.'); return; }
    setOcupado(true);
    try {
      const r = await repo.vincularEmail(email.trim(), senha);
      if (nomeConta.trim()) await atualizar((d) => ({ ...d, perfil: { ...d.perfil, nome: nomeConta.trim() } }), { perfil: true });
      setVincular(false); setSenha('');
      avisar(r.confirmarEmail ? 'Enviamos um link para confirmar o seu e-mail.' : 'Pronto! Agora você entra com este e-mail e senha.');
    } catch (e) {
      avisar((e as Error).message);
    } finally {
      setOcupado(false);
    }
  }

  async function sair() {
    // Visitante que sai sem salvar não consegue voltar a esta conta: apaga em vez de deixar dados órfãos no banco.
    try { await (visitante ? repo.excluirConta() : repo.sair()); } catch { await repo.sair(); }
    nav('/', { replace: true });
  }

  async function offline(v: boolean) {
    if (!v) { setBaixando(null); return; }
    if (!('caches' in window)) { avisar('Este navegador não permite estudar offline.'); return; }
    const urls = ['./data/conteudo.json', ...conteudo.questoes.flatMap((q) => [...q.figuras.map((f) => './' + f.imagem), ...q.alternativas.filter((a) => a.imagem).map((a) => './' + a.imagem!)])];
    const cache = await caches.open('pense-conteudo-v1');
    let n = 0;
    for (const u of urls) { try { await cache.add(u); } catch { /* ignora */ } n++; if (n % 20 === 0) setBaixando(Math.round((n / urls.length) * 100)); }
    setBaixando(100);
    avisar('Questões e imagens salvas para estudar sem internet.');
  }

  return (
    <div className="app">
      <header className="row" style={{ padding: '14px 16px 10px', borderBottom: '1.5px solid var(--line)', gap: 8 }}>
        <Link to="/perfil" aria-label="Voltar para o perfil" style={{ color: 'var(--text)', display: 'grid', placeItems: 'center', width: 42, height: 42 }}><IcVoltar /></Link>
        <h1 className="title" style={{ fontSize: 22 }}>Configurações</h1>
      </header>
      <div className="screen">
        <Secao titulo="Conta">
          <div className="list-card">
            <button className="list-row" onClick={() => setEditarNome(true)}>
              <span aria-hidden="true" style={{ width: 44, height: 44, borderRadius: '50%', background: 'var(--mascot)', color: '#12302C', display: 'grid', placeItems: 'center', fontFamily: 'var(--font-title)', fontWeight: 700, fontSize: 19 }}>{(dados.perfil.nome || 'E')[0]}</span>
              <Linha t={dados.perfil.nome} s="Toque para mudar o nome" /><IcSeta color="var(--text3)" size={18} />
            </button>
            <div className="list-row" style={{ cursor: 'default' }}><Linha t="Acesso" s={acesso} /></div>
            {visitante && (
              <div className="list-row col" style={{ alignItems: 'stretch', cursor: 'default', gap: 10 }}>
                <span className="small" style={{ color: 'var(--text2)' }}>Salve seu progresso numa conta para não perder nada ao trocar de aparelho.</span>
                <button className="btn google sm" onClick={salvarComGoogle}><IcGoogle size={18} />Salvar com Google</button>
                <button className="btn sm" onClick={() => setVincular(true)}>Salvar com e-mail</button>
              </div>
            )}
            {usuario?.provedor === 'email' && (
              <Link to="/nova-senha" className="list-row"><Linha t="Alterar senha" s="Crie uma senha nova para entrar com o e-mail" /><IcSeta color="var(--text3)" size={18} /></Link>
            )}
            <div className="list-row" style={{ cursor: 'default' }}><Linha t="Modo" s={supabaseConfigurado ? 'Conta na nuvem (Supabase)' : 'Demonstração (só neste navegador)'} /></div>
          </div>
        </Secao>

        <Secao titulo="Plano">
          <div className="card row" style={{ gap: 12 }}>
            <span style={{ width: 40, height: 40, borderRadius: 12, background: 'var(--primary-soft)', display: 'grid', placeItems: 'center' }}><IcCheck color="var(--primary)" /></span>
            <Linha t="Seu plano: Grátis" s="Questões, trilha e revisão sem pagar nada" />
            <span className="pill" style={{ background: 'var(--ok-soft)', color: 'var(--ok-text)' }}>Atual</span>
          </div>
          <CartaoPro />
        </Secao>

        <Secao titulo="Aparência">
          <div className="card col" style={{ gap: 12 }}>
            <span style={{ fontWeight: 600 }}>Tema</span>
            <Segmentado<Tema> rotulo="Tema" valor={prefs.tema} mudar={(v) => salvar({ tema: v })} opcoes={[{ v: 'claro', nome: 'Claro' }, { v: 'escuro', nome: 'Noturno' }, { v: 'auto', nome: 'Automático' }]} />
            <span style={{ fontWeight: 600, marginTop: 6 }}>Tamanho do texto</span>
            <Segmentado<TamanhoTexto> rotulo="Tamanho do texto" valor={prefs.tamanho_texto} mudar={(v) => salvar({ tamanho_texto: v })} opcoes={[{ v: 'padrao', nome: 'Aa' }, { v: 'grande', nome: 'Aa+' }, { v: 'maior', nome: 'Aa++' }]} />
          </div>
        </Secao>

        <Secao titulo="Sistema">
          <div className="list-card">
            <LinhaSwitch t="Sons e efeitos" s="Som de acerto, erro e conquista" v={prefs.sons} m={(v) => salvar({ sons: v })} />
            <LinhaSwitch t="Vibração" s="Vibra de leve ao responder" v={prefs.vibracao} m={(v) => salvar({ vibracao: v })} />
            <LinhaSwitch t="Reduzir animações" s="Menos movimento na tela" v={prefs.reduzir_animacoes} m={(v) => salvar({ reduzir_animacoes: v })} />
            <div className="list-row col" style={{ alignItems: 'stretch', cursor: 'default' }}>
              <div className="row"><Linha t="Estudar sem internet" s="Baixa as questões e as imagens" /><Interruptor rotulo="Estudar sem internet" ligado={baixando !== null} mudar={offline} /></div>
              {baixando !== null && <div className="bar"><span style={{ width: `${baixando}%`, background: 'var(--ok)' }} /></div>}
            </div>
          </div>
        </Secao>

        <Secao titulo="Privacidade">
          <div className="list-card">
            <button className="list-row" onClick={() => setExcluir(true)}><span style={{ fontWeight: 600, color: 'var(--coral-dark)' }}>Excluir conta</span></button>
          </div>
        </Secao>

        <button className="btn ghost" style={{ color: 'var(--coral-dark)' }} onClick={() => (visitante ? setConfirmarSair(true) : sair())}>Sair da conta</button>
        <div className="col" style={{ alignItems: 'center', gap: 4 }}><Mascote largura={46} flutuar={false} /><span className="muted" style={{ fontSize: 12 }}>Pense · versão 0.1</span></div>
      </div>

      <Folha aberta={excluir} fechar={() => setExcluir(false)} titulo="Excluir conta">
        <span className="title" style={{ fontSize: 24 }}>Excluir sua conta?</span>
        <p className="small">Seu XP, sequência, coroas e conquistas serão apagados e não dá para recuperar.</p>
        <button className="btn" onClick={() => setExcluir(false)}>Manter minha conta</button>
        <button className="linkbtn" style={{ color: 'var(--coral-dark)' }} onClick={async () => { try { await repo.excluirConta(); nav('/', { replace: true }); } catch (e) { avisar((e as Error).message); } }}>Excluir mesmo assim</button>
      </Folha>
      <Folha aberta={editarNome} fechar={() => setEditarNome(false)} titulo="Seu nome">
        <span className="title" style={{ fontSize: 24 }}>Seu nome</span>
        <input className="input" value={nome} onChange={(e) => setNome(e.target.value)} maxLength={40} />
        <button className="btn" onClick={async () => { await atualizar((d) => ({ ...d, perfil: { ...d.perfil, nome: nome.trim() || 'Estudante' } }), { perfil: true }); setEditarNome(false); }}>Salvar</button>
      </Folha>
      <Folha aberta={vincular} fechar={() => setVincular(false)} titulo="Salvar progresso">
        <span className="title" style={{ fontSize: 24 }}>Salvar seu progresso</span>
        <p className="small">Crie um acesso com e-mail e senha. Seu XP, sequência e coroas continuam os mesmos.</p>
        <input className="input" placeholder="Seu nome" aria-label="Seu nome" value={nomeConta} onChange={(e) => setNomeConta(e.target.value)} autoComplete="name" maxLength={40} />
        <input className="input" type="email" placeholder="voce@email.com" aria-label="E-mail" value={email} onChange={(e) => setEmail(e.target.value)} autoComplete="email" />
        <CampoSenha valor={senha} mudar={setSenha} rotulo="Senha (6 ou mais caracteres)" nova />
        <button className="btn" disabled={ocupado} onClick={salvarComEmail}>Salvar</button>
      </Folha>
      <Folha aberta={confirmarSair} fechar={() => setConfirmarSair(false)} titulo="Sair sem salvar">
        <span className="title" style={{ fontSize: 24 }}>Sair sem salvar?</span>
        <p className="small">Você entrou sem login. Se sair agora, este progresso é apagado e não dá para recuperar. Salve numa conta antes, se quiser continuar depois.</p>
        <button className="btn" onClick={() => { setConfirmarSair(false); setVincular(true); }}>Salvar com e-mail</button>
        <button className="btn google" onClick={() => { setConfirmarSair(false); salvarComGoogle(); }}><IcGoogle />Salvar com Google</button>
        <button className="linkbtn" style={{ color: 'var(--coral-dark)' }} onClick={sair}>Sair e apagar o progresso</button>
      </Folha>
    </div>
  );
}

function Secao({ titulo, children }: { titulo: string; children: React.ReactNode }) {
  return <section className="col" style={{ gap: 8 }}><h2 className="kicker" style={{ margin: '0 4px' }}>{titulo}</h2>{children}</section>;
}
function Linha({ t, s }: { t: string; s: string }) {
  return <span className="col spacer" style={{ gap: 1, minWidth: 0 }}><span style={{ fontWeight: 600 }}>{t}</span><span className="muted" style={{ fontSize: 12 }}>{s}</span></span>;
}
function LinhaSwitch({ t, s, v, m }: { t: string; s: string; v: boolean; m: (v: boolean) => void }) {
  return <div className="list-row" style={{ cursor: 'default' }}><Linha t={t} s={s} /><Interruptor rotulo={t} ligado={v} mudar={m} /></div>;
}
