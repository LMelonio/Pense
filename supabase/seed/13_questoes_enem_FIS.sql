-- Questões de enem-FIS (27)
begin;
insert into public.questoes (id, exame_id, recorte_id, banca, orgao, cargo, nivel, ano, numero, formato, disciplina, assunto, topico, lingua, texto_base_id, texto_apoio, comando, gabarito, dica1, dica2, explicacao, dificuldade) values
('2024-D2-Q091', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 91, '5_alternativas', 'Física', 'Energia e trabalho', 'Energia cinética em colisões', null, null, 'Muitas pessoas ainda se espantam com o fato de um passageiro sair ileso de um acidente de carro enquanto o veículo onde estava teve perda total. Essas pessoas talvez considerem, equivocadamente, que os carros mais seguros são os que têm as estruturas mais rígidas, ou seja, estruturas, que durante uma colisão, apresentam menor deformação. Na verdade, o que ocorre é o contrário. Por isso, a partir de 1958, passaram a ser produzidos carros com partes que se deformam facilmente.

Fonte: DAY, C. **Crumple Zones**. Disponível em: https://pubs.aip.org. Acesso em: 2 jul. 2024 (adaptado).

Assim, além dos cintos de segurança e dos airbags, os carros modernos passaram a contar com o dispositivo de segurança conhecido como *crumple zone* (região deformável, em inglês), conforme a figura.

{{figura:1}}

Fonte: **Momentum and Car safety**. GCSE Physics Revision. Disponível em: www.shalom-education.com. Acesso em: 5 jul. 2024 (adaptado).', 'Considerando o carro, seus ocupantes e o muro da figura como um sistema isolado, o *crumple zone* aumenta a segurança dos passageiros porque, durante uma colisão, a deformação da estrutura do carro', 'B', 'Pense no que acontece com a energia de movimento do carro quando a frente dele amassa no choque.', 'Num sistema isolado, a quantidade de movimento total se conserva e o centro de massa não muda de velocidade. Então sobra uma grandeza que pode ser transformada pela deformação.', 'Resposta: B. Ao amassar, a estrutura do carro transforma a energia cinética do sistema em trabalho de deformação (e calor), e faz isso ao longo de um tempo maior, o que reduz a força sobre os ocupantes. A alternativa C é a pegadinha: num sistema isolado a quantidade de movimento se conserva, ela não é "consumida". Pelo mesmo motivo, a velocidade do centro de massa não muda (E).', 'média'),
('2024-D2-Q096', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 96, '5_alternativas', 'Física', 'Dinâmica e leis de Newton', 'Centro de massa', null, null, 'Nos automóveis, é importante garantir que o centro de massa (**CM**) de cada conjunto roda/pneu coincida com o seu centro geométrico. Esse processo é realizado em uma máquina de balanceamento, na qual o conjunto roda e pneu é colocado para girar a uma velocidade de valor constante. Com base nas oscilações medidas, a máquina indica a posição do centro de massa do conjunto, e pequenas peças de chumbo são fixadas em lugares específicos da roda até que as vibrações diminuam. Durante o treinamento de sua equipe, a fim de corrigir a posição do centro de massa indicada pela máquina, um mecânico apresenta o esquema a seguir, com cinco possíveis pontos da roda para posicionar uma peça de chumbo.

{{figura:1}}', 'Em qual ponto deve ser fixada a peça de chumbo para corrigir a posição do centro de massa desse conjunto roda/pneu?', 'C', 'Para trazer o centro de massa de volta ao centro da roda, onde você colocaria um peso extra?', 'O CM está deslocado para cima e para a direita. O peso deve ir no lado oposto, na direção da reta que liga o CM ao centro da roda.', 'Resposta: C. O centro de massa está acima e à direita do centro geométrico, então há massa sobrando nesse lado. Para compensar, a peça de chumbo deve ficar do lado diametralmente oposto, abaixo e à esquerda, que é o ponto 3. O ponto 5 está no mesmo lado do CM e pioraria o desequilíbrio; os pontos 2 e 4 corrigiriam só uma das direções.', 'fácil'),
('2024-D2-Q099', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 99, '5_alternativas', 'Física', 'Ondulatória e som', 'Efeito Doppler', null, null, 'Uma ambulância em alta velocidade com a sirene ligada desloca-se em direção a um radar operado por uma pessoa. O radar emite ondas de rádio com frequência $f_0$ que são refletidas pela dianteira da ambulância, retornando para o detector com frequência $f_r$. A percepção do operador do radar, em relação ao som emitido pela sirene, é de que este se altera à medida que a ambulância se aproxima ou se afasta.', 'Durante a aproximação, como o operador percebe o som da sirene e qual é a relação entre as frequências $f_r$ e $f_0$ medidas pelo radar?', 'D', 'Isso é efeito Doppler: o que acontece com a frequência percebida quando a fonte se aproxima?', 'Na aproximação, a frequência percebida aumenta. Vale para o som da sirene e também para as ondas de rádio refletidas pela ambulância que vem em direção ao radar.', 'Resposta: D. Quando a fonte se aproxima, as frentes de onda chegam mais \"juntas\" ao observador, então a frequência percebida é maior: o som fica mais agudo. O mesmo ocorre com o radar: a ambulância funciona como um refletor em movimento na direção dele, e a onda volta com frequência maior, $f_r > f_0$. Som mais grave e $f_r < f_0$ corresponderiam ao afastamento.', 'fácil'),
('2024-D2-Q100', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 100, '5_alternativas', 'Física', 'Óptica', 'Espelhos esféricos', null, null, '**Mirascópio 3D: produtor de ilusão instantânea**

O equipamento ilustrado na figura, de dimensões apresentadas no esquema, é composto por dois espelhos côncavos **E₁** e **E₂**, apoiados um sobre o outro por suas bordas, de tal forma que o vértice de **E₁** coincide com o foco de **E₂** e vice-versa. Na abertura circular de **E₂**, é formada uma imagem tridimensional de um objeto posicionado sobre o vértice de **E₁**. Essa imagem é formada a partir dos raios procedentes do objeto, refletidos por **E₂** e **E₁**, respectivamente, conforme o esquema. Os observadores julgam visualizar o objeto quando estão, de fato, visualizando sua imagem. O efeito só é possível porque as superfícies de ambos os espelhos são de extrema qualidade.

{{figura:1}}

Fonte: SALZMANN, W. Disponível em: https://wissenstexte.de. Acesso em: 27 jun. 2024 (adaptado).', 'A natureza da imagem formada e a distância vertical entre cada ponto objeto e seu correspondente ponto imagem são', 'C', 'Os raios realmente se cruzam acima da abertura? Isso define se a imagem é real ou virtual. Depois olhe as cotas do esquema.', 'A imagem é formada pelo cruzamento dos próprios raios refletidos. Para a distância, compare a altura do vértice de E₁ com a da abertura de E₂.', 'Resposta: C. No esquema, os raios refletidos por E₂ e depois por E₁ se cruzam de fato na abertura de E₂, então a imagem é real (por isso parece um objeto \"de verdade\"). O objeto está no vértice de E₁ e a imagem na abertura de E₂, separados por $3{,}8 + 3{,}8 = 7{,}6\ \text{cm}$. O valor 3,8 cm é só metade da altura, e 5 cm é a largura da abertura, não uma distância vertical.', 'média'),
('2024-D2-Q101', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 101, '5_alternativas', 'Física', 'Ondulatória e som', 'Nível sonoro em decibéis', null, null, '**A saúde do professor: acústica arquitetônica**

Dentre os parâmetros acústicos que afetam a inteligibilidade dos sons emitidos em ambientes fechados, destacam-se o ruído de fundo do ambiente e o decréscimo do nível sonoro com a distância da fonte emissora. Assim, sentar-se no fundo da sala de aula pode prejudicar a aprendizagem dos estudantes, por impedir que eles distingam, com precisão, os sons emitidos, diminuindo a inteligibilidade da fala de seus professores. Considere a situação exemplificada pelo infográfico: à distância de 1 metro, o nível sonoro da fala de um professor é de 60 dB e diminui com a distância. Considere, ainda, que o ruído de fundo nessa sala de aula pode chegar a 45 dB e que, para ser compreendida, o nível sonoro da fala do professor deve estar 5 dB acima desse ruído.

{{figura:1}}

Fonte: Disponível em: www.ufrrj.br. Acesso em: 2 dez. 2021 (adaptado).', 'Para um valor máximo do ruído de fundo, a maior distância que um estudante pode estar do professor para que ainda consiga compreender sua fala é mais próxima de', 'A', 'Primeiro descubra qual nível sonoro a fala precisa ter; depois procure esse valor no gráfico.', 'Ruído máximo de 45 dB mais 5 dB dá o mínimo para entender. Leia no eixo horizontal a distância em que a curva chega a esse nível.', 'Resposta: A. Com ruído de 45 dB, a fala precisa de pelo menos $45 + 5 = 50$ dB. No gráfico, a curva passa por cerca de 50 dB perto de 3 m, então essa é a maior distância. A distância de 5 m é a pegadinha: ali a fala está em cerca de 45 dB, igual ao ruído, e não 5 dB acima dele.', 'fácil'),
('2024-D2-Q103', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 103, '5_alternativas', 'Física', 'Termologia', 'Convecção térmica', null, null, 'Aquecedores solares são equipamentos utilizados para o aquecimento de água pelo calor do Sol. São compostos por coletores solares, nos quais ocorre o aquecimento da água, e por um reservatório térmico, em que é armazenada a água quente para ser utilizada posteriormente. A figura ilustra esquematicamente como funciona esse equipamento.

{{figura:1}}

Fonte: **5 dicas de instalação de aquecedor solar**. Disponível em: https://instaline.com.br. Acesso em: 3 nov. 2023 (adaptado).', 'O processo pelo qual ocorre transferência de calor dos coletores solares para o reservatório térmico é a', 'E', 'Repare que a água quente sobe do coletor até o reservatório e a fria desce. Que processo envolve movimento do próprio fluido?', 'Condução ocorre em sólidos, sem deslocamento de matéria, e irradiação é por ondas. Aqui o calor é levado pela circulação da água.', 'Resposta: E. A água aquecida no coletor fica menos densa e sobe para o reservatório, enquanto a água fria, mais densa, desce até o coletor. Essa circulação do fluido, que transporta o calor, é a convecção. A irradiação (D) é como o calor do Sol chega ao coletor, mas não é como ele vai do coletor ao reservatório.', 'fácil'),
('2024-D2-Q106', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 106, '5_alternativas', 'Física', 'Física moderna', 'Raios X e absorção', null, null, 'Em aeroportos, por razões de segurança, os passageiros devem ter suas bagagens de mão examinadas antes do embarque, passando-as em esteiras para sua inspeção por aparelhos de raios X. Nessas inspeções, os passageiros são orientados a retirar seus computadores portáteis (notebooks ou laptops) de malas, mochilas ou bolsas para passá-los isoladamente pela esteira.', 'Que explicação física justifica esse procedimento?', 'D', 'O raio X forma imagem porque alguns materiais deixam ele passar e outros não. O que um notebook cheio de peças faz com os raios?', 'Materiais densos, como metais e baterias, absorvem muito raio X. Pense no que isso causa na imagem dos objetos que estão na mesma linha do computador.', 'Resposta: D. A imagem de raios X é formada pela diferença de absorção: materiais densos bloqueiam a radiação. Um notebook tem muitos componentes densos e cria uma "sombra" grande que esconde o que estiver à frente ou atrás dele dentro da mala. As outras alternativas inventam efeitos (desmagnetizar, aquecer, ionizar) ou dizem que não há interação, o que é o contrário do que acontece.', 'média'),
('2024-D2-Q119', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 119, '5_alternativas', 'Física', 'Cinemática', 'Composição de velocidades', null, null, 'Para os circuitos de maratonas aquáticas realizadas em mares calmos e próximos à praia, é montado um sistema de boias que determinam o trajeto a ser seguido pelos nadadores. Uma das dificuldades desse tipo de circuito é compensar os efeitos da corrente marinha. O diagrama contém o circuito em que deve ser realizada uma volta no sentido anti-horário. As quatro boias estão numeradas de 1 a 4. Existe uma corrente marinha de velocidade $\vec{\upsilon}_c$, cujo módulo é 30 metros por minuto, paralela à praia em toda a área do circuito. Nas arestas mais longas, o nadador precisará nadar na direção apontada pelos vetores $\vec{\upsilon}_n$ dos pontos 1 até 2 e de 3 até 4. Considere que a velocidade do nadador é de 50 metros por minuto, em relação à água, durante todo o circuito.

{{figura:1}}', 'Nessa situação, em quantos minutos o nadador completará a prova?', 'B', 'Divida o circuito nos quatro lados e calcule a velocidade real do nadador (em relação ao fundo) em cada um.', 'Nos lados de 800 m, o nadador inclina o corpo para anular a corrente: a velocidade resultante vem de Pitágoras com 50 e 30. Nos lados de 400 m, some ou subtraia 30 de 50.', 'Resposta: B. De 1 a 2 e de 3 a 4: $v=\sqrt{50^2-30^2}=40$ m/min, então cada trecho leva $800/40=20$ min. De 2 a 3 (contra a corrente): $50-30=20$ m/min, $400/20=20$ min. De 4 a 1 (a favor): $50+30=80$ m/min, $400/80=5$ min. Total: $20+20+20+5=65$ min. Quem usa 50 m/min em tudo, sem considerar a corrente, chega a 48 min, que nem aparece nas opções.', 'difícil'),
('2024-D2-Q121', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 121, '5_alternativas', 'Física', 'Dinâmica e leis de Newton', 'Força resultante e normal', null, null, 'Na tirinha, Calvin se divertia em um balanço antes de soltar-se dele e cair ao chão. Em sua fala, ele demonstra ter imaginado que permaneceria em movimento circular. Porém, a força gravitacional, que permanece atuando no garoto, modifica a direção de sua velocidade, fazendo com que ele chegue ao chão da maneira ilustrada no último quadrinho.

{{figura:1}}

Fonte: WATTERSON, B. Disponível em: https://tiras-do-calvin.tumblr.com. Acesso em: 19 nov. 2021 (adaptado).', 'Qual vetor representa a força resultante exercida pelo chão sobre Calvin no exato momento em que ele toca o chão?', 'A', 'A força do chão sobre Calvin tem duas partes: a normal e o atrito. Pense na direção de cada uma.', 'A normal aponta para cima. O atrito se opõe ao deslizamento horizontal: veja nos quadrinhos para que lado Calvin se move (os traços de movimento ficam atrás dele).', 'Ao tocar o chão, Calvin recebe a força normal, vertical para cima, e o atrito, horizontal e contrário ao seu movimento. Pelos traços de movimento, ele vem da direita para a esquerda, então o atrito aponta para a direita. Somando os dois vetores, a resultante fica inclinada para cima e para a direita: letra A. A letra D (só vertical) esquece o atrito, e a letra C erra o sentido do atrito.', 'difícil'),
('2024-D2-Q122', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 122, '5_alternativas', 'Física', 'Termologia', 'Mudança de fase da água', null, null, 'A tirinha ilustra esquimós dentro de um iglu, habitação de formato hemisférico construída durante o inverno a partir de neve ou blocos de gelo. Essa estrutura de construção se justifica pelo fato de esse povo habitar as regiões mais setentrionais da Groenlândia, Canadá e Alasca.

{{figura:1}}

Fonte: LAERTE. Disponível em: https://artedafisicapibid.blogspot.com. Acesso em: 4 dez. 2021 (adaptado).', 'Na tirinha, a geladeira é necessária para fazer gelo porque', 'A', 'Para a água virar gelo, a temperatura precisa ficar abaixo de quanto?', 'Mesmo feito de gelo, o iglu é um abrigo aquecido pelo corpo das pessoas e isolado do frio externo. Compare a temperatura lá dentro com 0 °C.', 'A água só solidifica abaixo de 0 °C (à pressão normal). O iglu funciona como isolante e é aquecido pelos moradores, então a temperatura interna fica acima do ponto de solidificação da água; por isso é preciso uma geladeira para fazer gelo: letra A. A letra C mistura as coisas: o isolamento existe, mas o que importa é que o ar interno não está frio o bastante para congelar a água.', 'fácil'),
('2024-D2-Q127', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 127, '5_alternativas', 'Física', 'Eletromagnetismo', 'Blindagem eletrostática', null, null, 'Em um experimento de laboratório, duas barras metálicas, **A** e **B**, são carregadas com cargas opostas e imersas em óleo. Farelo de milho é jogado sobre o óleo e, após um certo tempo, o farelo assume o formato das linhas de campo elétrico entre as barras. A figura representa a vista superior desse experimento.

{{figura:1}}

Fonte: ALMEIDA, M. A. T. **Introdução às ciências físicas 2** — volume 4: módulo 4. Rio de Janeiro: Fundação CECIERJ, 2007 (adaptado).', 'Ao repetir o experimento colocando um cilindro metálico oco entre as placas, o esquema que representa o formato das linhas de campo assumido pelo farelo é:', 'E', 'Pense no que acontece com o campo elétrico dentro de um condutor metálico em equilíbrio eletrostático.', 'Um condutor oco funciona como blindagem: o campo dentro dele é nulo, e as linhas chegam e saem perpendiculares à superfície. O sentido continua de A (+) para B (−).', 'O cilindro metálico oco faz blindagem eletrostática (gaiola de Faraday): as cargas se rearranjam na superfície e o campo no interior fica nulo. Por isso nenhuma linha atravessa o cilindro; elas terminam e recomeçam na sua superfície, chegando perpendicularmente a ela, e seguem de A para B. Esse é o esquema da letra E. As letras A e D mostram campo dentro do cilindro, e B e C invertem o sentido das linhas.', 'média'),
('2024-D2-Q130', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 130, '5_alternativas', 'Física', 'Termologia', 'Ciclo termodinâmico de motores', null, null, 'O diagrama P-V a seguir representa o ciclo de Otto para um motor de combustão interna, como os motores a gasolina ou a etanol, utilizados nos automóveis.

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
('2024-D2-Q131', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 131, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Circuito com LEDs', null, null, 'O LED é um dispositivo eletrônico que conduz corrente elétrica em um único sentido, sendo caracterizado por uma tensão e uma corrente máxima de funcionamento, $I_{\text{máx}}$. Um LED acende apenas se a corrente que o percorre está no sentido permitido e se a diferença de potencial à qual está submetido é igual ou superior à sua tensão de funcionamento. A figura ilustra o símbolo do LED usado na representação de circuitos.

{{figura:1}}

Um estudante de física analisa as propriedades do LED em um circuito simples de corrente contínua. Ele dispõe dos seguintes materiais: uma bateria ideal de 4,5 V; dois LEDs de tensão 3,0 V e $I_{\text{máx}} = 1{,}0$ mA cada; e dois resistores de 1,5 kΩ cada.', 'O circuito que o estudante pode montar, para que ambos os LEDs fiquem acesos e cada um seja percorrido por $I_{\text{máx}}$, é', 'B', 'Calcule quanto da tensão da bateria sobra para o resistor quando o LED está aceso e veja que corrente isso gera.', '$4{,}5 - 3{,}0 = 1{,}5$ V sobre um resistor de 1,5 kΩ dá exatamente 1,0 mA. Cada LED precisa do seu próprio resistor e precisa estar no sentido permitido.', 'Em cada ramo, o LED usa 3,0 V e o resistor fica com $4{,}5 - 3{,}0 = 1{,}5$ V, então $I = \frac{1{,}5}{1500} = 1{,}0$ mA, que é a $I_{\text{máx}}$. Assim, o certo é dois ramos em paralelo, cada um com resistor e LED no sentido da corrente (do + para o −): letra B. Na letra A, um único resistor divide 1,0 mA entre os dois LEDs (0,5 mA cada). Em C e E os LEDs estão invertidos, e em D os LEDs em série precisariam de 6,0 V.', 'difícil'),
('2024-D2-Q132', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2024, 132, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Divisor de tensão e lâmpadas', null, null, 'Uma caixa decorativa utiliza duas pequenas lâmpadas, **L₁** (6 V – 9 W) e **L₂** (12 V – 18 W), ligadas em série a uma bateria de tensão $V_{QR}$. Um fio resistivo **QR**, de 48 centímetros, está ligado em paralelo à bateria. Cinco pontos, *A*, *B*, *C*, *D* e *E*, dividem o fio **QR** em seis segmentos de comprimentos iguais. O circuito também tem um amperímetro com dois terminais. Um dos terminais (**P**) está ligado ao fio entre as duas lâmpadas. O outro terminal (***S***) está livre e será ligado ao fio **QR**. Dependendo do ponto em que esse terminal livre for conectado, ocorrerá a mudança na tensão à qual as lâmpadas são submetidas. Os demais fios do circuito têm resistências elétricas desprezíveis. A figura ilustra esse circuito.

{{figura:1}}', 'Em qual desses pontos o amperímetro deve ser conectado para que as lâmpadas acendam exatamente segundo as especificações de tensão e potência elétricas fornecidas?', 'B', 'Calcule a corrente e a resistência de cada lâmpada com $P = V \cdot i$ e veja que fração da tensão total fica em $L_1$.', 'As duas lâmpadas pedem 1,5 A. Em série, $L_1$ fica com 6 V de um total de 18 V, ou seja, 1/3. Ache no fio QR o ponto com o mesmo potencial de P.', 'Para $L_1$: $i = 9/6 = 1{,}5$ A; para $L_2$: $i = 18/12 = 1{,}5$ A. Em série com 1,5 A, $L_1$ fica com 6 V e $L_2$ com 12 V, totalizando 18 V, e $L_1$ recebe $\frac{6}{18} = \frac{1}{3}$ da tensão. No fio uniforme, o ponto com o mesmo potencial de P está a 1/3 do comprimento a partir de Q: $\frac{48}{3} = 16$ cm. Cada segmento tem $48/6 = 8$ cm, então 16 cm é o ponto B: letra B. Ali o amperímetro não desvia corrente e as lâmpadas funcionam como especificado.', 'difícil'),
('2025-D2-Q094', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 94, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Potência elétrica e fusíveis', null, null, 'Réguas elétricas são dispositivos que permitem a ligação segura e simultânea de dois ou mais aparelhos eletroeletrônicos à rede elétrica. Uma estudante comprou uma régua com seis tomadas, conforme a figura. Essa régua suporta uma intensidade máxima de corrente elétrica igual a 20 A. Acima desse valor, o fusível de segurança da régua se rompe, inutilizando-a até que um novo fusível seja instalado. Considere as potências nominais de alguns aparelhos eletroeletrônicos apresentadas no quadro.

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
('2025-D2-Q095', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 95, '5_alternativas', 'Física', 'Termologia', 'Irradiação térmica', null, null, '**TEXTO I**

**As mariposas**

As mariposa, quando chega o frio
Fica dando volta em volta da lâmpida pra se esquentá. [sic]

Fonte: BARBOSA, A. **Reviva: Adoniran Barbosa**. São Paulo: Som Livre, 2002 (fragmento).

**TEXTO II**

As mariposas se aproximam das lâmpadas atraídas pela luz, pois, sendo basicamente criaturas noturnas, estão adaptadas a seguir o brilho da lua, em um processo conhecido como orientação transversal. Assim, o que o sambista Adoniran Barbosa, no Texto I, descreve não é a causa, mas sim uma das consequências possíveis dessa aproximação. De fato, o calor gerado pelas lâmpadas, sobretudo as incandescentes, pode aquecer as mariposas.

Fonte: HERTZBERG, R. Por que as mariposas são tão atraídas por luzes fortes? **National Geographic**, nov. 2020 (adaptado).', 'Nesse contexto, o processo de transferência de calor para as mariposas que independe da presença de fluidos é a', 'C', 'Dos processos de propagação de calor, qual funciona até no vácuo?', 'Convecção precisa de um fluido em movimento; reflexão, refração e dispersão são fenômenos da luz, e não formas de transferir calor.', 'O calor da lâmpada chega à mariposa principalmente por ondas eletromagnéticas (sobretudo infravermelho). Essa é a irradiação térmica, a única forma de propagação de calor que não precisa de meio material e funciona até no vácuo: letra C. A convecção (E) depende justamente do movimento de um fluido, como o ar.', 'fácil'),
('2025-D2-Q108', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 108, '5_alternativas', 'Física', 'Dinâmica e leis de Newton', 'Atrito no plano inclinado', null, null, 'Para transportar uma caixa do primeiro para o segundo piso de uma construção, um trabalhador precisará arrasta-lá sobre um plano inclinado. O trabalhador começa a arrastar a caixa no primeiro piso, exercendo sobre ela uma força de grande intensidade, paralela ao seu deslocamento. Na medida em que a caixa sobe o plano inclinado, ele decide reduzir a força sobre ela, arrastando-a lentamente até chegar ao segundo piso. Considere que a caixa permanece em movimento nos encontros dos pisos com o plano inclinado, e que a rugosidade entre as superfícies permanece a mesma durante todo o percurso.', 'O comportamento da força de atrito entre a caixa e o chão no plano inclinado é representado em:', 'C', 'A força de atrito cinético depende do coeficiente de atrito e da força normal, e não da força que o trabalhador faz.', 'No plano inclinado a normal vale $N = mg\cos\theta$, que não muda durante a subida. A rugosidade também não muda. O que isso diz sobre o atrito?', 'Com a caixa sempre em movimento, o atrito é cinético: $F_{at} = \mu N$, com $N = mg\cos\theta$ no plano inclinado. Como $\mu$, a massa e a inclinação são constantes, o atrito fica constante o tempo todo, como no gráfico C. Reduzir a força do trabalhador muda a aceleração da caixa, mas não o atrito; por isso gráficos que caem junto com a força (D e E) estão errados.', 'média'),
('2025-D2-Q113', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 113, '5_alternativas', 'Física', 'Eletromagnetismo', 'Campo elétrico e cargas', null, null, 'A Figura 1 apresenta o esquema de um tubo de imagem em que um filamento, na posição A, libera elétrons por efeito termiônico. Esses elétrons formam um feixe estreito, que é acelerado por campos elétricos em direção à parte interna da tela. Nesse caminho, o feixe de elétrons passa por outro campo elétrico, na região B, atingindo, em seguida, a parte interna da tela do tubo, a qual é recoberta por um material que emite luz ao receber o impacto dos elétrons.

{{figura:1}}

Na Figura 2, a carga negativa representa o feixe de elétrons que é acelerado e, posteriormente, atinge um ponto da tela. O campo elétrico na região B apresenta a seguinte configuração:

{{figura:2}}

Fonte: Grupo de Reelaboração do Ensino de Física. **Física 3: eletromagnetismo**. São Paulo: Edusp, 2000 (adaptado).', 'Nessa situação, qual ponto da tela será atingido pelo feixe de elétrons?', 'B', 'Lembre que a força elétrica numa carga negativa tem sentido oposto ao do campo elétrico.', 'Na Figura 2 o campo aponta para cima. Descubra para onde o elétron é empurrado e procure na Figura 1 o ponto da tela nesse lado.', 'A força elétrica é $\vec{F} = q\vec{E}$. Como o elétron tem carga negativa, a força tem sentido contrário ao campo. O campo na região B aponta para cima, então o feixe é desviado para baixo e atinge o ponto 2 da tela: alternativa B. O ponto 1 seria o desvio de uma carga positiva, e o ponto 5 seria o caso sem campo.', 'média'),
('2025-D2-Q114', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 114, '5_alternativas', 'Física', 'Ondulatória e som', 'Ressonância', null, null, 'A tirinha ilustra um processo físico em que uma onda sonora, produzida pela Mônica, causa a quebra das taças de cristal. O fenômeno ondulatório que provoca a quebra das taças só é possível em razão de uma característica da voz produzida pela Mônica naquele momento, que, diferentemente do que sugere a tirinha, não está relacionada à sua intensidade.

{{figura:1}}

Fonte: Disponível em: https://artedafisicapibid.blogspot.com. Acesso em: 23 nov. 2021 (adaptado).', 'Esse fenômeno e a característica associada à voz da Mônica são, respectivamente,', 'B', 'O texto avisa que a quebra não depende da intensidade (o volume) da voz. Que outra característica do som pode fazer o vidro vibrar muito?', 'A taça tem uma frequência natural de vibração. Quando a fonte emite exatamente nessa frequência, a amplitude de vibração cresce muito. Que fenômeno é esse?', 'A taça quebra por ressonância: quando o som tem a mesma frequência natural de vibração da taça, ela passa a oscilar com amplitude cada vez maior até se romper. A característica da voz que importa é a frequência: alternativa B. Timbre (D) diferencia vozes e instrumentos, mas não é o que precisa coincidir; amplitude (E) está ligada à intensidade, que o texto descarta.', 'fácil'),
('2025-D2-Q118', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 118, '5_alternativas', 'Física', 'Hidrostática', 'Pressão e densidade', null, null, 'A laje de um depósito de bebidas tem 50 m² de área útil de armazenamento e foi projetada para suportar pressões de até 10⁴ Pa. O gerente do estabelecimento pretende armazenar um produto cuja densidade é 1 250 kg/m³. Considere a aceleração da gravidade igual a 10 m/s².', 'A altura máxima, em metro, de empilhamento do produto que essa laje é capaz de suportar é', 'C', 'A pressão de uma pilha de produto sobre a laje funciona como a de uma coluna de líquido: depende da densidade e da altura.', 'Use $p = d \cdot g \cdot h$ com a pressão máxima de $10^4$ Pa e isole $h$. A área de 50 m² não entra na conta.', 'A pressão exercida por uma camada de altura $h$ é $p = d \cdot g \cdot h$. Com o limite de $10^4$ Pa: $h = \frac{10^4}{1250 \cdot 10} = \frac{10\,000}{12\,500} = 0{,}8$ m, alternativa C. A área não importa: aumentar a área aumenta o peso e a superfície de apoio na mesma proporção, e a pressão continua igual.', 'fácil'),
('2025-D2-Q119', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 119, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Associação de geradores', null, null, 'Em uma comunidade rural, os moradores utilizam uma bomba-d’água alimentada por 100 V de tensão contínua, podendo variar em até 5 V. Um eletrotécnico pretende instalar placas fotovoltaicas para alimentar essa bomba. As placas são idênticas e cada uma apresenta tensão de operação igual a 34 V com corrente de 7,5 A. Além disso, cada placa apresenta 40 V de tensão elétrica, quando em circuito aberto. Assim, considerando que a placa descrita é um gerador não ideal, em circuito aberto ela pode ser representada conforme a figura:

{{figura:1}}

O eletrotécnico construiu um circuito que permite à bomba-d’água operar corretamente com o menor número possível de placas conectadas. Para isso, desenhou um diagrama no qual todas essas placas são representadas como um único gerador não ideal, com a especificação das correspondentes características elétricas.', 'O diagrama que representa o circuito construído pelo eletrotécnico é:', 'B', 'Primeiro descubra a resistência interna de uma placa usando os valores de circuito aberto e de operação.', 'Uma placa perde $40 - 34 = 6$ V em $7{,}5$ A. Depois, veja quantas placas em série dão entre 95 V e 105 V em operação, e some as fem e as resistências.', 'A resistência interna de cada placa é $r = \frac{40 - 34}{7{,}5} = 0{,}8\,\Omega$. Em operação, cada placa fornece 34 V; com 3 em série, $3 \cdot 34 = 102$ V, que está entre 95 V e 105 V (2 placas dariam só 68 V). O gerador equivalente tem $\varepsilon = 3 \cdot 40 = 120$ V e $r = 3 \cdot 0{,}8 = 2{,}4\,\Omega$: alternativa B. A alternativa D usa 102 V como fem, mas esse é o valor em operação, não a força eletromotriz.', 'difícil'),
('2025-D2-Q120', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 120, '5_alternativas', 'Física', 'Cinemática', 'Velocidade média e tempo', null, null, 'A figura ilustra as informações contidas no manual de um sistema de alarme que utiliza transmissores e receptores de radiação eletromagnética para a detecção de movimento. O receptor é regulado pelo tempo de resposta, que corresponde ao intervalo de tempo necessário para o corpo do invasor atravessar completamente o feixe, de diâmetro d = 15 cm. Considere que a menor porção do corpo de um invasor é a sua posição de perfil, cuja espessura típica é 20 cm. São indicados cinco possíveis movimentos de um invasor e suas velocidades típicas, que devem ser observadas para a escolha do tempo de resposta.

{{figura:1}}

Fonte: **Manual de referência e instalação**: sensor de barreira ativo. Disponível em: cs.ind.br. Acesso em: 2 dez. 2021 (adaptado).', 'Nesse sistema, o menor tempo de resposta, em milissegundo, que garante a detecção de um possível invasor é mais próximo de', 'B', 'Para garantir a detecção de qualquer invasor, pense no movimento que atravessa o feixe no menor tempo.', 'Para atravessar completamente, o corpo percorre a própria espessura mais o diâmetro do feixe: $20 + 15 = 35$ cm. Use a maior velocidade da figura.', 'O sistema precisa responder até mesmo ao invasor mais rápido, que fica menos tempo no feixe. Para atravessá-lo por completo, o corpo percorre $20 + 15 = 35$ cm $= 0{,}35$ m. Correndo a 5,0 m/s: $t = \frac{0{,}35}{5{,}0} = 0{,}07$ s $= 70$ ms, alternativa B. A alternativa E (700 ms) usa a menor velocidade (0,5 m/s); com esse tempo de resposta, quem passa correndo não seria detectado.', 'difícil'),
('2025-D2-Q122', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 122, '5_alternativas', 'Física', 'Eletromagnetismo', 'Indução eletromagnética', null, null, 'O aquecimento em fogões por indução utiliza bobinas para produzir um campo magnético variável. Essa bobina se localiza abaixo do vidro cerâmico sobre o qual a panela se apoia. O mecanismo aquece apenas a panela que se encontra na zona de cozimento, o que é uma das principais vantagens em relação ao uso do fogão a gás ou de resistência elétrica.

{{figura:1}}

Fonte: PEREIRA, A. B. et al. **Fogões de indução**: montagem e testes de um circuito disponível. Disponível em: https://publicacoes.fatecsertaozinho.edu.br. Acesso em: 21 maio 2025 (adaptado).', 'O uso do campo magnético variável tem a finalidade de', 'D', 'Lembre da lei de Faraday: o que um campo magnético variável provoca em um material condutor?', 'Um fluxo magnético variável induz correntes elétricas no metal da panela. O que acontece com um condutor percorrido por corrente?', 'O campo magnético variável da bobina produz, pela lei de Faraday, correntes elétricas induzidas no fundo metálico da panela. Essas correntes dissipam energia na forma de calor pelo efeito Joule, e a panela se aquece: alternativa D. O vidro e o ar não esquentam por convecção ou radiação vinda da bobina (C e E); a panela esquenta e depois transfere calor ao alimento.', 'média'),
('2025-D2-Q126', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 126, '5_alternativas', 'Física', 'Cinemática', 'Composição vetorial de velocidades', null, null, 'Segundo o princípio da independência dos movimentos, de Galileu, sempre que a velocidade resultante de um corpo puder ser decomposta em duas ou mais componentes perpendiculares entre si, cada um desses movimentos poderá ser analisado separadamente como se os outros não existissem. Esse princípio é muito útil para a simplificação de alguns problemas reais, em três dimensões.

Considere um avião que, ao decolar, é instruído pela torre a atingir, em 6 minutos, uma posição de 20 km a Leste, 20 km a Norte e 1 km de altitude em relação ao ponto de decolagem, conforme a figura (fora de escala). No entanto, no instante da decolagem, começa a soprar um vento cujo vetor velocidade tem componentes 30 km/h para Leste, 20 km/h para Sul e 1 km/h de cima para baixo.

{{figura:1}}', 'Durante a ação do vento, a velocidade $\vec{v}$ que o piloto deve estabelecer em relação ao ar para que o avião chegue à posição esperada no tempo indicado tem as componentes', 'D', 'Calcule a velocidade que o avião precisa ter em relação ao solo e depois desconte o efeito do vento, uma direção de cada vez.', '6 min é 0,1 h, então em relação ao solo são 200 km/h Leste, 200 km/h Norte e 10 km/h para cima. Use $\vec{v}_{ar} = \vec{v}_{solo} - \vec{v}_{vento}$ em cada eixo.', 'Em 0,1 h o avião precisa percorrer 20 km Leste, 20 km Norte e 1 km para cima: em relação ao solo, 200, 200 e 10 km/h. Subtraindo o vento: Leste $200 - 30 = 170$; Norte $200 - (-20) = 220$ (o vento empurra para o Sul, então o piloto compensa); vertical $10 - (-1) = 11$ para cima. Alternativa D. A alternativa B soma o vento em vez de descontá-lo.', 'difícil'),
('2025-D2-Q128', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 128, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Resistência e temperatura', null, null, 'A resistência de um fio de platina pode ser usada para medir temperaturas entre 0 °C e 100 °C e já foi utilizada como referência para a escala internacional de temperatura. Para um sensor feito de platina, a relação entre a resistência e a temperatura pode ser descrita por uma equação do tipo $R(T) = A + BT$, em que $T$ é a temperatura e A e B são constantes. O gráfico apresenta a dependência da resistência em função da temperatura para cinco diferentes sensores.

{{figura:1}}', 'Os sensores que apresentam maior sensibilidade são', 'E', 'Sensibilidade é o quanto a resistência muda para cada grau de variação na temperatura.', 'Na equação $R = A + BT$, a sensibilidade é o coeficiente $B$, ou seja, a inclinação da reta. Compare a variação de resistência de cada sensor no mesmo intervalo de temperatura.', 'A sensibilidade é a inclinação da reta $R(T)$. No mesmo intervalo de temperatura, o sensor 2 varia cerca de $225 - 76 \approx 149\,\Omega$ e o sensor 5 cerca de $145 - 66 \approx 79\,\Omega$, as duas maiores variações. O sensor 4 varia uns $58\,\Omega$, o 3 uns $22\,\Omega$ e o 1 quase nada. Logo, os mais sensíveis são 2 e 5, alternativa E. Não confunda com o valor da resistência: o sensor 1 tem a maior resistência, mas é o menos sensível.', 'média'),
('2025-D2-Q130', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 130, '5_alternativas', 'Física', 'Eletricidade e circuitos', 'Associação de resistores', null, null, 'Em sua maioria, os equipamentos eletrônicos domésticos demandam baixa potência elétrica em corrente contínua. Para alimentá-los, uma fonte externa ou embutida transforma a corrente alternada em corrente contínua de baixa tensão. Entretanto, cada equipamento tem suas especificidades, e muitas vezes não é possível simplesmente trocar essas fontes sem levar em conta a tensão, a corrente ou a potência elétrica de saída.

Considere um equipamento de resistência elétrica $R_C$ que funciona corretamente apenas em um dado valor de tensão. Porém, a única fonte de alimentação disponível fornece uma tensão 20% superior à tensão recomendada. Para adaptar essa fonte ao aparelho, a associação de um resistor de proteção $R_P$, de potência adequada, se faz necessária.', 'A configuração adequada do circuito e o valor do resistor de proteção, em relação ao valor da resistência do equipamento, são:', 'E', 'Para dividir a tensão entre dois componentes, eles precisam estar em série. Em paralelo, os dois recebem a mesma tensão da fonte.', 'Se a fonte dá $1{,}2V$ e o equipamento precisa de $V$, o resistor de proteção deve ficar com $0{,}2V$. Em série a corrente é a mesma, então a tensão é proporcional à resistência.', 'Em paralelo o equipamento continuaria recebendo a tensão total da fonte, então o resistor deve ficar em série. A fonte fornece $1{,}2V$; o equipamento precisa de $V$, logo sobram $0{,}2V$ para $R_P$. Com a mesma corrente $i$: $\frac{R_P}{R_C} = \frac{0{,}2V}{V} = 0{,}2$, ou seja, $R_P = 0{,}2\,R_C$ em série, alternativa E. A alternativa C ($1{,}2\,R_C$) faria o equipamento receber menos da metade da tensão total.', 'média'),
('2025-D2-Q135', 'enem', 'enem-FIS', 'INEP', null, null, 'Médio', 2025, 135, '5_alternativas', 'Física', 'Ondulatória e som', 'Frequência e comprimento de onda', null, null, 'A icterícia é uma doença que acomete recém-nascidos e pode ser tratada com um método de fototerapia conhecido como banho de luz, que consiste na exposição do recém-nascido a uma fonte luminosa equipada com LEDs azuis. Para o monitoramento da dosagem dessa radiação, é utilizada a resposta óptica de um sensor constituído de materiais orgânicos que luminescem quando expostos à luz azul. Com o passar do tempo, essa radiação oxida os materiais do sensor, alterando sua coloração de vermelho-laranja para verde, o que indica o final do tratamento.

O gráfico apresenta o espectro de fotoluminescência do sensor em função do comprimento de onda da luz emitida no início do tratamento, quando o sensor, colado na fralda do bebê (Figura 1), luminesce na região do vermelho-laranja (∼600 nm). A Figura 2 apresenta a evolução da coloração do sensor, mostrando que a frequência da luz emitida por ele aumenta em função do tempo de exposição à luz azul.

{{figura:1}}

Fonte: SILVA, M. M. et al. Fabricação de sensor orgânico flexível para aplicação em terapia com luz azul. **Tecnol. Metal. Mater. Miner.**, n. 3, jul.-set. 2011 (adaptado).', 'Os espectros de fotoluminescência do sensor no início e no final do tratamento estão esboçados no gráfico:', 'A', 'No fim do tratamento o sensor fica verde. Pense em como o pico do espectro deve se mover no eixo do comprimento de onda.', 'Frequência maior significa comprimento de onda menor ($c = \lambda f$). O verde fica por volta de 550 nm, à esquerda do vermelho-laranja de 600 nm.', 'No início, o pico de emissão está em cerca de 600 nm (vermelho-laranja). Com o tempo, a frequência da luz emitida aumenta e a cor vai para o verde; como $\lambda = c/f$, o comprimento de onda diminui. Assim, o pico do final deve ficar deslocado para a esquerda, perto de 550 nm, como no gráfico A. O gráfico B desloca o pico para comprimentos maiores (frequência menor), e C, D e E mantêm o pico em 600 nm, o que não mudaria a cor.', 'média')
on conflict (id) do update set exame_id = excluded.exame_id, recorte_id = excluded.recorte_id, banca = excluded.banca, orgao = excluded.orgao, cargo = excluded.cargo, nivel = excluded.nivel, ano = excluded.ano, numero = excluded.numero, formato = excluded.formato, disciplina = excluded.disciplina, assunto = excluded.assunto, topico = excluded.topico, lingua = excluded.lingua, texto_base_id = excluded.texto_base_id, texto_apoio = excluded.texto_apoio, comando = excluded.comando, gabarito = excluded.gabarito, dica1 = excluded.dica1, dica2 = excluded.dica2, explicacao = excluded.explicacao, dificuldade = excluded.dificuldade;
delete from public.alternativas where questao_id in ('2024-D2-Q091', '2024-D2-Q096', '2024-D2-Q099', '2024-D2-Q100', '2024-D2-Q101', '2024-D2-Q103', '2024-D2-Q106', '2024-D2-Q119', '2024-D2-Q121', '2024-D2-Q122', '2024-D2-Q127', '2024-D2-Q130', '2024-D2-Q131', '2024-D2-Q132', '2025-D2-Q094', '2025-D2-Q095', '2025-D2-Q108', '2025-D2-Q113', '2025-D2-Q114', '2025-D2-Q118', '2025-D2-Q119', '2025-D2-Q120', '2025-D2-Q122', '2025-D2-Q126', '2025-D2-Q128', '2025-D2-Q130', '2025-D2-Q135');
insert into public.alternativas (questao_id, letra, texto, imagem) values
('2024-D2-Q091', 'A', 'aciona os airbags do veículo.', null),
('2024-D2-Q091', 'B', 'absorve a energia cinética do sistema.', null),
('2024-D2-Q091', 'C', 'consome a quantidade de movimento do sistema.', null),
('2024-D2-Q091', 'D', 'cria uma barreira de proteção para seus ocupantes.', null),
('2024-D2-Q091', 'E', 'diminui a velocidade do centro de massa do sistema.', null),
('2024-D2-Q096', 'A', '1', null),
('2024-D2-Q096', 'B', '2', null),
('2024-D2-Q096', 'C', '3', null),
('2024-D2-Q096', 'D', '4', null),
('2024-D2-Q096', 'E', '5', null),
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
('2024-D2-Q103', 'A', 'difusão.', null),
('2024-D2-Q103', 'B', 'absorção.', null),
('2024-D2-Q103', 'C', 'condução.', null),
('2024-D2-Q103', 'D', 'irradiação.', null),
('2024-D2-Q103', 'E', 'convecção.', null),
('2024-D2-Q106', 'A', 'Os raios X não interagem com os componentes metálicos do computador, o que impede a formação de imagens.', null),
('2024-D2-Q106', 'B', 'Os raios X desmagnetizam o disco rígido do computador, quando refratados pelos componentes metálicos das bagagens de mão.', null),
('2024-D2-Q106', 'C', 'Os raios X aquecem os materiais metálicos encontrados em bagagens de mão, quando refletidos pelos componentes do computador.', null),
('2024-D2-Q106', 'D', 'Os raios X não atravessam os componentes densos do computador, o que impede a visualização de objetos que estão à frente ou atrás deles.', null),
('2024-D2-Q106', 'E', 'Os raios X ionizam os materiais metálicos normalmente encontrados em bagagens de mão, quando difratados pelos componentes do computador.', null),
('2024-D2-Q119', 'A', '42', null),
('2024-D2-Q119', 'B', '65', null),
('2024-D2-Q119', 'C', '72', null),
('2024-D2-Q119', 'D', '105', null),
('2024-D2-Q119', 'E', '120', null),
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
('2024-D2-Q127', 'A', null, 'imagens/2024/D2/q127_alt_A.webp'),
('2024-D2-Q127', 'B', null, 'imagens/2024/D2/q127_alt_B.webp'),
('2024-D2-Q127', 'C', null, 'imagens/2024/D2/q127_alt_C.webp'),
('2024-D2-Q127', 'D', null, 'imagens/2024/D2/q127_alt_D.webp'),
('2024-D2-Q127', 'E', null, 'imagens/2024/D2/q127_alt_E.webp'),
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
('2025-D2-Q108', 'A', null, 'imagens/2025/D2/q108_alt_A.webp'),
('2025-D2-Q108', 'B', null, 'imagens/2025/D2/q108_alt_B.webp'),
('2025-D2-Q108', 'C', null, 'imagens/2025/D2/q108_alt_C.webp'),
('2025-D2-Q108', 'D', null, 'imagens/2025/D2/q108_alt_D.webp'),
('2025-D2-Q108', 'E', null, 'imagens/2025/D2/q108_alt_E.webp'),
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
('2025-D2-Q122', 'A', 'imantar o material da panela por indução.', null),
('2025-D2-Q122', 'B', 'movimentar os átomos de ferro concentrados no fundo da panela.', null),
('2025-D2-Q122', 'C', 'emitir radiação eletromagnética, aquecendo a panela através do vidro cerâmico.', null),
('2025-D2-Q122', 'D', 'induzir corrente elétrica na parte inferior da panela, aquecendo-a por efeito Joule.', null),
('2025-D2-Q122', 'E', 'gerar um fluxo de corrente de convecção no ar contido entre a região da bobina e o vidro cerâmico.', null),
('2025-D2-Q126', 'A', '230 km/h para Leste, 180 km/h para Sul e 9 km/h para baixo.', null),
('2025-D2-Q126', 'B', '230 km/h para Leste, 180 km/h para Norte e 9 km/h para cima.', null),
('2025-D2-Q126', 'C', '200 km/h para Oeste, 200 km/h para Norte e 10 km/h para cima.', null),
('2025-D2-Q126', 'D', '170 km/h para Leste, 220 km/h para Norte e 11 km/h para cima.', null),
('2025-D2-Q126', 'E', '170 km/h para Leste, 180 km/h para Norte e 11 km/h para cima.', null),
('2025-D2-Q128', 'A', '1 e 2.', null),
('2025-D2-Q128', 'B', '1 e 3.', null),
('2025-D2-Q128', 'C', '2 e 3.', null),
('2025-D2-Q128', 'D', '2 e 4.', null),
('2025-D2-Q128', 'E', '2 e 5.', null),
('2025-D2-Q130', 'A', null, 'imagens/2025/D2/q130_alt_A.webp'),
('2025-D2-Q130', 'B', null, 'imagens/2025/D2/q130_alt_B.webp'),
('2025-D2-Q130', 'C', null, 'imagens/2025/D2/q130_alt_C.webp'),
('2025-D2-Q130', 'D', null, 'imagens/2025/D2/q130_alt_D.webp'),
('2025-D2-Q130', 'E', null, 'imagens/2025/D2/q130_alt_E.webp'),
('2025-D2-Q135', 'A', null, 'imagens/2025/D2/q135_alt_A.webp'),
('2025-D2-Q135', 'B', null, 'imagens/2025/D2/q135_alt_B.webp'),
('2025-D2-Q135', 'C', null, 'imagens/2025/D2/q135_alt_C.webp'),
('2025-D2-Q135', 'D', null, 'imagens/2025/D2/q135_alt_D.webp'),
('2025-D2-Q135', 'E', null, 'imagens/2025/D2/q135_alt_E.webp');
delete from public.questao_figuras where questao_id in ('2024-D2-Q091', '2024-D2-Q096', '2024-D2-Q099', '2024-D2-Q100', '2024-D2-Q101', '2024-D2-Q103', '2024-D2-Q106', '2024-D2-Q119', '2024-D2-Q121', '2024-D2-Q122', '2024-D2-Q127', '2024-D2-Q130', '2024-D2-Q131', '2024-D2-Q132', '2025-D2-Q094', '2025-D2-Q095', '2025-D2-Q108', '2025-D2-Q113', '2025-D2-Q114', '2025-D2-Q118', '2025-D2-Q119', '2025-D2-Q120', '2025-D2-Q122', '2025-D2-Q126', '2025-D2-Q128', '2025-D2-Q130', '2025-D2-Q135');
insert into public.questao_figuras (questao_id, ordem, imagem, descricao) values
('2024-D2-Q091', 1, 'imagens/2024/D2/q091_fig1.webp', 'Ilustração de um carro em corte lateral colidindo de frente contra um muro listrado de vermelho e branco, com a parte dianteira amassada. Dois bonecos de teste (manequins de colisão) estão sentados nos bancos dianteiro e traseiro. Legendas apontam: "Crumple zone (Região deformável)" para a frente deformada do carro; "Air bag" para o airbag inflado diante do motorista; "Seat belts (Cintos de segurança)" para os cintos dos dois ocupantes.'),
('2024-D2-Q096', 1, 'imagens/2024/D2/q096_fig1.webp', 'Desenho de uma roda com pneu (escrito "PNEU" no topo e embaixo), vista de frente, com duas linhas tracejadas passando pelo centro geométrico (uma vertical e uma horizontal). O ponto "CM" (laranja) está deslocado do centro para cima e para a direita (no quadrante superior direito, próximo ao eixo vertical). Na borda da roda há cinco pontos amarelos numerados: 1 no topo (sobre o eixo vertical); 5 na parte superior direita; 2 à esquerda (sobre o eixo horizontal); 3 na parte inferior esquerda; 4 embaixo (sobre o eixo vertical).'),
('2024-D2-Q100', 1, 'imagens/2024/D2/q100_fig1.webp', 'Acima, ilustração do mirascópio: um objeto escuro em forma de disco (duas cúpulas unidas pela borda), com a imagem de uma raposa de pé sobre a abertura circular do topo. Abaixo, esquema em corte: espelho côncavo inferior E₁ (com a raposa sobre seu vértice, apoiado numa superfície horizontal) e espelho côncavo superior E₂, com abertura no topo de 5 cm. Raios de luz partem do objeto no vértice de E₁, refletem em E₂ (descendo verticalmente) e depois em E₁, convergindo para um ponto na abertura de E₂. Cotas: largura total de 23 cm; altura de 3,8 cm entre a base e a junção das bordas e mais 3,8 cm da junção até o topo.'),
('2024-D2-Q101', 1, 'imagens/2024/D2/q101_fig1.webp', 'Infográfico: um professor fala diante de um quadro e cinco estudantes sentados em carteiras dispostas em fila, sobre uma escala de distância de 0 a 10 m. Acima, gráfico do “Nível sonoro (dB)” (eixo vertical, de 0 a 60) em função da “Distância (m)” (eixo horizontal, de 0 a 10): a curva começa em 60 dB a 1 m, cai para cerca de 53 dB a 2 m, cerca de 50 dB a 3 m, cerca de 46 dB a 4 m, cerca de 45 dB a 5 m, cerca de 44 dB a 6 m, cerca de 42 dB a 7 m, cerca de 41 dB a 8 m, cerca de 39 dB a 9 m e cerca de 38 dB a 10 m.'),
('2024-D2-Q103', 1, 'imagens/2024/D2/q103_fig1.webp', 'Esquema de um aquecedor solar: um reservatório cilíndrico horizontal (“Reservatório de água”), envolto por “Isolamento térmico de poliuretano”, posicionado acima de um “Coletor solar de tubo a vácuo” (painel inclinado com vários tubos escuros) que recebe “Radiação solar” (setas vindas do Sol). Um cano azul leva “Água fria” do reservatório até a parte inferior do coletor, e um cano vermelho leva “Água quente” do coletor de volta ao reservatório, subindo para sua parte superior.'),
('2024-D2-Q119', 1, 'imagens/2024/D2/q119_fig1.webp', 'Retângulo tracejado com boias (pontos pretos) nos vértices: 1 (inferior esquerdo), 2 (inferior direito), 3 (superior direito) e 4 (superior esquerdo). Os lados horizontais medem 800 m e os verticais 400 m. Dentro do retângulo, perto do lado 2–3, há o vetor υc apontando para baixo (paralelo aos lados verticais). Sobre o lado 1–2 há um vetor υn inclinado apontando para cima e para a direita; sobre o lado 4–3 há um vetor υn inclinado apontando para cima e para a esquerda.'),
('2024-D2-Q121', 1, 'imagens/2024/D2/q121_fig1.webp', 'Tirinha de Calvin em quatro quadrinhos. 1º: Calvin sorri sentado em um balanço, subindo. 2º: Calvin solta-se do balanço no ponto mais alto gritando "IIAUUUUUUU"; o assento do balanço fica para trás. 3º: Calvin voa pelo ar, deitado de costas, com traços de movimento à direita dele, indicando que se move para a esquerda. 4º: Calvin cai de cabeça para baixo em direção ao chão e diz: "HOUSTON, ESTAMOS COM UM PROBLEMA NA TRAJETÓRIA ORBITAL." Assinatura: WATTERSON.'),
('2024-D2-Q122', 1, 'imagens/2024/D2/q122_fig1.webp', 'Tirinha de Laerte em três quadrinhos verticais, dentro de um iglu. 1º: dois esquimós caminham ao lado de uma geladeira; um pergunta "Ué, você comprou uma geladeira?!" e o outro responde "É". 2º: um deles retira uma forma de gelo do congelador; diálogo: "Pra quê?!" — "É para as crianças.". 3º: duas crianças esquimós brincam montando um pequeno iglu com cubos de gelo, com a forma de gelo ao lado; legenda em balão: "Elas adoram brincar de casinha."'),
('2024-D2-Q127', 1, 'imagens/2024/D2/q127_fig1.webp', 'Vista superior: duas barras verticais paralelas, A à esquerda (com sinais + ao lado) e B à direita (com sinais – ao lado). Entre elas, nove linhas de campo horizontais, retas, igualmente espaçadas, com setas apontando de A para B.'),
('2024-D2-Q130', 1, 'imagens/2024/D2/q130_fig1.webp', 'Diagrama P (eixo vertical) × V (eixo horizontal) do ciclo de Otto. Pontos: 0 e 1 na mesma pressão baixa (0 com volume menor, 1 com volume maior), ligados por linha tracejada horizontal; 2 acima de 0, no volume menor; 3 acima de 2, no mesmo volume; 4 acima de 1, no volume maior. Curvas: de 1 a 2 uma curva descendente-côncava (compressão); de 2 a 3 segmento vertical; de 3 a 4 curva decrescente (expansão); de 4 a 1 segmento vertical. A área interna do ciclo 1-2-3-4, sombreada em amarelo, é marcada com "W".'),
('2024-D2-Q131', 1, 'imagens/2024/D2/q131_fig1.webp', 'Símbolo do LED, com o rótulo "LED": um triângulo amarelo apontando para a direita encostado em uma barra vertical (diodo), com duas pequenas setas saindo para cima indicando emissão de luz, ligado a fios horizontais nos dois lados. Abaixo, o texto "Sentido permitido da corrente" e uma seta vermelha apontando para a direita.'),
('2024-D2-Q132', 1, 'imagens/2024/D2/q132_fig1.webp', 'Circuito retangular. No fio superior, a lâmpada L₁ à esquerda e a lâmpada L₂ à direita, com o ponto P entre elas. De P sai um fio até o amperímetro (círculo com "A") e daí um terminal solto com seta, marcado S. No meio do retângulo, um fio resistivo horizontal de Q (esquerda) a R (direita), com os pontos A, B, C, D e E igualmente espaçados entre eles. No fio inferior, a bateria com tensão V_QR. Abaixo, uma cota de largura total "48 cm".'),
('2025-D2-Q094', 1, 'imagens/2025/D2/q094_fig1.webp', 'Foto de uma régua elétrica (filtro de linha) branca com seis tomadas de três pinos alinhadas, um interruptor e um cabo com plugue.'),
('2025-D2-Q113', 1, 'imagens/2025/D2/q113_fig1.webp', 'Figura 1: esquema de um tubo de imagem visto de lado. À esquerda, o filamento na posição "A", seguido de discos aceleradores; adiante, a região "B" com duas placas paralelas (uma acima e outra abaixo do eixo do feixe). O tubo se alarga até a "Tela", na qual estão marcados os pontos: "1" (acima), "2" (abaixo), "5" (centro, na direção do eixo), "4" (à esquerda do centro) e "3" (à direita do centro).'),
('2025-D2-Q113', 2, 'imagens/2025/D2/q113_fig2.webp', 'Figura 2: duas placas horizontais paralelas com linhas de campo elétrico verticais apontando para cima (vetor $\vec{E}$, de baixo para cima). Uma carga negativa (círculo amarelo com sinal "–") entra pela esquerda com velocidade $\vec{v}$ horizontal para a direita.'),
('2025-D2-Q114', 1, 'imagens/2025/D2/q114_fig1.webp', 'Tirinha em preto e branco de Mauricio de Sousa, em um quadro: um homem de óculos, sentado à mesa, olha assustado para a taça quebrada à sua frente; ao centro, Mônica, sentada à mesa com a boca aberta, e Cebolinha ao lado, de braços cruzados; à direita, um garçom segura uma bandeja com taças estilhaçadas, com o líquido escorrendo. Balão de fala: "E QUEM ESTÁ GRITANDO MUITO?".'),
('2025-D2-Q119', 1, 'imagens/2025/D2/q119_fig1.webp', 'Símbolo de gerador não ideal em circuito aberto: bateria com polos "–" (à esquerda) e "+" (à direita), força eletromotriz "ε = 40 V", em série com um resistor "r" (resistência interna).'),
('2025-D2-Q120', 1, 'imagens/2025/D2/q120_fig1.webp', 'Ilustração de um sensor de barreira: um "Transmissor" à esquerda emite um feixe horizontal (vermelho) até um "Receptor" à direita; no receptor está indicado o diâmetro "d" do feixe. Abaixo, cinco movimentos de um invasor com suas velocidades típicas: subindo um muro de tijolos (seta para cima) — 0,5 m/s; descendo o muro (seta para baixo) — 0,7 m/s; andando — 1,0 m/s; andando rápido — 2,0 m/s; correndo — 5,0 m/s.'),
('2025-D2-Q122', 1, 'imagens/2025/D2/q122_fig1.webp', 'Esquema de fogão por indução: uma panela tampada com líquido borbulhando ("Conteúdo aquecido"), com setas vermelhas nas paredes e no fundo indicando "Transferência do calor gerado na panela"; abaixo dela, uma placa de "Vidro cerâmico"; sob o vidro, uma "Bobina de indução" (fio enrolado em cilindro) com linhas de "Campo magnético criado por bobina de indução" entrando por uma extremidade e saindo pela outra.'),
('2025-D2-Q126', 1, 'imagens/2025/D2/q126_fig1.webp', 'Sistema de eixos em perspectiva com as direções Norte (eixo inclinado para cima à direita), Sul (oposto, para baixo à esquerda), Leste (horizontal à direita), Oeste (horizontal à esquerda) e um eixo vertical. Um avião verde está na origem, com um vetor $\vec{v}$ apontando para cima e à direita. Linhas tracejadas azuis partem do eixo Leste e do eixo Norte e se encontram em um ponto no plano horizontal, de onde uma linha tracejada vertical sobe até um ponto preto indicado por uma seta com o rótulo "Posição a ser atingida".'),
('2025-D2-Q128', 1, 'imagens/2025/D2/q128_fig1.webp', 'Gráfico de Resistência (ohm), de 50 a 250, em função da Temperatura (°C), de −100 a 350, com cinco retas de −50 °C a cerca de 320 °C. Sensor 1 (laranja): de cerca de 225 a 229 ohm, quase horizontal. Sensor 2 (verde): de cerca de 76 a 225 ohm, a mais inclinada. Sensor 3 (roxo): de cerca de 147 a 169 ohm. Sensor 4 (azul-claro): de cerca de 91 a 149 ohm. Sensor 5 (lilás): de cerca de 66 a 145 ohm.'),
('2025-D2-Q135', 1, 'imagens/2025/D2/q135_fig1.webp', 'Três partes. Gráfico: Fotoluminescência (u.a.), de 0,0 a 1,2, em função do Comprimento de onda (nm), de cerca de 525 a 725 nm; curva cinza com pico de 1,0 em 600 nm, valendo cerca de 0,3 em 525 nm e cerca de 0,1 em 725 nm. Figura 1: foto de um bebê sob luz azul, com um sensor vermelho em forma de coração colado na fralda. Figura 2: coluna de corações coloridos com tempos de exposição — 0 h (vermelho), 3 h (laranja-avermelhado), 6 h (laranja), 9 h (amarelo-esverdeado) e 12 h (verde) —, ladeada por uma seta para cima rotulada "Frequência" e outra seta para cima rotulada "Tempo de exposição".');
commit;
