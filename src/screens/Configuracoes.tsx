import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useApp, useDados } from '../state/AppContext';
import { repo, supabaseConfigurado } from '../lib/config';
import { Folha, Interruptor, Segmentado } from '../components/Base';
import { IcCheck, IcSeta, IcVoltar, Mascote } from '../components/Icones';
import type { Preferencias, TamanhoTexto, Tema } from '../data/types';

export default function Configuracoes() {
  const { dados, conteudo, atualizar, avisar } = useDados();
  const { usuario } = useApp();
  const nav = useNavigate();
  const prefs = dados.prefs;
  const [plano, setPlano] = useState<'mensal' | 'anual'>('anual');
  const [excluir, setExcluir] = useState(false);
  const [editarNome, setEditarNome] = useState(false);
  const [nome, setNome] = useState(dados.perfil.nome);
  const [vincular, setVincular] = useState(false);
  const [email, setEmail] = useState('');
  const [senha, setSenha] = useState('');
  const [baixando, setBaixando] = useState<number | null>(null);

  const salvar = (m: Partial<Preferencias>) => atualizar((d) => ({ ...d, prefs: { ...d.prefs, ...m } }), { prefs: true });

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

  async function exportar() {
    const blob = new Blob([JSON.stringify(await repo.exportar(dados), null, 2)], { type: 'application/json' });
    const a = document.createElement('a');
    a.href = URL.createObjectURL(blob); a.download = 'pense-meus-dados.json'; a.click();
    URL.revokeObjectURL(a.href);
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
            <div className="list-row" style={{ cursor: 'default' }}><Linha t="E-mail" s={usuario?.email ?? (usuario?.anonimo ? 'Conta sem e-mail (salve seu progresso)' : '—')} />
              {usuario?.anonimo && <button className="btn sm" onClick={() => setVincular(true)}>Salvar progresso</button>}
            </div>
            <div className="list-row" style={{ cursor: 'default' }}><Linha t="Modo" s={supabaseConfigurado ? 'Conta na nuvem (Supabase)' : 'Demonstração (só neste navegador)'} /></div>
          </div>
        </Secao>

        <Secao titulo="Plano">
          <div className="card row" style={{ gap: 12 }}>
            <span style={{ width: 40, height: 40, borderRadius: 12, background: 'var(--primary-soft)', display: 'grid', placeItems: 'center' }}><IcCheck color="var(--primary)" /></span>
            <Linha t="Seu plano: Grátis" s="Questões, trilha e revisão sem pagar nada" />
            <span className="pill" style={{ background: 'var(--ok-soft)', color: 'var(--ok-text)' }}>Atual</span>
          </div>
          <div className="col" style={{ background: 'var(--lav)', color: '#fff', borderRadius: 22, padding: 16, gap: 12 }}>
            <div className="row"><span className="title" style={{ fontSize: 22 }}>Pense Pro</span><span className="pill" style={{ background: 'rgba(255,255,255,.2)' }}>Em breve</span></div>
            <ul style={{ margin: 0, paddingLeft: 18, fontSize: 14, lineHeight: 1.5 }}>
              <li>Simulados completos, com o tempo da prova</li><li>Correção de redação com IA</li><li>Relatório de desempenho para você e o responsável</li>
            </ul>
            <div role="radiogroup" aria-label="Escolha do plano" style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
              {[{ k: 'mensal', n: 'Mensal', p: 'R$ 9,90', s: 'por mês · R$ 118,80 no ano', tag: '' }, { k: 'anual', n: 'Anual', p: 'R$ 69,90', s: 'R$ 5,83 por mês · economize R$ 48,90', tag: 'Promo 41% off' }].map((x) => (
                <button key={x.k} role="radio" aria-checked={plano === x.k} onClick={() => setPlano(x.k as 'mensal' | 'anual')}
                  style={{ position: 'relative', textAlign: 'left', padding: 12, borderRadius: 16, border: `2px solid ${plano === x.k ? '#fff' : 'rgba(255,255,255,.35)'}`, background: plano === x.k ? 'rgba(255,255,255,.16)' : 'transparent', color: '#fff', cursor: 'pointer' }}>
                  {x.tag && <span style={{ position: 'absolute', top: -10, right: 10, background: '#F2C14E', color: '#5A3E00', borderRadius: 99, fontSize: 11, fontWeight: 700, padding: '2px 8px' }}>{x.tag}</span>}
                  <span style={{ display: 'block', fontSize: 13, fontWeight: 600, opacity: 0.9 }}>{x.n}</span>
                  <span className="big" style={{ display: 'block', fontSize: 20 }}>{x.p}</span>
                  <span style={{ display: 'block', fontSize: 12, opacity: 0.85 }}>{x.s}</span>
                </button>
              ))}
            </div>
            <button className="btn white" style={{ color: 'var(--lav-dark)' }} onClick={async () => { await atualizar((d) => ({ ...d, interessePro: plano }), { interessePro: true }); avisar('Pronto! Vamos te avisar quando o Pro lançar.'); }}>
              {dados.interessePro ? 'Pronto, vamos te avisar' : 'Me avise quando lançar'}
            </button>
            <span style={{ fontSize: 12, opacity: 0.8 }}>Preços em teste. Ninguém é cobrado agora.</span>
          </div>
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
            <LinhaSwitch t="Aparecer no ranking da turma" s="Só nome e XP. Começa desligado." v={prefs.ranking_visivel} m={(v) => salvar({ ranking_visivel: v })} />
            <button className="list-row" onClick={exportar}><Linha t="Baixar meus dados" s="Arquivo JSON com seu progresso" /><IcSeta color="var(--text3)" size={18} /></button>
            <button className="list-row" onClick={() => setExcluir(true)}><span style={{ fontWeight: 600, color: 'var(--coral-dark)' }}>Excluir conta</span></button>
          </div>
        </Secao>

        <button className="btn ghost" style={{ color: 'var(--coral-dark)' }} onClick={async () => { await repo.sair(); nav('/', { replace: true }); }}>Sair da conta</button>
        <div className="col" style={{ alignItems: 'center', gap: 4 }}><Mascote largura={46} flutuar={false} /><span className="muted" style={{ fontSize: 12 }}>Pense · versão 0.1</span></div>
      </div>

      <Folha aberta={excluir} fechar={() => setExcluir(false)} titulo="Excluir conta">
        <span className="title" style={{ fontSize: 24 }}>Excluir sua conta?</span>
        <p className="small">Seu XP, sequência, coroas e conquistas serão apagados e não dá para recuperar. Se quiser, baixe seus dados antes.</p>
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
        <p className="small">Crie um acesso com e-mail e senha para não perder nada se trocar de celular.</p>
        <input className="input" type="email" placeholder="voce@email.com" value={email} onChange={(e) => setEmail(e.target.value)} />
        <input className="input" type="password" placeholder="Senha (6+ caracteres)" value={senha} onChange={(e) => setSenha(e.target.value)} />
        <button className="btn" onClick={async () => { try { await repo.vincularEmail(email.trim(), senha); setVincular(false); avisar('Pronto! Confira seu e-mail se pedirmos confirmação.'); } catch (e) { avisar((e as Error).message); } }}>Salvar</button>
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
