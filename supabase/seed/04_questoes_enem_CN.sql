-- Questões de enem-CN (87)
begin;
insert into public.questoes (id, exame_id, recorte_id, banca, orgao, cargo, nivel, ano, numero, formato, disciplina, assunto, topico, lingua, texto_base_id, texto_apoio, comando, gabarito, dica1, dica2, explicacao, dificuldade) values
('2024-D2-Q091', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 91, '5_alternativas', 'Física', 'Energia e trabalho', 'Energia cinética em colisões', null, null, 'Muitas pessoas ainda se espantam com o fato de um passageiro sair ileso de um acidente de carro enquanto o veículo onde estava teve perda total. Essas pessoas talvez considerem, equivocadamente, que os carros mais seguros são os que têm as estruturas mais rígidas, ou seja, estruturas, que durante uma colisão, apresentam menor deformação. Na verdade, o que ocorre é o contrário. Por isso, a partir de 1958, passaram a ser produzidos carros com partes que se deformam facilmente.

Fonte: DAY, C. **Crumple Zones**. Disponível em: https://pubs.aip.org. Acesso em: 2 jul. 2024 (adaptado).

Assim, além dos cintos de segurança e dos airbags, os carros modernos passaram a contar com o dispositivo de segurança conhecido como *crumple zone* (região deformável, em inglês), conforme a figura.

{{figura:1}}

Fonte: **Momentum and Car safety**. GCSE Physics Revision. Disponível em: www.shalom-education.com. Acesso em: 5 jul. 2024 (adaptado).', 'Considerando o carro, seus ocupantes e o muro da figura como um sistema isolado, o *crumple zone* aumenta a segurança dos passageiros porque, durante uma colisão, a deformação da estrutura do carro', 'B', 'Pense no que acontece com a energia de movimento do carro quando a frente dele amassa no choque.', 'Num sistema isolado, a quantidade de movimento total se conserva e o centro de massa não muda de velocidade. Então sobra uma grandeza que pode ser transformada pela deformação.', 'Resposta: B. Ao amassar, a estrutura do carro transforma a energia cinética do sistema em trabalho de deformação (e calor), e faz isso ao longo de um tempo maior, o que reduz a força sobre os ocupantes. A alternativa C é a pegadinha: num sistema isolado a quantidade de movimento se conserva, ela não é "consumida". Pelo mesmo motivo, a velocidade do centro de massa não muda (E).', 'média'),
('2024-D2-Q092', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 92, '5_alternativas', 'Química', 'Eletroquímica', 'Célula a combustível microbiana', null, null, 'Células a combustível microbianas (CCM) são capazes de gerar eletricidade a partir de águas residuárias urbanas e agroindustriais. As CCM são compostas de duas câmaras. Numa delas, onde ocorre o tratamento da matéria orgânica, as bactérias eletrogênicas crescem formando um biofilme e se alimentam dos poluentes presentes no efluente. Ao se alimentarem, essas bactérias geram uma corrente elétrica que percorre o material sobre o qual elas formaram o biofilme. Um fio condutor externo possibilita a migração dessa corrente para uma segunda câmara, promovendo uma reação química. A figura esquematiza uma CCM e as reações envolvidas.

{{figura:1}}

CH₃COO⁻ (aq) + 2 H₂O (l) → 2 CO₂ (g) + 7 H⁺ (aq) + 8 e⁻

4 H⁺ (aq) + O₂ (g) + 4 e⁻ → 2 H₂O (l)

Fonte: QUINTO, A. C. **Biobaterias geram eletricidade a partir de esgoto sanitário e efluentes agroindustriais**. Disponível em: https://jornal.usp.br. Acesso em: 1 dez. 2021 (adaptado).', 'Qual das equações representa a reação global que ocorre durante o funcionamento dessa CCM?', 'C', 'A reação global é a soma das duas semirreações, mas antes os elétrons precisam se cancelar.', 'O ânodo libera 8 elétrons e o cátodo consome 4. Multiplique a semirreação do cátodo por 2 e depois some, cancelando o que aparece dos dois lados.', 'Resposta: C. Multiplicando o cátodo por 2: $8\,H^+ + 2\,O_2 + 8\,e^- \to 4\,H_2O$. Somando com o ânodo: $CH_3COO^- + 2\,H_2O + 8\,H^+ + 2\,O_2 \to 2\,CO_2 + 7\,H^+ + 4\,H_2O$. Cancelando 2 $H_2O$ e 7 $H^+$ dos dois lados, sobra $CH_3COO^- + H^+ + 2\,O_2 \to 2\,CO_2 + 2\,H_2O$. A alternativa A esquece de igualar os elétrons, por isso fica com 1 $O_2$ e o balanço não fecha.', 'média'),
('2024-D2-Q093', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 93, '5_alternativas', 'Química', 'Química orgânica', 'Conceito de composto orgânico', null, null, 'No senso comum, considera-se, ainda hoje, que compostos orgânicos são substâncias presentes nos seres vivos. Na Química, a expressão “compostos orgânicos” tem um uso histórico de mais de 200 anos, adquirindo diferentes conotações ao longo do desenvolvimento dessa ciência. Atualmente, atribui-se a essa expressão outro significado.', 'A concepção científica atual define esses compostos como substâncias', 'E', 'A pergunta é sobre a definição química atual, não sobre o sentido de "orgânico" no supermercado.', 'Esqueça saúde, agrotóxicos ou origem em seres vivos: a Química define esses compostos pelo elemento que forma sua estrutura.', 'Resposta: E. Hoje, a Química chama de compostos orgânicos as substâncias que têm o carbono como elemento principal, formando cadeias carbônicas, sejam elas naturais ou sintéticas. As alternativas A, B e D usam o sentido popular de "orgânico" (saudável, natural, sem agrotóxico), e a C confunde a definição com a fotossíntese.', 'fácil'),
('2024-D2-Q094', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 94, '5_alternativas', 'Química', 'Química orgânica', 'Acidez de grupos funcionais', null, null, 'A nimesulida é um fármaco pouco solúvel em água, utilizado como anti-inflamatório, analgésico e antitérmico. Essa substância pode ser convertida em uma espécie eletricamente carregada, de maior solubilidade em água, mediante o tratamento com uma base de Brönsted-Lowry, isto é, uma espécie química capaz de capturar um próton (H⁺). Na figura são apresentados os grupamentos presentes na estrutura química da nimesulida.

{{figura:1}}

**Nimesulida**

Fonte: GONÇALVES, A. A. et al. Contextualizando reações ácido-base de acordo com a teoria protônica de Brönsted-Lowry usando comprimidos de propranolol e nimesulida. **Química Nova**, n. 3, 2013 (adaptado).', 'Na estrutura desse fármaco, o grupamento capaz de reagir com a base de Brönsted-Lowry é o grupo', 'A', 'Uma base de Brönsted-Lowry captura H⁺. Procure qual grupo da molécula tem um hidrogênio que pode ser doado.', 'Metila e anéis têm H ligado a carbono, que quase não sai. O H ligado a nitrogênio vizinho a um grupo $SO_2$ é bem mais ácido.', 'Resposta: A. Na sulfonamida, o H está ligado a um N que fica entre o grupo $SO_2$ e um anel aromático, que puxam elétrons e estabilizam a carga negativa depois que o H⁺ sai. Por isso esse é o próton capturado pela base, gerando o ânion mais solúvel em água. Metila e fenila só têm H ligado a carbono, e os grupos nitro e éter não têm hidrogênio para doar.', 'difícil'),
('2024-D2-Q095', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 95, '5_alternativas', 'Biologia', 'Biotecnologia', 'RT-PCR e expressão gênica', null, null, 'O desenvolvimento da biotecnologia e da clonagem gênica em procariotos fez com que a produção de proteínas se tornasse mais intensa, rápida e econômica. Para a produção de hormônios, enzimas e proteínas de resistência a drogas, uma variação da técnica de reação em cadeia pela polimerase (PCR, na sigla em inglês) utiliza a enzima transcriptase reversa (RT-PCR), que sintetiza moléculas de DNA complementares a partir de fitas de RNA.', 'Nesse contexto, essa técnica é importante para detectar genes', 'A', 'A transcriptase reversa parte de RNA. Pense em quais genes geram RNA dentro da célula.', 'Um gene só vira RNA mensageiro quando está sendo transcrito, ou seja, quando está "ligado". A técnica copia esse RNA em DNA.', 'Resposta: A. A RT-PCR usa a transcriptase reversa para fazer DNA complementar a partir do RNA mensageiro presente na célula. Como só há mRNA de genes que estão sendo transcritos, a técnica detecta genes expressos. Ser plasmidial, bacteriano, dominante ou autossômico não tem relação com a presença de RNA, que é o que a técnica usa.', 'média'),
('2024-D2-Q096', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 96, '5_alternativas', 'Física', 'Dinâmica e leis de Newton', 'Centro de massa', null, null, 'Nos automóveis, é importante garantir que o centro de massa (**CM**) de cada conjunto roda/pneu coincida com o seu centro geométrico. Esse processo é realizado em uma máquina de balanceamento, na qual o conjunto roda e pneu é colocado para girar a uma velocidade de valor constante. Com base nas oscilações medidas, a máquina indica a posição do centro de massa do conjunto, e pequenas peças de chumbo são fixadas em lugares específicos da roda até que as vibrações diminuam. Durante o treinamento de sua equipe, a fim de corrigir a posição do centro de massa indicada pela máquina, um mecânico apresenta o esquema a seguir, com cinco possíveis pontos da roda para posicionar uma peça de chumbo.

{{figura:1}}', 'Em qual ponto deve ser fixada a peça de chumbo para corrigir a posição do centro de massa desse conjunto roda/pneu?', 'C', 'Para trazer o centro de massa de volta ao centro da roda, onde você colocaria um peso extra?', 'O CM está deslocado para cima e para a direita. O peso deve ir no lado oposto, na direção da reta que liga o CM ao centro da roda.', 'Resposta: C. O centro de massa está acima e à direita do centro geométrico, então há massa sobrando nesse lado. Para compensar, a peça de chumbo deve ficar do lado diametralmente oposto, abaixo e à esquerda, que é o ponto 3. O ponto 5 está no mesmo lado do CM e pioraria o desequilíbrio; os pontos 2 e 4 corrigiriam só uma das direções.', 'fácil'),
('2024-D2-Q097', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 97, '5_alternativas', 'Química', 'Soluções', 'Concentração de soluções', null, null, 'O soro caseiro serve para combater a desidratação por meio da reposição da água e sais minerais perdidos, por exemplo, por diarreia. Uma receita simples para a sua preparação consiste em utilizar duas colheres grandes (de sopa) de açúcar e duas colheres pequenas (de café) de sal de cozinha, dissolvidos em 2 L de água fervida, obtendo-se uma solução com concentração de íon sódio de 1,4 mg/mL.

Considere as massas molares: NaCl = 58,5 g/mol; Na = 23 g/mol.', 'Qual é o valor mais próximo da massa, em grama, de cloreto de sódio presente em uma única colher pequena?', 'D', 'Comece pela concentração de sódio dada: com o volume total, dá para achar quanto sódio há na receita inteira.', 'Calcule a massa de Na em 2 L e converta para NaCl usando a proporção $58{,}5/23$. Lembre que a receita usa duas colheres pequenas.', 'Resposta: D. Massa de Na: $1{,}4\ \text{mg/mL} \times 2000\ \text{mL} = 2800\ \text{mg} = 2{,}8\ \text{g}$. Massa de NaCl: $2{,}8 \times \frac{58{,}5}{23} \approx 7{,}1\ \text{g}$. Como isso corresponde a duas colheres, cada uma tem $\approx 3{,}6\ \text{g}$. Quem para no 2,8 g (C) esqueceu de converter Na em NaCl, e quem marca 7,0 g (E) esqueceu de dividir por 2.', 'média'),
('2024-D2-Q098', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 98, '5_alternativas', 'Biologia', 'Zoologia', 'Reprodução e anexos embrionários', null, null, 'Apesar de os animais representados no cladograma compartilharem um mesmo ancestral, eles se caracterizam por distintos padrões de reprodução ou de nutrição dos embriões e descendentes.

{{figura:1}}

Fonte: DIXSON, A. F. **Mammalian Sexuality**: The Act of Mating and the Evolution of Reproduction. Disponível em: www.cambridge.org. Acesso em: 2 jul. 2024 (adaptado).', 'Ao longo do processo evolutivo, percebem-se, entre esses animais, perdas e ganhos nos padrões citados que envolvem o(a)', 'E', 'Compare como cada grupo alimenta o embrião: ornitorrinco põe ovos, canguru tem bolsa e elefante tem placenta.', 'Todos os mamíferos têm fecundação interna e reprodução sexuada. Pense no que acontece com a reserva nutritiva do ovo quando o filhote passa a ser nutrido pela mãe.', 'Resposta: E. Os monotremados põem ovos com bastante vitelo, que nutre o embrião. Em marsupiais e placentários, o embrião se desenvolve no corpo da mãe e a nutrição passa a depender dela (placenta e, principalmente nos marsupiais, a lactação), então a vesícula vitelínica fica reduzida. A alternativa B é tentadora, mas a fecundação já é interna em todos os mamíferos.', 'difícil'),
('2024-D2-Q099', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 99, '5_alternativas', 'Física', 'Ondulatória e som', 'Efeito Doppler', null, null, 'Uma ambulância em alta velocidade com a sirene ligada desloca-se em direção a um radar operado por uma pessoa. O radar emite ondas de rádio com frequência $f_0$ que são refletidas pela dianteira da ambulância, retornando para o detector com frequência $f_r$. A percepção do operador do radar, em relação ao som emitido pela sirene, é de que este se altera à medida que a ambulância se aproxima ou se afasta.', 'Durante a aproximação, como o operador percebe o som da sirene e qual é a relação entre as frequências $f_r$ e $f_0$ medidas pelo radar?', 'D', 'Isso é efeito Doppler: o que acontece com a frequência percebida quando a fonte se aproxima?', 'Na aproximação, a frequência percebida aumenta. Vale para o som da sirene e também para as ondas de rádio refletidas pela ambulância que vem em direção ao radar.', 'Resposta: D. Quando a fonte se aproxima, as frentes de onda chegam mais \"juntas\" ao observador, então a frequência percebida é maior: o som fica mais agudo. O mesmo ocorre com o radar: a ambulância funciona como um refletor em movimento na direção dele, e a onda volta com frequência maior, $f_r > f_0$. Som mais grave e $f_r < f_0$ corresponderiam ao afastamento.', 'fácil'),
('2024-D2-Q100', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 100, '5_alternativas', 'Física', 'Óptica', 'Espelhos esféricos', null, null, '**Mirascópio 3D: produtor de ilusão instantânea**

O equipamento ilustrado na figura, de dimensões apresentadas no esquema, é composto por dois espelhos côncavos **E₁** e **E₂**, apoiados um sobre o outro por suas bordas, de tal forma que o vértice de **E₁** coincide com o foco de **E₂** e vice-versa. Na abertura circular de **E₂**, é formada uma imagem tridimensional de um objeto posicionado sobre o vértice de **E₁**. Essa imagem é formada a partir dos raios procedentes do objeto, refletidos por **E₂** e **E₁**, respectivamente, conforme o esquema. Os observadores julgam visualizar o objeto quando estão, de fato, visualizando sua imagem. O efeito só é possível porque as superfícies de ambos os espelhos são de extrema qualidade.

{{figura:1}}

Fonte: SALZMANN, W. Disponível em: https://wissenstexte.de. Acesso em: 27 jun. 2024 (adaptado).', 'A natureza da imagem formada e a distância vertical entre cada ponto objeto e seu correspondente ponto imagem são', 'C', 'Os raios realmente se cruzam acima da abertura? Isso define se a imagem é real ou virtual. Depois olhe as cotas do esquema.', 'A imagem é formada pelo cruzamento dos próprios raios refletidos. Para a distância, compare a altura do vértice de E₁ com a da abertura de E₂.', 'Resposta: C. No esquema, os raios refletidos por E₂ e depois por E₁ se cruzam de fato na abertura de E₂, então a imagem é real (por isso parece um objeto \"de verdade\"). O objeto está no vértice de E₁ e a imagem na abertura de E₂, separados por $3{,}8 + 3{,}8 = 7{,}6\ \text{cm}$. O valor 3,8 cm é só metade da altura, e 5 cm é a largura da abertura, não uma distância vertical.', 'média'),
('2024-D2-Q101', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 101, '5_alternativas', 'Física', 'Ondulatória e som', 'Nível sonoro em decibéis', null, null, '**A saúde do professor: acústica arquitetônica**

Dentre os parâmetros acústicos que afetam a inteligibilidade dos sons emitidos em ambientes fechados, destacam-se o ruído de fundo do ambiente e o decréscimo do nível sonoro com a distância da fonte emissora. Assim, sentar-se no fundo da sala de aula pode prejudicar a aprendizagem dos estudantes, por impedir que eles distingam, com precisão, os sons emitidos, diminuindo a inteligibilidade da fala de seus professores. Considere a situação exemplificada pelo infográfico: à distância de 1 metro, o nível sonoro da fala de um professor é de 60 dB e diminui com a distância. Considere, ainda, que o ruído de fundo nessa sala de aula pode chegar a 45 dB e que, para ser compreendida, o nível sonoro da fala do professor deve estar 5 dB acima desse ruído.

{{figura:1}}

Fonte: Disponível em: www.ufrrj.br. Acesso em: 2 dez. 2021 (adaptado).', 'Para um valor máximo do ruído de fundo, a maior distância que um estudante pode estar do professor para que ainda consiga compreender sua fala é mais próxima de', 'A', 'Primeiro descubra qual nível sonoro a fala precisa ter; depois procure esse valor no gráfico.', 'Ruído máximo de 45 dB mais 5 dB dá o mínimo para entender. Leia no eixo horizontal a distância em que a curva chega a esse nível.', 'Resposta: A. Com ruído de 45 dB, a fala precisa de pelo menos $45 + 5 = 50$ dB. No gráfico, a curva passa por cerca de 50 dB perto de 3 m, então essa é a maior distância. A distância de 5 m é a pegadinha: ali a fala está em cerca de 45 dB, igual ao ruído, e não 5 dB acima dele.', 'fácil'),
('2024-D2-Q102', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 102, '5_alternativas', 'Biologia', 'Citologia', 'Desnaturação enzimática', null, null, 'Uma agricultora, com a intenção de comercializar o milho recém-colhido, testou uma forma de preservar o sabor adocicado do seu produto. O melhor resultado foi obtido quando ela imergiu as espigas em água fervente durante alguns minutos e, em seguida, em água gelada. Com esse procedimento, parte da glicose do milho não foi transformada em amido, mantendo o seu sabor adocicado.', 'Utilizando esse procedimento, o sabor foi conservado porque houve', 'A', 'A transformação de glicose em amido depende de proteínas que aceleram reações. O que a água fervente faz com elas?', 'Calor intenso muda a forma das enzimas e elas param de funcionar. A água gelada só interrompe o cozimento.', 'Resposta: A. A conversão de glicose em amido é catalisada por enzimas. A água fervente desnatura essas enzimas, que perdem a forma e deixam de funcionar, e assim a glicose continua no grão, mantendo o sabor doce. O frio (B) apenas desacelera reações e esfria o milho, mas o efeito que conserva o açúcar vem da alta temperatura.', 'fácil'),
('2024-D2-Q103', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 103, '5_alternativas', 'Física', 'Termologia', 'Convecção térmica', null, null, 'Aquecedores solares são equipamentos utilizados para o aquecimento de água pelo calor do Sol. São compostos por coletores solares, nos quais ocorre o aquecimento da água, e por um reservatório térmico, em que é armazenada a água quente para ser utilizada posteriormente. A figura ilustra esquematicamente como funciona esse equipamento.

{{figura:1}}

Fonte: **5 dicas de instalação de aquecedor solar**. Disponível em: https://instaline.com.br. Acesso em: 3 nov. 2023 (adaptado).', 'O processo pelo qual ocorre transferência de calor dos coletores solares para o reservatório térmico é a', 'E', 'Repare que a água quente sobe do coletor até o reservatório e a fria desce. Que processo envolve movimento do próprio fluido?', 'Condução ocorre em sólidos, sem deslocamento de matéria, e irradiação é por ondas. Aqui o calor é levado pela circulação da água.', 'Resposta: E. A água aquecida no coletor fica menos densa e sobe para o reservatório, enquanto a água fria, mais densa, desce até o coletor. Essa circulação do fluido, que transporta o calor, é a convecção. A irradiação (D) é como o calor do Sol chega ao coletor, mas não é como ele vai do coletor ao reservatório.', 'fácil'),
('2024-D2-Q104', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 104, '5_alternativas', 'Biologia', 'Microbiologia e doenças', 'Arboviroses e urbanização', null, null, 'As autoridades sanitárias brasileiras têm se preocupado muito nos últimos anos com o aumento da ocorrência de doenças transmitidas por mosquitos, principalmente arboviroses como chikungunya e zika, que se tornaram epidêmicas ou endêmicas em áreas urbanas. Parte de uma análise da relação entre a urbanização e a incidência dessas doenças está representada no fluxograma.

{{figura:1}}

Fonte: ALMEIDA, L. S.; COTA, A. L. S.; RODRIGUES, D. F. Saneamento, arboviroses e determinantes ambientais: impactos na saúde urbana. **Ciência & Saúde Coletiva**, v. 25, n. 10, 2020 (adaptado).', 'Nesse contexto, como a urbanização está causando riscos à saúde humana?', 'D', 'Siga o fluxograma até o fim e pense: quem, na água, controla as larvas de mosquitos?', 'A questão fala de arboviroses transmitidas por mosquitos, cujas larvas vivem na água. Menos biodiversidade aquática significa menos animais que comem essas larvas.', 'Resposta: D. Pelo fluxograma, a urbanização sem saneamento contamina a água e reduz a biodiversidade aquática. Com menos predadores aquáticos (peixes, insetos), as larvas de mosquitos sobrevivem mais, a população de mosquitos cresce e aumentam doenças como zika e chikungunya. A alternativa C fala de coliformes, que se ligam à contaminação da água, mas não explicam o elo com a biodiversidade nem com as arboviroses.', 'média'),
('2024-D2-Q105', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 105, '5_alternativas', 'Biologia', 'Ecologia', 'Bioacumulação de poluentes', null, null, '**Impactos do microplástico**

A ação de fatores abióticos aliada à biodeterioração contribuem para a formação de microplásticos, os quais se aderem a outros poluentes orgânicos apolares persistentes, como os derivados de pesticidas lipossolúveis. Há uma proporcionalidade direta entre a solubilidade desses tipos de poluentes e sua concentração nos tecidos dos organismos expostos a eles.

Fonte: Disponível em: www.ecycle.com.br. Acesso em: 9 dez. 2021 (adaptado).', 'Em animais vertebrados, essa associação de poluentes será preferencialmente acumulada no tecido', 'D', 'O texto diz que os poluentes são apolares e lipossolúveis. Onde o corpo guarda substâncias desse tipo?', 'Semelhante dissolve semelhante: substâncias apolares se acumulam em tecidos ricos em gordura.', 'Resposta: D. Os poluentes associados aos microplásticos são apolares e lipossolúveis, e o texto diz que sua concentração acompanha a solubilidade. Por isso eles se acumulam preferencialmente no tecido adiposo, rico em lipídios. O tecido nervoso também tem lipídios, mas o principal reservatório de gordura do corpo é o adiposo.', 'fácil'),
('2024-D2-Q106', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 106, '5_alternativas', 'Física', 'Física moderna', 'Raios X e absorção', null, null, 'Em aeroportos, por razões de segurança, os passageiros devem ter suas bagagens de mão examinadas antes do embarque, passando-as em esteiras para sua inspeção por aparelhos de raios X. Nessas inspeções, os passageiros são orientados a retirar seus computadores portáteis (notebooks ou laptops) de malas, mochilas ou bolsas para passá-los isoladamente pela esteira.', 'Que explicação física justifica esse procedimento?', 'D', 'O raio X forma imagem porque alguns materiais deixam ele passar e outros não. O que um notebook cheio de peças faz com os raios?', 'Materiais densos, como metais e baterias, absorvem muito raio X. Pense no que isso causa na imagem dos objetos que estão na mesma linha do computador.', 'Resposta: D. A imagem de raios X é formada pela diferença de absorção: materiais densos bloqueiam a radiação. Um notebook tem muitos componentes densos e cria uma "sombra" grande que esconde o que estiver à frente ou atrás dele dentro da mala. As outras alternativas inventam efeitos (desmagnetizar, aquecer, ionizar) ou dizem que não há interação, o que é o contrário do que acontece.', 'média'),
('2024-D2-Q107', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 107, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Digestão no estômago', null, null, 'Com base em testes realizados em ratos, concluiu-se que os compostos nitrosos são substâncias mutagênicas, ou seja, produzem mutações nas células e possivelmente câncer. Esses compostos podem ser obtidos pela reação entre o nitrito de sódio, que é um conservante adicionado às carnes, e o ácido clorídrico. O ácido nitroso produzido irá reagir com compostos nitrogenados, como as aminas, dando origem aos compostos nitrosos.', 'Em qual órgão esse processo será iniciado?', 'E', 'A reação precisa de ácido clorídrico. Em que órgão do sistema digestório esse ácido é produzido?', 'O nitrito vem na carne que comemos e o HCl faz parte do suco gástrico. Os dois se encontram logo no primeiro órgão que recebe o alimento já engolido.', 'Resposta: E. O ácido clorídrico é produzido pelas células da parede do estômago e faz parte do suco gástrico. Quando a carne com nitrito de sódio chega ao estômago, forma-se o ácido nitroso, que reage com aminas e gera os compostos nitrosos. O intestino (C) tem meio básico, sem HCl, e rim, fígado e pâncreas não recebem o alimento com ácido clorídrico.', 'fácil'),
('2024-D2-Q108', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 108, '5_alternativas', 'Biologia', 'Ecologia', 'Sucessão ecológica', null, null, '**Sistemas agroflorestais (SAFs)**

Os sistemas agroflorestais alinham os interesses econômicos aos ecológicos. Esses sistemas podem ser usados na recuperação ambiental de áreas degradadas que se tornaram pouco produtivas, como as utilizadas por muito tempo para pastagem. Para isso, num primeiro momento, as árvores nativas são plantadas em conjunto com culturas agrícolas anuais, como feijão, mandioca, milho e abóbora, que geram renda para os proprietários da terra e incentivam a manutenção do sistema. Em um segundo momento, são introduzidas outras espécies, como trepadeiras e arbustos, de acordo com um arranjo espacial e temporal preestabelecido. Nesse processo, ocorrerão mudanças graduais na estrutura e composição das comunidades vegetais ao longo do tempo, que culminarão no aumento da diversidade do ambiente.

Fonte: Disponível em: www.embrapa.br. Acesso em: 9 dez. 2021 (adaptado).', 'O conjunto dessas mudanças graduais é análogo ao processo natural denominado', 'B', 'O texto descreve uma comunidade que muda gradualmente até ficar mais diversa. Qual processo ecológico é assim?', 'Rotação de culturas é uma técnica agrícola, não um processo natural. Pense na substituição gradual de espécies que acontece quando um ambiente se recupera.', 'Resposta: B. A sucessão ecológica é a mudança gradual na composição e estrutura de uma comunidade ao longo do tempo, com espécies pioneiras sendo substituídas por outras até aumentar a diversidade. É exatamente o que o SAF imita, com etapas planejadas. A rotação de culturas (A) é uma prática humana de alternar plantios, e não um processo natural.', 'fácil'),
('2024-D2-Q109', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 109, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Fibras musculares e metabolismo', null, null, 'As fibras musculares esqueléticas não são todas iguais. As fibras lentas, também conhecidas como fibras vermelhas, apresentam muitas mitocôndrias e são bem supridas por vasos sanguíneos. Já as fibras rápidas, ou fibras brancas, apresentam poucas mitocôndrias e recebem menor suprimento sanguíneo. Dessa forma, a distribuição das fibras nos músculos esqueléticos do corpo auxilia de forma diferenciada no desempenho físico de um atleta.

Fonte: SADAVA, D. et al. **Vida: a ciência da biologia** — volume III: plantas e animais. Porto Alegre: Artmed, 2009 (adaptado).', 'Um atleta que sonha em disputar os Jogos Olímpicos e tem uma maior proporção de fibras brancas que fibras vermelhas teria mais vantagens na realização da prova de:', 'B', 'Fibras brancas têm poucas mitocôndrias e pouco sangue. Elas são boas para esforços longos ou curtos e explosivos?', 'Sem muitas mitocôndrias, a fibra depende da respiração anaeróbia: gera força rápida, mas cansa logo. Procure a prova mais curta e explosiva.', 'Resposta: B. As fibras brancas (rápidas) usam principalmente metabolismo anaeróbio, produzindo contrações fortes e rápidas, mas com pouca resistência. O salto em altura é um esforço curto e explosivo, ideal para elas. Triatlo, marcha, maratona aquática e ciclismo em estrada são provas longas de resistência, que dependem das fibras vermelhas.', 'fácil'),
('2024-D2-Q110', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 110, '5_alternativas', 'Biologia', 'Genética e evolução', 'Mimetismo', null, null, 'O Cerrado e a Amazônia abrigam grande número de serpentes popularmente conhecidas como cobras-corais. Na Amazônia predominam as corais-verdadeiras, que são peçonhentas, enquanto no Cerrado prevalecem as falsas-corais, que não possuem peçonha. Essas espécies apresentam um padrão de coloração muito semelhante. Essa similaridade traz uma vantagem tanto para as corais falsas como para as verdadeiras.

Fonte: FRANÇA, F. G. R. [...] **serpentes corais em ambientes campestres, savânicos e florestais da América do Sul**. Brasília: UnB, 2008 (adaptado).

Nas fotografias, são apresentados exemplos dessas serpentes: uma coral-verdadeira e uma falsa-coral.

{{figura:1}}

Fonte: SILVA, L. C.; COTTA, G. A.; RESENDE, F. C. Cobra-coral: aplicativo educativo para reconhecimento das cobras-corais do estado de Minas Gerais, Brasil. **Herpetologia Brasileira**, n. 1, 2021 (adaptado).', 'Qual é a vantagem dessa similaridade para as falsas-corais?', 'D', 'A falsa-coral não tem peçonha. Por que parecer uma cobra perigosa ajuda?', 'Predadores aprendem a evitar as corais-verdadeiras pela cor. Pense em como isso beneficia uma imitadora inofensiva.', 'Resposta: D. Isso é mimetismo: a falsa-coral imita o padrão de cores da coral-verdadeira, que é peçonhenta. Predadores que aprenderam a evitar esse padrão também evitam a falsa-coral, então ela sofre menos predação. A semelhança não ajuda a caçar, nem a encontrar parceiros, e espécies diferentes não geram híbridos por terem cores parecidas.', 'fácil'),
('2024-D2-Q111', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 111, '5_alternativas', 'Biologia', 'Zoologia', 'Exoesqueleto e muda', null, null, 'O exoesqueleto dos crustáceos é formado por quitina e impregnações de sais calcários e, por isso, é mais duro quando comparado com o exoesqueleto de outros artrópodes. Esse revestimento externo confere proteção, mas, por ser duro, limita o crescimento desses animais.', 'Para superar essa limitação, o exoesqueleto deve ser', 'D', 'O exoesqueleto é duro e não cresce junto com o animal. O que os artrópodes fazem quando ficam "apertados"?', 'Eles trocam a carapaça antiga por uma nova, maior. Esse processo tem nome: muda ou ecdise.', 'Resposta: D. Como o exoesqueleto rígido não acompanha o crescimento, os crustáceos passam por mudas (ecdise) periódicas: soltam a carapaça velha, crescem enquanto a nova ainda está mole e depois ela endurece. O exoesqueleto não é remodelado continuamente (C) nem fragmentado (B), e ele existe desde as fases jovens, não só no adulto.', 'fácil'),
('2024-D2-Q112', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 112, '5_alternativas', 'Biologia', 'Genética e evolução', 'Herança ligada ao X', null, null, 'Um dos exemplos mais conhecidos de herança recessiva ligada ao cromossomo X é o daltonismo. Como em qualquer distúrbio recessivo ligado ao cromossomo X, existem muito mais homens apresentando o fenótipo com esse tipo de daltonismo do que mulheres. Um casal formado por um homem não daltônico e por uma mulher gestante também não daltônica, mas portadora do gene recessivo para esse tipo de daltonismo, está esperando um bebê. Em uma das consultas de pré-natal, o casal recebeu um heredograma que contém todas as possibilidades de genótipo para esse bebê.

Considere a legenda:

- Círculo branco com um ponto vermelho no centro: Mulher heterozigota portadora do gene para daltonismo
- Círculo branco: Mulher não daltônica
- Círculo vermelho (preenchido): Mulher daltônica
- Quadrado branco: Homem não daltônico
- Quadrado azul (preenchido): Homem daltônico

Fonte: GRIFFITHS, A. et al. **Introdução à genética**. Rio de Janeiro: Guanabara Koogan, 2016 (adaptado).', 'Qual heredograma foi recebido pelo casal?', 'B', 'Monte o cruzamento: pai $X^DY$ e mãe portadora $X^DX^d$. Quais filhos são possíveis?', 'As filhas recebem o X normal do pai, então nenhuma pode ser daltônica. Já os filhos recebem o X da mãe, que pode ser o normal ou o afetado.', 'Resposta: B. Do cruzamento $X^DX^d \times X^DY$ saem quatro possibilidades: $X^DX^D$ (filha não daltônica), $X^DX^d$ (filha portadora), $X^DY$ (filho não daltônico) e $X^dY$ (filho daltônico). O heredograma B mostra exatamente isso. A e E têm filhas daltônicas, impossível porque o pai passa o X normal; D coloca os dois meninos daltônicos e C nenhum, mas cada menino tem 50% de chance de cada caso.', 'média'),
('2024-D2-Q113', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 113, '5_alternativas', 'Biologia', 'Ecologia', 'Ciclo do nitrogênio', null, null, '**Metabolismo de procariontes**

O esquema representa a ação de organismos no ciclo do nitrogênio e no ciclo do carbono. Os números correspondem a algumas etapas dos dois ciclos distintos.

{{figura:1}}

Fonte: Disponível em: https://pt.khanacademy.org. Acesso em: 27 jun. 2024 (adaptado).', 'Em qual etapa numerada ocorre uma transformação redox como a que ocorre nos procariontes nitrificantes?', 'E', 'Nitrificantes transformam $NH_3$ em nitrito e nitrato. Nessa reação o elemento ganha ou perde elétrons?', 'O N vai de −3 na amônia para +3 ou +5: é uma oxidação. Procure outra etapa em que um elemento também perde elétrons, lembrando que fixar $CO_2$ é reduzir o carbono.', 'Resposta: E. Os nitrificantes oxidam o nitrogênio ($NH_3 \to NO_2^-, NO_3^-$). Na etapa 5, os decompositores oxidam o carbono da matéria orgânica até $CO_2$, outra oxidação. Nas etapas 1 e 2 o nitrogênio é reduzido ($N_2 \to NH_3$ e $NO_3^- \to N_2$), e nas etapas 3 e 4 o $CO_2$ é fixado, ou seja, o carbono é reduzido.', 'difícil'),
('2024-D2-Q114', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 114, '5_alternativas', 'Química', 'Química ambiental', 'Emissões de motores a combustão', null, null, 'Um dos agentes que mais contribui para a poluição do ar é o automóvel a combustão interna. Em áreas urbanas, isso é demonstrado dramaticamente pela fumaça fotoquímica, resultante da interação entre óxidos de nitrogênio, hidrocarbonetos e luz solar, para formar produtos de oxidação, que causam irritação aos olhos, ao aparelho respiratório e danos às plantas. As condições de operação de motores a combustão, como a razão da mistura ar/combustível no cilindro, influenciam na composição dos gases lançados pelo escapamento na atmosfera. O gráfico ilustra a variação nas composições dos principais gases, dióxido de carbono (CO₂), hidrocarbonetos (HC), monóxido de carbono (CO), monóxido de nitrogênio (NO) e oxigênio molecular (O₂), emitidos por um motor a gasolina, em diferentes razões ar/combustível, em massa.

{{figura:1}}

Fonte: RANGEL, M. C.; CARVALHO, M. F. A. Impacto dos catalisadores automotivos no controle da qualidade do ar. **Química Nova**, v. 26, 2003 (adaptado).', 'Na condição de razão ar/combustível igual a 18, haverá uma emissão', 'C', 'Encontre a razão 18 no eixo horizontal e leia cada curva com atenção ao eixo certo (esquerdo ou direito).', 'Em 18 há excesso de ar, então a queima é quase completa. Pense no que acontece com o gás da combustão incompleta e com o da completa.', 'Resposta: C. Na razão 18 a mistura tem excesso de ar: o CO está praticamente em zero e o $CO_2$ continua alto, perto de 12% (a combustão é quase completa). A alternativa A erra porque o $O_2$ já está subindo nessa região (cerca de 4%), e não é baixo. O HC está no seu mínimo em 18, o que elimina B e E, e o CO baixo elimina D.', 'média'),
('2024-D2-Q115', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 115, '5_alternativas', 'Biologia', 'Citologia', 'Citoesqueleto', null, null, 'O esquema representa um experimento feito com células do protozoário *Amoeba proteus*. Nele, um grupo de células foi tratado com a droga citocalasina B, enquanto outro grupo não foi tratado, servindo como controle. O formato e o movimento das células tratadas foram comprometidos.

{{figura:1}}

Fonte: SADAVA, D. et al. **Vida: a ciência da biologia** — volume I: célula e hereditariedade. Porto Alegre: Artmed, 2009 (adaptado).', 'Qual componente celular foi afetado pela droga utilizada no experimento?', 'C', 'A ameba tratada perdeu a forma irregular e os pseudópodes. Que estrutura dá forma e movimento à célula?', 'Pseudópodes dependem do citoesqueleto, especificamente dos filamentos de actina, que se montam e desmontam para a célula se mover.', 'Resposta: C. Os microfilamentos (actina) fazem parte do citoesqueleto e são responsáveis pela forma da célula e pela formação de pseudópodes. A citocalasina B impede a montagem desses filamentos, por isso a ameba fica redonda e para de se mover. A membrana plasmática (E) continua lá: ela é deformada pelos microfilamentos, mas não é ela que gera o movimento.', 'média'),
('2024-D2-Q116', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 116, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Filtração', null, null, 'O magnésio metálico utilizado em ligas leves é produzido em um processo que envolve várias etapas e utiliza água do mar como matéria-prima. A primeira etapa desse processo consiste na reação entre o íon Mg²⁺ e hidróxido de cálcio, Ca(OH)₂, obtendo uma mistura que contém hidróxido de magnésio, pouco solúvel, e íons Ca²⁺, de acordo com a equação química:

Mg²⁺ (aq) + Ca(OH)₂ (aq) → Mg(OH)₂ (s) + Ca²⁺ (aq)', 'O método adequado para separar o Mg(OH)₂ dessa mistura é a', 'A', 'O $Mg(OH)_2$ formado é pouco solúvel, ou seja, vira um sólido no meio de um líquido.', 'Para separar um sólido de um líquido numa mistura heterogênea, use um método que retém o sólido e deixa passar a solução.', 'Resposta: A. Como o $Mg(OH)_2$ precipita e os íons $Ca^{2+}$ ficam dissolvidos, a mistura é heterogênea (sólido + solução). A filtração retém o sólido no filtro e deixa a solução passar. Destilação e evaporação servem para separar componentes de uma solução, e a catação é usada para pedaços sólidos grandes, que dá para pegar com a mão.', 'fácil'),
('2024-D2-Q117', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 117, '5_alternativas', 'Biologia', 'Zoologia', 'Comportamento reprodutivo de anfíbios', null, null, 'Moradores do Brooklin, bairro de São Paulo, perdem o sono com um som alto, constante e estridente. O barulho é causado por anfíbios anuros trazidos do Caribe, da espécie *Eleutherodactylus jahnstonei*, que têm tamanho um pouco maior que o de um grão de feijão e que encontraram na capital um ambiente favorável. Cientistas foram até o local e encontraram esses animais nos jardins das casas.

Fonte: **Pererecas-assobiadoras tiram o sono de moradores do Brooklin**. Disponível em: http://g1.globo.com. Acesso em: 26 mar. 2015 (adaptado).', 'Ao emitirem o som estridente, esses anfíbios', 'E', 'Em muitos anfíbios anuros, o canto dos machos tem uma função bem conhecida.', 'Pense em por que os sapos e pererecas cantam mais na época de reprodução.', 'Resposta: E. Os machos de anuros emitem cantos (vocalização) para atrair fêmeas e se reproduzir; por isso o som é alto e constante. O canto é um comportamento da espécie, não um sinal de que está fora do hábitat (A), de poluição (B) ou de superpopulação (C), e também não serve para atrair insetos.', 'fácil'),
('2024-D2-Q118', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 118, '5_alternativas', 'Química', 'Cinética e equilíbrio', 'Deslocamento de equilíbrio', null, null, 'A hidroxiapatita, Ca₅(PO₄)₃OH, é um mineral constituinte do esmalte dos dentes. Entre as diversas reações que ocorrem no meio bucal, encontram-se em equilíbrio as reações de desmineralização e mineralização da hidroxiapatita em meio aquoso, ilustradas a seguir. A desmineralização está associada à fragilização do esmalte do dente e à formação de cáries.

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
('2024-D2-Q119', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 119, '5_alternativas', 'Física', 'Cinemática', 'Composição de velocidades', null, null, 'Para os circuitos de maratonas aquáticas realizadas em mares calmos e próximos à praia, é montado um sistema de boias que determinam o trajeto a ser seguido pelos nadadores. Uma das dificuldades desse tipo de circuito é compensar os efeitos da corrente marinha. O diagrama contém o circuito em que deve ser realizada uma volta no sentido anti-horário. As quatro boias estão numeradas de 1 a 4. Existe uma corrente marinha de velocidade $\vec{\upsilon}_c$, cujo módulo é 30 metros por minuto, paralela à praia em toda a área do circuito. Nas arestas mais longas, o nadador precisará nadar na direção apontada pelos vetores $\vec{\upsilon}_n$ dos pontos 1 até 2 e de 3 até 4. Considere que a velocidade do nadador é de 50 metros por minuto, em relação à água, durante todo o circuito.

{{figura:1}}', 'Nessa situação, em quantos minutos o nadador completará a prova?', 'B', 'Divida o circuito nos quatro lados e calcule a velocidade real do nadador (em relação ao fundo) em cada um.', 'Nos lados de 800 m, o nadador inclina o corpo para anular a corrente: a velocidade resultante vem de Pitágoras com 50 e 30. Nos lados de 400 m, some ou subtraia 30 de 50.', 'Resposta: B. De 1 a 2 e de 3 a 4: $v=\sqrt{50^2-30^2}=40$ m/min, então cada trecho leva $800/40=20$ min. De 2 a 3 (contra a corrente): $50-30=20$ m/min, $400/20=20$ min. De 4 a 1 (a favor): $50+30=80$ m/min, $400/80=5$ min. Total: $20+20+20+5=65$ min. Quem usa 50 m/min em tudo, sem considerar a corrente, chega a 48 min, que nem aparece nas opções.', 'difícil'),
('2024-D2-Q120', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 120, '5_alternativas', 'Biologia', 'Microbiologia e doenças', 'Retrovírus e linfócitos T', null, null, 'O vírus linfotrópico de células T humanas tipo 1 (HTLV-1) é um retrovírus do mesmo grupo do vírus da imunodeficiência humana (HIV). Ambos são transmitidos da mesma forma e infectam as mesmas células de defesa do organismo, os linfócitos T. A diferença entre eles é que o HTLV-1 estimula o aumento da produção desses linfócitos, enquanto o HIV causa destruição dessas células.

Fonte: ROMANELLI, L. C. F.; CARAMELLI, P.; PROIETTI, A. B. F. C. O vírus linfotrópico de células T humanas tipo 1 (HTLV-1): quando suspeitar da infecção? **Revista da Associação Médica Brasileira**, v. 56, 2010 (adaptado).', 'Uma possível consequência da infecção por HTLV-1 é o desenvolvimento de', 'B', 'Compare o que o HTLV-1 faz com os linfócitos T com o que o HIV faz com eles.', 'O HIV destrói os linfócitos; o HTLV-1 faz o contrário, estimulando a multiplicação dessas células. Que doença surge quando células se multiplicam sem controle?', 'O texto diz que o HTLV-1 estimula o aumento da produção de linfócitos T. Proliferação celular descontrolada é a marca do câncer, por isso a resposta é a letra B (câncer); de fato, o HTLV-1 está ligado a leucemias e linfomas de células T. A aids (A) é a distratora tentadora, mas ela resulta da destruição dos linfócitos T pelo HIV, que é justamente o efeito oposto ao do HTLV-1.', 'média'),
('2024-D2-Q121', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 121, '5_alternativas', 'Física', 'Dinâmica e leis de Newton', 'Força resultante e normal', null, null, 'Na tirinha, Calvin se divertia em um balanço antes de soltar-se dele e cair ao chão. Em sua fala, ele demonstra ter imaginado que permaneceria em movimento circular. Porém, a força gravitacional, que permanece atuando no garoto, modifica a direção de sua velocidade, fazendo com que ele chegue ao chão da maneira ilustrada no último quadrinho.

{{figura:1}}

Fonte: WATTERSON, B. Disponível em: https://tiras-do-calvin.tumblr.com. Acesso em: 19 nov. 2021 (adaptado).', 'Qual vetor representa a força resultante exercida pelo chão sobre Calvin no exato momento em que ele toca o chão?', 'A', 'A força do chão sobre Calvin tem duas partes: a normal e o atrito. Pense na direção de cada uma.', 'A normal aponta para cima. O atrito se opõe ao deslizamento horizontal: veja nos quadrinhos para que lado Calvin se move (os traços de movimento ficam atrás dele).', 'Ao tocar o chão, Calvin recebe a força normal, vertical para cima, e o atrito, horizontal e contrário ao seu movimento. Pelos traços de movimento, ele vem da direita para a esquerda, então o atrito aponta para a direita. Somando os dois vetores, a resultante fica inclinada para cima e para a direita: letra A. A letra D (só vertical) esquece o atrito, e a letra C erra o sentido do atrito.', 'difícil'),
('2024-D2-Q122', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 122, '5_alternativas', 'Física', 'Termologia', 'Mudança de fase da água', null, null, 'A tirinha ilustra esquimós dentro de um iglu, habitação de formato hemisférico construída durante o inverno a partir de neve ou blocos de gelo. Essa estrutura de construção se justifica pelo fato de esse povo habitar as regiões mais setentrionais da Groenlândia, Canadá e Alasca.

{{figura:1}}

Fonte: LAERTE. Disponível em: https://artedafisicapibid.blogspot.com. Acesso em: 4 dez. 2021 (adaptado).', 'Na tirinha, a geladeira é necessária para fazer gelo porque', 'A', 'Para a água virar gelo, a temperatura precisa ficar abaixo de quanto?', 'Mesmo feito de gelo, o iglu é um abrigo aquecido pelo corpo das pessoas e isolado do frio externo. Compare a temperatura lá dentro com 0 °C.', 'A água só solidifica abaixo de 0 °C (à pressão normal). O iglu funciona como isolante e é aquecido pelos moradores, então a temperatura interna fica acima do ponto de solidificação da água; por isso é preciso uma geladeira para fazer gelo: letra A. A letra C mistura as coisas: o isolamento existe, mas o que importa é que o ar interno não está frio o bastante para congelar a água.', 'fácil'),
('2024-D2-Q123', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 123, '5_alternativas', 'Química', 'Química orgânica', 'Funções orgânicas', null, null, 'Os pesticidas naturais vêm sendo utilizados no controle de pragas e doenças agrícolas como substituintes de pesticidas sintéticos tradicionais, por serem menos nocivos ao ambiente, biodegradáveis e minimizarem custos e riscos relativos à lavoura. Por exemplo, os compostos 1 e 2 estão envolvidos nas respostas de defesa das plantas. Os grupos funcionais presentes nesses compostos são importantes para suas propriedades no controle de pragas.

{{figura:1}}

Fonte: PINTO-ZEVALLOS, D. M.; ZARBIN, P. H. G. A química na agricultura: perspectivas para o desenvolvimento de tecnologias sustentáveis. **Química Nova**, n. 10, 2013 (adaptado).', 'Qual é a função orgânica correspondente ao grupo funcional comum presente nesses dois compostos?', 'A', 'Identifique todos os grupos funcionais de cada composto e procure o que aparece nos dois.', 'O composto 1 tem um OH ligado ao anel aromático e outro grupo com C=O e OH juntos. O composto 2 tem um C=O no anel e o mesmo grupo C=O com OH na ponta da cadeia.', 'O composto 1 tem um fenol (OH no anel benzênico) e um grupo $-COOH$. O composto 2 tem uma cetona (C=O dentro do anel), uma ligação dupla C=C (alceno) e também um grupo $-COOH$. O único grupo comum aos dois é a carboxila, que caracteriza a função ácido carboxílico: letra A. Cetona, alceno e fenol aparecem em apenas um dos compostos, e não há álcool em nenhum deles.', 'média'),
('2024-D2-Q124', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 124, '5_alternativas', 'Biologia', 'Microbiologia e doenças', 'Metabolismo energético bacteriano', null, null, 'Utilizando-se um mesmo meio nutritivo, três gêneros bacterianos diferentes foram submetidos ao cultivo em tubos de ensaio. Após certo período de crescimento da cultura bacteriana em condições físico-químicas ideais, observou-se que o padrão de distribuição das células (representadas por pontos na figura) ao longo dos tubos era diferente em cada um dos casos.

{{figura:1}}', 'Em relação ao metabolismo energético, os microrganismos presentes nos tubos 1, 2 e 3 são classificados, respectivamente, como', 'C', 'Onde há mais oxigênio no tubo: perto da superfície ou no fundo?', 'Quem depende de O₂ cresce só em cima; quem é intoxicado por O₂ cresce só no fundo; quem vive com ou sem O₂ se espalha pelo tubo todo.', 'O oxigênio entra pela superfície do meio. No tubo 1, as bactérias ficam só em cima, onde há O₂: são aeróbias estritas. No tubo 2, ficam só no fundo, longe do O₂: anaeróbias estritas. No tubo 3, crescem em todo o tubo, com mais células em cima (respirar com O₂ rende mais energia): anaeróbias facultativas. Ordem: letra C.', 'fácil'),
('2024-D2-Q125', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 125, '5_alternativas', 'Química', 'Química geral e atomística', 'Transições eletrônicas e fosforescência', null, null, 'As placas que indicam saída de emergência brilham no escuro, pois apresentam substâncias que fosforecem na cor amarelo-esverdeada após exposição à luz ambiente, conforme a figura.

{{figura:1}}

Esse fenômeno ocorre pela presença do sulfeto de zinco (ZnS), dopado com prata ou cobre, na superfície da placa.

Fonte: **Zinc Sulphide Phosphorescence**. Disponível em: https://physicsopenlab.org. Acesso em: 8 nov. 2023 (adaptado).', 'O aparecimento do brilho nessas condições ocorre como consequência de', 'C', 'A placa absorve luz e depois devolve luz. Pense no que acontece com os elétrons dos átomos nesse processo.', 'Ao absorver energia, elétrons sobem para níveis mais energéticos; ao voltar, liberam essa energia como luz visível.', 'Na fosforescência, a luz ambiente excita elétrons do ZnS dopado para níveis de energia mais altos. Eles voltam aos níveis de origem aos poucos, emitindo fótons de luz amarelo-esverdeada, e por isso a placa continua brilhando no escuro. O fenômeno é explicado por transições eletrônicas: letra C. Não é reflexão (E), pois a placa emite luz mesmo sem luz incidindo, nem reação nuclear (D), já que o núcleo não muda.', 'fácil'),
('2024-D2-Q126', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 126, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Vacinas e imunização', null, null, 'Indústrias farmacêuticas e instituições científicas têm trabalhado no desenvolvimento de diferentes vacinas contra a covid-19. Em algumas dessas vacinas, a principal estrutura antigênica é uma proteína de superfície viral chamada espícula (*spike*, em inglês). Essa proteína só existe em coronavírus, incluindo o SARS-CoV-2. Ela se liga a receptores de membrana específicos das células humanas por um mecanismo do tipo “chave-fechadura”. Dessa forma, os vírus entram nas células, podendo se multiplicar e acarretar a doença.

Fonte: **O que são vacinas?** Disponível em: www.cienciaviva.pt. Acesso em: 30 nov. 2021 (adaptado).', 'Nessas vacinas, essa proteína viral induz a', 'A', 'Lembre o que o sistema imune faz quando encontra um antígeno pela primeira vez.', 'Vacina é imunização ativa: o próprio corpo responde ao antígeno. Descarte as opções que descrevem imunidade passiva ou efeitos diretos sobre o vírus.', 'Na vacina, a proteína spike funciona como antígeno: o sistema imune a reconhece e produz anticorpos específicos contra ela, além de células de memória. Assim, se o coronavírus aparecer depois, a defesa é rápida: letra A. A imunidade passiva (B) ocorre quando se recebem anticorpos prontos, como em soros. A proteína também não neutraliza vírus sozinha (D) nem altera genes ou receptores (C e E).', 'fácil'),
('2024-D2-Q127', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 127, '5_alternativas', 'Física', 'Eletromagnetismo', 'Blindagem eletrostática', null, null, 'Em um experimento de laboratório, duas barras metálicas, **A** e **B**, são carregadas com cargas opostas e imersas em óleo. Farelo de milho é jogado sobre o óleo e, após um certo tempo, o farelo assume o formato das linhas de campo elétrico entre as barras. A figura representa a vista superior desse experimento.

{{figura:1}}

Fonte: ALMEIDA, M. A. T. **Introdução às ciências físicas 2** — volume 4: módulo 4. Rio de Janeiro: Fundação CECIERJ, 2007 (adaptado).', 'Ao repetir o experimento colocando um cilindro metálico oco entre as placas, o esquema que representa o formato das linhas de campo assumido pelo farelo é:', 'E', 'Pense no que acontece com o campo elétrico dentro de um condutor metálico em equilíbrio eletrostático.', 'Um condutor oco funciona como blindagem: o campo dentro dele é nulo, e as linhas chegam e saem perpendiculares à superfície. O sentido continua de A (+) para B (−).', 'O cilindro metálico oco faz blindagem eletrostática (gaiola de Faraday): as cargas se rearranjam na superfície e o campo no interior fica nulo. Por isso nenhuma linha atravessa o cilindro; elas terminam e recomeçam na sua superfície, chegando perpendicularmente a ela, e seguem de A para B. Esse é o esquema da letra E. As letras A e D mostram campo dentro do cilindro, e B e C invertem o sentido das linhas.', 'média'),
('2024-D2-Q128', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 128, '5_alternativas', 'Química', 'Eletroquímica', 'Geração de diferença de potencial', null, null, 'Placas solares comuns dependem de dias ensolarados para gerar energia. Mas podemos gerar eletricidade com a ajuda de gotas de chuva, revestindo placas solares com uma fina camada de grafeno. Os íons dissociados a partir da água da chuva (Aᵐ⁺ e Bⁿ⁻) tornam a combinação grafeno e água da chuva um par perfeito para geração de energia. O processo requer apenas uma camada de grafeno para que grande quantidade de elétrons (e⁻) se movimente ao longo da superfície.

{{figura:1}}

Fonte: TANG, Q. et al. A Solar Cell that is Triggered by Sun and Rain. **Angewandte Chemie International Edition**, n. 55, 2016 (adaptado).', 'Ao produzir eletricidade em dias chuvosos, o grafeno', 'E', 'Observe a figura: onde ficam os cátions da água e os elétrons do grafeno, e que diferença de potencial aparece entre eles?', 'Não há reação química nem catálise: as cargas se organizam em camadas opostas na interface água-grafeno, como em um capacitor.', 'Os cátions $A^{m+}$ da chuva se acumulam junto à superfície do grafeno, que atrai elétrons para essa interface. Forma-se uma dupla camada de cargas opostas, com alto potencial no lado da água e baixo no lado do grafeno: surge uma diferença de potencial capaz de gerar corrente. É a letra E. A letra A está errada porque oxidar um cátion exigiria retirar elétrons dele, e os elétrons apenas se acumulam ao lado dos cátions.', 'média'),
('2024-D2-Q130', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 130, '5_alternativas', 'Física', 'Termologia', 'Ciclo termodinâmico de motores', null, null, 'O diagrama P-V a seguir representa o ciclo de Otto para um motor de combustão interna, como os motores a gasolina ou a etanol, utilizados nos automóveis.

{{figura:1}}

As etapas representadas no diagrama estão descritas no quadro.

| Etapa | Processo | Descrição |
|:---:|:---:|:---:|
| I | 0 a 1 | Admissão isobárica da mistura ar-combustível no cilindro do motor. |
| II | 1 a 2 | Compressão adiabática da mistura. |
| III | 2 a 3 | Introdução de energia na forma de calor da combustão. |
| IV | 3 a 4 | Expansão adiabática. |
| V | 4 a 1 | Liberação de energia na forma de calor. |
| VI | 1 a 0 | Liberação dos gases resultantes da combustão. |

Fonte: Disponível em: www.mspc.eng.br. Acesso em: 24 fev. 2013 (adaptado).', 'A transformação da energia térmica em energia útil ocorre na etapa', 'C', 'Energia útil em um motor é trabalho mecânico: em qual etapa o gás empurra o pistão?', 'Na compressão o pistão faz trabalho sobre o gás; na expansão é o gás quente, depois da combustão, que realiza trabalho sobre o pistão.', 'O trabalho útil aparece quando o gás quente, logo após a combustão, se expande e empurra o pistão. Isso ocorre na expansão adiabática de 3 a 4, a etapa IV: letra C. A etapa III (B) é só a entrada de calor, a volume constante, sem trabalho. Na etapa II o gás recebe trabalho (é comprimido), e V e VI são liberações de calor e de gases.', 'média'),
('2024-D2-Q131', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 131, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Circuito com LEDs', null, null, 'O LED é um dispositivo eletrônico que conduz corrente elétrica em um único sentido, sendo caracterizado por uma tensão e uma corrente máxima de funcionamento, $I_{\text{máx}}$. Um LED acende apenas se a corrente que o percorre está no sentido permitido e se a diferença de potencial à qual está submetido é igual ou superior à sua tensão de funcionamento. A figura ilustra o símbolo do LED usado na representação de circuitos.

{{figura:1}}

Um estudante de física analisa as propriedades do LED em um circuito simples de corrente contínua. Ele dispõe dos seguintes materiais: uma bateria ideal de 4,5 V; dois LEDs de tensão 3,0 V e $I_{\text{máx}} = 1{,}0$ mA cada; e dois resistores de 1,5 kΩ cada.', 'O circuito que o estudante pode montar, para que ambos os LEDs fiquem acesos e cada um seja percorrido por $I_{\text{máx}}$, é', 'B', 'Calcule quanto da tensão da bateria sobra para o resistor quando o LED está aceso e veja que corrente isso gera.', '$4{,}5 - 3{,}0 = 1{,}5$ V sobre um resistor de 1,5 kΩ dá exatamente 1,0 mA. Cada LED precisa do seu próprio resistor e precisa estar no sentido permitido.', 'Em cada ramo, o LED usa 3,0 V e o resistor fica com $4{,}5 - 3{,}0 = 1{,}5$ V, então $I = \frac{1{,}5}{1500} = 1{,}0$ mA, que é a $I_{\text{máx}}$. Assim, o certo é dois ramos em paralelo, cada um com resistor e LED no sentido da corrente (do + para o −): letra B. Na letra A, um único resistor divide 1,0 mA entre os dois LEDs (0,5 mA cada). Em C e E os LEDs estão invertidos, e em D os LEDs em série precisariam de 6,0 V.', 'difícil'),
('2024-D2-Q132', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 132, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Divisor de tensão e lâmpadas', null, null, 'Uma caixa decorativa utiliza duas pequenas lâmpadas, **L₁** (6 V – 9 W) e **L₂** (12 V – 18 W), ligadas em série a uma bateria de tensão $V_{QR}$. Um fio resistivo **QR**, de 48 centímetros, está ligado em paralelo à bateria. Cinco pontos, *A*, *B*, *C*, *D* e *E*, dividem o fio **QR** em seis segmentos de comprimentos iguais. O circuito também tem um amperímetro com dois terminais. Um dos terminais (**P**) está ligado ao fio entre as duas lâmpadas. O outro terminal (***S***) está livre e será ligado ao fio **QR**. Dependendo do ponto em que esse terminal livre for conectado, ocorrerá a mudança na tensão à qual as lâmpadas são submetidas. Os demais fios do circuito têm resistências elétricas desprezíveis. A figura ilustra esse circuito.

{{figura:1}}', 'Em qual desses pontos o amperímetro deve ser conectado para que as lâmpadas acendam exatamente segundo as especificações de tensão e potência elétricas fornecidas?', 'B', 'Calcule a corrente e a resistência de cada lâmpada com $P = V \cdot i$ e veja que fração da tensão total fica em $L_1$.', 'As duas lâmpadas pedem 1,5 A. Em série, $L_1$ fica com 6 V de um total de 18 V, ou seja, 1/3. Ache no fio QR o ponto com o mesmo potencial de P.', 'Para $L_1$: $i = 9/6 = 1{,}5$ A; para $L_2$: $i = 18/12 = 1{,}5$ A. Em série com 1,5 A, $L_1$ fica com 6 V e $L_2$ com 12 V, totalizando 18 V, e $L_1$ recebe $\frac{6}{18} = \frac{1}{3}$ da tensão. No fio uniforme, o ponto com o mesmo potencial de P está a 1/3 do comprimento a partir de Q: $\frac{48}{3} = 16$ cm. Cada segmento tem $48/6 = 8$ cm, então 16 cm é o ponto B: letra B. Ali o amperímetro não desvia corrente e as lâmpadas funcionam como especificado.', 'difícil'),
('2024-D2-Q133', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 133, '5_alternativas', 'Química', 'Estequiometria', 'Cálculo estequiométrico de combustíveis', null, null, 'O biogás é uma alternativa energética muito importante, pois, além de reduzir a dependência por combustíveis fósseis, sua obtenção pode ser realizada a partir de resíduos da produção agroindustrial. Considere que o biogás produzido em um empreendimento de suinocultura contém 70% em volume de metano (massa molar 16 g/mol; volume molar 22 L/mol). Ele será utilizado para geração de energia em substituição ao etanol (massa molar 46 g/mol) em um gerador no qual 1 m³ de biogás de origem suína substitui 0,59 L de etanol anidro (densidade 0,78 g/mL).', 'Nessas condições, a massa de metano necessária para substituir 10 mol de etanol na produção de energia é mais próxima de', 'C', 'Transforme os 10 mol de etanol em volume (litros) usando a massa molar e a densidade.', '10 mol de etanol dão cerca de 0,59 L, o que equivale a 1 m³ de biogás. Agora pegue 70% desse volume como metano e converta em massa.', 'Massa de etanol: $10 \times 46 = 460$ g; volume: $\frac{460}{0{,}78} \approx 590$ mL $= 0{,}59$ L, que equivale a 1 m³ (1000 L) de biogás. Metano: $0{,}70 \times 1000 = 700$ L, ou seja, $\frac{700}{22} \approx 31{,}8$ mol. Massa: $31{,}8 \times 16 \approx 509$ g, mais próxima de 510 g: letra C. A letra E (720 g) aparece se você esquecer de aplicar os 70%.', 'difícil'),
('2024-D2-Q134', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 134, '5_alternativas', 'Biologia', 'Ecologia', 'Fitorremediação de metais pesados', null, null, 'A fitorremediação é uma técnica que utiliza plantas para a remediação de ambientes contaminados. A descontaminação de solos pode ocorrer por descarte, absorção e metabolização, imobilização, extração ou volatilização do poluente, conforme representado na figura.

{{figura:1}}

Fonte: LUIZ, E. P. **Avaliação dos métodos de fitorremediação [...] na remoção de chumbo, cobre e zinco**. São Paulo: UFABC, 2016 (adaptado).', 'O método que retira o mercúrio de uma área contaminada, impedindo sua entrada na cadeia alimentar, é a', 'E', 'O comando pede um método que retire o mercúrio do local. Use as definições do quadro.', 'Descarte o que só imobiliza o metal no solo ou o joga no ar, e lembre que metal não é degradado por enzimas nem por microrganismos.', 'Na fitoextração, as plantas absorvem o metal pelas raízes e o acumulam na parte aérea; depois a biomassa é colhida e removida, tirando o mercúrio da área: letra E. A fitoestabilização (A) apenas prende o metal no solo, e a fitovolatilização (B) o lança no ar, de onde pode voltar ao ambiente. Fitodegradação e fitoestimulação (C e D) agem sobre poluentes orgânicos, e o mercúrio é um elemento que não se degrada.', 'média'),
('2024-D2-Q135', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2024, 135, '5_alternativas', 'Química', 'Estequiometria', 'Reciclagem do alumínio', null, null, '**Brasil fecha 2020 entre os maiores recicladores de latas de alumínio**

A bauxita contém alumina (Al₂O₃), que é a matéria-prima para produção do alumínio (Al). De forma geral, são necessários 50 kg de bauxita para produzir 10 kg de alumínio. O Brasil fechou 2020 como um dos principais líderes mundiais em reciclagem de latas de alumínio. De acordo com levantamento da Associação Brasileira dos Fabricantes de Latas de Alumínio (Abralatas), o país obteve um índice de reciclagem de 97,4%, de um total de 4,0 × 10⁵ toneladas de latas vendidas. Considere que a lata é constituída de alumínio puro.

Fonte: Disponível em: https://agenciabrasil.ebc.com.br. Acesso em: 30 nov. 2021 (adaptado).', 'Levando em conta apenas a reciclagem de latas, qual é o valor mais próximo da massa de bauxita, em tonelada, que deixou de ser extraída da natureza em 2020 no Brasil?', 'D', 'Primeiro descubra quanto alumínio foi reciclado; depois use a proporção entre bauxita e alumínio.', 'Recicladas: 97,4% de $4{,}0 \times 10^5$ t. Como 50 kg de bauxita geram 10 kg de alumínio, cada tonelada de alumínio exige 5 t de bauxita.', 'Alumínio reciclado: $0{,}974 \times 4{,}0 \times 10^5 \approx 3{,}9 \times 10^5$ t. A proporção é $\frac{50}{10} = 5$ t de bauxita por tonelada de alumínio, então a bauxita poupada é $5 \times 3{,}9 \times 10^5 \approx 1{,}9 \times 10^6$ t: letra D. A letra B ($3{,}9 \times 10^5$) é a massa de alumínio reciclado, e não a de bauxita.', 'média'),
('2025-D2-Q091', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 91, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Adsorção por carvão ativado', null, null, 'A filtração em carvão é uma das mais antigas formas de purificação de água. O carvão ativado, diferentemente do carvão comum, é útil para ser empregado na remoção de material orgânico, cloro e outros contaminantes. Essa capacidade decorre de suas propriedades de adsorção. A origem do material utilizado para produzir o carvão ativado pode influenciar sua porosidade e, consequentemente, interferir na capacidade do material de remover impurezas. Na figura, é ilustrada esquematicamente a diferença entre as estruturas físicas do carvão comum e do carvão ativado.

{{figura:1}}

Fonte: CORRÊA, M. A. **Cosmetologia: ciência e técnica**. São Paulo: Medfarma, 2012 (adaptado).', 'Qual característica do carvão ativado explica a sua maior eficiência nesse processo?', 'D', 'Compare as duas figuras: o que o carvão ativado tem a mais que o comum?', 'A adsorção é um fenômeno de superfície: as impurezas grudam nas paredes do material. Mais poros e fendas significam mais área disponível.', 'Na adsorção, as impurezas ficam presas na superfície do sólido. O carvão ativado tem muitos macro, meso e microporos e fendas, o que dá a ele uma área de superfície enorme, com muito mais pontos para reter contaminantes. Por isso é mais eficiente: letra D. Massa, dureza, densidade e condutividade não determinam quanto material consegue aderir.', 'fácil'),
('2025-D2-Q092', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 92, '5_alternativas', 'Biologia', 'Biotecnologia', 'Transgênicos e transferência gênica', null, null, 'A maioria dos seres vivos tem um relógio biológico (ciclo circadiano), que regula as mudanças metabólicas e comportamentais de acordo com o ciclo de 24 horas de rotação da Terra. Em 2015, um artigo publicado na revista *Science Advantage* mostrou ser possível a transferência dos genes do relógio circadiano da cianobactéria *Synechococcus elongatus* para o genoma da bactéria *Escherichia coli*, um organismo não circadiano.

Fonte: CHEN, A. H. et al. Transplantability of a Circardian Lock to Noncircardian Organism. **Science Advantage**, n. 1, 2015 (adaptado).', 'Estarão presentes no organismo geneticamente modificado os genes do', 'D', 'Pense no que foi transferido e no que a bactéria receptora já tinha antes.', 'A E. coli não tem ciclo circadiano próprio e manteve seu genoma; ela apenas ganhou os genes do relógio de outra espécie.', 'A E. coli é um organismo não circadiano, então não tem genes de ciclo circadiano próprios. Ela recebeu os genes do relógio biológico da cianobactéria S. elongatus e continuou com todo o seu genoma, incluindo os genes do seu metabolismo. Assim, o transgênico tem genes do ciclo circadiano de S. elongatus e do metabolismo de E. coli: letra D. As alternativas B, C e E falham por citar um ciclo circadiano da própria E. coli, que não existe.', 'fácil'),
('2025-D2-Q093', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 93, '5_alternativas', 'Biologia', 'Zoologia', 'Glândula uropigial das aves', null, null, 'Os funcionários de um zoológico observaram um aumento na taxa de mortalidade de aves aquáticas por afogamento. Um grupo de biólogos analisou o comportamento das aves por várias semanas e observou que elas apresentavam dificuldade de flutuação, por causa do encharcamento das penas com água.', 'O aumento na taxa de mortalidade dessas aves estava associado a uma redução na', 'C', 'O que deixa as penas das aves aquáticas impermeáveis?', 'As aves espalham com o bico um óleo produzido por uma glândula perto da cauda. Sem esse óleo, as penas encharcam.', 'A glândula uropigial, localizada na base da cauda, produz uma secreção oleosa que a ave espalha nas penas, tornando-as impermeáveis. Se essa secreção diminui, as penas encharcam, a ave fica pesada, perde flutuação e pode se afogar: letra C. Ossos pneumáticos (E) ajudam no voo por deixarem o corpo leve, mas não explicam penas encharcadas.', 'média'),
('2025-D2-Q094', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 94, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Potência elétrica e fusíveis', null, null, 'Réguas elétricas são dispositivos que permitem a ligação segura e simultânea de dois ou mais aparelhos eletroeletrônicos à rede elétrica. Uma estudante comprou uma régua com seis tomadas, conforme a figura. Essa régua suporta uma intensidade máxima de corrente elétrica igual a 20 A. Acima desse valor, o fusível de segurança da régua se rompe, inutilizando-a até que um novo fusível seja instalado. Considere as potências nominais de alguns aparelhos eletroeletrônicos apresentadas no quadro.

| Aparelho | Potência (watt) |
|---|---|
| Luminária de LED | 5 |
| Computador | 250 |
| Impressora a laser | 660 |
| Secador de cabelos | 750 |
| Cafeteira | 900 |
| Condicionador de ar portátil | 1 100 |

{{figura:1}}

Em um dia quente, a estudante mantém o computador e o condicionador de ar portátil ligados à régua permanentemente. Nessa situação, ela tenta realizar algumas atividades, uma de cada vez, utilizando a mesma régua, na seguinte ordem:

- 1º – imprimir um trabalho escolar;
- 2º – fazer um café com a cafeteira;
- 3º – ligar a luminária;
- 4º – secar os cabelos.

Sabe-se que a régua foi ligada à tensão elétrica de 110 V, adequada para o funcionamento desses aparelhos.', 'Considerando a ordem das tentativas, quantas atividades a estudante conseguiu realizar sem queimar o fusível?', 'D', 'Descubra a potência máxima que a régua aguenta com $P = U \cdot i$.', 'A régua aguenta $110 \times 20 = 2200$ W, e o computador e o ar-condicionado já usam 1350 W. Teste cada atividade na ordem e lembre: se o fusível queimar, a régua para.', 'Potência máxima: $P = 110 \times 20 = 2200$ W. Já ligados: $250 + 1100 = 1350$ W. 1º, impressora: $1350 + 660 = 2010$ W, abaixo do limite, então funciona. 2º, cafeteira: $1350 + 900 = 2250$ W, acima de 2200 W, e o fusível queima. Com a régua inutilizada, as outras atividades não acontecem. Ela realizou só 1 atividade: letra D. Quem marca 3 (B) esquece que a régua deixa de funcionar depois que o fusível rompe.', 'média'),
('2025-D2-Q095', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 95, '5_alternativas', 'Física', 'Termologia', 'Irradiação térmica', null, null, '**TEXTO I**

**As mariposas**

As mariposa, quando chega o frio
Fica dando volta em volta da lâmpida pra se esquentá. [sic]

Fonte: BARBOSA, A. **Reviva: Adoniran Barbosa**. São Paulo: Som Livre, 2002 (fragmento).

**TEXTO II**

As mariposas se aproximam das lâmpadas atraídas pela luz, pois, sendo basicamente criaturas noturnas, estão adaptadas a seguir o brilho da lua, em um processo conhecido como orientação transversal. Assim, o que o sambista Adoniran Barbosa, no Texto I, descreve não é a causa, mas sim uma das consequências possíveis dessa aproximação. De fato, o calor gerado pelas lâmpadas, sobretudo as incandescentes, pode aquecer as mariposas.

Fonte: HERTZBERG, R. Por que as mariposas são tão atraídas por luzes fortes? **National Geographic**, nov. 2020 (adaptado).', 'Nesse contexto, o processo de transferência de calor para as mariposas que independe da presença de fluidos é a', 'C', 'Dos processos de propagação de calor, qual funciona até no vácuo?', 'Convecção precisa de um fluido em movimento; reflexão, refração e dispersão são fenômenos da luz, e não formas de transferir calor.', 'O calor da lâmpada chega à mariposa principalmente por ondas eletromagnéticas (sobretudo infravermelho). Essa é a irradiação térmica, a única forma de propagação de calor que não precisa de meio material e funciona até no vácuo: letra C. A convecção (E) depende justamente do movimento de um fluido, como o ar.', 'fácil'),
('2025-D2-Q096', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 96, '5_alternativas', 'Biologia', 'Zoologia', 'Toxinas de anfíbios e dieta', null, null, 'Os sapinhos-ponta-de-flecha constituem um grupo de espécies encontradas na América Central e do Sul. Seus venenos são obtidos por meio do consumo de algumas formigas e cupins que se alimentam de plantas que contêm esses venenos. Esses anfíbios são usados para envenenar as flechas das zarabatanas dos caçadores nativos. Quando capturados e criados em condições artificiais, ou quando nascidos em cativeiro, não são tóxicos.

Fonte: BADIO, B. et al. Epibatidine: Discovery and Definition as a Potent Analgesic and Nicotinic Agonist. **Med. Chem. Res.**, n. 4, 1994 (adaptado).', 'A perda da capacidade de se obter a toxina nos nascidos em cativeiro é causada pela', 'B', 'Releia de onde vem o veneno desses sapinhos: eles fabricam a toxina ou a obtêm de algum lugar?', 'O veneno vem da cadeia alimentar: plantas, depois formigas e cupins, e por fim o sapo. Pense no que muda no cativeiro.', 'O texto diz que os sapinhos obtêm o veneno ao comer formigas e cupins que se alimentam de plantas tóxicas. Em cativeiro, recebem outro alimento, sem essas presas, e por isso não acumulam a toxina: letra B. A variabilidade genética (E) não explica a mudança, porque os genes dos animais são os mesmos; o que mudou foi a dieta.', 'fácil'),
('2025-D2-Q097', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 97, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Vacinas e imunização', null, null, 'A produção de vacinas exige uma sequência de procedimentos, além do cumprimento estrito de verificações de segurança. No esquema, estão demonstradas as etapas básicas realizadas para a fabricação de uma vacina utilizando a tecnologia tradicional e o efeito dela no organismo.

{{figura:1}}', 'O antígeno utilizado na vacina causa um efeito protetor contra o vírus porque', 'D', 'Veja a última etapa do esquema: o que aparece em volta dos vírus depois da vacina?', 'O vírus da vacina está inativado e não traz anticorpos prontos: ele só estimula o corpo a produzir defesas.', 'O antígeno do vírus inativado estimula o sistema imune a produzir anticorpos, que são proteínas capazes de se ligar ao vírus e neutralizá-lo, além de gerar memória imunológica. Essa é a letra D. A letra C descreve um soro, que já traz imunoglobulinas prontas. O antígeno também não mata nem aglutina o vírus por conta própria (A e B): quem faz isso são os anticorpos produzidos pelo organismo.', 'média'),
('2025-D2-Q098', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 98, '5_alternativas', 'Biologia', 'Ecologia', 'Espécies exóticas invasoras', null, null, 'O bioma Cerrado é caracterizado por apresentar ampla e natural diversidade de espécies vegetais. Nos últimos tempos, o homem vem modificando esse cenário pela inserção de plantas exóticas nesse ambiente. Exemplo disso é o cultivo do capim-gordura, nativo do continente africano e utilizado nesse tipo de ecossistema como forma de pastagem. É importante ressaltar que essa espécie vegetal é capaz de se espalhar por grandes áreas, devido à sua agressividade e poder competitivo.

Fonte: CARLOS JR., L. A.; BARBOSA, N. P. U.; FERNANDES, G. W. O capim-gordura e as invasões no Cerrado brasileiro. **Jornal do Biólogo**, mar.-jun. 2008 (adaptado).', 'Em longo prazo, essa ação do homem pode gerar qual consequência?', 'D', 'O texto destaca que o capim-gordura é agressivo e muito competitivo. Competindo com quem?', 'Uma espécie exótica invasora ocupa espaço e recursos das plantas locais. Pense no efeito disso sobre a biodiversidade do Cerrado.', 'O capim-gordura é uma espécie exótica invasora: se espalha rápido e compete por luz, água e nutrientes com as plantas nativas, que acabam deslocadas. Em longo prazo, isso reduz a diversidade de espécies nativas do Cerrado: letra D. A letra A é o oposto, porque a invasão tende a homogeneizar o ambiente; e gramíneas como essa até aumentam o material seco, favorecendo queimadas, e não reduzindo-as (E).', 'fácil'),
('2025-D2-Q099', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 99, '5_alternativas', 'Biologia', 'Ecologia', 'Adaptações e biomas brasileiros', null, null, 'O monstro de gila, um lagarto encontrado em um deserto dos Estados Unidos, apresenta adaptações à falta de alimento nesse ambiente. Esse lagarto possui um hormônio que controla os níveis de açúcar em seu próprio sangue. Foi observado que esse hormônio também controla os níveis de açúcar no sangue de pessoas diabéticas.

Fonte: RUSSELL, C. **Ozempic e outros remédios inspirados em veneno de animais**. Disponível em: www.bbc.com. Acesso em: 6 dez. 2024 (adaptado).', 'Considerando que animais de um mesmo grupo taxonômico podem apresentar características adaptativas semelhantes em ambientes similares, onde seria mais provável encontrar lagartos com essas características no território brasileiro?', 'C', 'O monstro de gila vive em deserto. Qual bioma brasileiro tem clima mais parecido?', 'Procure o bioma semiárido, com chuvas escassas e períodos longos de seca, em que a falta de alimento é comum.', 'O lagarto vive em deserto, ambiente seco e com pouca oferta de alimento. Pela lógica do enunciado, lagartos com adaptações parecidas seriam mais prováveis no bioma brasileiro de clima semiárido, com secas prolongadas e escassez de recursos: a Caatinga, letra C. O Cerrado (A) tem estação seca, mas é bem menos árido; Pantanal, Restinga e Pampas são ambientes mais úmidos.', 'fácil'),
('2025-D2-Q100', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 100, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Purificação da água', null, null, 'Existe um processo de purificação de água em que são removidos os sais dissolvidos. A água que passa por esse processo é muito utilizada em laboratórios de química, em indústrias (como solvente), em baterias de carros etc. Entretanto, esse tipo de água não é adequado para ingestão, pois pode causar problemas de saúde, como carência iônica e diarreia.', 'Essa água é chamada de', 'D', 'Que processo de separação ferve a água e condensa o vapor, deixando os sais para trás?', 'Os sais não evaporam junto com a água. A água obtida desse jeito é a usada em laboratórios e baterias.', 'Na destilação, a água é aquecida, vira vapor e depois é condensada, enquanto os sais dissolvidos ficam no recipiente original. O resultado é a água destilada, praticamente sem íons, usada em laboratórios e baterias, mas imprópria para consumo frequente: letra D. A água dura (A) é o contrário, rica em sais de cálcio e magnésio; a pesada (B) tem deutério; a sanitária e a oxigenada são soluções de outras substâncias.', 'fácil'),
('2025-D2-Q101', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 101, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Visão e pupila', null, null, '**Por que os olhos ficam vermelhos em algumas fotografias?**

Em fotos tiradas com câmeras fotográficas antigas, por vezes as pessoas aparecem com os olhos vermelhos. Isso ocorre porque a luz do flash da câmera incide diretamente no globo ocular, sendo refletida por uma região repleta de vasos sanguíneos.

Fonte: Disponível em: www.uol.com.br. Acesso em: 14 jun. 2017 (adaptado).', 'Esse efeito é mais comum à noite ou em lugares pouco iluminados porque, com a pupila', 'A', 'Como a pupila reage quando o ambiente está escuro?', 'No escuro, a pupila se abre para captar mais luz. Pense no que isso significa para a luz do flash que entra e volta refletida pelo fundo do olho.', 'Em ambientes pouco iluminados, a pupila fica dilatada. Quando o flash dispara, entra muita luz, que chega à retina, região cheia de vasos sanguíneos, e é refletida de volta, deixando o olho vermelho na foto. Por isso a resposta é a letra A: dilatada, chega mais luz à retina. As alternativas com pupila retraída descrevem o que acontece em ambientes claros.', 'fácil'),
('2025-D2-Q102', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 102, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Intoxicação por neurotoxina', null, null, 'O sashimi (filé de peixe cru) de baiacu é uma iguaria muito apreciada no Japão. Entretanto, sua ingestão pode causar a morte por parada respiratória, pois esse peixe contém uma potente neurotoxina termoestável, a tetrodotoxina, que é produzida e armazenada nas gônadas e vísceras.', 'Que ação poderia evitar essa intoxicação?', 'E', 'Repare em duas informações: a toxina é termoestável e fica guardada em órgãos específicos do peixe.', 'Se o calor não destrói a toxina, cozinhar não resolve. O jeito é impedir que ela chegue à carne que será comida.', 'A tetrodotoxina fica armazenada nas gônadas e vísceras. Se esses órgãos forem rompidos no preparo, a toxina contamina o filé. Portanto, manusear o peixe sem romper os órgãos internos evita a intoxicação: letra E. Cozinhar ou fritar (C) não adianta, porque a toxina é termoestável; e higiene (D) combate micróbios, mas a toxina é produzida pelo próprio peixe.', 'média'),
('2025-D2-Q103', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 103, '5_alternativas', 'Biologia', 'Citologia', 'Lisossomos', null, null, 'A deficiência da enzima lipase ácida causa uma doença em que o portador apresenta células que não degradam colesterol esterificado nem triglicerídeos, resultando no depósito desses compostos em diversos órgãos, principalmente no fígado.

Fonte: ANDERSON, R. A. et al. In Situ Localization of the Genetic Locus Encoding [...]. **Genomics**, n. 1, jan. 1993 (adaptado).', 'Essa doença resulta da insuficiência funcional de qual estrutura celular?', 'A', 'Qual organela celular é especializada em digerir substâncias com enzimas que atuam em pH ácido?', 'A pista está no nome da enzima: “lipase ácida”. Lembre qual organela tem o interior ácido e cheio de enzimas digestivas.', 'Os lisossomos são as organelas da digestão intracelular: têm interior ácido e contêm enzimas hidrolíticas, como a lipase ácida, que quebra lipídios. Sem essa enzima funcionando, o colesterol esterificado e os triglicerídeos se acumulam nas células, o que mostra uma falha dos lisossomos: letra A. O retículo endoplasmático liso (E) produz lipídios, mas não é responsável por degradá-los.', 'fácil'),
('2025-D2-Q104', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 104, '5_alternativas', 'Biologia', 'Ecologia', 'Sequestro de carbono', null, null, 'A quantidade de CO₂ na atmosfera da Terra aumentou em 50%, e a temperatura está agora cerca de 1,2 °C mais quente em comparação ao século XIX. O ritmo de aumento da temperatura precisa diminuir se quisermos evitar as piores consequências das mudanças climáticas. Cientistas afirmam que o aquecimento global precisa ser mantido em 1,5 °C até o ano 2100. No entanto, a menos que outras ações sejam tomadas, o planeta ainda pode aquecer mais de 2 °C até o final deste século. Na prática, os países precisam enfrentar as mudanças climáticas com ações mitigadoras, que reduzam tanto as emissões quanto os níveis de CO₂ na atmosfera.

Fonte: **Um guia rápido para entender as mudanças climáticas**. Disponível em: www.bbc.com. Acesso em: 6 dez. 2021 (adaptado).', 'Qual ação mitigadora auxilia na remoção desse gás presente na atmosfera, reduzindo seus níveis?', 'A', 'O comando pede uma ação que remova o CO₂ já presente no ar, e não apenas uma que emita menos.', 'Energia eólica, solar e menos fósseis reduzem novas emissões. Qual processo biológico retira CO₂ da atmosfera?', 'As árvores fazem fotossíntese: absorvem CO₂ da atmosfera e incorporam o carbono à sua biomassa. Plantar mais árvores, portanto, retira esse gás do ar e reduz seus níveis: letra A. Usinas eólicas, energia solar, deixar os combustíveis fósseis no solo e produzir menos resíduos (B a E) diminuem as emissões futuras, mas não removem o CO₂ que já está na atmosfera.', 'fácil'),
('2025-D2-Q105', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 105, '5_alternativas', 'Química', 'Química ambiental', 'Poluição térmica e oxigênio dissolvido', null, null, 'As usinas termonucleares são aquelas que produzem energia elétrica a partir da geração de energia térmica proveniente das reações nucleares. Normalmente, essas usinas funcionam por meio de dois circuitos, denominados circuito primário (vaso de pressão, pressurizador e bomba) e circuito secundário (gerador de vapor, turbina, condensador, tanque de alimentação e bombas), além de um sistema de água de refrigeração, formado por uma bomba ligada a uma fonte hídrica natural.

{{figura:1}}

Durante a operação da usina, se o sistema de água de refrigeração funcionar de forma ineficiente pode causar poluição térmica, comprometendo a vida no ecossistema aquático.

Fonte: Disponível em: www.eletronuclear.gov.br. Acesso em: 29 nov. 2021 (adaptado).', 'Para o ecossistema aquático, a ineficiência do sistema de água de refrigeração tem como consequência a', 'E', 'Pense no que acontece com a temperatura da água devolvida ao rio ou lago quando o resfriamento não funciona bem.', 'Poluição térmica é água mais quente, não substâncias tóxicas. Lembre como a temperatura afeta a quantidade de gás que consegue ficar dissolvida em um líquido.', 'Se o sistema de refrigeração é ineficiente, a água volta ao ecossistema mais quente. Gases se dissolvem menos em água quente, então cai a quantidade de oxigênio disponível para peixes e outros organismos: alternativa E, diminuição da solubilidade do gás oxigênio. A água de refrigeração não tem contato com o reator, por isso não leva elementos radioativos nem combustível (D e C).', 'fácil'),
('2025-D2-Q106', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 106, '5_alternativas', 'Química', 'Química geral e atomística', 'Fórmulas de compostos inorgânicos', null, null, 'No início do século XX, as fórmulas das substâncias eram representadas de modo diferente do atual. A figura apresenta uma fotografia bem antiga (1909) que registra uma aula de química ministrada em um colégio em Santos (SP). Um olhar mais atento permite identificar como os compostos químicos eram representados.

{{figura:1}}

O nitrogênio era chamado de azoto e representado pelo símbolo Az. Vê-se na lousa a equação representativa da adição do oxigênio atômico (O) ao monóxido de nitrogênio (AzO) com a formação de dióxido de nitrogênio (AzO²). Analogamente, o nitrato de sódio era representado por NaAzO³.

Fonte: Disponível em: www.novomilenio.inf.br. Acesso em: 29 ago. 2014 (adaptado).', 'Em 1909, as representações das substâncias ácido nítrico e cloreto de cálcio, tendo por base essas informações e seguindo a mesma lógica, seriam, respectivamente:', 'A', 'Compare as fórmulas antigas da lousa com as atuais: o que mudou foi só o símbolo do nitrogênio e o jeito de escrever os índices.', 'Escreva primeiro as fórmulas atuais: ácido nítrico é $HNO_3$ e cloreto de cálcio é $CaCl_2$. Depois troque N por Az e passe os índices para cima.', 'Na notação de 1909, N virava Az e os índices eram escritos em sobrescrito, como em NaAzO³ (hoje $NaNO_3$). Assim, $HNO_3$ vira HAzO³ e $CaCl_2$ vira CaCl²: alternativa A. As outras mudam a quantidade de átomos (como H³AzO⁴) ou trocam o cálcio por potássio (K), o que não faz sentido.', 'fácil'),
('2025-D2-Q107', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 107, '5_alternativas', 'Biologia', 'Genética e evolução', 'Primeira lei de Mendel', null, null, 'A figura apresenta a herança genética de uma característica a partir do cruzamento de insetos de uma mesma espécie.

{{figura:1}}', 'Qual alternativa representa a proporção fenotípica da prole resultante do cruzamento entre indivíduos da primeira geração?', 'E', 'Observe a primeira geração: os filhos mostram as duas características dos pais ao mesmo tempo. Que tipo de herança é essa?', 'Na codominância o heterozigoto expressa os dois alelos. Cruze dois heterozigotos e monte o quadro de Punnett: quais as proporções de cada genótipo?', 'Como a F1 tem pintas e listra juntas, os dois alelos se expressam: é codominância, e a F1 é heterozigota. Cruzando heterozigotos, temos 1/4 homozigotos só com pintas, 1/4 homozigotos só com listra e 1/2 heterozigotos com as duas marcas (1 : 1 : 2). É o que mostra a alternativa E: um inseto com pintas, um com listra e dois com pintas e listra. A alternativa C (todos iguais à F1) seria verdade só para a primeira geração, não para o cruzamento entre seus indivíduos.', 'média'),
('2025-D2-Q108', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 108, '5_alternativas', 'Física', 'Dinâmica e leis de Newton', 'Atrito no plano inclinado', null, null, 'Para transportar uma caixa do primeiro para o segundo piso de uma construção, um trabalhador precisará arrasta-lá sobre um plano inclinado. O trabalhador começa a arrastar a caixa no primeiro piso, exercendo sobre ela uma força de grande intensidade, paralela ao seu deslocamento. Na medida em que a caixa sobe o plano inclinado, ele decide reduzir a força sobre ela, arrastando-a lentamente até chegar ao segundo piso. Considere que a caixa permanece em movimento nos encontros dos pisos com o plano inclinado, e que a rugosidade entre as superfícies permanece a mesma durante todo o percurso.', 'O comportamento da força de atrito entre a caixa e o chão no plano inclinado é representado em:', 'C', 'A força de atrito cinético depende do coeficiente de atrito e da força normal, e não da força que o trabalhador faz.', 'No plano inclinado a normal vale $N = mg\cos\theta$, que não muda durante a subida. A rugosidade também não muda. O que isso diz sobre o atrito?', 'Com a caixa sempre em movimento, o atrito é cinético: $F_{at} = \mu N$, com $N = mg\cos\theta$ no plano inclinado. Como $\mu$, a massa e a inclinação são constantes, o atrito fica constante o tempo todo, como no gráfico C. Reduzir a força do trabalhador muda a aceleração da caixa, mas não o atrito; por isso gráficos que caem junto com a força (D e E) estão errados.', 'média'),
('2025-D2-Q109', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 109, '5_alternativas', 'Química', 'Química orgânica', 'Reação de descarboxilação', null, null, 'O fruto do cajueiro é um aquênio repleto de um líquido escuro, quase preto, cáustico e inflamável. Esse líquido da casca da castanha do caju (LCC) representa aproximadamente 25% da massa da castanha e é um subproduto de agronegócio do caju. Quando submetido a altas temperaturas, o ácido anacárdico presente no LCC é convertido a cardanol, que recebe a denominação de LCC técnico, conforme o esquema:

{{figura:1}}

Fonte: MAZZETTO, S. E.; LOMONACO, D.; MELE, G. Óleo da castanha de caju: oportunidades e desafios no contexto do desenvolvimento e sustentabilidade industrial. **Química Nova**, n. 3, 2009 (adaptado).', 'O LCC técnico é produzido por meio de uma reação orgânica do tipo', 'E', 'Compare as duas moléculas do esquema: que grupo o ácido anacárdico tem e o cardanol não tem? E qual gás sai?', 'O grupo que sumiu é a carboxila ($-COOH$), liberada na forma de $CO_2$. O nome da reação descreve exatamente a retirada desse grupo.', 'No aquecimento, o ácido anacárdico perde o grupo carboxila ($-COOH$), que sai como $CO_2$, e vira cardanol. A remoção da carboxila com liberação de $CO_2$ se chama descarboxilação: alternativa E. Não há entrada de água (hidrólise), de hidrogênio (hidrogenação) nem formação de éster (esterificação).', 'fácil'),
('2025-D2-Q110', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 110, '5_alternativas', 'Química', 'Química geral e atomística', 'Meia-vida radioativa', null, null, 'A química nuclear é uma importante ferramenta na produção de substâncias utilizadas na área da saúde humana. A radiação emitida pelo cobalto-60 é utilizada na medicina como ferramenta de diagnóstico e no tratamento do câncer. No entanto, esse radioisótopo tem um tempo de armazenamento limitado, pois seu tempo de meia-vida é de 5,3 anos. Considere um frasco com uma amostra contendo 2,00 mg de cobalto-60, armazenado durante um período de 26,5 anos.', 'A massa de cobalto-60, em miligrama, que restará ao final desse tempo é mais próxima de', 'E', 'Descubra quantas meias-vidas cabem em 26,5 anos.', 'Divida 26,5 por 5,3 para achar o número de meias-vidas. A cada uma delas, a massa cai pela metade.', 'O número de meias-vidas é $26{,}5 \div 5{,}3 = 5$. A massa cai pela metade 5 vezes: $2{,}00 \to 1{,}00 \to 0{,}50 \to 0{,}25 \to 0{,}125 \to 0{,}0625$ mg, ou seja, $\frac{2{,}00}{2^5} \approx 0{,}06$ mg (alternativa E). A alternativa D (0,13 mg) corresponde a apenas 4 meias-vidas.', 'fácil'),
('2025-D2-Q111', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 111, '5_alternativas', 'Biologia', 'Ecologia', 'Eutrofização', null, null, 'O esquema apresenta as etapas do processo de biodigestão, uma forma de dar um destino sustentável a excrementos animais e restos de comida produzidos em áreas de criação de gado e porcos confinados.

{{figura:1}}

Fonte: Disponível em: www.engquimicasantossp.com.br. Acesso em: 11 fev. 2015 (adaptado).', 'Dar destino sustentável às sobras, conforme apresentado na etapa 4, ajuda a evitar a', 'B', 'Pense no que aconteceria se esse material, rico em nutrientes, fosse parar em rios e lagos.', 'Esterco e restos de comida têm muito nitrogênio e fósforo. Qual problema ambiental acontece quando esses nutrientes chegam em excesso à água?', 'Usar as sobras como fertilizante evita que esse material rico em matéria orgânica e nutrientes (nitrogênio e fósforo) seja despejado em corpos d''água. Esse excesso provocaria a proliferação de algas, falta de oxigênio e morte de organismos aquáticos, a eutrofização: alternativa B. Camada de ozônio, inversão térmica e chuva ácida são problemas ligados a gases na atmosfera, não ao destino das sobras.', 'fácil'),
('2025-D2-Q112', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 112, '5_alternativas', 'Biologia', 'Fisiologia humana e saúde', 'Vitamina A e avitaminose', null, null, '*Golden Rice*, ou arroz dourado, é uma variedade de arroz enriquecida em betacaroteno, precursor da vitamina A. Foi desenvolvida para ajudar a combater a doença decorrente da deficiência dessa vitamina. Para a obtenção dessa variedade de arroz, foram utilizados métodos de engenharia genética.

Fonte: BORÉM, A.; SANTOS, F. R. **Entendendo a biotecnologia**. Viçosa: UFV, 2008 (adaptado).', 'Esse alimento contribui para diminuir a carência associada a qual doença?', 'D', 'O texto diz que o arroz tem betacaroteno, precursor da vitamina A. Que doença a falta dessa vitamina causa?', 'Lembre as associações clássicas: vitamina C com escorbuto, vitamina D com raquitismo, vitamina B12 com anemia perniciosa. Falta a da vitamina A, ligada à visão.', 'O betacaroteno é convertido em vitamina A no organismo, e essa vitamina é essencial para formar os pigmentos da retina que permitem enxergar com pouca luz. Sua deficiência causa cegueira noturna: alternativa D. Escorbuto vem da falta de vitamina C, raquitismo da falta de vitamina D, anemia perniciosa da falta de B12, e hemofilia é genética.', 'fácil'),
('2025-D2-Q113', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 113, '5_alternativas', 'Física', 'Eletromagnetismo', 'Campo elétrico e cargas', null, null, 'A Figura 1 apresenta o esquema de um tubo de imagem em que um filamento, na posição A, libera elétrons por efeito termiônico. Esses elétrons formam um feixe estreito, que é acelerado por campos elétricos em direção à parte interna da tela. Nesse caminho, o feixe de elétrons passa por outro campo elétrico, na região B, atingindo, em seguida, a parte interna da tela do tubo, a qual é recoberta por um material que emite luz ao receber o impacto dos elétrons.

{{figura:1}}

Na Figura 2, a carga negativa representa o feixe de elétrons que é acelerado e, posteriormente, atinge um ponto da tela. O campo elétrico na região B apresenta a seguinte configuração:

{{figura:2}}

Fonte: Grupo de Reelaboração do Ensino de Física. **Física 3: eletromagnetismo**. São Paulo: Edusp, 2000 (adaptado).', 'Nessa situação, qual ponto da tela será atingido pelo feixe de elétrons?', 'B', 'Lembre que a força elétrica numa carga negativa tem sentido oposto ao do campo elétrico.', 'Na Figura 2 o campo aponta para cima. Descubra para onde o elétron é empurrado e procure na Figura 1 o ponto da tela nesse lado.', 'A força elétrica é $\vec{F} = q\vec{E}$. Como o elétron tem carga negativa, a força tem sentido contrário ao campo. O campo na região B aponta para cima, então o feixe é desviado para baixo e atinge o ponto 2 da tela: alternativa B. O ponto 1 seria o desvio de uma carga positiva, e o ponto 5 seria o caso sem campo.', 'média'),
('2025-D2-Q114', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 114, '5_alternativas', 'Física', 'Ondulatória e som', 'Ressonância', null, null, 'A tirinha ilustra um processo físico em que uma onda sonora, produzida pela Mônica, causa a quebra das taças de cristal. O fenômeno ondulatório que provoca a quebra das taças só é possível em razão de uma característica da voz produzida pela Mônica naquele momento, que, diferentemente do que sugere a tirinha, não está relacionada à sua intensidade.

{{figura:1}}

Fonte: Disponível em: https://artedafisicapibid.blogspot.com. Acesso em: 23 nov. 2021 (adaptado).', 'Esse fenômeno e a característica associada à voz da Mônica são, respectivamente,', 'B', 'O texto avisa que a quebra não depende da intensidade (o volume) da voz. Que outra característica do som pode fazer o vidro vibrar muito?', 'A taça tem uma frequência natural de vibração. Quando a fonte emite exatamente nessa frequência, a amplitude de vibração cresce muito. Que fenômeno é esse?', 'A taça quebra por ressonância: quando o som tem a mesma frequência natural de vibração da taça, ela passa a oscilar com amplitude cada vez maior até se romper. A característica da voz que importa é a frequência: alternativa B. Timbre (D) diferencia vozes e instrumentos, mas não é o que precisa coincidir; amplitude (E) está ligada à intensidade, que o texto descarta.', 'fácil'),
('2025-D2-Q115', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 115, '5_alternativas', 'Química', 'Química orgânica', 'Fórmula molecular e oxidação', null, null, 'Em uma aula prática de química orgânica, um professor identificou os frascos de várias substâncias apenas por suas fórmulas moleculares. Em seguida, apresentou a representação tridimensional da molécula do borneol, um álcool secundário, conforme a figura. Ele explicou que, quando oxidado, o borneol dá origem à cânfora, uma cetona usada desde a Antiguidade como incenso e no preparo de medicamentos. Finalmente, o professor solicitou que os alunos identificassem o frasco contendo a substância cânfora.

{{figura:1}}

Fonte: SANTOS, A. P. B. et al. Oxidação do borneol à cânfora com água sanitária: um experimento simples de baixo custo e limpo. **Química Nova**, n. 6, 2009 (adaptado).', 'O frasco contendo cânfora apresenta a fórmula molecular:', 'C', 'Conte os carbonos do borneol e pense no que muda quando um álcool secundário vira cetona.', 'Na oxidação de um álcool secundário a cetona, o $C-OH$ vira $C=O$: a molécula perde 2 átomos de H e mantém os carbonos e o oxigênio. Ache primeiro a fórmula do borneol.', 'O borneol tem 10 carbonos (7 do esqueleto bicíclico e 3 grupos metila) e um OH; sua fórmula é $C_{10}H_{18}O$. Ao ser oxidado, o carbono do $C-OH$ vira carbonila ($C=O$), perdendo 2 hidrogênios. A cânfora fica $C_{10}H_{16}O$: alternativa C. Opções com $O_2$ (D e E) ganhariam um oxigênio, o que não acontece na formação de uma cetona.', 'média'),
('2025-D2-Q116', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 116, '5_alternativas', 'Biologia', 'Ecologia', 'Endemismo e seleção natural', null, null, 'As cangas são ambientes resultantes da atuação, ao longo de milhões de anos, de chuvas, enxurradas, calor e ventos em rochas ricas em ferro. São compostas por até 90% de óxidos de ferro e contêm solos muito ácidos, rasos, com reduzidos índices de fertilidade e temperaturas que atingem quase 70 °C na superfície. Ao contrário do que se imagina, esse tipo de ambiente abriga comunidades de plantas e animais com elevado número de espécies e distribuição restrita.

Fonte: CARMO, F. F. et al. **Ilhas de ferro estratégicas para a conservação**. Disponível em: http://cienciahoje.org.br. Acesso em: 2 dez. 2018 (adaptado).', 'A seleção adaptativa nesses ambientes favorece a ocorrência de espécies', 'C', 'As cangas são ambientes extremos (solo ácido, pobre, muito quente) e as espécies de lá têm distribuição restrita.', 'Condições muito específicas selecionam espécies que só sobrevivem ali. Como se chama uma espécie que ocorre apenas em determinado local?', 'Solo ácido, pobre e calor extremo exercem uma pressão seletiva forte, favorecendo espécies muito adaptadas a esse ambiente e que só existem nele. O próprio texto fala em distribuição restrita: são espécies endêmicas, alternativa C. Generalistas (E) vivem em muitos ambientes diferentes, e exóticas (A) vêm de outras regiões, o oposto do descrito.', 'fácil'),
('2025-D2-Q117', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 117, '5_alternativas', 'Química', 'Cinética e equilíbrio', 'Princípio de Le Chatelier', null, null, 'Para a produção de titânio metálico ou dióxido de titânio puros, é necessário fazer a cloração do minério que contém dióxido de titânio, com o objetivo de separar esse óxido de outras substâncias presentes no minério. A principal reação química de cloração é representada por:

TiO₂ (s) + 2 Cl₂ (g) ⇌ TiCl₄ (g) + O₂ (g)    ΔH = +175 kJ/mol

Depois da cloração, o tetracloreto de titânio é condensado e convertido, novamente, a dióxido de titânio.', 'Após o sistema atingir o equilíbrio químico, como a formação do TiCl₄ pode ser favorecida?', 'D', 'Use o princípio de Le Chatelier e analise cada perturbação separadamente.', 'Conte os mols de gás de cada lado: 2 e 2, então a pressão total não desloca. A reação é endotérmica. E sólidos não entram no equilíbrio.', 'Aumentar a pressão parcial de $Cl_2$, um reagente, faz o equilíbrio se deslocar no sentido de consumi-lo, formando mais $TiCl_4$: alternativa D. A pressão total (A) não muda nada, pois há 2 mols de gás de cada lado. Como $\Delta H > 0$, esfriar (B) favorece os reagentes. Aumentar $O_2$ (C) desloca para a esquerda, e o $TiO_2$ sólido (E) não altera o equilíbrio.', 'média'),
('2025-D2-Q118', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 118, '5_alternativas', 'Física', 'Hidrostática', 'Pressão e densidade', null, null, 'A laje de um depósito de bebidas tem 50 m² de área útil de armazenamento e foi projetada para suportar pressões de até 10⁴ Pa. O gerente do estabelecimento pretende armazenar um produto cuja densidade é 1 250 kg/m³. Considere a aceleração da gravidade igual a 10 m/s².', 'A altura máxima, em metro, de empilhamento do produto que essa laje é capaz de suportar é', 'C', 'A pressão de uma pilha de produto sobre a laje funciona como a de uma coluna de líquido: depende da densidade e da altura.', 'Use $p = d \cdot g \cdot h$ com a pressão máxima de $10^4$ Pa e isole $h$. A área de 50 m² não entra na conta.', 'A pressão exercida por uma camada de altura $h$ é $p = d \cdot g \cdot h$. Com o limite de $10^4$ Pa: $h = \frac{10^4}{1250 \cdot 10} = \frac{10\,000}{12\,500} = 0{,}8$ m, alternativa C. A área não importa: aumentar a área aumenta o peso e a superfície de apoio na mesma proporção, e a pressão continua igual.', 'fácil'),
('2025-D2-Q119', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 119, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Associação de geradores', null, null, 'Em uma comunidade rural, os moradores utilizam uma bomba-d’água alimentada por 100 V de tensão contínua, podendo variar em até 5 V. Um eletrotécnico pretende instalar placas fotovoltaicas para alimentar essa bomba. As placas são idênticas e cada uma apresenta tensão de operação igual a 34 V com corrente de 7,5 A. Além disso, cada placa apresenta 40 V de tensão elétrica, quando em circuito aberto. Assim, considerando que a placa descrita é um gerador não ideal, em circuito aberto ela pode ser representada conforme a figura:

{{figura:1}}

O eletrotécnico construiu um circuito que permite à bomba-d’água operar corretamente com o menor número possível de placas conectadas. Para isso, desenhou um diagrama no qual todas essas placas são representadas como um único gerador não ideal, com a especificação das correspondentes características elétricas.', 'O diagrama que representa o circuito construído pelo eletrotécnico é:', 'B', 'Primeiro descubra a resistência interna de uma placa usando os valores de circuito aberto e de operação.', 'Uma placa perde $40 - 34 = 6$ V em $7{,}5$ A. Depois, veja quantas placas em série dão entre 95 V e 105 V em operação, e some as fem e as resistências.', 'A resistência interna de cada placa é $r = \frac{40 - 34}{7{,}5} = 0{,}8\,\Omega$. Em operação, cada placa fornece 34 V; com 3 em série, $3 \cdot 34 = 102$ V, que está entre 95 V e 105 V (2 placas dariam só 68 V). O gerador equivalente tem $\varepsilon = 3 \cdot 40 = 120$ V e $r = 3 \cdot 0{,}8 = 2{,}4\,\Omega$: alternativa B. A alternativa D usa 102 V como fem, mas esse é o valor em operação, não a força eletromotriz.', 'difícil'),
('2025-D2-Q120', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 120, '5_alternativas', 'Física', 'Cinemática', 'Velocidade média e tempo', null, null, 'A figura ilustra as informações contidas no manual de um sistema de alarme que utiliza transmissores e receptores de radiação eletromagnética para a detecção de movimento. O receptor é regulado pelo tempo de resposta, que corresponde ao intervalo de tempo necessário para o corpo do invasor atravessar completamente o feixe, de diâmetro d = 15 cm. Considere que a menor porção do corpo de um invasor é a sua posição de perfil, cuja espessura típica é 20 cm. São indicados cinco possíveis movimentos de um invasor e suas velocidades típicas, que devem ser observadas para a escolha do tempo de resposta.

{{figura:1}}

Fonte: **Manual de referência e instalação**: sensor de barreira ativo. Disponível em: cs.ind.br. Acesso em: 2 dez. 2021 (adaptado).', 'Nesse sistema, o menor tempo de resposta, em milissegundo, que garante a detecção de um possível invasor é mais próximo de', 'B', 'Para garantir a detecção de qualquer invasor, pense no movimento que atravessa o feixe no menor tempo.', 'Para atravessar completamente, o corpo percorre a própria espessura mais o diâmetro do feixe: $20 + 15 = 35$ cm. Use a maior velocidade da figura.', 'O sistema precisa responder até mesmo ao invasor mais rápido, que fica menos tempo no feixe. Para atravessá-lo por completo, o corpo percorre $20 + 15 = 35$ cm $= 0{,}35$ m. Correndo a 5,0 m/s: $t = \frac{0{,}35}{5{,}0} = 0{,}07$ s $= 70$ ms, alternativa B. A alternativa E (700 ms) usa a menor velocidade (0,5 m/s); com esse tempo de resposta, quem passa correndo não seria detectado.', 'difícil'),
('2025-D2-Q121', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 121, '5_alternativas', 'Química', 'Química orgânica', 'Basicidade de aminas', null, null, 'A dimetilamina é uma substância de elevada toxidez que entra em ebulição a 7 °C. Na madrugada de um dia frio, essa substância se espalhou por uma rodovia após um acidente de trânsito envolvendo um caminhão que transportava esse produto. Para minimizar a agressão ao meio ambiente, bem como evitar a evaporação da dimetilamina com a elevação da temperatura ao longo do dia, um químico considerou o uso de algumas substâncias ou misturas como água, vinagre, óleo de soja, sal de cozinha e bicarbonato de sódio.', 'Dentre as opções apresentadas, o tratamento correto para minimizar esse problema é usar', 'B', 'A dimetilamina é uma amina. Pense no caráter ácido ou básico dela.', 'Aminas são bases. Reagindo com um ácido, formam um sal, que é iônico e não evapora com facilidade. Qual das opções é ácida?', 'Aminas como a dimetilamina são bases orgânicas. O ácido acético do vinagre reage com ela e forma um sal de amônio, um composto iônico, pouco volátil e menos agressivo: alternativa B. Água só dilui e não impede a evaporação; o bicarbonato de sódio (E) é básico e não neutraliza uma base; sal de cozinha e óleo de soja não reagem com ela.', 'média'),
('2025-D2-Q122', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 122, '5_alternativas', 'Física', 'Eletromagnetismo', 'Indução eletromagnética', null, null, 'O aquecimento em fogões por indução utiliza bobinas para produzir um campo magnético variável. Essa bobina se localiza abaixo do vidro cerâmico sobre o qual a panela se apoia. O mecanismo aquece apenas a panela que se encontra na zona de cozimento, o que é uma das principais vantagens em relação ao uso do fogão a gás ou de resistência elétrica.

{{figura:1}}

Fonte: PEREIRA, A. B. et al. **Fogões de indução**: montagem e testes de um circuito disponível. Disponível em: https://publicacoes.fatecsertaozinho.edu.br. Acesso em: 21 maio 2025 (adaptado).', 'O uso do campo magnético variável tem a finalidade de', 'D', 'Lembre da lei de Faraday: o que um campo magnético variável provoca em um material condutor?', 'Um fluxo magnético variável induz correntes elétricas no metal da panela. O que acontece com um condutor percorrido por corrente?', 'O campo magnético variável da bobina produz, pela lei de Faraday, correntes elétricas induzidas no fundo metálico da panela. Essas correntes dissipam energia na forma de calor pelo efeito Joule, e a panela se aquece: alternativa D. O vidro e o ar não esquentam por convecção ou radiação vinda da bobina (C e E); a panela esquenta e depois transfere calor ao alimento.', 'média'),
('2025-D2-Q124', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 124, '5_alternativas', 'Química', 'Eletroquímica', 'Potencial-padrão de pilhas', null, null, 'Objetos de prata escurecem em contato com compostos contendo enxofre por causa da formação de uma fina camada de sulfeto de prata. Um método simples para clarear o objeto consiste em forrar um recipiente com papel alumínio, adicionar ao recipiente uma solução aquosa de cloreto de sódio e, enfim, mergulhar o objeto de prata enegrecido. Em cerca de três minutos, a prata volta à coloração original. As seguintes semirreações e os respectivos potenciais-padrão de redução são úteis para a compreensão dos fenômenos ocorridos.

Ag₂S (s) + 2 e⁻ → 2 Ag (s) + S²⁻ (aq)    −0,69 V
O₂ (g) + 4 H⁺ (aq) + 4 e⁻ → 2 H₂O (l)    +1,23 V
Al³⁺ (aq) + 3 e⁻ → Al (s)    −1,68 V

Fonte: SARTORI, E. R.; BATISTA, E. F.; FATIBELLO-FILHO, O. Escurecimento e limpeza de objetos de prata: um experimento simples e de fácil execução envolvendo reações de oxidação-redução. **Química Nova na Escola**, n. 30, 2008 (adaptado).', 'Os valores das diferenças de potencial-padrão das reações que representam o escurecimento e o clareamento do objeto de prata são, respectivamente:', 'B', 'Monte as duas reações: no escurecimento a prata vira $Ag_2S$; no clareamento o $Ag_2S$ volta a ser prata, com ajuda do alumínio.', 'Use $\Delta E = E_{red}(\text{quem reduz}) - E_{red}(\text{quem oxida})$. No escurecimento, o $O_2$ é reduzido e a prata é oxidada; no clareamento, o $Ag_2S$ é reduzido e o Al é oxidado.', 'Escurecimento: a prata é oxidada a $Ag_2S$ e o $O_2$ é reduzido, então $\Delta E = 1{,}23 - (-0{,}69) = +1{,}92$ V. Clareamento: o $Ag_2S$ é reduzido a prata e o alumínio é oxidado, então $\Delta E = -0{,}69 - (-1{,}68) = +0{,}99$ V. Alternativa B. Os dois valores são positivos, como se espera de processos espontâneos; não se multiplicam os potenciais pelos coeficientes da equação.', 'difícil'),
('2025-D2-Q125', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 125, '5_alternativas', 'Química', 'Estequiometria', 'Rendimento e gases ideais', null, null, 'Apaixonada por culinária e química, uma chefe de cozinha calculou que, para promover o crescimento adequado da massa durante o cozimento de um bolo a 180 °C (453 K) e 1,00 atm, ela precisaria utilizar uma quantidade de fermento químico suficiente para produzir um volume de gás igual a 4,00 L. Com esse objetivo, ela escolheu utilizar o bicarbonato de amônio, um composto que, sob aquecimento, degrada-se em três gases distintos, que são os responsáveis pelo crescimento da massa. A decomposição do bicarbonato de amônio ocorre conforme a equação química apresentada e, nas condições do cozimento, seu rendimento é de 80%.

NH₄HCO₃ (s) → NH₃ (g) + CO₂ (g) + H₂O (g)

Considere que a mistura dos gases se comporta como gás ideal nas condições de cozimento utilizadas pela chefe.

Dados: Massa molar do NH₄HCO₃ = 79 g · mol⁻¹ e R = 0,082 atm · L · mol⁻¹ · K⁻¹.', 'A massa, em grama, de bicarbonato de amônio que ela deve utilizar é mais próxima de', 'B', 'Comece pela equação dos gases ideais para achar quantos mols de gás são necessários.', 'Cada mol de $NH_4HCO_3$ gera 3 mols de gás. Ache os mols de sal, corrija pelo rendimento de 80% (você precisa de mais sal) e multiplique por 79.', 'Mols de gás: $n = \frac{PV}{RT} = \frac{1{,}00 \cdot 4{,}00}{0{,}082 \cdot 453} \approx 0{,}108$ mol. Como 1 mol de sal gera 3 mols de gás, seriam $0{,}036$ mol de sal com rendimento total. Com 80%: $\frac{0{,}036}{0{,}8} \approx 0{,}045$ mol, ou $0{,}045 \cdot 79 \approx 3{,}5$ g, alternativa B. Esquecer o rendimento leva a cerca de 2,8 g; esquecer que são 3 gases leva a valores bem maiores.', 'difícil'),
('2025-D2-Q126', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 126, '5_alternativas', 'Física', 'Cinemática', 'Composição vetorial de velocidades', null, null, 'Segundo o princípio da independência dos movimentos, de Galileu, sempre que a velocidade resultante de um corpo puder ser decomposta em duas ou mais componentes perpendiculares entre si, cada um desses movimentos poderá ser analisado separadamente como se os outros não existissem. Esse princípio é muito útil para a simplificação de alguns problemas reais, em três dimensões.

Considere um avião que, ao decolar, é instruído pela torre a atingir, em 6 minutos, uma posição de 20 km a Leste, 20 km a Norte e 1 km de altitude em relação ao ponto de decolagem, conforme a figura (fora de escala). No entanto, no instante da decolagem, começa a soprar um vento cujo vetor velocidade tem componentes 30 km/h para Leste, 20 km/h para Sul e 1 km/h de cima para baixo.

{{figura:1}}', 'Durante a ação do vento, a velocidade $\vec{v}$ que o piloto deve estabelecer em relação ao ar para que o avião chegue à posição esperada no tempo indicado tem as componentes', 'D', 'Calcule a velocidade que o avião precisa ter em relação ao solo e depois desconte o efeito do vento, uma direção de cada vez.', '6 min é 0,1 h, então em relação ao solo são 200 km/h Leste, 200 km/h Norte e 10 km/h para cima. Use $\vec{v}_{ar} = \vec{v}_{solo} - \vec{v}_{vento}$ em cada eixo.', 'Em 0,1 h o avião precisa percorrer 20 km Leste, 20 km Norte e 1 km para cima: em relação ao solo, 200, 200 e 10 km/h. Subtraindo o vento: Leste $200 - 30 = 170$; Norte $200 - (-20) = 220$ (o vento empurra para o Sul, então o piloto compensa); vertical $10 - (-1) = 11$ para cima. Alternativa D. A alternativa B soma o vento em vez de descontá-lo.', 'difícil'),
('2025-D2-Q127', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 127, '5_alternativas', 'Química', 'Cinética e equilíbrio', 'Catálise e energia de ativação', null, null, 'Nos processos de transformação e reciclagem de recursos naturais, as velocidades das reações químicas são estudadas pela cinética química. Uma reação A → B é realizada na presença e na ausência de uma enzima, com todas as demais condições permanecendo inalteradas. Considere que, no gráfico da variação de energia ao longo dessa reação, a linha contínua representa o avanço da reação na ausência da enzima, e a linha pontilhada, na presença da enzima.', 'O gráfico que representa a situação descrita é:', 'C', 'Uma enzima é um catalisador. O que um catalisador muda no gráfico de energia de uma reação, e o que ele não muda?', 'O catalisador não altera a energia dos reagentes nem a dos produtos (o $\Delta H$ fica igual). Procure o gráfico em que só o pico muda.', 'A enzima cria um caminho de reação com menor energia de ativação, mas não altera a energia de A nem de B. No gráfico certo, a curva pontilhada começa e termina nos mesmos níveis da contínua e tem um pico mais baixo: alternativa C. Na D o pico pontilhado é mais alto, o que deixaria a reação mais lenta; em A, B e E mudam as energias de reagentes ou produtos.', 'fácil'),
('2025-D2-Q128', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 128, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Resistência e temperatura', null, null, 'A resistência de um fio de platina pode ser usada para medir temperaturas entre 0 °C e 100 °C e já foi utilizada como referência para a escala internacional de temperatura. Para um sensor feito de platina, a relação entre a resistência e a temperatura pode ser descrita por uma equação do tipo $R(T) = A + BT$, em que $T$ é a temperatura e A e B são constantes. O gráfico apresenta a dependência da resistência em função da temperatura para cinco diferentes sensores.

{{figura:1}}', 'Os sensores que apresentam maior sensibilidade são', 'E', 'Sensibilidade é o quanto a resistência muda para cada grau de variação na temperatura.', 'Na equação $R = A + BT$, a sensibilidade é o coeficiente $B$, ou seja, a inclinação da reta. Compare a variação de resistência de cada sensor no mesmo intervalo de temperatura.', 'A sensibilidade é a inclinação da reta $R(T)$. No mesmo intervalo de temperatura, o sensor 2 varia cerca de $225 - 76 \approx 149\,\Omega$ e o sensor 5 cerca de $145 - 66 \approx 79\,\Omega$, as duas maiores variações. O sensor 4 varia uns $58\,\Omega$, o 3 uns $22\,\Omega$ e o 1 quase nada. Logo, os mais sensíveis são 2 e 5, alternativa E. Não confunda com o valor da resistência: o sensor 1 tem a maior resistência, mas é o menos sensível.', 'média'),
('2025-D2-Q129', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 129, '5_alternativas', 'Biologia', 'Microbiologia e doenças', 'Esquistossomose e controle', null, null, 'O ácido úsnico é retirado de liquens e foi testado contra diversas espécies, conforme o quadro.

| Teste | Resultado |
|---|---|
| *Aedes aegypti* (larvas) | Baixa eficiência |
| Bacilo de Koch | Média eficiência |
| Moluscos aquáticos (adultos) | Alta eficiência |
| Pernilongo (larvas) | Média eficiência |
| Vermes platelmintos | Ineficiente |', 'O ácido úsnico mostrou-se mais indicado para o controle da', 'A', 'Procure no quadro o teste com alta eficiência e pense em qual doença depende desse ser vivo.', 'O ácido úsnico funciona bem contra moluscos aquáticos adultos. Qual doença tem um caramujo de água doce como hospedeiro intermediário?', 'O único resultado de alta eficiência foi contra moluscos aquáticos adultos. O caramujo *Biomphalaria* é hospedeiro intermediário do *Schistosoma mansoni*; eliminando o caramujo, interrompe-se o ciclo da esquistossomose, alternativa A. Repare que o ácido é ineficiente contra os vermes platelmintos, mas age sobre o hospedeiro. Contra o mosquito da dengue e da febre amarela teve baixa eficiência, e contra o bacilo da tuberculose, só média.', 'média'),
('2025-D2-Q130', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 130, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Associação de resistores', null, null, 'Em sua maioria, os equipamentos eletrônicos domésticos demandam baixa potência elétrica em corrente contínua. Para alimentá-los, uma fonte externa ou embutida transforma a corrente alternada em corrente contínua de baixa tensão. Entretanto, cada equipamento tem suas especificidades, e muitas vezes não é possível simplesmente trocar essas fontes sem levar em conta a tensão, a corrente ou a potência elétrica de saída.

Considere um equipamento de resistência elétrica $R_C$ que funciona corretamente apenas em um dado valor de tensão. Porém, a única fonte de alimentação disponível fornece uma tensão 20% superior à tensão recomendada. Para adaptar essa fonte ao aparelho, a associação de um resistor de proteção $R_P$, de potência adequada, se faz necessária.', 'A configuração adequada do circuito e o valor do resistor de proteção, em relação ao valor da resistência do equipamento, são:', 'E', 'Para dividir a tensão entre dois componentes, eles precisam estar em série. Em paralelo, os dois recebem a mesma tensão da fonte.', 'Se a fonte dá $1{,}2V$ e o equipamento precisa de $V$, o resistor de proteção deve ficar com $0{,}2V$. Em série a corrente é a mesma, então a tensão é proporcional à resistência.', 'Em paralelo o equipamento continuaria recebendo a tensão total da fonte, então o resistor deve ficar em série. A fonte fornece $1{,}2V$; o equipamento precisa de $V$, logo sobram $0{,}2V$ para $R_P$. Com a mesma corrente $i$: $\frac{R_P}{R_C} = \frac{0{,}2V}{V} = 0{,}2$, ou seja, $R_P = 0{,}2\,R_C$ em série, alternativa E. A alternativa C ($1{,}2\,R_C$) faria o equipamento receber menos da metade da tensão total.', 'média'),
('2025-D2-Q131', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 131, '5_alternativas', 'Química', 'Estequiometria', 'Reagente em excesso', null, null, 'O Brasil é o maior produtor mundial de nióbio (massa molar = 93 g mol⁻¹), metal utilizado na fabricação de vários tipos de aço: automotivos, estruturais e inoxidáveis. O processo utilizado na produção do nióbio é a redução aluminotérmica de Nb₂O₅ com excesso de 10% de Al (massa molar = 27 g mol⁻¹), em relação à quantidade estequiométrica da reação, representada pela equação química:

3 Nb₂O₅ (s) + 10 Al (s) → 6 Nb (s) + 5 Al₂O₃ (s)

Uma engenheira metalúrgica estimou a massa de alumínio necessária para produzir 9,3 kg de nióbio, nas condições descritas, para a produção de um lote de peças de aço encomendado por uma indústria, considerando um rendimento de 100%.

Fonte: Disponível em: www.cbmm.com.br. Acesso em: 17 out. 2015 (adaptado).', 'A massa de alumínio, em quilograma, estimada pela engenheira é mais próxima de', 'E', 'Transforme 9,3 kg de nióbio em mols e use a proporção da equação entre Al e Nb.', '9,3 kg de Nb são 100 mol. A equação dá 10 mol de Al para 6 mol de Nb. Não esqueça de somar os 10% de excesso no final.', 'Mols de Nb: $\frac{9300}{93} = 100$ mol. Pela equação, $n_{Al} = 100 \cdot \frac{10}{6} \approx 166{,}7$ mol, o que dá $166{,}7 \cdot 27 \approx 4500$ g $= 4{,}5$ kg (quantidade estequiométrica). Com 10% de excesso: $4{,}5 \cdot 1{,}1 \approx 4{,}95 \approx 5{,}0$ kg, alternativa E. A alternativa D (4,5 kg) esquece o excesso de alumínio.', 'média'),
('2025-D2-Q133', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 133, '5_alternativas', 'Química', 'Separação de misturas e materiais', 'Separação óleo-água', null, null, 'O despejo acidental de óleo nos oceanos tem ocasionado incontáveis prejuízos à vida marinha e à economia de regiões costeiras. Métodos tradicionais de tratamento do despejo geram resíduos de difícil descarte e nem sempre são eficazes. Por isso, pesquisadores desenvolveram um filtro capaz de separar óleo e água. O dispositivo é montado sobre uma malha de aço com uma sequência de camadas. A primeira camada é formada por um polímero de carga positiva, a segunda é composta por nanopartículas de sílica (SiO₂), a terceira é formada pelo mesmo polímero e a última é um surfactante, conforme apresentado na figura.

**Representação esquemática do dispositivo**

{{figura:1}}

Fonte: BROWN, P. S.; BHUSHAN, B. Mechanically durable, superoleophobic coatings prepared by layer-by-layer technique for anti-smudge and oil-water separation. **Scientific Reports**, v. 5, mar. 2015 (adaptado).', 'Na utilização desse dispositivo, a retenção do óleo ocorre', 'A', 'Veja qual camada fica por cima, em contato direto com a mistura de óleo e água, e do que ela é feita.', 'O surfactante tem cadeias cheias de flúor ($CF_2$, $CF_3$). Cadeias fluoradas repelem o óleo (são oleofóbicas), então o óleo nem chega às camadas de baixo.', 'A camada mais externa é o surfactante, com cadeias fluoradas que repelem o óleo. Por isso o óleo fica retido logo na superfície, no surfactante, enquanto a água consegue passar pelo filtro: alternativa A. As camadas de polímero e de sílica servem para prender o surfactante por atração entre cargas opostas, e a malha de aço é só o suporte.', 'difícil'),
('2025-D2-Q134', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 134, '5_alternativas', 'Química', 'Química geral e atomística', 'Polaridade e solubilidade', null, null, 'Alguns hormônios sexuais têm ganhado notável atenção nos últimos anos por suas concentrações cada vez maiores no solo e na água em todo o mundo. O motivo da preocupação é porque, em níveis poluentes, eles têm sido associados ao câncer de mama e ao câncer de próstata, além de perturbarem a fisiologia dos peixes, podendo, ainda, afetarem o desenvolvimento reprodutivo de animais domésticos e selvagens. Assim, o descarte inadequado desses hormônios representa uma séria ameaça ao solo, plantas, recursos hídricos e humanos. De baixa polaridade, eles apresentam uma solubilidade pequena e variável em água, dependendo dos grupos presentes em suas estruturas, representando um grande risco para os ambientes aquáticos. As figuras a seguir apresentam as estruturas de alguns desses hormônios.

{{figura:1}}

Fonte: MUHAMMAD, A. et al. Environmental Impact of Estrogens on Human, Animal and Plant Life: a Critical Review. **Environment International**, n. 99, 2017 (adaptado).', 'Do ponto de vista das interações químicas, qual desses hormônios apresenta maior solubilidade em ambientes aquáticos?', 'B', 'A água é muito polar. Procure nas estruturas os grupos que fazem ligações de hidrogênio com ela.', 'Os esqueletos dos cinco hormônios são parecidos e apolares. Conte quantos grupos $-OH$ cada um tem: quanto mais, maior a interação com a água.', 'Os hormônios têm o mesmo esqueleto de anéis, pouco polar; o que muda a solubilidade em água são os grupos polares. Os grupos $-OH$ fazem ligações de hidrogênio com a água, e o estriol tem três deles, mais do que qualquer outro: alternativa B. O estradiol e o novestrol têm dois OH, e a estrona e a noretindrona têm uma carbonila, que interage menos com a água do que um OH.', 'fácil'),
('2025-D2-Q135', 'enem', 'enem-CN', 'INEP', null, null, 'Médio', 2025, 135, '5_alternativas', 'Física', 'Ondulatória e som', 'Frequência e comprimento de onda', null, null, 'A icterícia é uma doença que acomete recém-nascidos e pode ser tratada com um método de fototerapia conhecido como banho de luz, que consiste na exposição do recém-nascido a uma fonte luminosa equipada com LEDs azuis. Para o monitoramento da dosagem dessa radiação, é utilizada a resposta óptica de um sensor constituído de materiais orgânicos que luminescem quando expostos à luz azul. Com o passar do tempo, essa radiação oxida os materiais do sensor, alterando sua coloração de vermelho-laranja para verde, o que indica o final do tratamento.

O gráfico apresenta o espectro de fotoluminescência do sensor em função do comprimento de onda da luz emitida no início do tratamento, quando o sensor, colado na fralda do bebê (Figura 1), luminesce na região do vermelho-laranja (∼600 nm). A Figura 2 apresenta a evolução da coloração do sensor, mostrando que a frequência da luz emitida por ele aumenta em função do tempo de exposição à luz azul.

{{figura:1}}

Fonte: SILVA, M. M. et al. Fabricação de sensor orgânico flexível para aplicação em terapia com luz azul. **Tecnol. Metal. Mater. Miner.**, n. 3, jul.-set. 2011 (adaptado).', 'Os espectros de fotoluminescência do sensor no início e no final do tratamento estão esboçados no gráfico:', 'A', 'No fim do tratamento o sensor fica verde. Pense em como o pico do espectro deve se mover no eixo do comprimento de onda.', 'Frequência maior significa comprimento de onda menor ($c = \lambda f$). O verde fica por volta de 550 nm, à esquerda do vermelho-laranja de 600 nm.', 'No início, o pico de emissão está em cerca de 600 nm (vermelho-laranja). Com o tempo, a frequência da luz emitida aumenta e a cor vai para o verde; como $\lambda = c/f$, o comprimento de onda diminui. Assim, o pico do final deve ficar deslocado para a esquerda, perto de 550 nm, como no gráfico A. O gráfico B desloca o pico para comprimentos maiores (frequência menor), e C, D e E mantêm o pico em 600 nm, o que não mudaria a cor.', 'média')
on conflict (id) do update set exame_id = excluded.exame_id, recorte_id = excluded.recorte_id, banca = excluded.banca, orgao = excluded.orgao, cargo = excluded.cargo, nivel = excluded.nivel, ano = excluded.ano, numero = excluded.numero, formato = excluded.formato, disciplina = excluded.disciplina, assunto = excluded.assunto, topico = excluded.topico, lingua = excluded.lingua, texto_base_id = excluded.texto_base_id, texto_apoio = excluded.texto_apoio, comando = excluded.comando, gabarito = excluded.gabarito, dica1 = excluded.dica1, dica2 = excluded.dica2, explicacao = excluded.explicacao, dificuldade = excluded.dificuldade;
delete from public.alternativas where questao_id in ('2024-D2-Q091', '2024-D2-Q092', '2024-D2-Q093', '2024-D2-Q094', '2024-D2-Q095', '2024-D2-Q096', '2024-D2-Q097', '2024-D2-Q098', '2024-D2-Q099', '2024-D2-Q100', '2024-D2-Q101', '2024-D2-Q102', '2024-D2-Q103', '2024-D2-Q104', '2024-D2-Q105', '2024-D2-Q106', '2024-D2-Q107', '2024-D2-Q108', '2024-D2-Q109', '2024-D2-Q110', '2024-D2-Q111', '2024-D2-Q112', '2024-D2-Q113', '2024-D2-Q114', '2024-D2-Q115', '2024-D2-Q116', '2024-D2-Q117', '2024-D2-Q118', '2024-D2-Q119', '2024-D2-Q120', '2024-D2-Q121', '2024-D2-Q122', '2024-D2-Q123', '2024-D2-Q124', '2024-D2-Q125', '2024-D2-Q126', '2024-D2-Q127', '2024-D2-Q128', '2024-D2-Q130', '2024-D2-Q131', '2024-D2-Q132', '2024-D2-Q133', '2024-D2-Q134', '2024-D2-Q135', '2025-D2-Q091', '2025-D2-Q092', '2025-D2-Q093', '2025-D2-Q094', '2025-D2-Q095', '2025-D2-Q096', '2025-D2-Q097', '2025-D2-Q098', '2025-D2-Q099', '2025-D2-Q100', '2025-D2-Q101', '2025-D2-Q102', '2025-D2-Q103', '2025-D2-Q104', '2025-D2-Q105', '2025-D2-Q106', '2025-D2-Q107', '2025-D2-Q108', '2025-D2-Q109', '2025-D2-Q110', '2025-D2-Q111', '2025-D2-Q112', '2025-D2-Q113', '2025-D2-Q114', '2025-D2-Q115', '2025-D2-Q116', '2025-D2-Q117', '2025-D2-Q118', '2025-D2-Q119', '2025-D2-Q120', '2025-D2-Q121', '2025-D2-Q122', '2025-D2-Q124', '2025-D2-Q125', '2025-D2-Q126', '2025-D2-Q127', '2025-D2-Q128', '2025-D2-Q129', '2025-D2-Q130', '2025-D2-Q131', '2025-D2-Q133', '2025-D2-Q134', '2025-D2-Q135');
insert into public.alternativas (questao_id, letra, texto, imagem) values
('2024-D2-Q091', 'A', 'aciona os airbags do veículo.', null),
('2024-D2-Q091', 'B', 'absorve a energia cinética do sistema.', null),
('2024-D2-Q091', 'C', 'consome a quantidade de movimento do sistema.', null),
('2024-D2-Q091', 'D', 'cria uma barreira de proteção para seus ocupantes.', null),
('2024-D2-Q091', 'E', 'diminui a velocidade do centro de massa do sistema.', null),
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
('2024-D2-Q095', 'A', 'expressos.', null),
('2024-D2-Q095', 'B', 'plasmidiais.', null),
('2024-D2-Q095', 'C', 'bacterianos.', null),
('2024-D2-Q095', 'D', 'dominantes.', null),
('2024-D2-Q095', 'E', 'autossômicos.', null),
('2024-D2-Q096', 'A', '1', null),
('2024-D2-Q096', 'B', '2', null),
('2024-D2-Q096', 'C', '3', null),
('2024-D2-Q096', 'D', '4', null),
('2024-D2-Q096', 'E', '5', null),
('2024-D2-Q097', 'A', '0,7 g', null),
('2024-D2-Q097', 'B', '1,8 g', null),
('2024-D2-Q097', 'C', '2,8 g', null),
('2024-D2-Q097', 'D', '3,6 g', null),
('2024-D2-Q097', 'E', '7,0 g', null),
('2024-D2-Q098', 'A', 'aumento no número de descendentes por ninhada.', null),
('2024-D2-Q098', 'B', 'mudança no tipo de fecundação de externa para interna.', null),
('2024-D2-Q098', 'C', 'redução da versatilidade de reprodução, que se torna unicamente sexuada.', null),
('2024-D2-Q098', 'D', 'desenvolvimento embrionário, que passa do meio aquático para o terrestre.', null),
('2024-D2-Q098', 'E', 'diminuição da vesícula vitelínica, associada ao desenvolvimento da lactação.', null),
('2024-D2-Q099', 'A', 'Mais grave do que o som emitido e $f_r < f_0$.', null),
('2024-D2-Q099', 'B', 'Mais agudo do que o som emitido e $f_r < f_0$.', null),
('2024-D2-Q099', 'C', 'Mais agudo do que o som emitido e $f_r = f_0$.', null),
('2024-D2-Q099', 'D', 'Mais agudo do que o som emitido e $f_r > f_0$.', null),
('2024-D2-Q099', 'E', 'Mais grave do que o som emitido e $f_r > f_0$.', null),
('2024-D2-Q100', 'A', 'real e 5 cm.', null),
('2024-D2-Q100', 'B', 'real e 3,8 cm.', null),
('2024-D2-Q100', 'C', 'real e 7,6 cm.', null),
('2024-D2-Q100', 'D', 'virtual e 7,6 cm.', null),
('2024-D2-Q100', 'E', 'virtual e 3,8 cm.', null),
('2024-D2-Q101', 'A', '3,0 m.', null),
('2024-D2-Q101', 'B', '4,5 m.', null),
('2024-D2-Q101', 'C', '6,5 m.', null),
('2024-D2-Q101', 'D', '8,0 m.', null),
('2024-D2-Q101', 'E', '9,5 m.', null),
('2024-D2-Q102', 'A', 'desnaturação enzimática pela alta temperatura.', null),
('2024-D2-Q102', 'B', 'conversão de nutrientes pela redução de temperatura.', null),
('2024-D2-Q102', 'C', 'degradação das reservas nutritivas pelo choque térmico.', null),
('2024-D2-Q102', 'D', 'impedimento da entrada de oxigênio pela fervura da água.', null),
('2024-D2-Q102', 'E', 'desidratação dos grãos por causa da alteração da temperatura.', null),
('2024-D2-Q103', 'A', 'difusão.', null),
('2024-D2-Q103', 'B', 'absorção.', null),
('2024-D2-Q103', 'C', 'condução.', null),
('2024-D2-Q103', 'D', 'irradiação.', null),
('2024-D2-Q103', 'E', 'convecção.', null),
('2024-D2-Q104', 'A', 'Disseminando verminoses.', null),
('2024-D2-Q104', 'B', 'Causando a eutrofização de lagoas.', null),
('2024-D2-Q104', 'C', 'Aumentando a chance de contato com coliformes.', null),
('2024-D2-Q104', 'D', 'Diminuindo a população de predadores aquáticos.', null),
('2024-D2-Q104', 'E', 'Aproximando as pessoas das áreas de ocorrência de mosquitos.', null),
('2024-D2-Q105', 'A', 'ósseo.', null),
('2024-D2-Q105', 'B', 'nervoso.', null),
('2024-D2-Q105', 'C', 'epitelial.', null),
('2024-D2-Q105', 'D', 'adiposo.', null),
('2024-D2-Q105', 'E', 'sanguíneo.', null),
('2024-D2-Q106', 'A', 'Os raios X não interagem com os componentes metálicos do computador, o que impede a formação de imagens.', null),
('2024-D2-Q106', 'B', 'Os raios X desmagnetizam o disco rígido do computador, quando refratados pelos componentes metálicos das bagagens de mão.', null),
('2024-D2-Q106', 'C', 'Os raios X aquecem os materiais metálicos encontrados em bagagens de mão, quando refletidos pelos componentes do computador.', null),
('2024-D2-Q106', 'D', 'Os raios X não atravessam os componentes densos do computador, o que impede a visualização de objetos que estão à frente ou atrás deles.', null),
('2024-D2-Q106', 'E', 'Os raios X ionizam os materiais metálicos normalmente encontrados em bagagens de mão, quando difratados pelos componentes do computador.', null),
('2024-D2-Q107', 'A', 'Rim.', null),
('2024-D2-Q107', 'B', 'Fígado.', null),
('2024-D2-Q107', 'C', 'Intestino.', null),
('2024-D2-Q107', 'D', 'Pâncreas.', null),
('2024-D2-Q107', 'E', 'Estômago.', null),
('2024-D2-Q108', 'A', 'rotação de culturas.', null),
('2024-D2-Q108', 'B', 'sucessão ecológica.', null),
('2024-D2-Q108', 'C', 'coevolução específica.', null),
('2024-D2-Q108', 'D', 'adaptação por seleção.', null),
('2024-D2-Q108', 'E', 'convergência adaptativa.', null),
('2024-D2-Q109', 'A', 'Triatlo.', null),
('2024-D2-Q109', 'B', 'Salto em altura.', null),
('2024-D2-Q109', 'C', 'Marcha atlética.', null),
('2024-D2-Q109', 'D', 'Maratona aquática.', null),
('2024-D2-Q109', 'E', 'Ciclismo em estrada.', null),
('2024-D2-Q110', 'A', 'Facilita a captura de presas.', null),
('2024-D2-Q110', 'B', 'Diminui a competição por recursos.', null),
('2024-D2-Q110', 'C', 'Possibilita a geração de indivíduos híbridos.', null),
('2024-D2-Q110', 'D', 'Reduz a possibilidade de sofrerem predação.', null),
('2024-D2-Q110', 'E', 'Otimiza o encontro de parceiros reprodutivos.', null),
('2024-D2-Q111', 'A', 'formado somente na fase adulta do animal.', null),
('2024-D2-Q111', 'B', 'fragmentado para expansão nas áreas de articulação.', null),
('2024-D2-Q111', 'C', 'modelado continuamente para ajuste ao tamanho do corpo.', null),
('2024-D2-Q111', 'D', 'substituído por meio de mudas que ocorrem periodicamente.', null),
('2024-D2-Q111', 'E', 'impregnado por pequena quantidade de sais para sua distensão.', null),
('2024-D2-Q112', 'A', null, 'imagens/2024/D2/q112_alt_A.webp'),
('2024-D2-Q112', 'B', null, 'imagens/2024/D2/q112_alt_B.webp'),
('2024-D2-Q112', 'C', null, 'imagens/2024/D2/q112_alt_C.webp'),
('2024-D2-Q112', 'D', null, 'imagens/2024/D2/q112_alt_D.webp'),
('2024-D2-Q112', 'E', null, 'imagens/2024/D2/q112_alt_E.webp'),
('2024-D2-Q113', 'A', '1', null),
('2024-D2-Q113', 'B', '2', null),
('2024-D2-Q113', 'C', '3', null),
('2024-D2-Q113', 'D', '4', null),
('2024-D2-Q113', 'E', '5', null),
('2024-D2-Q114', 'A', 'baixa de O₂ e alta de NO.', null),
('2024-D2-Q114', 'B', 'baixa de NO e alta de HC.', null),
('2024-D2-Q114', 'C', 'baixa de CO e alta de CO₂.', null),
('2024-D2-Q114', 'D', 'baixa de HC e alta de CO.', null),
('2024-D2-Q114', 'E', 'baixa de CO₂ e alta de HC.', null),
('2024-D2-Q115', 'A', 'Vacúolos.', null),
('2024-D2-Q115', 'B', 'Mitocôndrias.', null),
('2024-D2-Q115', 'C', 'Microfilamentos.', null),
('2024-D2-Q115', 'D', 'Material genético.', null),
('2024-D2-Q115', 'E', 'Membrana plasmática.', null),
('2024-D2-Q116', 'A', 'filtração.', null),
('2024-D2-Q116', 'B', 'catação.', null),
('2024-D2-Q116', 'C', 'destilação.', null),
('2024-D2-Q116', 'D', 'dissolução.', null),
('2024-D2-Q116', 'E', 'evaporação.', null),
('2024-D2-Q117', 'A', 'indicam que estão fora de seu hábitat natural.', null),
('2024-D2-Q117', 'B', 'alertam para a presença de poluição urbana.', null),
('2024-D2-Q117', 'C', 'sinalizam a existência de superpopulação.', null),
('2024-D2-Q117', 'D', 'direcionam insetos para sua alimentação.', null),
('2024-D2-Q117', 'E', 'atraem fêmeas para o acasalamento.', null),
('2024-D2-Q118', 'A', 'I', null),
('2024-D2-Q118', 'B', 'II', null),
('2024-D2-Q118', 'C', 'III', null),
('2024-D2-Q118', 'D', 'IV', null),
('2024-D2-Q118', 'E', 'V', null),
('2024-D2-Q119', 'A', '42', null),
('2024-D2-Q119', 'B', '65', null),
('2024-D2-Q119', 'C', '72', null),
('2024-D2-Q119', 'D', '105', null),
('2024-D2-Q119', 'E', '120', null),
('2024-D2-Q120', 'A', 'aids.', null),
('2024-D2-Q120', 'B', 'câncer.', null),
('2024-D2-Q120', 'C', 'diabetes.', null),
('2024-D2-Q120', 'D', 'hepatite B.', null),
('2024-D2-Q120', 'E', 'hemorragia.', null),
('2024-D2-Q121', 'A', null, 'imagens/2024/D2/q121_alt_A.webp'),
('2024-D2-Q121', 'B', null, 'imagens/2024/D2/q121_alt_B.webp'),
('2024-D2-Q121', 'C', null, 'imagens/2024/D2/q121_alt_C.webp'),
('2024-D2-Q121', 'D', null, 'imagens/2024/D2/q121_alt_D.webp'),
('2024-D2-Q121', 'E', null, 'imagens/2024/D2/q121_alt_E.webp'),
('2024-D2-Q122', 'A', 'a temperatura interna do iglu é maior que a de solidificação da água.', null),
('2024-D2-Q122', 'B', 'a umidade dentro do iglu dificulta o processo de mudança de fase da água.', null),
('2024-D2-Q122', 'C', 'o ar dentro do iglu é isolante térmico, dificultando a perda de calor pela água.', null),
('2024-D2-Q122', 'D', 'a temperatura uniforme no interior do iglu impede as correntes de convecção.', null),
('2024-D2-Q122', 'E', 'a pressão do ar no interior do iglu é baixa, dificultando a solidificação da água.', null),
('2024-D2-Q123', 'A', 'Ácido carboxílico.', null),
('2024-D2-Q123', 'B', 'Cetona.', null),
('2024-D2-Q123', 'C', 'Alceno.', null),
('2024-D2-Q123', 'D', 'Álcool.', null),
('2024-D2-Q123', 'E', 'Fenol.', null),
('2024-D2-Q124', 'A', 'anaeróbio facultativo, anaeróbio estrito e aeróbio estrito.', null),
('2024-D2-Q124', 'B', 'anaeróbio facultativo, aeróbio estrito e anaeróbio estrito.', null),
('2024-D2-Q124', 'C', 'aeróbio estrito, anaeróbio estrito e anaeróbio facultativo.', null),
('2024-D2-Q124', 'D', 'anaeróbio estrito, aeróbio estrito e anaeróbio facultativo.', null),
('2024-D2-Q124', 'E', 'aeróbio estrito, anaeróbio facultativo e anaeróbio estrito.', null),
('2024-D2-Q125', 'A', 'colisões interatômicas.', null),
('2024-D2-Q125', 'B', 'coloração dos átomos.', null),
('2024-D2-Q125', 'C', 'transições eletrônicas.', null),
('2024-D2-Q125', 'D', 'reações nucleares.', null),
('2024-D2-Q125', 'E', 'reflexão da luz.', null),
('2024-D2-Q126', 'A', 'produção de anticorpos específicos contra os vírus.', null),
('2024-D2-Q126', 'B', 'imunidade passiva contra o desenvolvimento da doença.', null),
('2024-D2-Q126', 'C', 'alteração genômica para formação da memória imunológica.', null),
('2024-D2-Q126', 'D', 'neutralização direta dos vírus presentes na circulação sanguínea.', null),
('2024-D2-Q126', 'E', 'modificação dos receptores de membrana específicos para o vírus.', null),
('2024-D2-Q127', 'A', null, 'imagens/2024/D2/q127_alt_A.webp'),
('2024-D2-Q127', 'B', null, 'imagens/2024/D2/q127_alt_B.webp'),
('2024-D2-Q127', 'C', null, 'imagens/2024/D2/q127_alt_C.webp'),
('2024-D2-Q127', 'D', null, 'imagens/2024/D2/q127_alt_D.webp'),
('2024-D2-Q127', 'E', null, 'imagens/2024/D2/q127_alt_E.webp'),
('2024-D2-Q128', 'A', 'oxida os cátions dissolvidos na água da chuva.', null),
('2024-D2-Q128', 'B', 'impede a difusão da água através das placas solares.', null),
('2024-D2-Q128', 'C', 'diminui a energia de ativação da reação no pseudocapacitor.', null),
('2024-D2-Q128', 'D', 'forma um compósito não metálico com os íons na água da chuva.', null),
('2024-D2-Q128', 'E', 'gera uma diferença de potencial pela interação dos elétrons com os cátions.', null),
('2024-D2-Q130', 'A', 'II.', null),
('2024-D2-Q130', 'B', 'III.', null),
('2024-D2-Q130', 'C', 'IV.', null),
('2024-D2-Q130', 'D', 'V.', null),
('2024-D2-Q130', 'E', 'VI.', null),
('2024-D2-Q131', 'A', null, 'imagens/2024/D2/q131_alt_A.webp'),
('2024-D2-Q131', 'B', null, 'imagens/2024/D2/q131_alt_B.webp'),
('2024-D2-Q131', 'C', null, 'imagens/2024/D2/q131_alt_C.webp'),
('2024-D2-Q131', 'D', null, 'imagens/2024/D2/q131_alt_D.webp'),
('2024-D2-Q131', 'E', null, 'imagens/2024/D2/q131_alt_E.webp'),
('2024-D2-Q132', 'A', 'A', null),
('2024-D2-Q132', 'B', 'B', null),
('2024-D2-Q132', 'C', 'C', null),
('2024-D2-Q132', 'D', 'D', null),
('2024-D2-Q132', 'E', 'E', null),
('2024-D2-Q133', 'A', '300 g.', null),
('2024-D2-Q133', 'B', '400 g.', null),
('2024-D2-Q133', 'C', '510 g.', null),
('2024-D2-Q133', 'D', '590 g.', null),
('2024-D2-Q133', 'E', '720 g.', null),
('2024-D2-Q134', 'A', 'fitoestabilização, ficando o mercúrio disponível sob a superfície das raízes das plantas.', null),
('2024-D2-Q134', 'B', 'fitovolatilização, permitindo a retirada do mercúrio por plantas e a sua transferência para uma forma volátil.', null),
('2024-D2-Q134', 'C', 'fitodegradação, com a degradação do mercúrio promovida por enzimas, contidas nas raízes, formando espécies menos tóxicas.', null),
('2024-D2-Q134', 'D', 'fitoestimulação, com a remoção do mercúrio pela ação de microrganismos presentes nas raízes que absorvem e imobilizam o metal.', null),
('2024-D2-Q134', 'E', 'fitoextração, em que as plantas que acumulam o mercúrio são cultivadas nesses locais, e a biomassa rica no metal é retirada após o crescimento.', null),
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
('2025-D2-Q092', 'A', 'metabolismo de *E. coli*, apenas.', null),
('2025-D2-Q092', 'B', 'ciclo circadiano de *E. coli*, apenas.', null),
('2025-D2-Q092', 'C', 'metabolismo de *S. elongatus* e do ciclo circadiano de *E. coli*.', null),
('2025-D2-Q092', 'D', 'ciclo circadiano de *S. elongatus* e do metabolismo de *E. coli*.', null),
('2025-D2-Q092', 'E', 'ciclo circadiano de *S. elongatus* e do ciclo circadiano de *E. coli*.', null),
('2025-D2-Q093', 'A', 'dilatação do papo.', null),
('2025-D2-Q093', 'B', 'reposição de penas das asas.', null),
('2025-D2-Q093', 'C', 'secreção da glândula uropigial.', null),
('2025-D2-Q093', 'D', 'formação da membrana natatória.', null),
('2025-D2-Q093', 'E', 'largura das cavidades de ossos pneumáticos.', null),
('2025-D2-Q094', 'A', '4', null),
('2025-D2-Q094', 'B', '3', null),
('2025-D2-Q094', 'C', '2', null),
('2025-D2-Q094', 'D', '1', null),
('2025-D2-Q094', 'E', '0', null),
('2025-D2-Q095', 'A', 'reflexão.', null),
('2025-D2-Q095', 'B', 'refração.', null),
('2025-D2-Q095', 'C', 'irradiação.', null),
('2025-D2-Q095', 'D', 'dispersão.', null),
('2025-D2-Q095', 'E', 'convecção.', null),
('2025-D2-Q096', 'A', 'diferença de umidade entre os ambientes.', null),
('2025-D2-Q096', 'B', 'ausência de alimentação natural.', null),
('2025-D2-Q096', 'C', 'adaptação ao novo ambiente.', null),
('2025-D2-Q096', 'D', 'mudança de comportamento.', null),
('2025-D2-Q096', 'E', 'variabilidade genética.', null),
('2025-D2-Q097', 'A', 'mata o vírus pela ligação.', null),
('2025-D2-Q097', 'B', 'aglutina o vírus por associação.', null),
('2025-D2-Q097', 'C', 'contém imunoglobulinas de defesa.', null),
('2025-D2-Q097', 'D', 'induz a produção de proteínas neutralizadoras.', null),
('2025-D2-Q097', 'E', 'mantém a quantidade de anticorpos preexistentes.', null),
('2025-D2-Q098', 'A', 'Diversificar nichos ecológicos.', null),
('2025-D2-Q098', 'B', 'Assorear as nascentes do bioma.', null),
('2025-D2-Q098', 'C', 'Dificultar a infiltração de água na terra.', null),
('2025-D2-Q098', 'D', 'Diminuir as espécies nativas do bioma.', null),
('2025-D2-Q098', 'E', 'Contribuir com a redução das queimadas.', null),
('2025-D2-Q099', 'A', 'Cerrado.', null),
('2025-D2-Q099', 'B', 'Pampas.', null),
('2025-D2-Q099', 'C', 'Caatinga.', null),
('2025-D2-Q099', 'D', 'Restinga.', null),
('2025-D2-Q099', 'E', 'Pantanal.', null),
('2025-D2-Q100', 'A', 'dura.', null),
('2025-D2-Q100', 'B', 'pesada.', null),
('2025-D2-Q100', 'C', 'sanitária.', null),
('2025-D2-Q100', 'D', 'destilada.', null),
('2025-D2-Q100', 'E', 'oxigenada.', null),
('2025-D2-Q101', 'A', 'dilatada, chega mais luz à retina.', null),
('2025-D2-Q101', 'B', 'retraída, chega mais luz vermelha à retina.', null),
('2025-D2-Q101', 'C', 'retraída, chega mais luz vermelha aos bastonetes.', null),
('2025-D2-Q101', 'D', 'retraída, chegam menos luzes azul e verde aos cones.', null),
('2025-D2-Q101', 'E', 'dilatada, chegam menos luzes azul e verde aos bastonetes.', null),
('2025-D2-Q102', 'A', 'Criar os peixes em cativeiro.', null),
('2025-D2-Q102', 'B', 'Realizar a pesca com redes.', null),
('2025-D2-Q102', 'C', 'Consumir peixes cozidos ou fritos.', null),
('2025-D2-Q102', 'D', 'Preparar o peixe em condições adequadas de higiene.', null),
('2025-D2-Q102', 'E', 'Manusear o peixe sem provocar o rompimento dos órgãos internos.', null),
('2025-D2-Q103', 'A', 'Lisossomos.', null),
('2025-D2-Q103', 'B', 'Ribossomos.', null),
('2025-D2-Q103', 'C', 'Mitocôndrias.', null),
('2025-D2-Q103', 'D', 'Peroxissomos.', null),
('2025-D2-Q103', 'E', 'Retículo endoplasmático liso.', null),
('2025-D2-Q104', 'A', 'Plantar mais árvores.', null),
('2025-D2-Q104', 'B', 'Instalar mais usinas eólicas.', null),
('2025-D2-Q104', 'C', 'Ampliar o uso de energia solar.', null),
('2025-D2-Q104', 'D', 'Manter os combustíveis fósseis no solo.', null),
('2025-D2-Q104', 'E', 'Produzir menos resíduos sólidos urbanos.', null),
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
('2025-D2-Q107', 'A', null, 'imagens/2025/D2/q107_alt_A.webp'),
('2025-D2-Q107', 'B', null, 'imagens/2025/D2/q107_alt_B.webp'),
('2025-D2-Q107', 'C', null, 'imagens/2025/D2/q107_alt_C.webp'),
('2025-D2-Q107', 'D', null, 'imagens/2025/D2/q107_alt_D.webp'),
('2025-D2-Q107', 'E', null, 'imagens/2025/D2/q107_alt_E.webp'),
('2025-D2-Q108', 'A', null, 'imagens/2025/D2/q108_alt_A.webp'),
('2025-D2-Q108', 'B', null, 'imagens/2025/D2/q108_alt_B.webp'),
('2025-D2-Q108', 'C', null, 'imagens/2025/D2/q108_alt_C.webp'),
('2025-D2-Q108', 'D', null, 'imagens/2025/D2/q108_alt_D.webp'),
('2025-D2-Q108', 'E', null, 'imagens/2025/D2/q108_alt_E.webp'),
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
('2025-D2-Q111', 'A', 'bioacumulação de toxinas em plantas.', null),
('2025-D2-Q111', 'B', 'eutrofização dos corpos de água.', null),
('2025-D2-Q111', 'C', 'destruição da camada de ozônio.', null),
('2025-D2-Q111', 'D', 'ocorrência de inversão térmica.', null),
('2025-D2-Q111', 'E', 'produção de chuva ácida.', null),
('2025-D2-Q112', 'A', 'Hemofilia.', null),
('2025-D2-Q112', 'B', 'Escorbuto.', null),
('2025-D2-Q112', 'C', 'Raquitismo.', null),
('2025-D2-Q112', 'D', 'Cegueira noturna.', null),
('2025-D2-Q112', 'E', 'Anemia perniciosa.', null),
('2025-D2-Q113', 'A', '1', null),
('2025-D2-Q113', 'B', '2', null),
('2025-D2-Q113', 'C', '3', null),
('2025-D2-Q113', 'D', '4', null),
('2025-D2-Q113', 'E', '5', null),
('2025-D2-Q114', 'A', 'reflexão e comprimento de onda.', null),
('2025-D2-Q114', 'B', 'ressonância e frequência.', null),
('2025-D2-Q114', 'C', 'interferência e velocidade.', null),
('2025-D2-Q114', 'D', 'ressonância e timbre.', null),
('2025-D2-Q114', 'E', 'reflexão e amplitude.', null),
('2025-D2-Q115', 'A', 'C₉H₁₆O', null),
('2025-D2-Q115', 'B', 'C₉H₁₇O', null),
('2025-D2-Q115', 'C', 'C₁₀H₁₆O', null),
('2025-D2-Q115', 'D', 'C₁₀H₁₆O₂', null),
('2025-D2-Q115', 'E', 'C₁₀H₁₈O₂', null),
('2025-D2-Q116', 'A', 'exóticas.', null),
('2025-D2-Q116', 'B', 'migratórias.', null),
('2025-D2-Q116', 'C', 'endêmicas.', null),
('2025-D2-Q116', 'D', 'dominantes.', null),
('2025-D2-Q116', 'E', 'generalistas.', null),
('2025-D2-Q117', 'A', 'Aumentando a pressão total do sistema.', null),
('2025-D2-Q117', 'B', 'Diminuindo a temperatura do sistema.', null),
('2025-D2-Q117', 'C', 'Aumentando a pressão parcial de O₂.', null),
('2025-D2-Q117', 'D', 'Aumentando a pressão parcial de Cl₂.', null),
('2025-D2-Q117', 'E', 'Variando a quantidade de TiO₂.', null),
('2025-D2-Q118', 'A', '0,16 m.', null),
('2025-D2-Q118', 'B', '0,50 m.', null),
('2025-D2-Q118', 'C', '0,80 m.', null),
('2025-D2-Q118', 'D', '1,60 m.', null),
('2025-D2-Q118', 'E', '8,00 m.', null),
('2025-D2-Q119', 'A', null, 'imagens/2025/D2/q119_alt_A.webp'),
('2025-D2-Q119', 'B', null, 'imagens/2025/D2/q119_alt_B.webp'),
('2025-D2-Q119', 'C', null, 'imagens/2025/D2/q119_alt_C.webp'),
('2025-D2-Q119', 'D', null, 'imagens/2025/D2/q119_alt_D.webp'),
('2025-D2-Q119', 'E', null, 'imagens/2025/D2/q119_alt_E.webp'),
('2025-D2-Q120', 'A', '30 ms.', null),
('2025-D2-Q120', 'B', '70 ms.', null),
('2025-D2-Q120', 'C', '300 ms.', null),
('2025-D2-Q120', 'D', '400 ms.', null),
('2025-D2-Q120', 'E', '700 ms.', null),
('2025-D2-Q121', 'A', 'água.', null),
('2025-D2-Q121', 'B', 'vinagre.', null),
('2025-D2-Q121', 'C', 'óleo de soja.', null),
('2025-D2-Q121', 'D', 'sal de cozinha.', null),
('2025-D2-Q121', 'E', 'bicarbonato de sódio.', null),
('2025-D2-Q122', 'A', 'imantar o material da panela por indução.', null),
('2025-D2-Q122', 'B', 'movimentar os átomos de ferro concentrados no fundo da panela.', null),
('2025-D2-Q122', 'C', 'emitir radiação eletromagnética, aquecendo a panela através do vidro cerâmico.', null),
('2025-D2-Q122', 'D', 'induzir corrente elétrica na parte inferior da panela, aquecendo-a por efeito Joule.', null),
('2025-D2-Q122', 'E', 'gerar um fluxo de corrente de convecção no ar contido entre a região da bobina e o vidro cerâmico.', null),
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
('2025-D2-Q126', 'A', '230 km/h para Leste, 180 km/h para Sul e 9 km/h para baixo.', null),
('2025-D2-Q126', 'B', '230 km/h para Leste, 180 km/h para Norte e 9 km/h para cima.', null),
('2025-D2-Q126', 'C', '200 km/h para Oeste, 200 km/h para Norte e 10 km/h para cima.', null),
('2025-D2-Q126', 'D', '170 km/h para Leste, 220 km/h para Norte e 11 km/h para cima.', null),
('2025-D2-Q126', 'E', '170 km/h para Leste, 180 km/h para Norte e 11 km/h para cima.', null),
('2025-D2-Q127', 'A', null, 'imagens/2025/D2/q127_alt_A.webp'),
('2025-D2-Q127', 'B', null, 'imagens/2025/D2/q127_alt_B.webp'),
('2025-D2-Q127', 'C', null, 'imagens/2025/D2/q127_alt_C.webp'),
('2025-D2-Q127', 'D', null, 'imagens/2025/D2/q127_alt_D.webp'),
('2025-D2-Q127', 'E', null, 'imagens/2025/D2/q127_alt_E.webp'),
('2025-D2-Q128', 'A', '1 e 2.', null),
('2025-D2-Q128', 'B', '1 e 3.', null),
('2025-D2-Q128', 'C', '2 e 3.', null),
('2025-D2-Q128', 'D', '2 e 4.', null),
('2025-D2-Q128', 'E', '2 e 5.', null),
('2025-D2-Q129', 'A', 'esquistossomose.', null),
('2025-D2-Q129', 'B', 'febre amarela.', null),
('2025-D2-Q129', 'C', 'coqueluche.', null),
('2025-D2-Q129', 'D', 'tuberculose.', null),
('2025-D2-Q129', 'E', 'dengue.', null),
('2025-D2-Q130', 'A', null, 'imagens/2025/D2/q130_alt_A.webp'),
('2025-D2-Q130', 'B', null, 'imagens/2025/D2/q130_alt_B.webp'),
('2025-D2-Q130', 'C', null, 'imagens/2025/D2/q130_alt_C.webp'),
('2025-D2-Q130', 'D', null, 'imagens/2025/D2/q130_alt_D.webp'),
('2025-D2-Q130', 'E', null, 'imagens/2025/D2/q130_alt_E.webp'),
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
('2025-D2-Q134', 'E', 'Noretindrona.', null),
('2025-D2-Q135', 'A', null, 'imagens/2025/D2/q135_alt_A.webp'),
('2025-D2-Q135', 'B', null, 'imagens/2025/D2/q135_alt_B.webp'),
('2025-D2-Q135', 'C', null, 'imagens/2025/D2/q135_alt_C.webp'),
('2025-D2-Q135', 'D', null, 'imagens/2025/D2/q135_alt_D.webp'),
('2025-D2-Q135', 'E', null, 'imagens/2025/D2/q135_alt_E.webp');
delete from public.questao_figuras where questao_id in ('2024-D2-Q091', '2024-D2-Q092', '2024-D2-Q093', '2024-D2-Q094', '2024-D2-Q095', '2024-D2-Q096', '2024-D2-Q097', '2024-D2-Q098', '2024-D2-Q099', '2024-D2-Q100', '2024-D2-Q101', '2024-D2-Q102', '2024-D2-Q103', '2024-D2-Q104', '2024-D2-Q105', '2024-D2-Q106', '2024-D2-Q107', '2024-D2-Q108', '2024-D2-Q109', '2024-D2-Q110', '2024-D2-Q111', '2024-D2-Q112', '2024-D2-Q113', '2024-D2-Q114', '2024-D2-Q115', '2024-D2-Q116', '2024-D2-Q117', '2024-D2-Q118', '2024-D2-Q119', '2024-D2-Q120', '2024-D2-Q121', '2024-D2-Q122', '2024-D2-Q123', '2024-D2-Q124', '2024-D2-Q125', '2024-D2-Q126', '2024-D2-Q127', '2024-D2-Q128', '2024-D2-Q130', '2024-D2-Q131', '2024-D2-Q132', '2024-D2-Q133', '2024-D2-Q134', '2024-D2-Q135', '2025-D2-Q091', '2025-D2-Q092', '2025-D2-Q093', '2025-D2-Q094', '2025-D2-Q095', '2025-D2-Q096', '2025-D2-Q097', '2025-D2-Q098', '2025-D2-Q099', '2025-D2-Q100', '2025-D2-Q101', '2025-D2-Q102', '2025-D2-Q103', '2025-D2-Q104', '2025-D2-Q105', '2025-D2-Q106', '2025-D2-Q107', '2025-D2-Q108', '2025-D2-Q109', '2025-D2-Q110', '2025-D2-Q111', '2025-D2-Q112', '2025-D2-Q113', '2025-D2-Q114', '2025-D2-Q115', '2025-D2-Q116', '2025-D2-Q117', '2025-D2-Q118', '2025-D2-Q119', '2025-D2-Q120', '2025-D2-Q121', '2025-D2-Q122', '2025-D2-Q124', '2025-D2-Q125', '2025-D2-Q126', '2025-D2-Q127', '2025-D2-Q128', '2025-D2-Q129', '2025-D2-Q130', '2025-D2-Q131', '2025-D2-Q133', '2025-D2-Q134', '2025-D2-Q135');
insert into public.questao_figuras (questao_id, ordem, imagem, descricao) values
('2024-D2-Q091', 1, 'imagens/2024/D2/q091_fig1.webp', 'Ilustração de um carro em corte lateral colidindo de frente contra um muro listrado de vermelho e branco, com a parte dianteira amassada. Dois bonecos de teste (manequins de colisão) estão sentados nos bancos dianteiro e traseiro. Legendas apontam: "Crumple zone (Região deformável)" para a frente deformada do carro; "Air bag" para o airbag inflado diante do motorista; "Seat belts (Cintos de segurança)" para os cintos dos dois ocupantes.'),
('2024-D2-Q092', 1, 'imagens/2024/D2/q092_fig1.webp', 'Esquema de uma célula a combustível microbiana com duas câmaras separadas por uma membrana. À esquerda, câmara verde com o "Ânodo" (eletrodo azul); entra "Matéria orgânica (CH₃COO⁻)" e sai "CO₂". À direita, câmara azul-clara com o "Cátodo" (eletrodo laranja); entra "O₂" e sai "H₂O". Íons "H⁺" atravessam a "Membrana" do ânodo para o cátodo (seta). Um fio externo liga os eletrodos, com setas indicando elétrons (e⁻) saindo do ânodo e chegando ao cátodo, e uma seta no fio apontando da esquerda para a direita.'),
('2024-D2-Q094', 1, 'imagens/2024/D2/q094_fig1.webp', 'Fórmula estrutural da nimesulida com os grupamentos circulados por linhas tracejadas e rotulados: "metila" (H₃C ligado ao enxofre); "sulfonamida" (S com dois O em dupla ligação, ligado a N–H); o N da sulfonamida está ligado a um anel benzênico; nesse anel, em posição vizinha, há um O identificado como "éter", que o liga a um segundo anel benzênico identificado como "fenila"; na posição oposta ao N, o anel tem o grupo "nitro" (N⁺ com um O em dupla ligação e um O⁻).'),
('2024-D2-Q096', 1, 'imagens/2024/D2/q096_fig1.webp', 'Desenho de uma roda com pneu (escrito "PNEU" no topo e embaixo), vista de frente, com duas linhas tracejadas passando pelo centro geométrico (uma vertical e uma horizontal). O ponto "CM" (laranja) está deslocado do centro para cima e para a direita (no quadrante superior direito, próximo ao eixo vertical). Na borda da roda há cinco pontos amarelos numerados: 1 no topo (sobre o eixo vertical); 5 na parte superior direita; 2 à esquerda (sobre o eixo horizontal); 3 na parte inferior esquerda; 4 embaixo (sobre o eixo vertical).'),
('2024-D2-Q098', 1, 'imagens/2024/D2/q098_fig1.webp', 'Cladograma dos mamíferos. Na base, “Mammalia”, de onde partem dois ramos: “Prototheria”, que leva a “Monotremata” (ilustrado por um ornitorrinco), e “Theria”, que se divide em “Metatheria”, levando a “Marsupialia” (ilustrado por um canguru com filhote na bolsa), e “Eutheria”, levando a “Placentalia” (ilustrado por um elefante).'),
('2024-D2-Q100', 1, 'imagens/2024/D2/q100_fig1.webp', 'Acima, ilustração do mirascópio: um objeto escuro em forma de disco (duas cúpulas unidas pela borda), com a imagem de uma raposa de pé sobre a abertura circular do topo. Abaixo, esquema em corte: espelho côncavo inferior E₁ (com a raposa sobre seu vértice, apoiado numa superfície horizontal) e espelho côncavo superior E₂, com abertura no topo de 5 cm. Raios de luz partem do objeto no vértice de E₁, refletem em E₂ (descendo verticalmente) e depois em E₁, convergindo para um ponto na abertura de E₂. Cotas: largura total de 23 cm; altura de 3,8 cm entre a base e a junção das bordas e mais 3,8 cm da junção até o topo.'),
('2024-D2-Q101', 1, 'imagens/2024/D2/q101_fig1.webp', 'Infográfico: um professor fala diante de um quadro e cinco estudantes sentados em carteiras dispostas em fila, sobre uma escala de distância de 0 a 10 m. Acima, gráfico do “Nível sonoro (dB)” (eixo vertical, de 0 a 60) em função da “Distância (m)” (eixo horizontal, de 0 a 10): a curva começa em 60 dB a 1 m, cai para cerca de 53 dB a 2 m, cerca de 50 dB a 3 m, cerca de 46 dB a 4 m, cerca de 45 dB a 5 m, cerca de 44 dB a 6 m, cerca de 42 dB a 7 m, cerca de 41 dB a 8 m, cerca de 39 dB a 9 m e cerca de 38 dB a 10 m.'),
('2024-D2-Q103', 1, 'imagens/2024/D2/q103_fig1.webp', 'Esquema de um aquecedor solar: um reservatório cilíndrico horizontal (“Reservatório de água”), envolto por “Isolamento térmico de poliuretano”, posicionado acima de um “Coletor solar de tubo a vácuo” (painel inclinado com vários tubos escuros) que recebe “Radiação solar” (setas vindas do Sol). Um cano azul leva “Água fria” do reservatório até a parte inferior do coletor, e um cano vermelho leva “Água quente” do coletor de volta ao reservatório, subindo para sua parte superior.'),
('2024-D2-Q104', 1, 'imagens/2024/D2/q104_fig1.webp', 'Fluxograma com cinco caixas ligadas por setas: “Urbanização” → “Ausência de saneamento básico” → “Contaminação da água” → “Redução da biodiversidade aquática” → “Riscos para a saúde humana”.'),
('2024-D2-Q110', 1, 'imagens/2024/D2/q110_fig1.webp', 'Duas fotografias de serpentes enroladas, lado a lado, ambas com anéis vermelhos, pretos e brancos. À esquerda, legenda “Coral-verdadeira (*Micrurus decoratus*)”, sobre tronco/solo escuro; à direita, legenda “Falsa-coral (*Erythrolamprus aesculapii*)”, sobre folhas secas. O padrão de coloração das duas é muito semelhante.'),
('2024-D2-Q113', 1, 'imagens/2024/D2/q113_fig1.webp', 'Esquema em dois painéis com plantas (uma leguminosa e um tomateiro), solo e círculos com procariontes. Painel superior, “Procariontes no ciclo do nitrogênio”: “Nitrogênio atmosférico (N₂)” → etapa 1, “Procariontes fixadores de nitrogênio: convertem N₂ em amônia (NH₃)” → “Procariontes nitrificantes: convertem NH₃ em nitritos (NO₂⁻) e nitratos (NO₃⁻)” (com setas também para as raízes das plantas) → etapa 2, “Procariontes desnitrificantes: convertem nitratos em N₂”, que retorna ao nitrogênio atmosférico. Painel inferior, “Procariontes no ciclo do carbono”: “Carbono atmosférico (CO₂)” → etapa 3, “Procariontes fotossintetizantes: fixam CO₂”, e etapa 4, “Plantas: fixam CO₂”; ambos levam à etapa 5, “Procariontes decompositores: convertem o carbono fixado em CO₂”, que retorna ao carbono atmosférico.'),
('2024-D2-Q114', 1, 'imagens/2024/D2/q114_fig1.webp', 'Gráfico de linhas. Eixo horizontal: “Razão ar/combustível (massa/massa)”, de 10 a 20, com linha tracejada vertical em cerca de 14,7 indicando a “Razão estequiométrica ar/combustível”; à esquerda dela, “Deficiência”, à direita, “Excesso”. Eixo vertical esquerdo: “O₂, CO, CO₂ (% volume)”, de 0 a 14 (curvas CO₂, CO e O₂). Eixo vertical direito: “NO (10³ vppm), HC como C₆ (10² vppm)”, de 0 a 7 (curvas NO e HC). Curvas: CO₂ sobe de cerca de 7,5 (razão 10) até o máximo de cerca de 14 (razão 15) e cai para cerca de 11 (razão 19,5); CO cai de cerca de 12 (razão 10,5) para quase 0 a partir de 15; O₂ é quase 0 até 13 e sobe até cerca de 5,7 em 19,5; HC cai de cerca de 7,2 (razão 10,5) para um mínimo de cerca de 1,25 perto da razão 18 e volta a subir para cerca de 1,7 em 19,5; NO sobe de quase 0 até o máximo de cerca de 3,6 perto da razão 16 e cai para cerca de 0,7 em 19,5 (em 18, cerca de 2).'),
('2024-D2-Q115', 1, 'imagens/2024/D2/q115_fig1.webp', 'Desenho em duas colunas, cada uma com uma ameba (com pseudópodes e núcleo) e uma seta para baixo indicando o resultado. Coluna “Grupo controle”: a ameba continua com formato irregular, emitindo pseudópodes. Coluna “Ameba tratada com citocalasina B”: a ameba se torna arredondada, sem pseudópodes.'),
('2024-D2-Q119', 1, 'imagens/2024/D2/q119_fig1.webp', 'Retângulo tracejado com boias (pontos pretos) nos vértices: 1 (inferior esquerdo), 2 (inferior direito), 3 (superior direito) e 4 (superior esquerdo). Os lados horizontais medem 800 m e os verticais 400 m. Dentro do retângulo, perto do lado 2–3, há o vetor υc apontando para baixo (paralelo aos lados verticais). Sobre o lado 1–2 há um vetor υn inclinado apontando para cima e para a direita; sobre o lado 4–3 há um vetor υn inclinado apontando para cima e para a esquerda.'),
('2024-D2-Q121', 1, 'imagens/2024/D2/q121_fig1.webp', 'Tirinha de Calvin em quatro quadrinhos. 1º: Calvin sorri sentado em um balanço, subindo. 2º: Calvin solta-se do balanço no ponto mais alto gritando "IIAUUUUUUU"; o assento do balanço fica para trás. 3º: Calvin voa pelo ar, deitado de costas, com traços de movimento à direita dele, indicando que se move para a esquerda. 4º: Calvin cai de cabeça para baixo em direção ao chão e diz: "HOUSTON, ESTAMOS COM UM PROBLEMA NA TRAJETÓRIA ORBITAL." Assinatura: WATTERSON.'),
('2024-D2-Q122', 1, 'imagens/2024/D2/q122_fig1.webp', 'Tirinha de Laerte em três quadrinhos verticais, dentro de um iglu. 1º: dois esquimós caminham ao lado de uma geladeira; um pergunta "Ué, você comprou uma geladeira?!" e o outro responde "É". 2º: um deles retira uma forma de gelo do congelador; diálogo: "Pra quê?!" — "É para as crianças.". 3º: duas crianças esquimós brincam montando um pequeno iglu com cubos de gelo, com a forma de gelo ao lado; legenda em balão: "Elas adoram brincar de casinha."'),
('2024-D2-Q123', 1, 'imagens/2024/D2/q123_fig1.webp', 'Fórmulas estruturais de dois compostos. Composto 1: anel benzênico com um grupo C(=O)OH e, no carbono vizinho, um grupo OH. Composto 2: anel de cinco carbonos (ciclopentano) com um C=O no anel; no carbono vizinho à carbonila, uma cadeia lateral com ligação dupla C=C (configuração cis) terminando em etila; no carbono seguinte do anel, um grupo CH₂ ligado a COOH. Rótulos: "Composto 1" e "Composto 2".'),
('2024-D2-Q124', 1, 'imagens/2024/D2/q124_fig1.webp', 'Três tubos de ensaio numerados 1, 2 e 3, com meio de cultura amarelo e células bacterianas representadas por pontos vermelhos. Tubo 1: pontos concentrados apenas na parte superior do meio, junto à superfície. Tubo 2: pontos concentrados apenas no fundo do tubo. Tubo 3: pontos mais concentrados na superfície, mas também espalhados ao longo de todo o meio.'),
('2024-D2-Q125', 1, 'imagens/2024/D2/q125_fig1.webp', 'Placa quadrada de saída de emergência: fundo verde com uma porta em amarelo-claro (fosforescente) e, sobre ela, a silhueta verde de uma pessoa correndo em direção à abertura da porta.'),
('2024-D2-Q127', 1, 'imagens/2024/D2/q127_fig1.webp', 'Vista superior: duas barras verticais paralelas, A à esquerda (com sinais + ao lado) e B à direita (com sinais – ao lado). Entre elas, nove linhas de campo horizontais, retas, igualmente espaçadas, com setas apontando de A para B.'),
('2024-D2-Q128', 1, 'imagens/2024/D2/q128_fig1.webp', 'Ilustração de uma nuvem com gotas de chuva caindo sobre uma placa solar em camadas, revestida por uma malha de grafeno com uma gota de água sobre ela. Um destaque ampliado (elipse) mostra a "Camada fina de água", com íons Bⁿ⁻ na parte de cima e íons Aᵐ⁺ junto à interface, sobre a "Camada fina de grafeno", que contém elétrons e⁻ próximos à interface. Uma seta para cima indica "Alto potencial elétrico" (lado da água) e uma seta para baixo indica "Baixo potencial elétrico" (lado do grafeno).'),
('2024-D2-Q130', 1, 'imagens/2024/D2/q130_fig1.webp', 'Diagrama P (eixo vertical) × V (eixo horizontal) do ciclo de Otto. Pontos: 0 e 1 na mesma pressão baixa (0 com volume menor, 1 com volume maior), ligados por linha tracejada horizontal; 2 acima de 0, no volume menor; 3 acima de 2, no mesmo volume; 4 acima de 1, no volume maior. Curvas: de 1 a 2 uma curva descendente-côncava (compressão); de 2 a 3 segmento vertical; de 3 a 4 curva decrescente (expansão); de 4 a 1 segmento vertical. A área interna do ciclo 1-2-3-4, sombreada em amarelo, é marcada com "W".'),
('2024-D2-Q131', 1, 'imagens/2024/D2/q131_fig1.webp', 'Símbolo do LED, com o rótulo "LED": um triângulo amarelo apontando para a direita encostado em uma barra vertical (diodo), com duas pequenas setas saindo para cima indicando emissão de luz, ligado a fios horizontais nos dois lados. Abaixo, o texto "Sentido permitido da corrente" e uma seta vermelha apontando para a direita.'),
('2024-D2-Q132', 1, 'imagens/2024/D2/q132_fig1.webp', 'Circuito retangular. No fio superior, a lâmpada L₁ à esquerda e a lâmpada L₂ à direita, com o ponto P entre elas. De P sai um fio até o amperímetro (círculo com "A") e daí um terminal solto com seta, marcado S. No meio do retângulo, um fio resistivo horizontal de Q (esquerda) a R (direita), com os pontos A, B, C, D e E igualmente espaçados entre eles. No fio inferior, a bateria com tensão V_QR. Abaixo, uma cota de largura total "48 cm".'),
('2024-D2-Q134', 1, 'imagens/2024/D2/q134_fig1.webp', 'Infográfico de uma árvore com raízes no solo e círculos ampliados indicando processos: na copa, "Fitovolatilização" (folha liberando partículas amarelas para o ar), "Fitoextração" (partículas roxas acumuladas nas folhas) e "Fitodegradação" (partículas transformadas dentro da folha); no solo, "Fitoextração" (partículas roxas absorvidas pela raiz), "Fitoestabilização" (aglomerados de partículas roxas presos junto às raízes), "Fitodegradação" (partículas degradadas junto à raiz) e "Fitoestimulação" (contaminantes convertidos em CO₂ junto às raízes). Ao lado, um quadro com as definições: "Fitoestabilização: imobilização dos contaminantes através de sorção por raízes, precipitação, complexação ou redução de valência." "Fitovolatilização: retirada de poluentes pelas plantas e transferência para uma forma volátil." "Fitodegradação: degradação dos contaminantes orgânicos por ação enzimática." "Fitoestimulação: estimulação dos microrganismos degradadores de contaminantes orgânicos." "Fitoextração: remoção de poluentes pelas raízes e sua transferência e acúmulo na parte aérea das plantas."'),
('2025-D2-Q091', 1, 'imagens/2025/D2/q091_fig1.webp', 'Esquema com dois círculos cinza. À esquerda, "Carvão comum": círculo liso com poucos poros pequenos, um deles indicado como "Mesoporo". À direita, "Carvão ativado": círculo com contorno irregular, reentrâncias e fendas, contendo poros de vários tamanhos indicados como "Macroporo", "Mesoporo" e "Microporo", e pontos pretos aderidos às paredes e fendas indicados como "Impureza adsorvida".'),
('2025-D2-Q094', 1, 'imagens/2025/D2/q094_fig1.webp', 'Foto de uma régua elétrica (filtro de linha) branca com seis tomadas de três pinos alinhadas, um interruptor e um cabo com plugue.'),
('2025-D2-Q097', 1, 'imagens/2025/D2/q097_fig1.webp', 'Esquema em etapas numeradas da fabricação de uma vacina tradicional. Parte de um microscópio com destaque de células, legenda "Cultura de células infectadas com vírus"; seta 1 leva a um aglomerado de vírus roxos, legenda "Isolamento dos vírus"; seta 2 leva a vírus em preto e branco, legenda "Inativação dos vírus pelo calor ou por ação química"; seta 3 leva a uma mulher de máscara recebendo injeção no braço, legenda "Aplicação da vacina"; seta 4 aponta para baixo, mostrando vírus cercados por anticorpos verdes em forma de Y.'),
('2025-D2-Q105', 1, 'imagens/2025/D2/q105_fig1.webp', 'Esquema de usina termonuclear com legenda: amarelo = "Circuito primário", azul = "Circuito secundário", verde = "Sistema de água de refrigeração". Dentro do "Vaso de contenção": "Reator" com "Elemento combustível", "Pressurizador", "Bomba" e gerador de "Vapor" (circuito primário em amarelo, com setas vermelhas, aquecendo a água do circuito secundário). O vapor segue para a "Turbina", ligada ao "Gerador elétrico" e à "Torre de transmissão". Após a turbina, o "Condensador" é resfriado pelo sistema de água de refrigeração (verde), que circula com "Bombas" entre o condensador, a "Torre de resfriamento" e o "Ecossistema aquático" (de onde vem a "Água fria"). A "Água" condensada volta por uma "Bomba" a partir do "Tanque de água de alimentação".'),
('2025-D2-Q106', 1, 'imagens/2025/D2/q106_fig1.webp', 'Fotografia antiga em preto e branco de uma sala de aula de química (1909), com alunos sentados de costas, um professor e um aluno junto à lousa. Um detalhe ampliado da lousa mostra as equações (com os índices escritos como sobrescritos): "AzO + O = AzO²"; "SO² + H²O = H²SO³"; "2 H²SO³ + O² = 2 H²SO⁴"; "2 HCl + MgO²H² = MgCl² + 2 H²O".'),
('2025-D2-Q107', 1, 'imagens/2025/D2/q107_fig1.webp', 'Esquema de cruzamento de insetos semelhantes a joaninhas (corpo vermelho, cabeça preta). "Parentais": "Macho" com quatro pintas pretas (duas de cada lado) × "Fêmea" com uma listra preta vertical no centro do dorso. "Primeira geração": "Macho" e "Fêmea" iguais, ambos com as quatro pintas pretas e a listra central (as duas características juntas).'),
('2025-D2-Q109', 1, 'imagens/2025/D2/q109_fig1.webp', 'Esquema de reação: "Ácido anacárdico" (anel benzênico com grupo OH, grupo carboxila COOH em posição vizinha e cadeia C₁₅H₃₁ na outra posição vizinha à carboxila) → sob aquecimento (Δ, 180 °C a 200 °C) → "Cardanol" (anel benzênico com OH e cadeia C₁₅H₃₁, sem a carboxila) + CO₂.'),
('2025-D2-Q111', 1, 'imagens/2025/D2/q111_fig1.webp', 'Ilustração de um biodigestor com uma vaca e um porco no topo e duas estruturas de tijolos (alimentador retangular e biodigestor cilíndrico com tubo de saída de gás). Etapas numeradas: "1 Excrementos animais e restos de alimentos são misturados com água no alimentador do biodigestor"; "2 Dentro do biodigestor, a ação das bactérias decompõe os resíduos, transformando-os em gás metano e adubo"; "3 O gás metano pode ser encanado para alimentar um gerador ou aquecedor"; "4 As sobras servem como fertilizante" (monte de material ao lado do biodigestor).'),
('2025-D2-Q113', 1, 'imagens/2025/D2/q113_fig1.webp', 'Figura 1: esquema de um tubo de imagem visto de lado. À esquerda, o filamento na posição "A", seguido de discos aceleradores; adiante, a região "B" com duas placas paralelas (uma acima e outra abaixo do eixo do feixe). O tubo se alarga até a "Tela", na qual estão marcados os pontos: "1" (acima), "2" (abaixo), "5" (centro, na direção do eixo), "4" (à esquerda do centro) e "3" (à direita do centro).'),
('2025-D2-Q113', 2, 'imagens/2025/D2/q113_fig2.webp', 'Figura 2: duas placas horizontais paralelas com linhas de campo elétrico verticais apontando para cima (vetor $\vec{E}$, de baixo para cima). Uma carga negativa (círculo amarelo com sinal "–") entra pela esquerda com velocidade $\vec{v}$ horizontal para a direita.'),
('2025-D2-Q114', 1, 'imagens/2025/D2/q114_fig1.webp', 'Tirinha em preto e branco de Mauricio de Sousa, em um quadro: um homem de óculos, sentado à mesa, olha assustado para a taça quebrada à sua frente; ao centro, Mônica, sentada à mesa com a boca aberta, e Cebolinha ao lado, de braços cruzados; à direita, um garçom segura uma bandeja com taças estilhaçadas, com o líquido escorrendo. Balão de fala: "E QUEM ESTÁ GRITANDO MUITO?".'),
('2025-D2-Q115', 1, 'imagens/2025/D2/q115_fig1.webp', 'Fórmula estrutural em perspectiva do "Borneol": estrutura bicíclica em ponte (biciclo[2.2.1]heptano) com dois grupos CH₃ (H₃C e CH₃) no carbono da ponte superior, um grupo H₃C em uma das cabeças de ponte e um grupo OH ligado a um carbono do anel adjacente a essa cabeça de ponte.'),
('2025-D2-Q119', 1, 'imagens/2025/D2/q119_fig1.webp', 'Símbolo de gerador não ideal em circuito aberto: bateria com polos "–" (à esquerda) e "+" (à direita), força eletromotriz "ε = 40 V", em série com um resistor "r" (resistência interna).'),
('2025-D2-Q120', 1, 'imagens/2025/D2/q120_fig1.webp', 'Ilustração de um sensor de barreira: um "Transmissor" à esquerda emite um feixe horizontal (vermelho) até um "Receptor" à direita; no receptor está indicado o diâmetro "d" do feixe. Abaixo, cinco movimentos de um invasor com suas velocidades típicas: subindo um muro de tijolos (seta para cima) — 0,5 m/s; descendo o muro (seta para baixo) — 0,7 m/s; andando — 1,0 m/s; andando rápido — 2,0 m/s; correndo — 5,0 m/s.'),
('2025-D2-Q122', 1, 'imagens/2025/D2/q122_fig1.webp', 'Esquema de fogão por indução: uma panela tampada com líquido borbulhando ("Conteúdo aquecido"), com setas vermelhas nas paredes e no fundo indicando "Transferência do calor gerado na panela"; abaixo dela, uma placa de "Vidro cerâmico"; sob o vidro, uma "Bobina de indução" (fio enrolado em cilindro) com linhas de "Campo magnético criado por bobina de indução" entrando por uma extremidade e saindo pela outra.'),
('2025-D2-Q126', 1, 'imagens/2025/D2/q126_fig1.webp', 'Sistema de eixos em perspectiva com as direções Norte (eixo inclinado para cima à direita), Sul (oposto, para baixo à esquerda), Leste (horizontal à direita), Oeste (horizontal à esquerda) e um eixo vertical. Um avião verde está na origem, com um vetor $\vec{v}$ apontando para cima e à direita. Linhas tracejadas azuis partem do eixo Leste e do eixo Norte e se encontram em um ponto no plano horizontal, de onde uma linha tracejada vertical sobe até um ponto preto indicado por uma seta com o rótulo "Posição a ser atingida".'),
('2025-D2-Q128', 1, 'imagens/2025/D2/q128_fig1.webp', 'Gráfico de Resistência (ohm), de 50 a 250, em função da Temperatura (°C), de −100 a 350, com cinco retas de −50 °C a cerca de 320 °C. Sensor 1 (laranja): de cerca de 225 a 229 ohm, quase horizontal. Sensor 2 (verde): de cerca de 76 a 225 ohm, a mais inclinada. Sensor 3 (roxo): de cerca de 147 a 169 ohm. Sensor 4 (azul-claro): de cerca de 91 a 149 ohm. Sensor 5 (lilás): de cerca de 66 a 145 ohm.'),
('2025-D2-Q133', 1, 'imagens/2025/D2/q133_fig1.webp', 'Esquema em camadas, de baixo para cima: "Malha de aço" (grade cinza); "Camada inferior de polímero" (cadeia polimérica azul, entre parênteses com índice n, com anéis contendo N⁺ ligado a dois grupos metila); "Nanopartículas de sílica" (fileira de círculos laranja com SiO₂ e cargas negativas); "Camada superior de polímero" (mesma cadeia azul com N⁺, índice n); "Surfactante" (cadeias laranja de carbonos ligados a átomos de flúor, CF₃ e CF₂, terminadas em grupo com carga negativa ⊖ voltado para o polímero). Chaves à direita identificam cada camada.'),
('2025-D2-Q134', 1, 'imagens/2025/D2/q134_fig1.webp', 'Fórmulas estruturais de cinco hormônios esteroides (quatro anéis fundidos, com CH₃ na junção dos anéis): Estradiol — anel aromático com HO e um OH no anel de cinco membros (2 grupos OH); Estriol — anel aromático com HO e dois OH no anel de cinco membros (3 grupos OH); Estrona — anel aromático com HO e uma carbonila (C=O) no anel de cinco membros; Novestrol — anel aromático com HO, e no anel de cinco membros um OH e um grupo etinil (C≡CH); Noretindrona — anel não aromático com carbonila (O=) e dupla ligação, e no anel de cinco membros um OH e um grupo C≡CH.'),
('2025-D2-Q135', 1, 'imagens/2025/D2/q135_fig1.webp', 'Três partes. Gráfico: Fotoluminescência (u.a.), de 0,0 a 1,2, em função do Comprimento de onda (nm), de cerca de 525 a 725 nm; curva cinza com pico de 1,0 em 600 nm, valendo cerca de 0,3 em 525 nm e cerca de 0,1 em 725 nm. Figura 1: foto de um bebê sob luz azul, com um sensor vermelho em forma de coração colado na fralda. Figura 2: coluna de corações coloridos com tempos de exposição — 0 h (vermelho), 3 h (laranja-avermelhado), 6 h (laranja), 9 h (amarelo-esverdeado) e 12 h (verde) —, ladeada por uma seta para cima rotulada "Frequência" e outra seta para cima rotulada "Tempo de exposição".');
commit;
