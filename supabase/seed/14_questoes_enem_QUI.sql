-- Questões de enem-QUI (27)
begin;
insert into public.questoes (id, exame_id, recorte_id, banca, orgao, cargo, nivel, ano, numero, formato, disciplina, assunto, topico, lingua, texto_base_id, texto_apoio, comando, gabarito, dica1, dica2, explicacao, dificuldade) values
('2024-D2-Q092', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 92, '5_alternativas', 'Química', 'Eletroquímica', 'Célula a combustível microbiana', null, null, 'Células a combustível microbianas (CCM) são capazes de gerar eletricidade a partir de águas residuárias urbanas e agroindustriais. As CCM são compostas de duas câmaras. Numa delas, onde ocorre o tratamento da matéria orgânica, as bactérias eletrogênicas crescem formando um biofilme e se alimentam dos poluentes presentes no efluente. Ao se alimentarem, essas bactérias geram uma corrente elétrica que percorre o material sobre o qual elas formaram o biofilme. Um fio condutor externo possibilita a migração dessa corrente para uma segunda câmara, promovendo uma reação química. A figura esquematiza uma CCM e as reações envolvidas.

{{figura:1}}

CH₃COO⁻ (aq) + 2 H₂O (l) → 2 CO₂ (g) + 7 H⁺ (aq) + 8 e⁻

4 H⁺ (aq) + O₂ (g) + 4 e⁻ → 2 H₂O (l)

Fonte: QUINTO, A. C. **Biobaterias geram eletricidade a partir de esgoto sanitário e efluentes agroindustriais**. Disponível em: https://jornal.usp.br. Acesso em: 1 dez. 2021 (adaptado).', 'Qual das equações representa a reação global que ocorre durante o funcionamento dessa CCM?', 'C', 'A reação global é a soma das duas semirreações, mas antes os elétrons precisam se cancelar.', 'O ânodo libera 8 elétrons e o cátodo consome 4. Multiplique a semirreação do cátodo por 2 e depois some, cancelando o que aparece dos dois lados.', 'Resposta: C. Multiplicando o cátodo por 2: $8\,H^+ + 2\,O_2 + 8\,e^- \to 4\,H_2O$. Somando com o ânodo: $CH_3COO^- + 2\,H_2O + 8\,H^+ + 2\,O_2 \to 2\,CO_2 + 7\,H^+ + 4\,H_2O$. Cancelando 2 $H_2O$ e 7 $H^+$ dos dois lados, sobra $CH_3COO^- + H^+ + 2\,O_2 \to 2\,CO_2 + 2\,H_2O$. A alternativa A esquece de igualar os elétrons, por isso fica com 1 $O_2$ e o balanço não fecha.', 'média'),
('2024-D2-Q093', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 93, '5_alternativas', 'Química', 'Química orgânica', 'Conceito de composto orgânico', null, null, 'No senso comum, considera-se, ainda hoje, que compostos orgânicos são substâncias presentes nos seres vivos. Na Química, a expressão “compostos orgânicos” tem um uso histórico de mais de 200 anos, adquirindo diferentes conotações ao longo do desenvolvimento dessa ciência. Atualmente, atribui-se a essa expressão outro significado.', 'A concepção científica atual define esses compostos como substâncias', 'E', 'A pergunta é sobre a definição química atual, não sobre o sentido de "orgânico" no supermercado.', 'Esqueça saúde, agrotóxicos ou origem em seres vivos: a Química define esses compostos pelo elemento que forma sua estrutura.', 'Resposta: E. Hoje, a Química chama de compostos orgânicos as substâncias que têm o carbono como elemento principal, formando cadeias carbônicas, sejam elas naturais ou sintéticas. As alternativas A, B e D usam o sentido popular de "orgânico" (saudável, natural, sem agrotóxico), e a alternativa C confunde a definição com a fotossíntese.', 'fácil'),
('2024-D2-Q094', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 94, '5_alternativas', 'Química', 'Química orgânica', 'Acidez de grupos funcionais', null, null, 'A nimesulida é um fármaco pouco solúvel em água, utilizado como anti-inflamatório, analgésico e antitérmico. Essa substância pode ser convertida em uma espécie eletricamente carregada, de maior solubilidade em água, mediante o tratamento com uma base de Brönsted-Lowry, isto é, uma espécie química capaz de capturar um próton (H⁺). Na figura são apresentados os grupamentos presentes na estrutura química da nimesulida.

{{figura:1}}

**Nimesulida**

Fonte: GONÇALVES, A. A. et al. Contextualizando reações ácido-base de acordo com a teoria protônica de Brönsted-Lowry usando comprimidos de propranolol e nimesulida. **Química Nova**, n. 3, 2013 (adaptado).', 'Na estrutura desse fármaco, o grupamento capaz de reagir com a base de Brönsted-Lowry é o grupo', 'A', 'Uma base de Brönsted-Lowry captura H⁺. Procure qual grupo da molécula tem um hidrogênio que pode ser doado.', 'Metila e anéis têm H ligado a carbono, que quase não sai. O H ligado a nitrogênio vizinho a um grupo $SO_2$ é bem mais ácido.', 'Resposta: A. Na sulfonamida, o H está ligado a um N que fica entre o grupo $SO_2$ e um anel aromático, que puxam elétrons e estabilizam a carga negativa depois que o H⁺ sai. Por isso esse é o próton capturado pela base, gerando o ânion mais solúvel em água. Metila e fenila só têm H ligado a carbono, e os grupos nitro e éter não têm hidrogênio para doar.', 'difícil'),
('2024-D2-Q097', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 97, '5_alternativas', 'Química', 'Soluções', 'Concentração de soluções', null, null, 'O soro caseiro serve para combater a desidratação por meio da reposição da água e sais minerais perdidos, por exemplo, por diarreia. Uma receita simples para a sua preparação consiste em utilizar duas colheres grandes (de sopa) de açúcar e duas colheres pequenas (de café) de sal de cozinha, dissolvidos em 2 L de água fervida, obtendo-se uma solução com concentração de íon sódio de 1,4 mg/mL.

Considere as massas molares: NaCl = 58,5 g/mol; Na = 23 g/mol.', 'Qual é o valor mais próximo da massa, em grama, de cloreto de sódio presente em uma única colher pequena?', 'D', 'Comece pela concentração de sódio dada: com o volume total, dá para achar quanto sódio há na receita inteira.', 'Calcule a massa de Na em 2 L e converta para NaCl usando a proporção $58{,}5/23$. Lembre que a receita usa duas colheres pequenas.', 'Resposta: D. Massa de Na: $1{,}4\ \text{mg/mL} \times 2000\ \text{mL} = 2800\ \text{mg} = 2{,}8\ \text{g}$. Massa de NaCl: $2{,}8 \times \frac{58{,}5}{23} \approx 7{,}1\ \text{g}$. Como isso corresponde a duas colheres, cada uma tem $\approx 3{,}6\ \text{g}$. Quem para no 2,8 g (C) esqueceu de converter Na em NaCl, e quem marca 7,0 g (E) esqueceu de dividir por 2.', 'média'),
('2024-D2-Q114', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 114, '5_alternativas', 'Química', 'Química ambiental', 'Emissões de motores a combustão', null, null, 'Um dos agentes que mais contribui para a poluição do ar é o automóvel a combustão interna. Em áreas urbanas, isso é demonstrado dramaticamente pela fumaça fotoquímica, resultante da interação entre óxidos de nitrogênio, hidrocarbonetos e luz solar, para formar produtos de oxidação, que causam irritação aos olhos, ao aparelho respiratório e danos às plantas. As condições de operação de motores a combustão, como a razão da mistura ar/combustível no cilindro, influenciam na composição dos gases lançados pelo escapamento na atmosfera. O gráfico ilustra a variação nas composições dos principais gases, dióxido de carbono (CO₂), hidrocarbonetos (HC), monóxido de carbono (CO), monóxido de nitrogênio (NO) e oxigênio molecular (O₂), emitidos por um motor a gasolina, em diferentes razões ar/combustível, em massa.

{{figura:1}}

Fonte: RANGEL, M. C.; CARVALHO, M. F. A. Impacto dos catalisadores automotivos no controle da qualidade do ar. **Química Nova**, v. 26, 2003 (adaptado).', 'Na condição de razão ar/combustível igual a 18, haverá uma emissão', 'C', 'Encontre a razão 18 no eixo horizontal e leia cada curva com atenção ao eixo certo (esquerdo ou direito).', 'Em 18 há excesso de ar, então a queima é quase completa. Pense no que acontece com o gás da combustão incompleta e com o da completa.', 'Resposta: C. Na razão 18 a mistura tem excesso de ar: o CO está praticamente em zero e o $CO_2$ continua alto, perto de 12% (a combustão é quase completa). A alternativa A erra porque o $O_2$ já está subindo nessa região (cerca de 4%), e não é baixo. O HC está no seu mínimo em 18, o que elimina B e E, e o CO baixo elimina D.', 'média'),
('2024-D2-Q116', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 116, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Filtração', null, null, 'O magnésio metálico utilizado em ligas leves é produzido em um processo que envolve várias etapas e utiliza água do mar como matéria-prima. A primeira etapa desse processo consiste na reação entre o íon Mg²⁺ e hidróxido de cálcio, Ca(OH)₂, obtendo uma mistura que contém hidróxido de magnésio, pouco solúvel, e íons Ca²⁺, de acordo com a equação química:

Mg²⁺ (aq) + Ca(OH)₂ (aq) → Mg(OH)₂ (s) + Ca²⁺ (aq)', 'O método adequado para separar o Mg(OH)₂ dessa mistura é a', 'A', 'O $Mg(OH)_2$ formado é pouco solúvel, ou seja, vira um sólido no meio de um líquido.', 'Para separar um sólido de um líquido numa mistura heterogênea, use um método que retém o sólido e deixa passar a solução.', 'Resposta: A. Como o $Mg(OH)_2$ precipita e os íons $Ca^{2+}$ ficam dissolvidos, a mistura é heterogênea (sólido + solução). A filtração retém o sólido no filtro e deixa a solução passar. Destilação e evaporação servem para separar componentes de uma solução, e a catação é usada para pedaços sólidos grandes, que dá para pegar com a mão.', 'fácil'),
('2024-D2-Q118', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 118, '5_alternativas', 'Química', 'Cinética e equilíbrio', 'Deslocamento de equilíbrio', null, null, 'A hidroxiapatita, Ca₅(PO₄)₃OH, é um mineral constituinte do esmalte dos dentes. Entre as diversas reações que ocorrem no meio bucal, encontram-se em equilíbrio as reações de desmineralização e mineralização da hidroxiapatita em meio aquoso, ilustradas a seguir. A desmineralização está associada à fragilização do esmalte do dente e à formação de cáries.

Ca₅(PO₄)₃OH (s) + H⁺ (aq) ⇌ 5 Ca²⁺ (aq) + 3 PO₄³⁻ (aq) + H₂O (l)

(sentido direto: Desmineralização; sentido inverso: Mineralização)

O uso de creme dental pode minimizar a perda da hidroxiapatita. O quadro apresenta o agente de polimento e o pH de alguns cremes dentais comerciais.

| Creme dental | Agente de polimento | pH |
|---|---|---|
| I | Bicarbonato de sódio | 9,5 |
| II | Carbonato de cálcio | 11,0 |
| III | Citrato de potássio | 7,7 |
| IV | Dióxido de silício | 6,9 |
| V | Fosfato de cálcio | 7,3 |

Fonte: STORGATTO, G. A.; BRAIBANTE, M. E. F.; BRAIBANTE, H. T. S. A química na odontologia. **Química Nova na Escola**, v. 39, fev. 2017 (adaptado).', 'Considerando o equilíbrio químico envolvido, qual creme dental promove a maior desmineralização do esmalte do dente?', 'D', 'Veja que o $H^+$ está no lado dos reagentes da desmineralização. Mais $H^+$ desloca o equilíbrio para qual lado?', 'Pelo princípio de Le Chatelier, quanto mais ácido o meio, mais o equilíbrio vai para a desmineralização. Procure o creme dental de menor pH.', 'Resposta: D. Aumentar a concentração de $H^+$ desloca o equilíbrio no sentido direto, que é a desmineralização. O meio mais ácido é o de menor pH: o creme IV, com pH 6,9. Os cremes com pH maior consomem $H^+$ e favorecem a mineralização; o V ainda fornece íons de cálcio e fosfato, que deslocam o equilíbrio para a mineralização.', 'média'),
('2024-D2-Q123', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 123, '5_alternativas', 'Química', 'Química orgânica', 'Funções orgânicas', null, null, 'Os pesticidas naturais vêm sendo utilizados no controle de pragas e doenças agrícolas como substituintes de pesticidas sintéticos tradicionais, por serem menos nocivos ao ambiente, biodegradáveis e minimizarem custos e riscos relativos à lavoura. Por exemplo, os compostos 1 e 2 estão envolvidos nas respostas de defesa das plantas. Os grupos funcionais presentes nesses compostos são importantes para suas propriedades no controle de pragas.

{{figura:1}}

Fonte: PINTO-ZEVALLOS, D. M.; ZARBIN, P. H. G. A química na agricultura: perspectivas para o desenvolvimento de tecnologias sustentáveis. **Química Nova**, n. 10, 2013 (adaptado).', 'Qual é a função orgânica correspondente ao grupo funcional comum presente nesses dois compostos?', 'A', 'Identifique todos os grupos funcionais de cada composto e procure o que aparece nos dois.', 'O composto 1 tem um OH ligado ao anel aromático e outro grupo com C=O e OH juntos. O composto 2 tem um C=O no anel e o mesmo grupo C=O com OH na ponta da cadeia.', 'O composto 1 tem um fenol (OH no anel benzênico) e um grupo $-COOH$. O composto 2 tem uma cetona (C=O dentro do anel), uma ligação dupla C=C (alceno) e também um grupo $-COOH$. O único grupo comum aos dois é a carboxila, que caracteriza a função ácido carboxílico: letra A. Cetona, alceno e fenol aparecem em apenas um dos compostos, e não há álcool em nenhum deles.', 'média'),
('2024-D2-Q125', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 125, '5_alternativas', 'Química', 'Química geral e atomística', 'Transições eletrônicas e fosforescência', null, null, 'As placas que indicam saída de emergência brilham no escuro, pois apresentam substâncias que fosforecem na cor amarelo-esverdeada após exposição à luz ambiente, conforme a figura.

{{figura:1}}

Esse fenômeno ocorre pela presença do sulfeto de zinco (ZnS), dopado com prata ou cobre, na superfície da placa.

Fonte: **Zinc Sulphide Phosphorescence**. Disponível em: https://physicsopenlab.org. Acesso em: 8 nov. 2023 (adaptado).', 'O aparecimento do brilho nessas condições ocorre como consequência de', 'C', 'A placa absorve luz e depois devolve luz. Pense no que acontece com os elétrons dos átomos nesse processo.', 'Ao absorver energia, elétrons sobem para níveis mais energéticos; ao voltar, liberam essa energia como luz visível.', 'Na fosforescência, a luz ambiente excita elétrons do ZnS dopado para níveis de energia mais altos. Eles voltam aos níveis de origem aos poucos, emitindo fótons de luz amarelo-esverdeada, e por isso a placa continua brilhando no escuro. O fenômeno é explicado por transições eletrônicas: letra C. Não é reflexão (E), pois a placa emite luz mesmo sem luz incidindo, nem reação nuclear (D), já que o núcleo não muda.', 'fácil'),
('2024-D2-Q128', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 128, '5_alternativas', 'Química', 'Eletroquímica', 'Geração de diferença de potencial', null, null, 'Placas solares comuns dependem de dias ensolarados para gerar energia. Mas podemos gerar eletricidade com a ajuda de gotas de chuva, revestindo placas solares com uma fina camada de grafeno. Os íons dissociados a partir da água da chuva (Aᵐ⁺ e Bⁿ⁻) tornam a combinação grafeno e água da chuva um par perfeito para geração de energia. O processo requer apenas uma camada de grafeno para que grande quantidade de elétrons (e⁻) se movimente ao longo da superfície.

{{figura:1}}

Fonte: TANG, Q. et al. A Solar Cell that is Triggered by Sun and Rain. **Angewandte Chemie International Edition**, n. 55, 2016 (adaptado).', 'Ao produzir eletricidade em dias chuvosos, o grafeno', 'E', 'Observe a figura: onde ficam os cátions da água e os elétrons do grafeno, e que diferença de potencial aparece entre eles?', 'Não há reação química nem catálise: as cargas se organizam em camadas opostas na interface água-grafeno, como em um capacitor.', 'Os cátions $A^{m+}$ da chuva se acumulam junto à superfície do grafeno, que atrai elétrons para essa interface. Forma-se uma dupla camada de cargas opostas, com alto potencial no lado da água e baixo no lado do grafeno: surge uma diferença de potencial capaz de gerar corrente. É a letra E. A letra A está errada porque oxidar um cátion exigiria retirar elétrons dele, e os elétrons apenas se acumulam ao lado dos cátions.', 'média'),
('2024-D2-Q133', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 133, '5_alternativas', 'Química', 'Estequiometria', 'Cálculo estequiométrico de combustíveis', null, null, 'O biogás é uma alternativa energética muito importante, pois, além de reduzir a dependência por combustíveis fósseis, sua obtenção pode ser realizada a partir de resíduos da produção agroindustrial. Considere que o biogás produzido em um empreendimento de suinocultura contém 70% em volume de metano (massa molar 16 g/mol; volume molar 22 L/mol). Ele será utilizado para geração de energia em substituição ao etanol (massa molar 46 g/mol) em um gerador no qual 1 m³ de biogás de origem suína substitui 0,59 L de etanol anidro (densidade 0,78 g/mL).', 'Nessas condições, a massa de metano necessária para substituir 10 mol de etanol na produção de energia é mais próxima de', 'C', 'Transforme os 10 mol de etanol em volume (litros) usando a massa molar e a densidade.', '10 mol de etanol dão cerca de 0,59 L, o que equivale a 1 m³ de biogás. Agora pegue 70% desse volume como metano e converta em massa.', 'Massa de etanol: $10 \times 46 = 460$ g; volume: $\frac{460}{0{,}78} \approx 590$ mL $= 0{,}59$ L, que equivale a 1 m³ (1000 L) de biogás. Metano: $0{,}70 \times 1000 = 700$ L, ou seja, $\frac{700}{22} \approx 31{,}8$ mol. Massa: $31{,}8 \times 16 \approx 509$ g, mais próxima de 510 g: letra C. A letra E (720 g) aparece se você esquecer de aplicar os 70%.', 'difícil'),
('2024-D2-Q135', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2024, 135, '5_alternativas', 'Química', 'Estequiometria', 'Reciclagem do alumínio', null, null, '**Brasil fecha 2020 entre os maiores recicladores de latas de alumínio**

A bauxita contém alumina (Al₂O₃), que é a matéria-prima para produção do alumínio (Al). De forma geral, são necessários 50 kg de bauxita para produzir 10 kg de alumínio. O Brasil fechou 2020 como um dos principais líderes mundiais em reciclagem de latas de alumínio. De acordo com levantamento da Associação Brasileira dos Fabricantes de Latas de Alumínio (Abralatas), o país obteve um índice de reciclagem de 97,4%, de um total de 4,0 × 10⁵ toneladas de latas vendidas. Considere que a lata é constituída de alumínio puro.

Fonte: Disponível em: https://agenciabrasil.ebc.com.br. Acesso em: 30 nov. 2021 (adaptado).', 'Levando em conta apenas a reciclagem de latas, qual é o valor mais próximo da massa de bauxita, em tonelada, que deixou de ser extraída da natureza em 2020 no Brasil?', 'D', 'Primeiro descubra quanto alumínio foi reciclado; depois use a proporção entre bauxita e alumínio.', 'Recicladas: 97,4% de $4{,}0 \times 10^5$ t. Como 50 kg de bauxita geram 10 kg de alumínio, cada tonelada de alumínio exige 5 t de bauxita.', 'Alumínio reciclado: $0{,}974 \times 4{,}0 \times 10^5 \approx 3{,}9 \times 10^5$ t. A proporção é $\frac{50}{10} = 5$ t de bauxita por tonelada de alumínio, então a bauxita poupada é $5 \times 3{,}9 \times 10^5 \approx 1{,}9 \times 10^6$ t: letra D. A letra B ($3{,}9 \times 10^5$) é a massa de alumínio reciclado, e não a de bauxita.', 'média'),
('2025-D2-Q091', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 91, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Adsorção por carvão ativado', null, null, 'A filtração em carvão é uma das mais antigas formas de purificação de água. O carvão ativado, diferentemente do carvão comum, é útil para ser empregado na remoção de material orgânico, cloro e outros contaminantes. Essa capacidade decorre de suas propriedades de adsorção. A origem do material utilizado para produzir o carvão ativado pode influenciar sua porosidade e, consequentemente, interferir na capacidade do material de remover impurezas. Na figura, é ilustrada esquematicamente a diferença entre as estruturas físicas do carvão comum e do carvão ativado.

{{figura:1}}

Fonte: CORRÊA, M. A. **Cosmetologia: ciência e técnica**. São Paulo: Medfarma, 2012 (adaptado).', 'Qual característica do carvão ativado explica a sua maior eficiência nesse processo?', 'D', 'Compare as duas figuras: o que o carvão ativado tem a mais que o comum?', 'A adsorção é um fenômeno de superfície: as impurezas grudam nas paredes do material. Mais poros e fendas significam mais área disponível.', 'Na adsorção, as impurezas ficam presas na superfície do sólido. O carvão ativado tem muitos macro, meso e microporos e fendas, o que dá a ele uma área de superfície enorme, com muito mais pontos para reter contaminantes. Por isso é mais eficiente: letra D. Massa, dureza, densidade e condutividade não determinam quanto material consegue aderir.', 'fácil'),
('2025-D2-Q100', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 100, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Purificação da água', null, null, 'Existe um processo de purificação de água em que são removidos os sais dissolvidos. A água que passa por esse processo é muito utilizada em laboratórios de química, em indústrias (como solvente), em baterias de carros etc. Entretanto, esse tipo de água não é adequado para ingestão, pois pode causar problemas de saúde, como carência iônica e diarreia.', 'Essa água é chamada de', 'D', 'Que processo de separação ferve a água e condensa o vapor, deixando os sais para trás?', 'Os sais não evaporam junto com a água. A água obtida desse jeito é a usada em laboratórios e baterias.', 'Na destilação, a água é aquecida, vira vapor e depois é condensada, enquanto os sais dissolvidos ficam no recipiente original. O resultado é a água destilada, praticamente sem íons, usada em laboratórios e baterias, mas imprópria para consumo frequente: letra D. A água dura (A) é o contrário, rica em sais de cálcio e magnésio; a pesada (B) tem deutério; a sanitária e a oxigenada são soluções de outras substâncias.', 'fácil'),
('2025-D2-Q105', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 105, '5_alternativas', 'Química', 'Química ambiental', 'Poluição térmica e oxigênio dissolvido', null, null, 'As usinas termonucleares são aquelas que produzem energia elétrica a partir da geração de energia térmica proveniente das reações nucleares. Normalmente, essas usinas funcionam por meio de dois circuitos, denominados circuito primário (vaso de pressão, pressurizador e bomba) e circuito secundário (gerador de vapor, turbina, condensador, tanque de alimentação e bombas), além de um sistema de água de refrigeração, formado por uma bomba ligada a uma fonte hídrica natural.

{{figura:1}}

Durante a operação da usina, se o sistema de água de refrigeração funcionar de forma ineficiente pode causar poluição térmica, comprometendo a vida no ecossistema aquático.

Fonte: Disponível em: www.eletronuclear.gov.br. Acesso em: 29 nov. 2021 (adaptado).', 'Para o ecossistema aquático, a ineficiência do sistema de água de refrigeração tem como consequência a', 'E', 'Pense no que acontece com a temperatura da água devolvida ao rio ou lago quando o resfriamento não funciona bem.', 'Poluição térmica é água mais quente, não substâncias tóxicas. Lembre como a temperatura afeta a quantidade de gás que consegue ficar dissolvida em um líquido.', 'Se o sistema de refrigeração é ineficiente, a água volta ao ecossistema mais quente. Gases se dissolvem menos em água quente, então cai a quantidade de oxigênio disponível para peixes e outros organismos: alternativa E, diminuição da solubilidade do gás oxigênio. A água de refrigeração não tem contato com o reator, por isso não leva elementos radioativos nem combustível (D e C).', 'fácil'),
('2025-D2-Q106', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 106, '5_alternativas', 'Química', 'Química geral e atomística', 'Fórmulas de compostos inorgânicos', null, null, 'No início do século XX, as fórmulas das substâncias eram representadas de modo diferente do atual. A figura apresenta uma fotografia bem antiga (1909) que registra uma aula de química ministrada em um colégio em Santos (SP). Um olhar mais atento permite identificar como os compostos químicos eram representados.

{{figura:1}}

O nitrogênio era chamado de azoto e representado pelo símbolo Az. Vê-se na lousa a equação representativa da adição do oxigênio atômico (O) ao monóxido de nitrogênio (AzO) com a formação de dióxido de nitrogênio (AzO²). Analogamente, o nitrato de sódio era representado por NaAzO³.

Fonte: Disponível em: www.novomilenio.inf.br. Acesso em: 29 ago. 2014 (adaptado).', 'Em 1909, as representações das substâncias ácido nítrico e cloreto de cálcio, tendo por base essas informações e seguindo a mesma lógica, seriam, respectivamente:', 'A', 'Compare as fórmulas antigas da lousa com as atuais: o que mudou foi só o símbolo do nitrogênio e o jeito de escrever os índices.', 'Escreva primeiro as fórmulas atuais: ácido nítrico é $HNO_3$ e cloreto de cálcio é $CaCl_2$. Depois troque N por Az e passe os índices para cima.', 'Na notação de 1909, N virava Az e os índices eram escritos em sobrescrito, como em NaAzO³ (hoje $NaNO_3$). Assim, $HNO_3$ vira HAzO³ e $CaCl_2$ vira CaCl²: alternativa A. As outras mudam a quantidade de átomos (como H³AzO⁴) ou trocam o cálcio por potássio (K), o que não faz sentido.', 'fácil'),
('2025-D2-Q109', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 109, '5_alternativas', 'Química', 'Química orgânica', 'Reação de descarboxilação', null, null, 'O fruto do cajueiro é um aquênio repleto de um líquido escuro, quase preto, cáustico e inflamável. Esse líquido da casca da castanha do caju (LCC) representa aproximadamente 25% da massa da castanha e é um subproduto de agronegócio do caju. Quando submetido a altas temperaturas, o ácido anacárdico presente no LCC é convertido a cardanol, que recebe a denominação de LCC técnico, conforme o esquema:

{{figura:1}}

Fonte: MAZZETTO, S. E.; LOMONACO, D.; MELE, G. Óleo da castanha de caju: oportunidades e desafios no contexto do desenvolvimento e sustentabilidade industrial. **Química Nova**, n. 3, 2009 (adaptado).', 'O LCC técnico é produzido por meio de uma reação orgânica do tipo', 'E', 'Compare as duas moléculas do esquema: que grupo o ácido anacárdico tem e o cardanol não tem? E qual gás sai?', 'O grupo que sumiu é a carboxila ($-COOH$), liberada na forma de $CO_2$. O nome da reação descreve exatamente a retirada desse grupo.', 'No aquecimento, o ácido anacárdico perde o grupo carboxila ($-COOH$), que sai como $CO_2$, e vira cardanol. A remoção da carboxila com liberação de $CO_2$ se chama descarboxilação: alternativa E. Não há entrada de água (hidrólise), de hidrogênio (hidrogenação) nem formação de éster (esterificação).', 'fácil'),
('2025-D2-Q110', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 110, '5_alternativas', 'Química', 'Química geral e atomística', 'Meia-vida radioativa', null, null, 'A química nuclear é uma importante ferramenta na produção de substâncias utilizadas na área da saúde humana. A radiação emitida pelo cobalto-60 é utilizada na medicina como ferramenta de diagnóstico e no tratamento do câncer. No entanto, esse radioisótopo tem um tempo de armazenamento limitado, pois seu tempo de meia-vida é de 5,3 anos. Considere um frasco com uma amostra contendo 2,00 mg de cobalto-60, armazenado durante um período de 26,5 anos.', 'A massa de cobalto-60, em miligrama, que restará ao final desse tempo é mais próxima de', 'E', 'Descubra quantas meias-vidas cabem em 26,5 anos.', 'Divida 26,5 por 5,3 para achar o número de meias-vidas. A cada uma delas, a massa cai pela metade.', 'O número de meias-vidas é $26{,}5 \div 5{,}3 = 5$. A massa cai pela metade 5 vezes: $2{,}00 \to 1{,}00 \to 0{,}50 \to 0{,}25 \to 0{,}125 \to 0{,}0625$ mg, ou seja, $\frac{2{,}00}{2^5} \approx 0{,}06$ mg (alternativa E). A alternativa D (0,13 mg) corresponde a apenas 4 meias-vidas.', 'fácil'),
('2025-D2-Q115', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 115, '5_alternativas', 'Química', 'Química orgânica', 'Fórmula molecular e oxidação', null, null, 'Em uma aula prática de química orgânica, um professor identificou os frascos de várias substâncias apenas por suas fórmulas moleculares. Em seguida, apresentou a representação tridimensional da molécula do borneol, um álcool secundário, conforme a figura. Ele explicou que, quando oxidado, o borneol dá origem à cânfora, uma cetona usada desde a Antiguidade como incenso e no preparo de medicamentos. Finalmente, o professor solicitou que os alunos identificassem o frasco contendo a substância cânfora.

{{figura:1}}

Fonte: SANTOS, A. P. B. et al. Oxidação do borneol à cânfora com água sanitária: um experimento simples de baixo custo e limpo. **Química Nova**, n. 6, 2009 (adaptado).', 'O frasco contendo cânfora apresenta a fórmula molecular:', 'C', 'Conte os carbonos do borneol e pense no que muda quando um álcool secundário vira cetona.', 'Na oxidação de um álcool secundário a cetona, o $C-OH$ vira $C=O$: a molécula perde 2 átomos de H e mantém os carbonos e o oxigênio. Ache primeiro a fórmula do borneol.', 'O borneol tem 10 carbonos (7 do esqueleto bicíclico e 3 grupos metila) e um OH; sua fórmula é $C_{10}H_{18}O$. Ao ser oxidado, o carbono do $C-OH$ vira carbonila ($C=O$), perdendo 2 hidrogênios. A cânfora fica $C_{10}H_{16}O$: alternativa C. Opções com $O_2$ (D e E) ganhariam um oxigênio, o que não acontece na formação de uma cetona.', 'média'),
('2025-D2-Q117', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 117, '5_alternativas', 'Química', 'Cinética e equilíbrio', 'Princípio de Le Chatelier', null, null, 'Para a produção de titânio metálico ou dióxido de titânio puros, é necessário fazer a cloração do minério que contém dióxido de titânio, com o objetivo de separar esse óxido de outras substâncias presentes no minério. A principal reação química de cloração é representada por:

TiO₂ (s) + 2 Cl₂ (g) ⇌ TiCl₄ (g) + O₂ (g)    ΔH = +175 kJ/mol

Depois da cloração, o tetracloreto de titânio é condensado e convertido, novamente, a dióxido de titânio.', 'Após o sistema atingir o equilíbrio químico, como a formação do TiCl₄ pode ser favorecida?', 'D', 'Use o princípio de Le Chatelier e analise cada perturbação separadamente.', 'Conte os mols de gás de cada lado: 2 e 2, então a pressão total não desloca. A reação é endotérmica. E sólidos não entram no equilíbrio.', 'Aumentar a pressão parcial de $Cl_2$, um reagente, faz o equilíbrio se deslocar no sentido de consumi-lo, formando mais $TiCl_4$: alternativa D. A pressão total (A) não muda nada, pois há 2 mols de gás de cada lado. Como $\Delta H > 0$, esfriar (B) favorece os reagentes. Aumentar $O_2$ (C) desloca para a esquerda, e o $TiO_2$ sólido (E) não altera o equilíbrio.', 'média'),
('2025-D2-Q121', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 121, '5_alternativas', 'Química', 'Química orgânica', 'Basicidade de aminas', null, null, 'A dimetilamina é uma substância de elevada toxidez que entra em ebulição a 7 °C. Na madrugada de um dia frio, essa substância se espalhou por uma rodovia após um acidente de trânsito envolvendo um caminhão que transportava esse produto. Para minimizar a agressão ao meio ambiente, bem como evitar a evaporação da dimetilamina com a elevação da temperatura ao longo do dia, um químico considerou o uso de algumas substâncias ou misturas como água, vinagre, óleo de soja, sal de cozinha e bicarbonato de sódio.', 'Dentre as opções apresentadas, o tratamento correto para minimizar esse problema é usar', 'B', 'A dimetilamina é uma amina. Pense no caráter ácido ou básico dela.', 'Aminas são bases. Reagindo com um ácido, formam um sal, que é iônico e não evapora com facilidade. Qual das opções é ácida?', 'Aminas como a dimetilamina são bases orgânicas. O ácido acético do vinagre reage com ela e forma um sal de amônio, um composto iônico, pouco volátil e menos agressivo: alternativa B. Água só dilui e não impede a evaporação; o bicarbonato de sódio (E) é básico e não neutraliza uma base; sal de cozinha e óleo de soja não reagem com ela.', 'média'),
('2025-D2-Q124', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 124, '5_alternativas', 'Química', 'Eletroquímica', 'Potencial-padrão de pilhas', null, null, 'Objetos de prata escurecem em contato com compostos contendo enxofre por causa da formação de uma fina camada de sulfeto de prata. Um método simples para clarear o objeto consiste em forrar um recipiente com papel alumínio, adicionar ao recipiente uma solução aquosa de cloreto de sódio e, enfim, mergulhar o objeto de prata enegrecido. Em cerca de três minutos, a prata volta à coloração original. As seguintes semirreações e os respectivos potenciais-padrão de redução são úteis para a compreensão dos fenômenos ocorridos.

Ag₂S (s) + 2 e⁻ → 2 Ag (s) + S²⁻ (aq)    −0,69 V
O₂ (g) + 4 H⁺ (aq) + 4 e⁻ → 2 H₂O (l)    +1,23 V
Al³⁺ (aq) + 3 e⁻ → Al (s)    −1,68 V

Fonte: SARTORI, E. R.; BATISTA, E. F.; FATIBELLO-FILHO, O. Escurecimento e limpeza de objetos de prata: um experimento simples e de fácil execução envolvendo reações de oxidação-redução. **Química Nova na Escola**, n. 30, 2008 (adaptado).', 'Os valores das diferenças de potencial-padrão das reações que representam o escurecimento e o clareamento do objeto de prata são, respectivamente:', 'B', 'Monte as duas reações: no escurecimento a prata vira $Ag_2S$; no clareamento o $Ag_2S$ volta a ser prata, com ajuda do alumínio.', 'Use $\Delta E = E_{red}(\text{quem reduz}) - E_{red}(\text{quem oxida})$. No escurecimento, o $O_2$ é reduzido e a prata é oxidada; no clareamento, o $Ag_2S$ é reduzido e o Al é oxidado.', 'Escurecimento: a prata é oxidada a $Ag_2S$ e o $O_2$ é reduzido, então $\Delta E = 1{,}23 - (-0{,}69) = +1{,}92$ V. Clareamento: o $Ag_2S$ é reduzido a prata e o alumínio é oxidado, então $\Delta E = -0{,}69 - (-1{,}68) = +0{,}99$ V. Alternativa B. Os dois valores são positivos, como se espera de processos espontâneos; não se multiplicam os potenciais pelos coeficientes da equação.', 'difícil'),
('2025-D2-Q125', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 125, '5_alternativas', 'Química', 'Estequiometria', 'Rendimento e gases ideais', null, null, 'Apaixonada por culinária e química, uma chefe de cozinha calculou que, para promover o crescimento adequado da massa durante o cozimento de um bolo a 180 °C (453 K) e 1,00 atm, ela precisaria utilizar uma quantidade de fermento químico suficiente para produzir um volume de gás igual a 4,00 L. Com esse objetivo, ela escolheu utilizar o bicarbonato de amônio, um composto que, sob aquecimento, degrada-se em três gases distintos, que são os responsáveis pelo crescimento da massa. A decomposição do bicarbonato de amônio ocorre conforme a equação química apresentada e, nas condições do cozimento, seu rendimento é de 80%.

NH₄HCO₃ (s) → NH₃ (g) + CO₂ (g) + H₂O (g)

Considere que a mistura dos gases se comporta como gás ideal nas condições de cozimento utilizadas pela chefe.

Dados: Massa molar do NH₄HCO₃ = 79 g · mol⁻¹ e R = 0,082 atm · L · mol⁻¹ · K⁻¹.', 'A massa, em grama, de bicarbonato de amônio que ela deve utilizar é mais próxima de', 'B', 'Comece pela equação dos gases ideais para achar quantos mols de gás são necessários.', 'Cada mol de $NH_4HCO_3$ gera 3 mols de gás. Ache os mols de sal, corrija pelo rendimento de 80% (você precisa de mais sal) e multiplique por 79.', 'Mols de gás: $n = \frac{PV}{RT} = \frac{1{,}00 \cdot 4{,}00}{0{,}082 \cdot 453} \approx 0{,}108$ mol. Como 1 mol de sal gera 3 mols de gás, seriam $0{,}036$ mol de sal com rendimento total. Com 80%: $\frac{0{,}036}{0{,}8} \approx 0{,}045$ mol, ou $0{,}045 \cdot 79 \approx 3{,}5$ g, alternativa B. Esquecer o rendimento leva a cerca de 2,8 g; esquecer que são 3 gases leva a valores bem maiores.', 'difícil'),
('2025-D2-Q127', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 127, '5_alternativas', 'Química', 'Cinética e equilíbrio', 'Catálise e energia de ativação', null, null, 'Nos processos de transformação e reciclagem de recursos naturais, as velocidades das reações químicas são estudadas pela cinética química. Uma reação A → B é realizada na presença e na ausência de uma enzima, com todas as demais condições permanecendo inalteradas. Considere que, no gráfico da variação de energia ao longo dessa reação, a linha contínua representa o avanço da reação na ausência da enzima, e a linha pontilhada, na presença da enzima.', 'O gráfico que representa a situação descrita é:', 'C', 'Uma enzima é um catalisador. O que um catalisador muda no gráfico de energia de uma reação, e o que ele não muda?', 'O catalisador não altera a energia dos reagentes nem a dos produtos (o $\Delta H$ fica igual). Procure o gráfico em que só o pico muda.', 'A enzima cria um caminho de reação com menor energia de ativação, mas não altera a energia de A nem de B. No gráfico certo, a curva pontilhada começa e termina nos mesmos níveis da contínua e tem um pico mais baixo: alternativa C. Na D o pico pontilhado é mais alto, o que deixaria a reação mais lenta; em A, B e E mudam as energias de reagentes ou produtos.', 'fácil'),
('2025-D2-Q131', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 131, '5_alternativas', 'Química', 'Estequiometria', 'Reagente em excesso', null, null, 'O Brasil é o maior produtor mundial de nióbio (massa molar = 93 g mol⁻¹), metal utilizado na fabricação de vários tipos de aço: automotivos, estruturais e inoxidáveis. O processo utilizado na produção do nióbio é a redução aluminotérmica de Nb₂O₅ com excesso de 10% de Al (massa molar = 27 g mol⁻¹), em relação à quantidade estequiométrica da reação, representada pela equação química:

3 Nb₂O₅ (s) + 10 Al (s) → 6 Nb (s) + 5 Al₂O₃ (s)

Uma engenheira metalúrgica estimou a massa de alumínio necessária para produzir 9,3 kg de nióbio, nas condições descritas, para a produção de um lote de peças de aço encomendado por uma indústria, considerando um rendimento de 100%.

Fonte: Disponível em: www.cbmm.com.br. Acesso em: 17 out. 2015 (adaptado).', 'A massa de alumínio, em quilograma, estimada pela engenheira é mais próxima de', 'E', 'Transforme 9,3 kg de nióbio em mols e use a proporção da equação entre Al e Nb.', '9,3 kg de Nb são 100 mol. A equação dá 10 mol de Al para 6 mol de Nb. Não esqueça de somar os 10% de excesso no final.', 'Mols de Nb: $\frac{9300}{93} = 100$ mol. Pela equação, $n_{Al} = 100 \cdot \frac{10}{6} \approx 166{,}7$ mol, o que dá $166{,}7 \cdot 27 \approx 4500$ g $= 4{,}5$ kg (quantidade estequiométrica). Com 10% de excesso: $4{,}5 \cdot 1{,}1 \approx 4{,}95 \approx 5{,}0$ kg, alternativa E. A alternativa D (4,5 kg) esquece o excesso de alumínio.', 'média'),
('2025-D2-Q133', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 133, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Separação óleo-água', null, null, 'O despejo acidental de óleo nos oceanos tem ocasionado incontáveis prejuízos à vida marinha e à economia de regiões costeiras. Métodos tradicionais de tratamento do despejo geram resíduos de difícil descarte e nem sempre são eficazes. Por isso, pesquisadores desenvolveram um filtro capaz de separar óleo e água. O dispositivo é montado sobre uma malha de aço com uma sequência de camadas. A primeira camada é formada por um polímero de carga positiva, a segunda é composta por nanopartículas de sílica (SiO₂), a terceira é formada pelo mesmo polímero e a última é um surfactante, conforme apresentado na figura.

**Representação esquemática do dispositivo**

{{figura:1}}

Fonte: BROWN, P. S.; BHUSHAN, B. Mechanically durable, superoleophobic coatings prepared by layer-by-layer technique for anti-smudge and oil-water separation. **Scientific Reports**, v. 5, mar. 2015 (adaptado).', 'Na utilização desse dispositivo, a retenção do óleo ocorre', 'A', 'Veja qual camada fica por cima, em contato direto com a mistura de óleo e água, e do que ela é feita.', 'O surfactante tem cadeias cheias de flúor ($CF_2$, $CF_3$). Cadeias fluoradas repelem o óleo (são oleofóbicas), então o óleo nem chega às camadas de baixo.', 'A camada mais externa é o surfactante, com cadeias fluoradas que repelem o óleo. Por isso o óleo fica retido logo na superfície, no surfactante, enquanto a água consegue passar pelo filtro: alternativa A. As camadas de polímero e de sílica servem para prender o surfactante por atração entre cargas opostas, e a malha de aço é só o suporte.', 'difícil'),
('2025-D2-Q134', 'enem', 'enem-QUI', 'INEP', null, null, 'Médio', 2025, 134, '5_alternativas', 'Química', 'Química geral e atomística', 'Polaridade e solubilidade', null, null, 'Alguns hormônios sexuais têm ganhado notável atenção nos últimos anos por suas concentrações cada vez maiores no solo e na água em todo o mundo. O motivo da preocupação é porque, em níveis poluentes, eles têm sido associados ao câncer de mama e ao câncer de próstata, além de perturbarem a fisiologia dos peixes, podendo, ainda, afetarem o desenvolvimento reprodutivo de animais domésticos e selvagens. Assim, o descarte inadequado desses hormônios representa uma séria ameaça ao solo, plantas, recursos hídricos e humanos. De baixa polaridade, eles apresentam uma solubilidade pequena e variável em água, dependendo dos grupos presentes em suas estruturas, representando um grande risco para os ambientes aquáticos. As figuras a seguir apresentam as estruturas de alguns desses hormônios.

{{figura:1}}

Fonte: MUHAMMAD, A. et al. Environmental Impact of Estrogens on Human, Animal and Plant Life: a Critical Review. **Environment International**, n. 99, 2017 (adaptado).', 'Do ponto de vista das interações químicas, qual desses hormônios apresenta maior solubilidade em ambientes aquáticos?', 'B', 'A água é muito polar. Procure nas estruturas os grupos que fazem ligações de hidrogênio com ela.', 'Os esqueletos dos cinco hormônios são parecidos e apolares. Conte quantos grupos $-OH$ cada um tem: quanto mais, maior a interação com a água.', 'Os hormônios têm o mesmo esqueleto de anéis, pouco polar; o que muda a solubilidade em água são os grupos polares. Os grupos $-OH$ fazem ligações de hidrogênio com a água, e o estriol tem três deles, mais do que qualquer outro: alternativa B. O estradiol e o novestrol têm dois OH, e a estrona e a noretindrona têm uma carbonila, que interage menos com a água do que um OH.', 'fácil')
on conflict (id) do update set exame_id = excluded.exame_id, recorte_id = excluded.recorte_id, banca = excluded.banca, orgao = excluded.orgao, cargo = excluded.cargo, nivel = excluded.nivel, ano = excluded.ano, numero = excluded.numero, formato = excluded.formato, disciplina = excluded.disciplina, assunto = excluded.assunto, topico = excluded.topico, lingua = excluded.lingua, texto_base_id = excluded.texto_base_id, texto_apoio = excluded.texto_apoio, comando = excluded.comando, gabarito = excluded.gabarito, dica1 = excluded.dica1, dica2 = excluded.dica2, explicacao = excluded.explicacao, dificuldade = excluded.dificuldade;
delete from public.alternativas where questao_id in ('2024-D2-Q092', '2024-D2-Q093', '2024-D2-Q094', '2024-D2-Q097', '2024-D2-Q114', '2024-D2-Q116', '2024-D2-Q118', '2024-D2-Q123', '2024-D2-Q125', '2024-D2-Q128', '2024-D2-Q133', '2024-D2-Q135', '2025-D2-Q091', '2025-D2-Q100', '2025-D2-Q105', '2025-D2-Q106', '2025-D2-Q109', '2025-D2-Q110', '2025-D2-Q115', '2025-D2-Q117', '2025-D2-Q121', '2025-D2-Q124', '2025-D2-Q125', '2025-D2-Q127', '2025-D2-Q131', '2025-D2-Q133', '2025-D2-Q134');
insert into public.alternativas (questao_id, letra, texto, imagem) values
('2024-D2-Q092', 'A', 'CH₃COO⁻ (aq) + O₂ (g) → 2 CO₂ (g) + 3 H⁺ (aq)', null),
('2024-D2-Q092', 'B', 'CO₂ (g) + O₂ (g) + H⁺ (aq) → H₂O (l) + CH₃COO⁻ (aq)', null),
('2024-D2-Q092', 'C', 'CH₃COO⁻ (aq) + H⁺ (aq) + 2 O₂ (g) → 2 CO₂ (g) + 2 H₂O (l)', null),
('2024-D2-Q092', 'D', 'CH₃COO⁻ (aq) + 6 H₂O (l) → 2 CO₂ (g) + 2 O₂ (g) + 15 H⁺ (aq)', null),
('2024-D2-Q092', 'E', '2 CO₂ (g) + 11 H⁺ (aq) + O₂ (g) → CH₃COO⁻ (aq) + 4 H₂O (l)', null),
('2024-D2-Q093', 'A', 'benéficas à saúde humana.', null),
('2024-D2-Q093', 'B', 'capazes de serem biodegradadas.', null),
('2024-D2-Q093', 'C', 'formadas a partir de gás carbônico.', null),
('2024-D2-Q093', 'D', 'produzidas sem o uso de agrotóxicos.', null),
('2024-D2-Q093', 'E', 'contendo carbono como elemento principal.', null),
('2024-D2-Q094', 'A', 'sulfonamida.', null),
('2024-D2-Q094', 'B', 'metila.', null),
('2024-D2-Q094', 'C', 'fenila.', null),
('2024-D2-Q094', 'D', 'nitro.', null),
('2024-D2-Q094', 'E', 'éter.', null),
('2024-D2-Q097', 'A', '0,7 g', null),
('2024-D2-Q097', 'B', '1,8 g', null),
('2024-D2-Q097', 'C', '2,8 g', null),
('2024-D2-Q097', 'D', '3,6 g', null),
('2024-D2-Q097', 'E', '7,0 g', null),
('2024-D2-Q114', 'A', 'baixa de O₂ e alta de NO.', null),
('2024-D2-Q114', 'B', 'baixa de NO e alta de HC.', null),
('2024-D2-Q114', 'C', 'baixa de CO e alta de CO₂.', null),
('2024-D2-Q114', 'D', 'baixa de HC e alta de CO.', null),
('2024-D2-Q114', 'E', 'baixa de CO₂ e alta de HC.', null),
('2024-D2-Q116', 'A', 'filtração.', null),
('2024-D2-Q116', 'B', 'catação.', null),
('2024-D2-Q116', 'C', 'destilação.', null),
('2024-D2-Q116', 'D', 'dissolução.', null),
('2024-D2-Q116', 'E', 'evaporação.', null),
('2024-D2-Q118', 'A', 'I', null),
('2024-D2-Q118', 'B', 'II', null),
('2024-D2-Q118', 'C', 'III', null),
('2024-D2-Q118', 'D', 'IV', null),
('2024-D2-Q118', 'E', 'V', null),
('2024-D2-Q123', 'A', 'Ácido carboxílico.', null),
('2024-D2-Q123', 'B', 'Cetona.', null),
('2024-D2-Q123', 'C', 'Alceno.', null),
('2024-D2-Q123', 'D', 'Álcool.', null),
('2024-D2-Q123', 'E', 'Fenol.', null),
('2024-D2-Q125', 'A', 'colisões interatômicas.', null),
('2024-D2-Q125', 'B', 'coloração dos átomos.', null),
('2024-D2-Q125', 'C', 'transições eletrônicas.', null),
('2024-D2-Q125', 'D', 'reações nucleares.', null),
('2024-D2-Q125', 'E', 'reflexão da luz.', null),
('2024-D2-Q128', 'A', 'oxida os cátions dissolvidos na água da chuva.', null),
('2024-D2-Q128', 'B', 'impede a difusão da água através das placas solares.', null),
('2024-D2-Q128', 'C', 'diminui a energia de ativação da reação no pseudocapacitor.', null),
('2024-D2-Q128', 'D', 'forma um compósito não metálico com os íons na água da chuva.', null),
('2024-D2-Q128', 'E', 'gera uma diferença de potencial pela interação dos elétrons com os cátions.', null),
('2024-D2-Q133', 'A', '300 g.', null),
('2024-D2-Q133', 'B', '400 g.', null),
('2024-D2-Q133', 'C', '510 g.', null),
('2024-D2-Q133', 'D', '590 g.', null),
('2024-D2-Q133', 'E', '720 g.', null),
('2024-D2-Q135', 'A', '1,0 × 10⁴ ton', null),
('2024-D2-Q135', 'B', '3,9 × 10⁵ ton', null),
('2024-D2-Q135', 'C', '5,0 × 10⁵ ton', null),
('2024-D2-Q135', 'D', '1,9 × 10⁶ ton', null),
('2024-D2-Q135', 'E', '2,0 × 10⁷ ton', null),
('2025-D2-Q091', 'A', 'Massa.', null),
('2025-D2-Q091', 'B', 'Dureza.', null),
('2025-D2-Q091', 'C', 'Densidade.', null),
('2025-D2-Q091', 'D', 'Superfície.', null),
('2025-D2-Q091', 'E', 'Condutividade.', null),
('2025-D2-Q100', 'A', 'dura.', null),
('2025-D2-Q100', 'B', 'pesada.', null),
('2025-D2-Q100', 'C', 'sanitária.', null),
('2025-D2-Q100', 'D', 'destilada.', null),
('2025-D2-Q100', 'E', 'oxigenada.', null),
('2025-D2-Q105', 'A', 'diminuição do pH.', null),
('2025-D2-Q105', 'B', 'liberação de gases poluentes.', null),
('2025-D2-Q105', 'C', 'contaminação por combustíveis.', null),
('2025-D2-Q105', 'D', 'liberação de elementos radioativos.', null),
('2025-D2-Q105', 'E', 'diminuição da solubilidade do gás oxigênio.', null),
('2025-D2-Q106', 'A', 'HAzO³ e CaCl²', null),
('2025-D2-Q106', 'B', 'HAz³O e Ca²Cl', null),
('2025-D2-Q106', 'C', 'H³AzO⁴ e CaCl', null),
('2025-D2-Q106', 'D', 'HAz³O e KCl²', null),
('2025-D2-Q106', 'E', 'HAzO² e KCl', null),
('2025-D2-Q109', 'A', 'hidrólise.', null),
('2025-D2-Q109', 'B', 'fenilação.', null),
('2025-D2-Q109', 'C', 'esterificação.', null),
('2025-D2-Q109', 'D', 'hidrogenação.', null),
('2025-D2-Q109', 'E', 'descarboxilação.', null),
('2025-D2-Q110', 'A', '2,00 mg.', null),
('2025-D2-Q110', 'B', '1,00 mg.', null),
('2025-D2-Q110', 'C', '0,40 mg.', null),
('2025-D2-Q110', 'D', '0,13 mg.', null),
('2025-D2-Q110', 'E', '0,06 mg.', null),
('2025-D2-Q115', 'A', 'C₉H₁₆O', null),
('2025-D2-Q115', 'B', 'C₉H₁₇O', null),
('2025-D2-Q115', 'C', 'C₁₀H₁₆O', null),
('2025-D2-Q115', 'D', 'C₁₀H₁₆O₂', null),
('2025-D2-Q115', 'E', 'C₁₀H₁₈O₂', null),
('2025-D2-Q117', 'A', 'Aumentando a pressão total do sistema.', null),
('2025-D2-Q117', 'B', 'Diminuindo a temperatura do sistema.', null),
('2025-D2-Q117', 'C', 'Aumentando a pressão parcial de O₂.', null),
('2025-D2-Q117', 'D', 'Aumentando a pressão parcial de Cl₂.', null),
('2025-D2-Q117', 'E', 'Variando a quantidade de TiO₂.', null),
('2025-D2-Q121', 'A', 'água.', null),
('2025-D2-Q121', 'B', 'vinagre.', null),
('2025-D2-Q121', 'C', 'óleo de soja.', null),
('2025-D2-Q121', 'D', 'sal de cozinha.', null),
('2025-D2-Q121', 'E', 'bicarbonato de sódio.', null),
('2025-D2-Q124', 'A', '+0,54 V e +2,37 V.', null),
('2025-D2-Q124', 'B', '+1,92 V e +0,99 V.', null),
('2025-D2-Q124', 'C', '−0,15 V e +5,43 V.', null),
('2025-D2-Q124', 'D', '+2,61 V e +1,29 V.', null),
('2025-D2-Q124', 'E', '+0,15 V e −1,29 V.', null),
('2025-D2-Q125', 'A', '2,3 g.', null),
('2025-D2-Q125', 'B', '3,5 g.', null),
('2025-D2-Q125', 'C', '5,9 g.', null),
('2025-D2-Q125', 'D', '6,8 g.', null),
('2025-D2-Q125', 'E', '8,9 g.', null),
('2025-D2-Q127', 'A', null, 'imagens/2025/D2/q127_alt_A.webp'),
('2025-D2-Q127', 'B', null, 'imagens/2025/D2/q127_alt_B.webp'),
('2025-D2-Q127', 'C', null, 'imagens/2025/D2/q127_alt_C.webp'),
('2025-D2-Q127', 'D', null, 'imagens/2025/D2/q127_alt_D.webp'),
('2025-D2-Q127', 'E', null, 'imagens/2025/D2/q127_alt_E.webp'),
('2025-D2-Q131', 'A', '2,7 kg.', null),
('2025-D2-Q131', 'B', '3,0 kg.', null),
('2025-D2-Q131', 'C', '4,1 kg.', null),
('2025-D2-Q131', 'D', '4,5 kg.', null),
('2025-D2-Q131', 'E', '5,0 kg.', null),
('2025-D2-Q133', 'A', 'no surfactante.', null),
('2025-D2-Q133', 'B', 'na camada superior de polímero.', null),
('2025-D2-Q133', 'C', 'nas nanopartículas de sílica.', null),
('2025-D2-Q133', 'D', 'na camada inferior de polímero.', null),
('2025-D2-Q133', 'E', 'na malha de aço.', null),
('2025-D2-Q134', 'A', 'Estradiol.', null),
('2025-D2-Q134', 'B', 'Estriol.', null),
('2025-D2-Q134', 'C', 'Estrona.', null),
('2025-D2-Q134', 'D', 'Novestrol.', null),
('2025-D2-Q134', 'E', 'Noretindrona.', null);
delete from public.questao_figuras where questao_id in ('2024-D2-Q092', '2024-D2-Q093', '2024-D2-Q094', '2024-D2-Q097', '2024-D2-Q114', '2024-D2-Q116', '2024-D2-Q118', '2024-D2-Q123', '2024-D2-Q125', '2024-D2-Q128', '2024-D2-Q133', '2024-D2-Q135', '2025-D2-Q091', '2025-D2-Q100', '2025-D2-Q105', '2025-D2-Q106', '2025-D2-Q109', '2025-D2-Q110', '2025-D2-Q115', '2025-D2-Q117', '2025-D2-Q121', '2025-D2-Q124', '2025-D2-Q125', '2025-D2-Q127', '2025-D2-Q131', '2025-D2-Q133', '2025-D2-Q134');
insert into public.questao_figuras (questao_id, ordem, imagem, descricao) values
('2024-D2-Q092', 1, 'imagens/2024/D2/q092_fig1.webp', 'Esquema de uma célula a combustível microbiana com duas câmaras separadas por uma membrana. À esquerda, câmara verde com o "Ânodo" (eletrodo azul); entra "Matéria orgânica (CH₃COO⁻)" e sai "CO₂". À direita, câmara azul-clara com o "Cátodo" (eletrodo laranja); entra "O₂" e sai "H₂O". Íons "H⁺" atravessam a "Membrana" do ânodo para o cátodo (seta). Um fio externo liga os eletrodos, com setas indicando elétrons (e⁻) saindo do ânodo e chegando ao cátodo, e uma seta no fio apontando da esquerda para a direita.'),
('2024-D2-Q094', 1, 'imagens/2024/D2/q094_fig1.webp', 'Fórmula estrutural da nimesulida com os grupamentos circulados por linhas tracejadas e rotulados: "metila" (H₃C ligado ao enxofre); "sulfonamida" (S com dois O em dupla ligação, ligado a N–H); o N da sulfonamida está ligado a um anel benzênico; nesse anel, em posição vizinha, há um O identificado como "éter", que o liga a um segundo anel benzênico identificado como "fenila"; na posição oposta ao N, o anel tem o grupo "nitro" (N⁺ com um O em dupla ligação e um O⁻).'),
('2024-D2-Q114', 1, 'imagens/2024/D2/q114_fig1.webp', 'Gráfico de linhas. Eixo horizontal: “Razão ar/combustível (massa/massa)”, de 10 a 20, com linha tracejada vertical em cerca de 14,7 indicando a “Razão estequiométrica ar/combustível”; à esquerda dela, “Deficiência”, à direita, “Excesso”. Eixo vertical esquerdo: “O₂, CO, CO₂ (% volume)”, de 0 a 14 (curvas CO₂, CO e O₂). Eixo vertical direito: “NO (10³ vppm), HC como C₆ (10² vppm)”, de 0 a 7 (curvas NO e HC). Curvas: CO₂ sobe de cerca de 7,5 (razão 10) até o máximo de cerca de 14 (razão 15) e cai para cerca de 11 (razão 19,5); CO cai de cerca de 12 (razão 10,5) para quase 0 a partir de 15; O₂ é quase 0 até 13 e sobe até cerca de 5,7 em 19,5; HC cai de cerca de 7,2 (razão 10,5) para um mínimo de cerca de 1,25 perto da razão 18 e volta a subir para cerca de 1,7 em 19,5; NO sobe de quase 0 até o máximo de cerca de 3,6 perto da razão 16 e cai para cerca de 0,7 em 19,5 (em 18, cerca de 2).'),
('2024-D2-Q123', 1, 'imagens/2024/D2/q123_fig1.webp', 'Fórmulas estruturais de dois compostos. Composto 1: anel benzênico com um grupo C(=O)OH e, no carbono vizinho, um grupo OH. Composto 2: anel de cinco carbonos (ciclopentano) com um C=O no anel; no carbono vizinho à carbonila, uma cadeia lateral com ligação dupla C=C (configuração cis) terminando em etila; no carbono seguinte do anel, um grupo CH₂ ligado a COOH. Rótulos: "Composto 1" e "Composto 2".'),
('2024-D2-Q125', 1, 'imagens/2024/D2/q125_fig1.webp', 'Placa quadrada de saída de emergência: fundo verde com uma porta em amarelo-claro (fosforescente) e, sobre ela, a silhueta verde de uma pessoa correndo em direção à abertura da porta.'),
('2024-D2-Q128', 1, 'imagens/2024/D2/q128_fig1.webp', 'Ilustração de uma nuvem com gotas de chuva caindo sobre uma placa solar em camadas, revestida por uma malha de grafeno com uma gota de água sobre ela. Um destaque ampliado (elipse) mostra a "Camada fina de água", com íons Bⁿ⁻ na parte de cima e íons Aᵐ⁺ junto à interface, sobre a "Camada fina de grafeno", que contém elétrons e⁻ próximos à interface. Uma seta para cima indica "Alto potencial elétrico" (lado da água) e uma seta para baixo indica "Baixo potencial elétrico" (lado do grafeno).'),
('2025-D2-Q091', 1, 'imagens/2025/D2/q091_fig1.webp', 'Esquema com dois círculos cinza. À esquerda, "Carvão comum": círculo liso com poucos poros pequenos, um deles indicado como "Mesoporo". À direita, "Carvão ativado": círculo com contorno irregular, reentrâncias e fendas, contendo poros de vários tamanhos indicados como "Macroporo", "Mesoporo" e "Microporo", e pontos pretos aderidos às paredes e fendas indicados como "Impureza adsorvida".'),
('2025-D2-Q105', 1, 'imagens/2025/D2/q105_fig1.webp', 'Esquema de usina termonuclear com legenda: amarelo = "Circuito primário", azul = "Circuito secundário", verde = "Sistema de água de refrigeração". Dentro do "Vaso de contenção": "Reator" com "Elemento combustível", "Pressurizador", "Bomba" e gerador de "Vapor" (circuito primário em amarelo, com setas vermelhas, aquecendo a água do circuito secundário). O vapor segue para a "Turbina", ligada ao "Gerador elétrico" e à "Torre de transmissão". Após a turbina, o "Condensador" é resfriado pelo sistema de água de refrigeração (verde), que circula com "Bombas" entre o condensador, a "Torre de resfriamento" e o "Ecossistema aquático" (de onde vem a "Água fria"). A "Água" condensada volta por uma "Bomba" a partir do "Tanque de água de alimentação".'),
('2025-D2-Q106', 1, 'imagens/2025/D2/q106_fig1.webp', 'Fotografia antiga em preto e branco de uma sala de aula de química (1909), com alunos sentados de costas, um professor e um aluno junto à lousa. Um detalhe ampliado da lousa mostra as equações (com os índices escritos como sobrescritos): "AzO + O = AzO²"; "SO² + H²O = H²SO³"; "2 H²SO³ + O² = 2 H²SO⁴"; "2 HCl + MgO²H² = MgCl² + 2 H²O".'),
('2025-D2-Q109', 1, 'imagens/2025/D2/q109_fig1.webp', 'Esquema de reação: "Ácido anacárdico" (anel benzênico com grupo OH, grupo carboxila COOH em posição vizinha e cadeia C₁₅H₃₁ na outra posição vizinha à carboxila) → sob aquecimento (Δ, 180 °C a 200 °C) → "Cardanol" (anel benzênico com OH e cadeia C₁₅H₃₁, sem a carboxila) + CO₂.'),
('2025-D2-Q115', 1, 'imagens/2025/D2/q115_fig1.webp', 'Fórmula estrutural em perspectiva do "Borneol": estrutura bicíclica em ponte (biciclo[2.2.1]heptano) com dois grupos CH₃ (H₃C e CH₃) no carbono da ponte superior, um grupo H₃C em uma das cabeças de ponte e um grupo OH ligado a um carbono do anel adjacente a essa cabeça de ponte.'),
('2025-D2-Q133', 1, 'imagens/2025/D2/q133_fig1.webp', 'Esquema em camadas, de baixo para cima: "Malha de aço" (grade cinza); "Camada inferior de polímero" (cadeia polimérica azul, entre parênteses com índice n, com anéis contendo N⁺ ligado a dois grupos metila); "Nanopartículas de sílica" (fileira de círculos laranja com SiO₂ e cargas negativas); "Camada superior de polímero" (mesma cadeia azul com N⁺, índice n); "Surfactante" (cadeias laranja de carbonos ligados a átomos de flúor, CF₃ e CF₂, terminadas em grupo com carga negativa ⊖ voltado para o polímero). Chaves à direita identificam cada camada.'),
('2025-D2-Q134', 1, 'imagens/2025/D2/q134_fig1.webp', 'Fórmulas estruturais de cinco hormônios esteroides (quatro anéis fundidos, com CH₃ na junção dos anéis): Estradiol — anel aromático com HO e um OH no anel de cinco membros (2 grupos OH); Estriol — anel aromático com HO e dois OH no anel de cinco membros (3 grupos OH); Estrona — anel aromático com HO e uma carbonila (C=O) no anel de cinco membros; Novestrol — anel aromático com HO, e no anel de cinco membros um OH e um grupo etinil (C≡CH); Noretindrona — anel não aromático com carbonila (O=) e dupla ligação, e no anel de cinco membros um OH e um grupo C≡CH.');
commit;
