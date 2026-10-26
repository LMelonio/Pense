// Sem vidas: revisar as questões de hoje (recupera 1 vida, acertando pelo menos 1, uma vez por dia), assistir a um
// anúncio (+1 vida), adiantar a revisão (treino; na 1ª vez sem vidas, também devolve 1 vida), esperar a recarga ou
// conhecer o Pense Pro (em breve).
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAviso, useProgresso } from '../state/AppContext';
import { repo } from '../lib/config';
import { MINUTOS_POR_VIDA, VIDAS_MAX, ajustarVidas, revisaoPendente, revisaoVencida, vidaPelaRevisao, vidaPeloTreino, vidasAgora } from '../domain/regras';
import { duracao, plural } from '../lib/texto';
import { AnuncioPremiado } from './AnuncioPremiado';
import { IcCoracao, IcPlay, IcRevisar } from './Icones';

/** Abre o anúncio premiado; se o aluno assistir até o fim, soma 1 vida. Renderize `anuncio` na tela. */
export function useAnuncioDeVida() {
  const { atualizar, sincronizar } = useProgresso();
  const avisar = useAviso();
  const [aberto, setAberto] = useState(false);
  async function concluir() {
    setAberto(false);
    await atualizar((d) => ({ ...d, perfil: ajustarVidas(d.perfil, +1) })); // na tela já; o servidor confirma
    try {
      await repo.ganharVidaAnuncio(); // o servidor soma a vida (com limite diário)
      avisar('+1 vida! Bons estudos.');
    } catch (e) {
      avisar((e as Error).message);
      sincronizar(); // desfaz a vida mostrada na tela
    }
  }
  return { abrir: () => setAberto(true), anuncio: <AnuncioPremiado aberto={aberto} concluir={concluir} cancelar={() => setAberto(false)} /> };
}

export function SemVidas({ esperar }: { esperar: () => void }) {
  const { dados } = useProgresso();
  const nav = useNavigate();
  const { abrir, anuncio } = useAnuncioDeVida();
  if (!dados) return null;
  const { proximaEmMin } = vidasAgora(dados.perfil);
  // Questões vencidas valem XP; a vida, só a primeira revisão do dia devolve. Sem nada vencido, os erros guardados
  // podem ser adiantados (treino, sem XP), e na primeira vez sem vidas esse treino devolve 1 vida.
  const vencidas = revisaoVencida(dados).length;
  const guardados = vencidas ? 0 : revisaoPendente(dados).length;
  const vida = vencidas ? vidaPelaRevisao(dados) : vidaPeloTreino(dados);
  const revisar = vencidas > 0 || vida;
  return (
    <div className="col gap-12">
      <div className="row just-centro gap-6" aria-hidden="true">
        {Array.from({ length: VIDAS_MAX }, (_, i) => <IcCoracao key={i} size={30} bater={false} cor="var(--line)" />)}
      </div>
      <span className="title fs-24 centro">Suas vidas acabaram</span>
      <p className="small centro texto2">
        {vencidas > 0 && vida ? `Você tem ${plural(vencidas, 'questão', 'questões')} na revisão de hoje: acertando pelo menos 1, recupera 1 vida na hora. ` : ''}
        {vencidas > 0 && !vida ? `A vida da revisão de hoje já veio, mas as ${plural(vencidas, 'questão vencida', 'questões vencidas')} ainda ${vencidas === 1 ? 'vale' : 'valem'} XP. ` : ''}
        {!vencidas && vida ? `Na primeira vez, a revisão adiantada também devolve vida: acertando ${guardados === 1 ? 'o erro guardado' : `pelo menos 1 dos ${guardados} erros guardados`}, você recupera 1 vida na hora (sem XP). ` : ''}
        Volta 1 vida a cada {duracao(MINUTOS_POR_VIDA)}; a próxima chega em {duracao(proximaEmMin)}.
      </p>
      {revisar && <button className="btn" onClick={() => nav(vencidas ? '/refazer' : '/refazer?todas=1')}><IcRevisar size={20} />{vida ? 'Revisar e recuperar 1 vida' : 'Revisar agora'}</button>}
      <button className={revisar ? 'btn ghost' : 'btn lav'} onClick={abrir}><IcPlay size={18} />Assistir anúncio e ganhar 1 vida</button>
      {guardados > 0 && !vida && <button className="linkbtn" onClick={() => nav('/refazer?todas=1')}>Adiantar revisão ({plural(guardados, 'erro', 'erros')}, sem XP)</button>}
      <button className="linkbtn" onClick={esperar}>Esperar {duracao(proximaEmMin)}</button>
      <button className="linkbtn" onClick={() => nav('/pro')}>Pense Pro: vidas ilimitadas (em breve)</button>
      {anuncio}
    </div>
  );
}
