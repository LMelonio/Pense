-- Questões de enem-MAT (89)
begin;
insert into public.questoes (id, exame_id, recorte_id, banca, orgao, cargo, nivel, ano, numero, formato, disciplina, assunto, topico, lingua, texto_base_id, texto_apoio, comando, gabarito, dica1, dica2, explicacao, dificuldade) values
('2024-D2-Q136', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 136, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Conversão de unidades de comprimento', null, null, 'O tamanho mínimo que a visão humana é capaz de visualizar sem o uso de equipamento auxiliar é equivalente a 100 micrômetros (1 micrômetro = 10⁻³ milímetros). Uma estudante pretende visualizar e analisar hemácias do sangue humano, que medem 0,007 mm de diâmetro. Ela adquiriu um microscópio óptico que tem uma lente ocular que amplia em 10 vezes a imagem do objeto em observação, e um conjunto de lentes objetivas com estas capacidades de ampliação:

- lente I: 2 vezes;
- lente II: 10 vezes;
- lente III: 15 vezes;
- lente IV: 1,1 vez;
- lente V: 1,4 vez.

{{figura:1}}

O funcionamento desse microscópio permite o uso da lente ocular sozinha ou a combinação dela com uma de suas lentes objetivas, proporcionando, nesse caso, um aumento de sua capacidade de ampliação final, que é dada pelo produto entre as capacidades de ampliação da ocular e da objetiva.

Essa estudante pretende selecionar a lente objetiva de menor capacidade de ampliação que permita, na combinação com a ocular, visualizar hemácias do sangue humano.', 'A lente objetiva a ser selecionada pela estudante é a', 'A', 'Converta tudo para a mesma unidade: quanto vale 100 micrômetros em milímetros?', 'A hemácia ampliada precisa medir pelo menos $0{,}1$ mm. Descubra a ampliação total mínima e divida pelos 10 vezes da ocular.', 'Como $100\ \mu m = 100 \times 10^{-3} = 0{,}1$ mm, a ampliação total deve ser pelo menos $0{,}1 \div 0{,}007 \approx 14{,}3$ vezes. A ocular já dá 10 vezes, então a objetiva precisa ampliar no mínimo $14{,}3 \div 10 \approx 1{,}43$ vez. A menor objetiva que atende é a lente I (2 vezes), letra A: $10 \times 2 = 20$ vezes. A lente V é a armadilha: $10 \times 1{,}4 = 14$ vezes deixa a hemácia com $0{,}098$ mm, ainda abaixo de $0{,}1$ mm.', 'média'),
('2024-D2-Q137', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 137, '5_alternativas', 'Matemática', 'Estatística', 'Média aritmética', null, null, 'Ao calcular a média de suas notas em 4 provas, um estudante dividiu, por engano, a soma das notas por 5. Com isso, a média obtida foi 1 unidade menor do que deveria ser, caso fosse calculada corretamente.', 'O valor correto da média das notas desse estudante é', 'B', 'Chame a soma das notas de $S$ e escreva as duas médias: a certa e a errada.', 'A média certa é $\frac{S}{4}$ e a errada é $\frac{S}{5}$. Monte a equação $\frac{S}{4} - \frac{S}{5} = 1$.', 'Com soma $S$, a média correta é $\frac{S}{4}$ e a calculada por engano é $\frac{S}{5}$. Como a diferença é 1: $\frac{S}{4} - \frac{S}{5} = \frac{S}{20} = 1$, logo $S = 20$. A média correta é $\frac{20}{4} = 5$, letra B. Cuidado para não marcar 4: esse é o valor da média errada ($\frac{20}{5}$).', 'fácil'),
('2024-D2-Q138', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 138, '5_alternativas', 'Matemática', 'Análise combinatória', 'Princípio fundamental da contagem', null, null, 'Para abrir a porta de uma empresa, cada funcionário deve cadastrar uma senha utilizando um teclado alfanumérico como o representado na figura.

{{figura:1}}

Por exemplo: a tecla que contém o número 2 traz as letras correlacionadas A, B e C. Cada toque nessa tecla mostra, sequencialmente, os seguintes caracteres: 2, A, B e C. Para os próximos toques, essa sequência se repete. As demais teclas funcionam da mesma maneira.

As senhas a serem cadastradas pelos funcionários devem conter 5 caracteres, sendo 2 algarismos distintos seguidos de 3 letras diferentes, nessa ordem. Um funcionário irá cadastrar a sua primeira senha, podendo escolher entre as teclas que apresentam os números 1, 2, 5, 7 e 0 e as respectivas letras correlacionadas, quando houver.', 'O número de possibilidades diferentes que esse funcionário tem para cadastrar sua senha é', 'B', 'Separe a senha em duas partes: os 2 algarismos e as 3 letras. Use o princípio multiplicativo.', 'São 5 algarismos possíveis (1, 2, 5, 7, 0), mas só as teclas 2, 5 e 7 têm letras. Conte quantas letras existem nessas teclas.', 'Algarismos distintos entre 1, 2, 5, 7 e 0: $5 \times 4 = 20$ opções. Letras disponíveis: ABC (tecla 2), JKL (tecla 5) e PQRS (tecla 7), total de 10 letras; três diferentes em ordem: $10 \times 9 \times 8 = 720$. Total: $20 \times 720 = 14\,400$, letra B. Um erro comum é esquecer que as teclas 1 e 0 não têm letras.', 'média'),
('2024-D2-Q139', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 139, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Operações com decimais e custos', null, null, 'Um artesão utiliza dois tipos de componentes, X e Y, nos enfeites que produz. Ele sempre compra todos os componentes em uma mesma loja. O quadro apresenta os preços dos dois tipos de componentes nas lojas I e II.

| Lojas | Preços dos componentes (R\$) — X | Preços dos componentes (R\$) — Y |
|:---:|:---:|:---:|
| I | 3,00 | 1,00 |
| II | 2,00 | 4,00 |

Ele confeccionará enfeites formados por duas unidades do componente X e uma unidade do componente Y e efetuará a compra na loja que oferecer o menor valor total para a confecção de um enfeite.', 'O artesão efetuará a compra na loja', 'A', 'Calcule o custo de um enfeite em cada loja, lembrando que ele usa 2 unidades de X e 1 de Y.', 'Não basta olhar o componente mais barato: faça $2 \cdot X + Y$ para cada loja e compare os totais.', 'Loja I: $2 \cdot 3 + 1 = 7$ reais. Loja II: $2 \cdot 2 + 4 = 8$ reais. A loja I é mais barata, com valor de R\$ 7,00 por enfeite: letra A. A alternativa E parece lógica (X é o mais usado e é mais barato na loja II), mas o preço alto de Y na loja II faz o total ficar maior.', 'fácil'),
('2024-D2-Q140', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 140, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Cálculo de porcentagem', null, null, 'João e Felipe participaram, na escola, de uma maratona de matemática na qual, durante uma semana, resolveram 200 questões cada. Nessa maratona, a porcentagem $P$ de acertos de cada participante é convertida em um conceito:

- insatisfatório: se $0 \leq P < 50$;
- regular: se $50 \leq P < 60$;
- bom: se $60 \leq P < 75$;
- muito bom: se $75 \leq P < 90$;
- excelente: se $90 \leq P \leq 100$.

João acertou 75% das questões da maratona e Felipe acertou 30% a menos que a quantidade de questões que João acertou.', 'Os conceitos de João e Felipe foram, respectivamente,', 'B', 'Descubra quantas questões cada um acertou e depois volte para a porcentagem sobre as 200 questões.', 'Os 30% a menos são sobre a quantidade que João acertou, não sobre o total. Calcule 70% dos acertos de João.', 'João acertou $0{,}75 \times 200 = 150$ questões, ou seja, $P = 75$: conceito muito bom. Felipe acertou 30% a menos que 150: $0{,}7 \times 150 = 105$ questões, que é $\frac{105}{200} = 52{,}5\%$, conceito regular. Resposta: letra B. Se você fizer $75\% - 30\% = 45\%$, cai na alternativa C, mas os 30% incidem sobre os acertos de João.', 'média'),
('2024-D2-Q141', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 141, '5_alternativas', 'Matemática', 'Funções do 1º e 2º grau', 'Composição de funções afins', null, null, 'Três grandezas (I, II e III) se relacionam entre si. Os gráficos a seguir, formados por segmentos de reta, descrevem as relações de dependência existentes entre as grandezas I e II, e entre as grandezas II e III.

{{figura:1}}

{{figura:2}}', 'O valor máximo assumido pela grandeza III, quando a grandeza I varia de 1 a 3, é', 'B', 'Use o primeiro gráfico para descobrir entre quais valores a grandeza II varia quando I vai de 1 a 3.', 'Com I de 1 a 3, a grandeza II vai de 1,5 a 3,5. Agora veja no segundo gráfico onde III é maior nesse intervalo de II.', 'No 1º gráfico, de (0,0) a (2,3) a inclinação é 1,5, então I = 1 dá II = 1,5; de (2,3) a (4,4) a inclinação é 0,5, então I = 3 dá II = 3,5. No 2º gráfico, III cai de 4 até 1 quando II vai de 0 a 3 (III = 4 − II) e depois sobe com inclinação 2. Para II = 1,5: III = 2,5; para II = 3,5: III = 1 + 2·0,5 = 2. O máximo é 2,5, letra B. A letra E (4,0) seria o valor para II = 0, que está fora do intervalo.', 'difícil'),
('2024-D2-Q142', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 142, '5_alternativas', 'Matemática', 'Progressões', 'Progressão geométrica', null, null, 'Uma criança, utilizando um aplicativo, escreveu uma mensagem para enviar a um amigo. Essa mensagem foi escrita seguindo estas etapas:

| Etapas | Visor de escrita |
|---|---|
| 1ª etapa: inseriu três figuras do tipo 🙂 no visor de escrita da mensagem; | 🙂🙂🙂 |
| 2ª etapa: copiou o que havia inserido anteriormente e colou (inseriu o que havia copiado) ao lado; | 🙂🙂🙂🙂🙂🙂 |
| 3ª etapa: copiou o que tinha no visor na 2ª etapa e colou ao lado. | 🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂 |

A criança seguiu copiando e colando, em cada etapa, o que tinha no visor na etapa imediatamente anterior, até concluir a 20ª etapa. Em seguida, enviou a mensagem.', 'Qual foi o total de figuras contidas na mensagem enviada?', 'A', 'Observe o que acontece com a quantidade de figuras a cada etapa: ela sempre dobra.', 'Etapa 1: 3; etapa 2: $3 \times 2$; etapa 3: $3 \times 2^2$. Qual expoente aparece na etapa 20?', 'A cada etapa a quantidade dobra, formando uma PG de primeiro termo 3 e razão 2. O termo da etapa $n$ é $3 \times 2^{n-1}$, então na 20ª etapa há $3 \times 2^{19}$ figuras, letra A. A letra B ($3 \times 2^{20}$) é a armadilha de usar o expoente igual ao número da etapa: note que na 1ª etapa já há 3 figuras, sem nenhuma duplicação.', 'fácil'),
('2024-D2-Q143', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 143, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Porcentagem, receita e lucro', null, null, 'Uma casa de shows terá um evento cujo custo total de produção é de R\$ 34 350,00, sendo que comporta 500 pessoas. O preço do ingresso será de R\$ 130,00 e, normalmente, 60% das pessoas adquirem meia-entrada, pagando R\$ 65,00 pelo ingresso. Além do faturamento proveniente da venda de ingressos, a casa de shows vende, com 60% de lucro, bebidas e petiscos ao público no dia do evento.

Após ter vendido todos os 500 ingressos, constatou-se que a quantidade de meias-entradas vendidas superou em 50% o que estava previsto, impactando o faturamento estimado com a venda de ingressos.

No dia do evento, decidiu-se manter o percentual de 60% de lucro sobre as bebidas e petiscos, pois todo o público que comprou ingresso compareceu ao show. Com isso, espera-se ter lucro de R\$ 17 000,00 nesse evento.', 'Para que se alcance o lucro esperado, o gasto médio por pessoa com bebidas e petiscos, em real, deverá ser de', 'D', 'Primeiro descubra quantas meias-entradas foram vendidas de fato: 50% a mais do que os 60% previstos.', 'Calcule a receita dos ingressos, desconte o custo e veja quanto de lucro falta para chegar a R\$ 17 000. Esse lucro corresponde a 60% do que se vende em bebidas.', 'Previsto: $0{,}6 \times 500 = 300$ meias; vendidas: $300 \times 1{,}5 = 450$ meias e 50 inteiras. Receita: $450 \cdot 65 + 50 \cdot 130 = 29\,250 + 6\,500 = 35\,750$. Lucro com ingressos: $35\,750 - 34\,350 = 1\,400$. Faltam $17\,000 - 1\,400 = 15\,600$ de lucro com bebidas, ou $31{,}20$ por pessoa. Como o lucro é 60% do valor gasto: $0{,}6g = 31{,}20 \Rightarrow g = 52$. Letra D.', 'difícil'),
('2024-D2-Q144', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 144, '5_alternativas', 'Matemática', 'Geometria espacial', 'Sólidos de revolução', null, null, 'Para obter um sólido de revolução (rotação de 360° em torno de um eixo fixo), uma professora realizou as seguintes etapas:

- recortou o trapézio retângulo *PQRS* de um material rígido;
- afixou o lado *PS* do trapézio em uma vareta fixa retilínea (eixo de rotação);
- girou o trapézio 360° em torno da vareta e obteve um sólido de revolução.

Observe a figura que apresenta o trapézio afixado na vareta e o sentido de giro.

{{figura:1}}', 'O sólido obtido foi um(a)', 'D', 'Imagine cada lado do trapézio girando em volta da vareta: que figura cada base forma?', 'As duas bases (PQ e SR) viram círculos de tamanhos diferentes, e o lado inclinado QR forma uma superfície lateral cônica.', 'Ao girar, a base menor PQ gera um círculo pequeno e a base maior SR gera um círculo grande, paralelos entre si. O lado inclinado QR forma a superfície lateral, como a de um cone cortado. O sólido é um tronco de cone, letra D. Não é cilindro porque os dois círculos têm raios diferentes, e não pode ser pirâmide, já que rotação gera faces curvas, não planas.', 'fácil'),
('2024-D2-Q145', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 145, '5_alternativas', 'Matemática', 'Geometria plana', 'Área do retângulo', null, null, 'O estádio do Maracanã passou por algumas modificações estruturais para a realização da Copa do Mundo de 2014, como, por exemplo, as dimensões do campo retangular. Para se adaptar aos padrões da Fifa, as dimensões do campo foram reduzidas de 110 m × 75 m para 105 m × 68 m.

Fonte: Disponível em: http://virgula.uol.com.br. Acesso em: 14 ago. 2013 (adaptado).', 'Em quantos metros quadrados a área do campo do Maracanã foi reduzida?', 'D', 'Calcule a área do campo antes e depois da reforma e faça a diferença.', 'Área do retângulo = comprimento × largura. Não subtraia as medidas lado a lado: subtraia as áreas.', 'Antes: $110 \times 75 = 8\,250\ \text{m}^2$. Depois: $105 \times 68 = 7\,140\ \text{m}^2$. Redução: $8\,250 - 7\,140 = 1\,110\ \text{m}^2$, letra D. Subtrair só as medidas (5 m e 7 m) e multiplicar daria 35, alternativa B, que não representa a variação da área.', 'fácil'),
('2024-D2-Q146', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 146, '5_alternativas', 'Matemática', 'Funções do 1º e 2º grau', 'Máximo da função quadrática', null, null, 'Um fazendeiro pretende construir um galinheiro ocupando uma região plana de formato retangular, com lados de comprimentos *L* metro e *C* metro. Os lados serão cercados por telas de tipos diferentes. Nos lados de comprimento *L* metro, será utilizada uma tela cujo metro linear custa R\$ 20,00, enquanto, nos outros dois lados, uma que custa R\$ 15,00. O fazendeiro quer gastar, no máximo, R\$ 6 000,00 na compra de toda a tela necessária para o galinheiro, e deseja que o galinheiro tenha a maior área possível.', 'Qual será a medida, em metro, do maior lado do galinheiro?', 'B', 'Escreva o custo total das telas em função de $L$ e $C$ e iguale ao gasto máximo.', 'O custo é $40L + 30C = 6\,000$. Isole $C$, escreva a área $L \cdot C$ como função do 2º grau de $L$ e procure o vértice.', 'Dois lados $L$ a R\$ 20 e dois lados $C$ a R\$ 15: $40L + 30C = 6\,000$, logo $C = 200 - \frac{4L}{3}$. A área é $A = L\left(200 - \frac{4L}{3}\right)$, uma parábola com raízes $L = 0$ e $L = 150$; o máximo ocorre no ponto médio, $L = 75$. Então $C = 200 - 100 = 100$. Os lados medem 75 m e 100 m, e o maior é 100 m, letra B.', 'difícil'),
('2024-D2-Q147', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 147, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Representações de números racionais', null, null, 'Uma professora de matemática utiliza em suas aulas uma “máquina caça-números” para verificar os conhecimentos de seus estudantes sobre representações de números racionais. Essa máquina tem um visor dividido em seis compartimentos e, na lateral, uma alavanca. Cada estudante puxa a alavanca e espera que os compartimentos parem de girar. A partir daí, precisa responder para a professora em quais posições se encontram os números que representam a mesma quantidade.

Um estudante puxou a alavanca, aguardou que os compartimentos parassem de girar e observou os números apresentados no visor. A configuração da máquina naquele instante está apresentada na imagem.

{{figura:1}}

Esse estudante respondeu corretamente à pergunta da professora.', 'As posições indicadas pelo estudante foram', 'B', 'Escreva todos os números do visor na forma decimal para comparar.', 'Lembre: $4^{\frac{1}{2}} = \sqrt{4}$ e o número misto $4\frac{1}{2}$ significa $4 + \frac{1}{2}$, que são coisas bem diferentes.', 'Convertendo: I) $4^{\frac{1}{2}} = 2$; II) $4\frac{1}{2} = 4{,}5$; III) $\frac{10}{45} \approx 0{,}22$; IV) $\frac{18}{4} = 4{,}5$; V) $4{,}5$; VI) $\frac{4}{5} = 0{,}8$. Os três iguais são II, IV e V, letra B. A letra A engana quem confunde $4^{\frac{1}{2}}$ com 4,5.', 'fácil'),
('2024-D2-Q148', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 148, '5_alternativas', 'Matemática', 'Exponencial e logaritmo', 'Função exponencial', null, null, 'Uma caneca com água fervendo é retirada de um forno de micro-ondas. A temperatura *T*, em grau Celsius, da caneca, em função do tempo *t*, em minuto, pode ser modelada pela função $T(t) = a + 80\,b^t$, representada no gráfico a seguir.

{{figura:1}}', 'Os valores das constantes *a* e *b* são', 'C', 'Leia no gráfico a temperatura em $t = 0$ e use que $b^0 = 1$ para achar $a$.', 'Com $a$ encontrado, use outro ponto do gráfico, como $(10, 60)$, e isole $b^{10}$.', 'Em $t = 0$: $T(0) = a + 80 \cdot b^0 = a + 80 = 100$, então $a = 20$. Em $t = 10$: $20 + 80b^{10} = 60 \Rightarrow b^{10} = 0{,}5 \Rightarrow b = (0{,}5)^{\frac{1}{10}}$. Letra C. Conferindo em $t = 20$: $20 + 80 \cdot 0{,}25 = 40$, como no gráfico. A letra B ($a = 100$) confunde o valor inicial de $T$ com a constante $a$.', 'média'),
('2024-D2-Q149', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 149, '5_alternativas', 'Matemática', 'Geometria espacial', 'Volume do cilindro e cubo', null, null, 'Em uma empresa é comercializado um produto em embalagens em formato de cilindro circular reto, com raio medindo 3 cm, e altura medindo 15 cm. Essa empresa planeja comercializar o mesmo produto em embalagens em formato de cubo, com capacidade igual a 80% da capacidade da embalagem cilíndrica utilizada atualmente.

Use 3 como valor aproximado para π.', 'A medida da aresta da nova embalagem, em centímetro, deve ser', 'E', 'Calcule o volume do cilindro com $V = \pi r^2 h$, usando $\pi = 3$.', 'O cubo terá 80% desse volume, e seu volume é $a^3$. Fatore o resultado procurando um cubo perfeito.', 'Cilindro: $3 \cdot 3^2 \cdot 15 = 405\ \text{cm}^3$. Cubo: $0{,}8 \cdot 405 = 324\ \text{cm}^3$. Então $a^3 = 324 = 27 \cdot 12$, e $a = \sqrt[3]{27 \cdot 12} = 3\sqrt[3]{12}$, letra E. Conferindo: $(3\sqrt[3]{12})^3 = 27 \cdot 12 = 324$.', 'média'),
('2024-D2-Q150', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 150, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Medidas de comprimento e custo', null, null, 'Uma sala com piso no formato retangular, com lados de medidas 3 m e 6 m, será dividida em dois ambientes. Para isso, serão utilizadas colunas em formato cilíndrico, dispostas perpendicularmente ao piso e representadas na figura pelos círculos de cor azul. Os centros desses círculos estarão sobre uma reta paralela aos lados de menor medida do piso da sala. Os vãos entre duas colunas e entre uma coluna e a parede não poderão ser superiores a 15 cm.

{{figura:1}}

Para efetuar a compra dessas colunas, foram feitos orçamentos com base em dados fornecidos por cinco lojas.

| Loja | Raio (cm) | Preço por unidade (R\$) |
|:---:|:---:|:---:|
| I | 5 | 60 |
| II | 10 | 70 |
| III | 12 | 75 |
| IV | 15 | 90 |
| V | 20 | 120 |

A compra será realizada na loja cujo orçamento resulte no menor valor total possível.', 'A compra será realizada na loja', 'C', 'A fileira de colunas atravessa a sala no lado de 3 m. Pense em colunas e vãos de 15 cm alternados preenchendo 300 cm.', 'Com $n$ colunas de diâmetro $d$ há $n + 1$ vãos: é preciso $n \cdot d + 15(n+1) \geq 300$. Ache o menor $n$ de cada loja e multiplique pelo preço.', 'Use o diâmetro (2 × raio): $n \geq \frac{285}{d + 15}$. Loja I ($d = 10$): 12 colunas, R\$ 720. II ($d = 20$): 9, R\$ 630. III ($d = 24$): 8, R\$ 600. IV ($d = 30$): 7, R\$ 630. V ($d = 40$): 6, R\$ 720. O menor total é da loja III, letra C. Atenção: usar o raio no lugar do diâmetro muda todas as contas.', 'difícil'),
('2024-D2-Q151', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 151, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Escala e razão de áreas', null, null, 'O arquiteto Renzo Piano exibiu a maquete da nova sede do Museu Whitney de Arte Americana, um prédio assimétrico que tem um vão aberto para a galeria principal, cuja medida da área é 1 672 m².

Considere que a escala da maquete exibida é 1 : 200.

Fonte: **Época**, n. 682, jun. 2011 (adaptado).', 'A medida da área do vão aberto nessa maquete, em centímetro quadrado, é', 'E', 'Numa escala $1 : 200$ de comprimento, as áreas ficam na razão $1 : 200^2$.', 'Converta $1\,672\ \text{m}^2$ para $\text{cm}^2$ (1 m² = 10 000 cm²) e depois divida por 40 000.', 'Se os comprimentos são reduzidos 200 vezes, a área é reduzida $200^2 = 40\,000$ vezes. Em centímetros quadrados: $1\,672\ \text{m}^2 = 16\,720\,000\ \text{cm}^2$. Na maquete: $16\,720\,000 \div 40\,000 = 418\ \text{cm}^2$, letra E. Quem divide só por 200 (esquecendo de elevar ao quadrado) chega a valores muito maiores, que nem aparecem nas opções.', 'média'),
('2024-D2-Q152', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 152, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Interpretação de gráfico de linhas', null, null, 'O gráfico apresenta o valor total de exportações e o valor total de importações, ao longo de um período, em bilhão de dólares. O saldo da balança comercial brasileira é dado pelo valor total de exportações menos o valor total de importações num mesmo período.

**Valor total de exportações e importações**

{{figura:1}}

Fonte: Ministério do Desenvolvimento. Disponível em: http://blogs.estadao.com.br. Acesso em: 20 fev. 2013 (adaptado).

Considere que os saldos da balança comercial brasileira, nos três meses destacados no gráfico, sejam representados por:

- $S_1$: saldo em junho de 2009;
- $S_2$: saldo em janeiro de 2010;
- $S_3$: saldo em junho de 2010.', 'A ordenação dos saldos $S_1$, $S_2$ e $S_3$, do maior para o menor, é', 'A', 'Saldo = exportações − importações. Leia as duas linhas em cada mês destacado.', 'Repare em janeiro de 2010: a linha das exportações está abaixo da linha das importações. O que isso diz sobre o sinal do saldo?', 'Jun/2009: $14{,}5 - 10 = 4{,}5$ (positivo e grande). Jun/2010: $17{,}1 - 14{,}8 = 2{,}3$. Jan/2010: exportações ($\approx 11{,}3$) abaixo das importações ($\approx 11{,}6$), saldo negativo ($\approx -0{,}3$). Do maior para o menor: $S_1$, $S_3$, $S_2$, letra A. A letra D cai na armadilha de achar que junho de 2010 tem o maior saldo só porque os valores são os mais altos.', 'média'),
('2024-D2-Q153', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 153, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Porcentagem na forma decimal', null, null, 'Um instituto de pesquisa constatou que, nos últimos dez anos, o crescimento populacional de uma cidade foi de 135,25%.', 'Qual é a representação decimal da taxa percentual desse crescimento populacional?', 'D', 'Porcentagem significa “dividido por 100”.', 'Para passar de porcentagem para decimal, desloque a vírgula duas casas para a esquerda.', '$135{,}25\% = \frac{135{,}25}{100} = 1{,}3525$, letra D. A letra B só repete o número sem dividir por 100, e a alternativa C divide por 10 em vez de 100.', 'fácil'),
('2024-D2-Q154', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 154, '5_alternativas', 'Matemática', 'Estatística', 'Média aritmética', null, null, 'Contratos de vários serviços disponíveis na internet apresentam uma quantidade excessiva de informações. Isso faz com que o tempo necessário para a leitura desses contratos possa ser longo.

O quadro apresenta uma amostra do tempo considerado necessário para a leitura completa do contrato de alguns serviços digitais.

| Tipo de serviço | Tempo necessário para a leitura completa do contrato (em minuto) |
|:---:|:---:|
| A | 36 |
| B | 17 |
| C | 27 |
| D | 13 |
| E | 13 |
| F | 13 |

Fonte: ROMERO, L. Não li e concordo. **Superinteressante**, n. 307, ago. 2012 (adaptado).', 'O tempo médio, em minuto, necessário para a leitura completa de um contrato de serviço dentre os listados no quadro é, com uma casa decimal, aproximadamente,', 'C', 'Tempo médio é a média aritmética: some todos os tempos e divida pela quantidade de serviços.', 'São 6 serviços. Não confunda média com moda (o valor que mais aparece) nem com mediana.', 'Soma: $36 + 17 + 27 + 13 + 13 + 13 = 119$. Média: $119 \div 6 \approx 19{,}83$, ou 19,8 com uma casa decimal, letra C. A letra A (13,0) é a moda e a B (15,0) é a mediana, $\frac{13 + 17}{2}$.', 'fácil'),
('2024-D2-Q155', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 155, '5_alternativas', 'Matemática', 'Geometria plana', 'Área do setor circular', null, null, 'Um proprietário pretende instalar um sensor de presença para a proteção de seu imóvel. O sensor deverá detectar movimentos de objetos e pessoas numa determinada região plana. A figura ilustra a vista superior da área de cobertura (setor circular em azul) de um sensor colocado no ponto *S*. Essa área depende da medida do ângulo α, em grau, e do raio *R*, em metro.

{{figura:1}}

Ao aumentar o ângulo α ou o raio *R* aumenta-se a área de cobertura do sensor. Entretanto, quanto maior essa área, maior o preço do sensor.

Para esse fim, há cinco tipos de sensores disponíveis no mercado, cada um com as seguintes características:

- tipo I: α = 15° e *R* = 20 m;
- tipo II: α = 30° e *R* = 22 m;
- tipo III: α = 40° e *R* = 12 m;
- tipo IV: α = 60° e *R* = 16 m;
- tipo V: α = 90° e *R* = 10 m.

Esse proprietário pretende adquirir um desses sensores que seja capaz de cobrir, no mínimo, uma área de medida 70 m², com o menor preço possível.

Use 3 como valor aproximado para π.', 'O proprietário do imóvel deverá adquirir o sensor do tipo', 'E', 'A área de um setor circular é a fração $\frac{\alpha}{360°}$ da área do círculo $\pi R^2$.', 'Calcule a área de cada sensor com $\pi = 3$. Entre os que cobrem pelo menos 70 m², o mais barato é o de menor área.', 'Áreas ($\frac{\alpha}{360} \cdot 3R^2$): I = 50; II = 121; III = 48; IV = 128; V = $\frac{90}{360} \cdot 3 \cdot 100 = 75$ m². Atingem 70 m² os tipos II, IV e V. Como preço maior acompanha área maior, o mais barato desses é o de menor área: tipo V, letra E. Os tipos II e IV também funcionam, mas cobrem mais área e custam mais.', 'média'),
('2024-D2-Q156', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 156, '5_alternativas', 'Matemática', 'Funções do 1º e 2º grau', 'Lei de formação da função afim', null, null, 'O uso de aplicativos de transporte tem sido uma alternativa à população que busca preços mais competitivos para se locomover, principalmente nas grandes cidades. As formas usadas para determinar o valor cobrado por cada viagem variam de um aplicativo para outro, mas, em geral, o valor *V* a ser pago, em real, varia em função de:

- tarifa base *F*: valor fixo, em real, cobrado no início da viagem;
- tempo *T*: tempo, em minuto, de duração da viagem;
- distância *D*: distância percorrida, em quilômetro.

Um desses aplicativos cobra R\$ 2,00 de valor fixo, acrescido de R\$ 0,26 por minuto de viagem e de R\$ 1,40 por quilômetro rodado.', 'Nessas condições, a expressão que fornece o valor *V* a ser pago por uma viagem desse aplicativo é', 'B', 'O valor fixo entra uma vez só; tempo e distância entram multiplicados pelo preço de cada unidade.', 'Monte: fixo + (preço por minuto)·T + (preço por km)·D. Cuidado com alternativas que multiplicam o valor fixo por alguma variável.', 'O valor é a tarifa fixa de R$ 2,00, mais R$ 0,26 vezes os minutos (T), mais R$ 1,40 vezes os quilômetros (D): $V = 2{,}00 + 0{,}26T + 1{,}40D$, letra B. A letra A está errada porque a tarifa base já é o próprio valor 2,00; multiplicar por $F$ não faz sentido.', 'fácil'),
('2024-D2-Q157', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 157, '5_alternativas', 'Matemática', 'Equações, inequações e sistemas', 'Equação do 1º grau', null, null, 'Uma doceira vende e entrega, em seu bairro, porções de 100 g de docinhos de aniversário. Atualmente, a taxa única de entrega é R\$ 10,00, e o valor cobrado por uma porção é R\$ 25,00. Por uma estratégia de vendas, a partir da próxima semana, a taxa única de entrega será R\$ 15,00, e um novo valor será cobrado por uma porção, de maneira que o valor total a ser pago por um cliente na compra de 5 porções permaneça o mesmo.', 'A partir da próxima semana, qual será o novo valor cobrado, em real, por uma porção?', 'C', 'Calcule quanto o cliente paga hoje por 5 porções, incluindo a entrega.', 'O total de 5 porções deve continuar igual. Monte $15 + 5p = $ total atual e resolva.', 'Hoje: $5 \cdot 25 + 10 = 135$ reais. Na próxima semana: $15 + 5p = 135 \Rightarrow 5p = 120 \Rightarrow p = 24$. O novo preço é R\$ 24,00, letra C. Note que a entrega subiu R\$ 5,00, e essa diferença foi dividida entre as 5 porções (R\$ 1,00 a menos em cada).', 'fácil'),
('2024-D2-Q158', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 158, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Regra de três e comparação de custos', null, null, 'Em uma loja de defensivos agrícolas, os preços de alguns produtos foram divulgados em um cartaz.

{{figura:1}}

Sabe-se que 1 litro de defensivo do Tipo A é suficiente para aplicação em 0,5 hectare (ha), enquanto que 1 litro de defensivo do Tipo B é suficiente para aplicação em 0,4 ha. Um agricultor precisa comprar, nessa loja, uma quantidade de litros de defensivo suficiente para aplicar em uma área de 20 ha, além de levar uma máscara para aplicação.', 'O valor mínimo, em real, a ser gasto pelo agricultor é', 'C', 'Calcule quantos litros de cada tipo seriam necessários para os 20 ha e compare os custos, incluindo a máscara.', 'Teste as opções: só tipo A (ganha a máscara), só tipo B (paga a máscara) e uma mistura com 35 L de A. Não escolha só pelo preço do litro.', 'Só A: $20 \div 0{,}5 = 40$ L, $40 \cdot 4{,}20 = 168$ reais, com máscara grátis. Só B: $20 \div 0{,}4 = 50$ L, $50 \cdot 3 = 150$, mais $12{,}50$ da máscara = R\$ 162,50. Mistura: 35 L de A cobrem 17,5 ha; os 2,5 ha restantes pedem 6,25 L de B: $147 + 18{,}75 = 165{,}75$. O mínimo é R\$ 162,50, letra C. A letra B (150) esquece de pagar a máscara.', 'difícil'),
('2024-D2-Q159', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 159, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Unidades de medida compostas', null, null, 'Uma tubulação despeja sempre o mesmo volume de água por unidade de tempo em uma caixa-d’água, o que significa dizer que a vazão de água nessa tubulação é constante. Na junção dessa tubulação com a caixa-d’água, está instalada uma membrana de filtragem cujo objetivo é filtrar eventuais impurezas presentes na água, combinado a um bom fluxo de água. O fluxo (ϕ) de água através da superfície da membrana é diretamente proporcional à vazão de água na tubulação, medida em mililitro por segundo, e inversamente proporcional à área da superfície da membrana, medida em centímetro quadrado.', 'A unidade de medida adequada para descrever o fluxo (ϕ) de água que atravessa a superfície da membrana é', 'C', 'Diretamente proporcional fica no numerador; inversamente proporcional fica no denominador.', 'O fluxo é (vazão) ÷ (área). A vazão está em mL/s e a área em cm². Monte essa divisão com as unidades.', 'Como $\phi$ é proporcional à vazão e inversamente proporcional à área, $\phi = \frac{\text{vazão}}{\text{área}}$. Com unidades: $\frac{\text{mL/s}}{\text{cm}^2} = \frac{\text{mL}}{\text{cm}^2 \cdot \text{s}}$, letra C. A letra B multiplica pela área, o que corresponderia a uma relação diretamente proporcional à área.', 'média'),
('2024-D2-Q160', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 160, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Vazão e grandezas proporcionais', null, null, 'Uma piscina tem capacidade de 2 500 000 litros. Seu sistema de abastecimento foi regulado para ter uma vazão constante de 6 000 litros de água por minuto.

O mesmo sistema foi instalado em uma segunda piscina, com capacidade de 2 750 000 litros, e regulado para ter uma vazão, também constante, capaz de enchê-la em um tempo 20% maior que o gasto para encher a primeira piscina.', 'A vazão do sistema de abastecimento da segunda piscina, em litro por minuto, é', 'D', 'Comece calculando o tempo para encher a primeira piscina: volume ÷ vazão.', 'O tempo da segunda é 20% maior que o da primeira. Depois, vazão = volume da segunda ÷ esse novo tempo.', 'Primeira piscina: $t_1 = \frac{2\,500\,000}{6\,000} = \frac{1\,250}{3}$ min. Segunda: $t_2 = 1{,}2 \cdot \frac{1\,250}{3} = 500$ min. Vazão: $\frac{2\,750\,000}{500} = 5\,500$ L/min, letra D. Atenção: tempo maior significa vazão menor; a letra B (7 920) aparece quando se aumenta a vazão em vez de reduzi-la.', 'média'),
('2024-D2-Q161', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 161, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Gráfico de enchimento de recipiente', null, null, 'Um tanque, em formato de paralelepípedo reto retângulo, tem em seu interior dois anteparos verticais, fixados na sua base e em duas paredes opostas, sendo perpendiculares a elas, conforme a figura.

{{figura:1}}

Esses anteparos, de espessuras desprezíveis, estão instalados de maneira a dividir a base do tanque em três retângulos congruentes, tendo suas alturas iguais à metade e a um quarto da altura do tanque. O tanque é abastecido por uma entrada situada no teto, através de um duto que despeja água a uma vazão constante, sendo necessárias 12 horas para finalizar o seu enchimento.', 'O gráfico que descreve, em cada instante, a maior altura de coluna de água, dentre aquelas que vão sendo formadas ao longo do enchimento do tanque, é', 'B', 'A água cai no compartimento da direita, ao lado do anteparo mais alto ($\frac{H}{2}$). Pense em que ordem cada parte enche.', 'Enquanto a água transborda para os outros compartimentos, a maior altura fica parada em $\frac{H}{2}$. Calcule quanto tempo leva cada etapa, sabendo que o tanque todo enche em 12 h.', 'O compartimento da direita (1/3 da base) enche até $\frac{H}{2}$: é $\frac{1}{6}$ do volume, 2 h. Depois a água transborda e enche o meio e a esquerda até $\frac{H}{4}$ e então até $\frac{H}{2}$: $\frac{2}{3} \cdot \frac{1}{2} = \frac{1}{3}$ do volume, 4 h, com a maior altura parada em $\frac{H}{2}$. Por fim, o tanque inteiro sobe de $\frac{H}{2}$ até $H$: metade do volume, 6 h. O gráfico sobe de 0 a 2 h, fica constante de 2 a 6 h e sobe em linha reta de 6 a 12 h: letra B. A letra C erra os tempos (patamar até 10 h).', 'difícil'),
('2024-D2-Q162', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 162, '5_alternativas', 'Matemática', 'Progressões', 'Progressão geométrica crescente', null, null, 'Uma imobiliária iniciou uma campanha de divulgação para promover a venda de apartamentos que podem ser pagos em 100 parcelas mensais. O valor da primeira delas é fixado no momento da compra, com o pagamento dessa primeira parcela. A partir da segunda parcela, o valor é determinado pela aplicação de um acréscimo percentual fixo ao valor da parcela anterior. Como atrativo, a imobiliária fará o pagamento de todas as parcelas correspondentes ao mês de aniversário do comprador.

Um cliente, que faz aniversário no mês de maio, decidiu comprar um desses apartamentos por meio do financiamento oferecido pela imobiliária, e pretende escolher o mês mais adequado para realizar essa compra, de modo que o valor total dos pagamentos seja o menor possível.', 'Qual é o mês que esse cliente deverá escolher para realizar a compra do apartamento?', 'A', 'As parcelas só aumentam com o tempo, então o melhor é que as parcelas de maio sejam as mais caras possíveis e o maior número possível.', '100 meses = 8 anos e 4 meses. Maio aparece 9 vezes só se cair entre as 4 primeiras parcelas. Qual posição deixa a última parcela (a mais cara) em maio?', 'Como 100 = 8·12 + 4, os meses que ocupam as posições 1 a 4 aparecem 9 vezes no financiamento; os demais, 8. Para maio aparecer 9 vezes e nas parcelas mais caras, ele deve ser a 4ª parcela: assim as parcelas grátis são a 4ª, 16ª, ..., 100ª, incluindo a última, que é a maior. Para maio ser a 4ª parcela, a compra (1ª parcela) deve ser em fevereiro, letra A. Comprar em maio (letra C) também dá 9 parcelas grátis, mas são as de posição 1, 13, ..., 97, mais baratas.', 'difícil'),
('2024-D2-Q163', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 163, '5_alternativas', 'Matemática', 'Geometria plana', 'Comprimento de correia e circunferência', null, null, 'Um sistema de polias circulares e correias é um dos mecanismos responsáveis pela transmissão de movimento em máquinas rotativas. O manual de um motor traz uma figura representando um sistema composto por duas polias e uma correia de transmissão, tensionada e perfeitamente ajustada sobre as polias, de modo a não apresentar folgas nos contatos com as polias. Considere que as partes dessa correia que não ficam em contato com as polias são representadas por segmentos de reta tangentes às polias.

{{figura:1}}

Para substituição dessa correia, é necessária a especificação de seu comprimento.

Considere 3 como valor aproximado para π.', 'A medida do comprimento dessa correia, em centímetro, é', 'D', 'A correia tem 4 partes: dois segmentos retos de 15 cm e dois arcos, um em cada polia.', 'Os ângulos dos dois arcos somam 360°. Se na polia menor o arco é de 150°, na maior é de 210°. Use comprimento de arco $= \frac{\theta}{360°} \cdot 2\pi r$.', 'Arco na polia menor: $\frac{150}{360} \cdot 2 \cdot 3 \cdot 4 = 10$ cm. Na polia maior, o arco tem $360° - 150° = 210°$: $\frac{210}{360} \cdot 2 \cdot 3 \cdot 8 = 28$ cm. Segmentos retos: $2 \cdot 15 = 30$ cm. Total: $10 + 28 + 30 = 68$ cm, letra D. Usar 150° também na polia maior dá 60 cm (letra B), mas a correia abraça mais da metade da polia grande.', 'difícil'),
('2024-D2-Q164', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 164, '5_alternativas', 'Matemática', 'Geometria plana', 'Circuncentro do triângulo equilátero', null, null, 'A prefeitura de uma cidade planeja construir três postos de saúde. Esses postos devem ser construídos em locais equidistantes entre si e de forma que as distâncias desses três postos ao hospital dessa cidade sejam iguais. Foram conseguidos três locais para a construção dos postos de saúde que apresentam as características desejadas, e que distam 10 km entre si, conforme o esquema, no qual o ponto *H* representa o local onde está construído o hospital; os pontos $P_1$, $P_2$ e $P_3$, os postos de saúde; e esses quatro pontos estão em um mesmo plano.

{{figura:1}}', 'A distância, em quilômetro, entre o hospital e cada um dos postos de saúde, é um valor entre', 'C', 'O ponto que fica à mesma distância dos três vértices de um triângulo equilátero é o seu centro.', 'No triângulo equilátero, a distância do centro a um vértice é $\frac{2}{3}$ da altura, e a altura é $\frac{l\sqrt{3}}{2}$.', 'A altura do triângulo de lado 10 km é $\frac{10\sqrt{3}}{2} = 5\sqrt{3}$. A distância do centro H a cada vértice é $\frac{2}{3} \cdot 5\sqrt{3} = \frac{10\sqrt{3}}{3} \approx \frac{10 \cdot 1{,}73}{3} \approx 5{,}77$ km. Esse valor está entre 5 e 6, letra C. Se você usar $\frac{1}{3}$ da altura (distância do centro ao lado), chega a cerca de 2,9 km, a armadilha da letra A.', 'média'),
('2024-D2-Q165', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 165, '5_alternativas', 'Matemática', 'Probabilidade', 'Eventos independentes', null, null, 'Para melhorar o fluxo de ônibus em uma avenida que tem dois semáforos, a prefeitura reduzirá o tempo em que cada sinal ficará vermelho, que atualmente é de 15 segundos a cada 60 segundos. Admita que o instante de chegada de um ônibus a cada semáforo é aleatório.

O engenheiro de tráfego da prefeitura calculou a probabilidade de um ônibus encontrar cada um deles vermelho, obtendo $\frac{15}{60}$. A partir daí, estabeleceu uma mesma redução na quantidade do tempo, em segundo, em que cada sinal ficará vermelho, de maneira que a probabilidade de um ônibus encontrar ambos os sinais vermelhos numa mesma viagem seja igual a $\frac{4}{100}$, considerando os eventos independentes.', 'Para isso, a redução do tempo em que o sinal ficará vermelho, em segundo, estabelecida pelo engenheiro foi de', 'B', 'Eventos independentes: a probabilidade dos dois sinais vermelhos é o produto das probabilidades de cada um.', 'Se cada sinal fica vermelho $15 - x$ segundos a cada 60, monte $\left(\frac{15 - x}{60}\right)^2 = \frac{4}{100}$ e tire a raiz.', 'Com redução de $x$ segundos, cada sinal tem probabilidade $\frac{15 - x}{60}$ de estar vermelho. Para os dois: $\left(\frac{15 - x}{60}\right)^2 = \frac{4}{100}$, então $\frac{15 - x}{60} = \frac{2}{10}$, ou seja, $15 - x = 12$ e $x = 3$ segundos, letra B. A letra D (12,60) aparece se você esquecer de tirar a raiz e usar $\frac{4}{100}$ para um único sinal.', 'média'),
('2024-D2-Q166', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 166, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Razão entre grandezas (densidade)', null, null, 'A densidade demográfica de uma região é definida como sendo a razão entre o número de habitantes dessa região e sua área, expressa na unidade habitantes por quilômetro quadrado.

Uma região *R* é subdividida em várias outras, sendo uma delas a região *Q*. A área de *Q* é igual a três quartos da área de *R*, e o número de habitantes de *Q* é igual à metade do número de habitantes de *R*. As densidades demográficas correspondentes a essas regiões são denotadas por $d(Q)$ e $d(R)$.', 'A expressão que relaciona $d(Q)$ e $d(R)$ é', 'E', 'Densidade é habitantes dividido por área. Escreva $d(Q)$ usando os habitantes e a área de *R*.', 'Se *R* tem $H$ habitantes e área $A$, então *Q* tem $\frac{H}{2}$ habitantes e área $\frac{3A}{4}$. Divida uma fração pela outra.', 'Com $d(R) = \frac{H}{A}$, temos $d(Q) = \frac{H/2}{3A/4} = \frac{H}{2}\cdot\frac{4}{3A} = \frac{2}{3}\cdot\frac{H}{A}$. Logo, $d(Q) = \frac{2}{3}\,d(R)$, alternativa E. A pegadinha é achar que basta multiplicar $\frac{1}{2}$ por $\frac{3}{4}$: a área está no denominador, então é preciso dividir, não multiplicar.', 'média'),
('2024-D2-Q167', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 167, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Frações e números mistos', null, null, 'Atualmente, há telefones celulares com telas de diversos tamanhos e em formatos retangulares. Alguns deles apresentam telas medindo $3\frac{1}{2}$ polegadas, com determinadas especificações técnicas. Além disso, em muitos modelos, com a inclusão de novas funções no celular, suas telas ficaram maiores, sendo muito comum encontrarmos atualmente telas medindo $4\frac{5}{6}$ polegadas, conforme a figura.

{{figura:1}}

Fonte: Disponível em: www.tecmundo.com.br. Acesso em: 5 nov. 2014 (adaptado).', 'A diferença de tamanho, em valor absoluto, entre as medidas, em polegada, das telas do celular 2 e do celular 1, representada apenas com uma casa decimal, é', 'D', 'Transforme os números mistos em frações impróprias com o mesmo denominador antes de subtrair.', '$3\frac{1}{2} = \frac{21}{6}$ e $4\frac{5}{6} = \frac{29}{6}$. Subtraia e depois converta o resultado para decimal.', '$4\frac{5}{6} - 3\frac{1}{2} = \frac{29}{6} - \frac{21}{6} = \frac{8}{6} = \frac{4}{3} \approx 1{,}33$. Com uma casa decimal, a diferença é 1,3 polegada, alternativa D. Cuidado para não subtrair as partes separadamente de forma errada, como fazer $\frac{5}{6}-\frac{1}{2}$ e esquecer de somar a parte inteira.', 'fácil'),
('2024-D2-Q168', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 168, '5_alternativas', 'Matemática', 'Trigonometria', 'Função seno: amplitude e período', null, null, 'Projetistas de uma fábrica de amortecedores realizaram uma série de experimentos que produziram oscilações semelhantes ao comportamento do gráfico de uma senoide, para qualquer tipo de estrada. Cada experimento teve duração de 20 minutos, sendo os 9 primeiros minutos em superfície que simula uma rodovia asfaltada, e os 11 minutos restantes em superfície que simula uma estrada de chão.

Para os amortecedores serem aprovados no experimento, exige-se que as amplitudes das ondas oscilatórias, em cada tipo de superfície, sejam constantes e, ainda, que a amplitude da oscilação do amortecedor no asfalto seja menor do que sua amplitude da oscilação na estrada de chão.', 'O tipo de gráfico que descreve o comportamento oscilatório de um amortecedor aprovado nesse experimento é', 'A', 'A amplitude é a altura das ondas. Observe como ela deve ser em cada trecho: antes e depois dos 9 minutos.', 'Procure o gráfico em que a altura das ondas é a mesma do início até 9 min, fica maior depois disso e não muda mais até 20 min. A frequência das ondas não importa aqui.', 'O amortecedor aprovado tem amplitude constante no asfalto (0 a 9 min), amplitude constante na estrada de chão (9 a 20 min) e a do asfalto menor que a do chão. O gráfico da alternativa A mostra exatamente isso: ondas baixas e iguais até 9 min e, depois, ondas mais altas e iguais até o fim. Na B, a amplitude depois de 9 min vai diminuindo, ou seja, não é constante. Nas outras, a amplitude é igual nos dois trechos ou diminui.', 'fácil'),
('2024-D2-Q169', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 169, '5_alternativas', 'Matemática', 'Probabilidade', 'Probabilidade sem reposição', null, null, 'A criptografia refere-se à construção e análise de protocolos que impedem terceiros de lerem mensagens privadas. Júlio César, imperador romano, utilizava um código para proteger as mensagens enviadas a seus generais. Assim, se a mensagem caísse em mãos inimigas, a informação não poderia ser compreendida. Nesse código, cada letra do alfabeto era substituída pela letra três posições à frente, ou seja, o “A” era substituído pelo “D”, o “B” pelo “E”, o “C” pelo “F”, e assim sucessivamente.

| Letra do texto original | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Letra do texto codificado | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | A | B | C |

Fonte: Disponível em: www.codifica.ibict.br. Acesso em: 15 out. 2019.

Qualquer código que tenha um padrão de substituição de letras como o descrito é considerado uma Cifra de César ou um Código de César. Note que, para decifrar uma Cifra de César, basta descobrir por qual letra o “A” foi substituído, pois isso define todas as demais substituições a serem feitas.

Uma mensagem, em um alfabeto de 26 letras, foi codificada usando uma Cifra de César. Considere a probabilidade de se descobrir, aleatoriamente, o padrão utilizado nessa codificação, e que uma tentativa frustrada deverá ser eliminada nas tentativas seguintes.', 'A probabilidade de se descobrir o padrão dessa Cifra de César apenas na terceira tentativa é dada por', 'E', 'Para acertar só na terceira tentativa, as duas primeiras precisam dar errado. E cada erro é descartado.', 'São 25 padrões possíveis (o A pode virar qualquer uma das outras 25 letras). Calcule a chance de errar, errar de novo com uma opção a menos e então acertar, multiplicando as etapas.', 'Há 25 padrões. Errar na 1ª: $\frac{24}{25}$. Errar na 2ª, sobrando 24 opções: $\frac{23}{24}$. Acertar na 3ª, sobrando 23: $\frac{1}{23}$. Como os eventos acontecem em sequência, multiplicamos: $\frac{24}{25}\times\frac{23}{24}\times\frac{1}{23}$, alternativa E. A alternativa B usa os mesmos números, mas soma, o que é errado para eventos que precisam ocorrer juntos; a alternativa D esquece que as tentativas frustradas são eliminadas.', 'média'),
('2024-D2-Q170', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 170, '5_alternativas', 'Matemática', 'Exponencial e logaritmo', 'Logaritmo na escala Richter', null, null, 'Em uma região com grande incidência de terremotos, observou-se que dois terremotos ocorridos apresentaram magnitudes $M_1$ e $M_2$, medidos segundo a escala Richter, e liberaram energias iguais a $E_1$ e $E_2$, respectivamente. Entre os estudiosos do assunto, é conhecida uma expressão algébrica relacionando esses valores dada por

$$M_2 - M_1 = \frac{2}{3}\log\left(\frac{E_2}{E_1}\right)$$

Estudos mais abrangentes observaram que o primeiro terremoto apresentou a magnitude $M_1 = 6{,}9$ e a energia liberada foi um décimo da observada no segundo terremoto.', 'O valor aproximado da magnitude $M_2$ do segundo terremoto, expresso com uma casa decimal, é igual a', 'C', 'A energia do primeiro foi um décimo da do segundo. Descubra quanto vale $\frac{E_2}{E_1}$.', 'Se $E_1 = \frac{E_2}{10}$, então $\frac{E_2}{E_1} = 10$, e $\log 10 = 1$. Substitua na fórmula e isole $M_2$.', 'Como $\frac{E_2}{E_1} = 10$, temos $M_2 - 6{,}9 = \frac{2}{3}\log 10 = \frac{2}{3} \approx 0{,}67$. Assim, $M_2 \approx 6{,}9 + 0{,}67 = 7{,}57 \approx 7{,}6$, alternativa C. Quem inverte a razão ($\frac{E_2}{E_1} = \frac{1}{10}$) acha $\log = -1$ e chega a 6,2, mas o segundo terremoto liberou mais energia, então sua magnitude tem que ser maior.', 'média'),
('2024-D2-Q171', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 171, '5_alternativas', 'Matemática', 'Geometria plana', 'Áreas de polígonos regulares', null, null, 'Um jardineiro dispõe de *k* metros lineares de cerca baixa para fazer um jardim ornamental. O jardim, delimitado por essa cerca, deve ter a forma de um triângulo equilátero, um quadrado ou um hexágono regular. A escolha será pela forma que resulte na maior área.', 'O jardineiro escolherá a forma de', 'A', 'O perímetro é sempre $k$. Ache o lado de cada figura dividindo $k$ pelo número de lados e calcule as três áreas.', 'Lados: triângulo $\frac{k}{3}$, quadrado $\frac{k}{4}$, hexágono $\frac{k}{6}$. O hexágono regular é formado por 6 triângulos equiláteros. Compare as áreas em decimal.', 'Hexágono de lado $\frac{k}{6}$: $6\cdot\frac{(k/6)^2\sqrt{3}}{4} = \frac{k^2\sqrt{3}}{24} \approx 0{,}072k^2$. Quadrado: $\left(\frac{k}{4}\right)^2 = \frac{k^2}{16} \approx 0{,}063k^2$. Triângulo: $\frac{(k/3)^2\sqrt{3}}{4} = \frac{k^2\sqrt{3}}{36} \approx 0{,}048k^2$. O hexágono vence, com área $\frac{k^2\sqrt{3}}{24}$: alternativa A. A alternativa B usa $k$ como lado do hexágono, mas $k$ é o perímetro.', 'difícil'),
('2024-D2-Q172', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 172, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Velocidade média e encontro', null, null, 'Um aeroporto disponibiliza o serviço de transporte gratuito entre seus dois terminais utilizando os ônibus A e B, que partem simultaneamente, de hora em hora, de terminais diferentes. A distância entre os terminais é de 9 000 metros, e o percurso total dos ônibus, de um terminal ao outro, é monitorado por um sistema de cinco câmeras que cobrem diferentes partes do trecho, conforme o esquema.

{{figura:1}}

O alcance de cada uma das cinco câmeras é:

- câmera I: $\frac{1}{5}$ do percurso;
- câmera II: $\frac{3}{10}$ do percurso;
- câmera III: $\frac{1}{10}$ do percurso;
- câmera IV: $\frac{1}{10}$ do percurso;
- câmera V: $\frac{3}{10}$ do percurso.

Em determinado horário, o ônibus A parte do terminal 1 e realiza o percurso total com velocidade constante de 250 m/min; enquanto o ônibus B, que parte do terminal 2, realiza o percurso total com velocidade constante de 150 m/min.', 'Qual câmera registra o momento em que os ônibus A e B se encontram?', 'D', 'Os ônibus andam em sentidos opostos, então se aproximam com a soma das velocidades.', 'Ache o tempo do encontro com $\frac{9\,000}{250+150}$. Depois calcule quanto o ônibus A andou e veja que fração do percurso isso representa.', 'Velocidade de aproximação: $250 + 150 = 400$ m/min. Tempo até o encontro: $\frac{9\,000}{400} = 22{,}5$ min. Nesse tempo, A anda $250 \times 22{,}5 = 5\,625$ m, que é $\frac{5\,625}{9\,000} = 0{,}625$ do percurso a partir do terminal 1. Somando as câmeras: I vai até 0,2; II até 0,5; III até 0,6; IV até 0,7. Como 0,625 está entre 0,6 e 0,7, o encontro é registrado pela câmera IV, alternativa D.', 'média'),
('2024-D2-Q173', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 173, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Gráfico de barras e probabilidade', null, null, 'Uma empresa tem 400 funcionários, distribuídos em três setores: administrativo, logística e produção. O gráfico apresenta a distribuição quantitativa desses funcionários, por setor e por faixa etária.

{{figura:1}}

Uma viagem de férias será sorteada entre esses funcionários, de forma que todos terão igual probabilidade de serem sorteados.', 'A maior probabilidade é que o funcionário sorteado esteja na faixa etária', 'A', 'Porcentagens de setores diferentes não podem ser somadas direto: transforme cada uma em número de pessoas.', 'Calcule a quantidade de funcionários de cada faixa etária em cada setor (porcentagem × total do setor) e some por faixa. A maior soma dá a maior probabilidade.', 'Até 25 anos: $16 + 30 + 80 = 126$. Entre 25 e 45: $24 + 48 + 70 = 142$. A partir de 45: $40 + 42 + 50 = 132$. A faixa entre 25 e 45 anos tem mais funcionários, então é a mais provável no sorteio: alternativa A. A alternativa E soma as porcentagens (110%), mas isso não faz sentido, porque cada porcentagem se refere a um setor de tamanho diferente.', 'média'),
('2024-D2-Q174', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 174, '5_alternativas', 'Matemática', 'Geometria espacial', 'Projeção ortogonal', null, null, 'Em um jogo virtual para celular, um personagem pode percorrer trajetórias retilíneas voando ou se deslocando ao longo de paredes. Considere que o personagem descreve a trajetória *ABCDEF*, em que os pontos *A*, *D* e *E* estão em um plano paralelo ao que contém os pontos *B* e *C*, sendo esses dois planos ortogonais ao plano da base que contém o ponto *F*, conforme a figura.

{{figura:1}}', 'A projeção ortogonal, sobre o plano da base, da trajetória *ABCDEF* descrita pelo personagem é', 'C', 'Projetar no plano da base é como olhar a trajetória de cima: tudo o que é vertical vira um ponto.', 'O trecho BC é vertical, então B e C caem no mesmo ponto. Já D e E estão na mesma parede, mas em posições diferentes de profundidade, então DE vira um segmento sobre a borda daquela parede.', 'Vista de cima: A fica no canto do fundo da parede direita; B e C, um acima do outro, viram um único ponto na borda esquerda; D e E, na parede direita, viram um pequeno segmento sobre a borda direita; e F fica no meio da borda da frente. A alternativa C mostra exatamente esse caminho: do canto até a borda esquerda, depois até a borda direita, um trecho reto sobre essa borda e, por fim, até F. A alternativa D erra ao desenhar BC como segmento, e a alternativa B ignora o trecho DE.', 'difícil'),
('2024-D2-Q175', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 175, '5_alternativas', 'Matemática', 'Geometria espacial', 'Volume do cilindro', null, null, 'Uma indústria faz uma parceria com uma distribuidora de sucos para lançar no mercado dois tipos de embalagens. Para a fabricação dessas embalagens, a indústria dispõe de folhas de alumínio retangulares, de dimensões 10 cm por 20 cm. Cada uma dessas folhas é utilizada para formar a superfície lateral da embalagem, em formato de cilindro circular reto, que posteriormente recebe fundo e tampa circulares. A figura ilustra, dependendo de qual das duas extensões será utilizada como altura, as duas opções para formar a possível embalagem.

{{figura:1}}', 'Dentre essas duas embalagens, a de maior capacidade apresentará volume, em centímetro cúbico, igual a', 'D', 'O lado da folha que não é a altura vira o comprimento da circunferência da base: $2\pi r$.', 'Na embalagem 1, $2\pi r = 10$ e $h = 20$; na embalagem 2, $2\pi r = 20$ e $h = 10$. Ache o raio de cada uma e calcule $V = \pi r^2 h$.', 'Embalagem 1: $r = \frac{5}{\pi}$ e $V = \pi\cdot\frac{25}{\pi^2}\cdot 20 = \frac{500}{\pi}$. Embalagem 2: $r = \frac{10}{\pi}$ e $V = \pi\cdot\frac{100}{\pi^2}\cdot 10 = \frac{1\,000}{\pi}$. A maior capacidade é $\frac{1\,000}{\pi}$ cm³, alternativa D. O cilindro mais largo ganha porque o raio entra ao quadrado no volume. A alternativa E é o volume da embalagem menor.', 'média'),
('2024-D2-Q176', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 176, '5_alternativas', 'Matemática', 'Funções do 1º e 2º grau', 'Reta de tendência (função afim)', null, null, 'As receitas anuais obtidas por uma indústria no período de 2014 a 2021, em milhão de reais, foram registradas, por pontos, em um gráfico. Nele, também está representada a reta que descreve a tendência de evolução das receitas. Essa reta pode ser utilizada para estimar as receitas dos anos seguintes.

{{figura:1}}', 'A estimativa da receita, em milhão de reais, dessa indústria, para o ano de 2026, obtida a partir dessa reta de tendência, é', 'B', 'Não use os pontos soltos: use a reta. Procure onde ela cruza exatamente a malha do gráfico.', 'A reta passa por (2014, 4), (2017, 5) e (2020, 6): sobe 1 milhão a cada 3 anos. Continue esse padrão até 2026.', 'Pela reta de tendência, a receita cresce 1 milhão de reais a cada 3 anos: 4 em 2014, 5 em 2017, 6 em 2020. Seguindo o padrão, são 7 em 2023 e 8 em 2026. A estimativa é de 8 milhões de reais, alternativa B. Quem se guia pelo ponto de 2021 (cerca de 6,7) em vez da reta tende a errar a conta.', 'média'),
('2024-D2-Q177', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 177, '5_alternativas', 'Matemática', 'Funções do 1º e 2º grau', 'Função afim de custo', null, null, 'Uma empresa produz mochilas escolares sob encomenda. Essa empresa tem um custo total de produção, composto por um custo fixo, que não depende do número de mochilas, mais um custo variável, que é proporcional ao número de mochilas produzidas. O custo total cresce de forma linear, e a tabela apresenta esse custo para três quantidades de mochilas produzidas.

| Quantidade de mochilas | 30 | 50 | 100 |
|:---:|:---:|:---:|:---:|
| **Custo total (R\$)** | 1 050,00 | 1 650,00 | 3 150,00 |', 'O custo total, em real, para a produção de 80 mochilas será', 'C', 'Custo total = custo fixo + (custo por mochila × quantidade). Use a tabela para achar o custo por mochila.', 'De 30 para 50 mochilas, o custo sobe R$ 600,00 para 20 mochilas a mais. Com isso, descubra o valor por mochila e depois o custo fixo.', 'Custo por mochila: (1 650 − 1 050) ÷ 20 = R$ 30,00. Custo fixo: 1 050 − 30 × 30 = R$ 150,00. Para 80 mochilas: 150 + 30 × 80 = 150 + 2 400 = R$ 2 550,00, alternativa C. A alternativa A (2 400) esquece o custo fixo, e a E (2 800) supõe, sem razão, que o custo é proporcional à quantidade.', 'fácil'),
('2024-D2-Q178', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 178, '5_alternativas', 'Matemática', 'Estatística', 'Mediana', null, null, 'A umidade relativa do ar é um dos indicadores utilizados na meteorologia para fazer previsões sobre o clima. O quadro apresenta as médias mensais, em porcentagem, da umidade relativa do ar em um período de seis meses consecutivos em uma cidade.

| **Meses** | Maio | Jun. | Jul. | Ago. | Set. | Out. |
|---|---|---|---|---|---|---|
| **Média mensal da umidade relativa do ar (%)** | 66 | 64 | 54 | 46 | 60 | 64 |', 'Nessa cidade, a mediana desses dados, em porcentagem, da umidade relativa do ar no período considerado foi', 'E', 'Para achar a mediana, coloque os valores em ordem crescente primeiro.', 'São 6 valores, um número par. A mediana é a média dos dois valores do meio da lista ordenada.', 'Em ordem: 46, 54, 60, 64, 64, 66. Os dois do meio são 60 e 64, então a mediana é $\frac{60+64}{2} = 62$, alternativa E. A alternativa D (60) aparece para quem pega só um dos valores centrais, e a C (59) é a média aritmética, não a mediana.', 'fácil'),
('2024-D2-Q179', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 179, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Divisão proporcional', null, null, 'Uma empresa de engenharia foi contratada para realizar um serviço no valor de R\$ 71 250,00. Os sócios da empresa decidiram que 40% desse valor seria destinado ao pagamento de três engenheiros que gerenciaram o serviço. O pagamento para cada um deles será feito de forma diretamente proporcional ao total de horas trabalhadas. O número de dias e o número de horas diárias trabalhadas pelos engenheiros foram, respectivamente:

- engenheiro I: 4 dias, numa jornada de 5 horas e meia por dia;
- engenheiro II: 5 dias, numa jornada de 4 horas por dia;
- engenheiro III: 6 dias, numa jornada de 2 horas e meia por dia.', 'Qual a maior diferença, em real, entre os valores recebidos por esse serviço entre dois desses engenheiros?', 'C', 'Primeiro ache quanto vai para os engenheiros. Depois divida esse valor proporcionalmente às horas de cada um.', 'Horas totais: I = 4 × 5,5; II = 5 × 4; III = 6 × 2,5. A maior diferença é entre quem trabalhou mais horas e quem trabalhou menos.', '40% de R$ 71 250,00 = R$ 28 500,00. Horas: I = 22, II = 20, III = 15, total de 57 horas. Cada hora vale 28 500 ÷ 57 = R$ 500,00. Então I recebe R$ 11 000,00, II recebe R$ 10 000,00 e III recebe R$ 7 500,00. A maior diferença é 11 000 − 7 500 = R$ 3 500,00, alternativa C.', 'média'),
('2024-D2-Q180', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2024, 180, '5_alternativas', 'Matemática', 'Análise combinatória', 'Combinação simples', null, null, 'Um hospital tem 7 médicos cardiologistas e 6 médicos neurologistas em seu quadro de funcionários. Para executar determinada atividade, a direção desse hospital formará uma equipe com 5 médicos, sendo, pelo menos, 3 cardiologistas.', 'A expressão numérica que representa o número máximo de maneiras distintas de formar essa equipe é', 'E', '"Pelo menos 3 cardiologistas" significa separar em casos: 3, 4 ou 5 cardiologistas.', 'Em cada caso, multiplique a escolha dos cardiologistas pela dos neurologistas (as duas acontecem juntas). Depois some os casos (um ou outro acontece).', 'Casos: 3 cardiologistas e 2 neurologistas: $C_{7,3}\times C_{6,2}$; 4 e 1: $C_{7,4}\times C_{6,1}$; 5 e 0: $C_{7,5}\times C_{6,0}$. O total é a soma desses três produtos, que é exatamente a expressão da alternativa E. A alternativa B considera só o primeiro caso, e a alternativa D troca as operações: soma onde deveria multiplicar e multiplica onde deveria somar.', 'difícil'),
('2025-D2-Q136', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 136, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Consumo médio de combustível', null, null, 'Uma pessoa pretende instalar um kit de gás natural veicular (GNV) em seu carro. Na loja que escolheu para realizar a compra e instalação desse kit, havia cinco modelos de cilindro para armazenamento do gás, cujas capacidades, em metro cúbico, eram, respectivamente: 10, 14, 17, 21 e 25. O preço do cilindro é proporcional à sua capacidade. Esse carro rodará 30 km diariamente, 7 dias por semana, e o consumo do GNV é de 1 m³ a cada 13 km rodados. A pessoa escolherá o modelo de cilindro de menor preço e que garanta apenas um abastecimento semanal.', 'Nessas condições, qual será a capacidade, em metro cúbico, do cilindro escolhido por essa pessoa?', 'C', 'Calcule quantos quilômetros o carro roda em uma semana e quanto gás isso consome.', 'Distância semanal: $30 \times 7$ km. Divida por 13 para achar os metros cúbicos. O cilindro precisa ser pelo menos desse tamanho.', 'Por semana: $30 \times 7 = 210$ km. Consumo: $\frac{210}{13} \approx 16{,}2$ m³. O cilindro de 14 m³ não é suficiente, e o menor que garante um abastecimento por semana é o de 17 m³, alternativa C. Como o preço é proporcional à capacidade, os de 21 e 25 m³ servem, mas custam mais.', 'fácil'),
('2025-D2-Q137', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 137, '5_alternativas', 'Matemática', 'Probabilidade', 'Probabilidade com dados de infográfico', null, null, 'A reportagem de uma revista abordou o uso de redes sociais pelos internautas brasileiros. Alguns dos dados apurados pela reportagem estão apresentados no infográfico.

**Perfil dos brasileiros nas redes sociais**

{{figura:1}}

Fonte: Disponível em: http://revistagalileu.globo.com. Acesso em: 22 out. 2015 (adaptado).', 'Segundo os dados do infográfico, ao se escolher aleatoriamente um internauta brasileiro no período ao qual se refere a reportagem, a probabilidade de ele ser um homem que acessa alguma rede social é', 'B', 'A pessoa precisa cumprir duas condições ao mesmo tempo: acessar redes sociais e ser homem.', 'Os 60% de mulheres são calculados só sobre quem acessa redes sociais (os 90%). Então os homens são 40% desse grupo. Multiplique as porcentagens.', '90% dos internautas acessam redes sociais, e desses, 40% são homens (já que 60% são mulheres). Assim, a probabilidade é $0{,}9 \times 0{,}4 = 0{,}36 = \frac{36}{100}$, alternativa B. A alternativa C ($\frac{40}{100}$) esquece que os 40% valem só para quem acessa redes sociais, e não para todos os internautas.', 'média'),
('2025-D2-Q138', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 138, '5_alternativas', 'Matemática', 'Geometria analítica', 'Coordenadas no espaço e projeções', null, null, 'Em um jogo de computador, um cubo se encontra inicialmente posicionado conforme indicado na figura.

{{figura:1}}

Cada deslocamento efetuado por esse cubo se dá sempre em uma das direções definidas pelos três eixos coordenados. Ao se movimentar a partir da posição inicial, esse cubo se aproximou 3 unidades do plano *yz*, se afastou 5 unidades do plano *xz* e se aproximou 4 unidades do plano *xy*.', 'A figura que apresenta as projeções ortogonais desse cubo sobre os três planos coordenados, após efetuar as movimentações descritas, é', 'E', 'Aproximar ou afastar de um plano muda só a coordenada perpendicular a ele: plano *yz* ↔ *x*, plano *xz* ↔ *y*, plano *xy* ↔ *z*.', 'O cubo fica com $x$ 3 unidades menor, $y$ 5 unidades maior e $z$ 4 unidades menor. Leia as coordenadas iniciais na malha e confira as três projeções.', 'Na figura, o cubo ocupa, aproximadamente, x de 5 a 6, y de 1 a 2 e z de 6 a 7. Após o movimento, ele passa a ocupar x de 2 a 3, y de 6 a 7 e z de 2 a 3. Assim, a projeção no plano yz vai para y 6–7, z 2–3; no plano xz, para x 2–3, z 2–3; e no plano xy, para x 2–3, y 6–7. A alternativa E é a que mostra as três projeções nessas posições. A alternativa A acerta o plano yz, mas erra a coordenada x nos outros dois planos.', 'difícil'),
('2025-D2-Q139', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 139, '5_alternativas', 'Matemática', 'Geometria plana', 'Comprimento da circunferência', null, null, 'No entorno de uma lagoa circular, cujo raio mede 1 km, há um uma ciclovia. Devido aos frequentes roubos de bicicleta, a prefeitura planeja alocar policiais em posições estratégicas para patrulhar essa ciclovia, de forma a torná-la totalmente protegida. Um ponto da ciclovia é considerado protegido se houver pelo menos um policial a, no máximo, 200 m de distância daquele ponto, posicionado sobre a ciclovia. A figura ilustra um ponto *P* sobre a ciclovia, que estará protegido se houver pelo menos um policial posicionado sobre a região de cor cinza escuro.

Desconsidere a largura da pista da ciclovia e utilize 3 como aproximação para $\pi$.

{{figura:1}}', 'Nessas condições, a quantidade mínima necessária de policiais a serem alocados ao longo dessa ciclovia para torná-la protegida é', 'C', 'A ciclovia contorna a lagoa: calcule o comprimento da circunferência e quanto cada policial consegue proteger.', 'Cada policial protege 200 m para cada lado, ou seja, 400 m de ciclovia. O comprimento total é $2\pi r$, com $r = 1$ km e $\pi = 3$.', 'Comprimento da ciclovia: $2 \times 3 \times 1 = 6$ km $= 6\,000$ m. Cada policial cobre 200 m de cada lado, totalizando 400 m. Número mínimo: $\frac{6\,000}{400} = 15$ policiais, alternativa C. Quem considera apenas 200 m por policial encontra 30, mas a proteção vale para os dois lados.', 'média'),
('2025-D2-Q140', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 140, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Porcentagem em misturas', null, null, 'Em um laboratório, um recipiente contém 10 litros de uma solução composta apenas pelas substâncias S₁ e S₂. Dessa solução, 99,95% é de S₁. Uma quantidade de S₁ será retirada dessa solução, mantendo a quantidade inicial de S₂, de modo que 99,90% da nova solução seja de S₁.', 'Qual é a quantidade de S₁, em litro, que será retirada?', 'E', 'A quantidade de S₂ não muda. Descubra quanto de S₂ existe e use isso para achar o novo total.', 'S₂ é 0,05% de 10 L. Na nova solução, essa mesma quantidade deve ser 0,10% do total. Se a porcentagem dobra, o que acontece com o total?', 'S₂ = 0,05% de 10 L = $0{,}005$ L. Na nova solução, S₂ será 0,10%, então o total passa a ser $\frac{0{,}005}{0{,}001} = 5$ L. Como saiu apenas S₁, a quantidade retirada é $10 - 5 = 5$ L, alternativa E. Parece pouca mudança de 99,95% para 99,90%, mas a parte de S₂ dobrou de 0,05% para 0,10%, então o total precisou cair pela metade.', 'difícil'),
('2025-D2-Q141', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 141, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Problema aritmético com perdas', null, null, 'Uma distribuidora de combustível possui caminhões-tanque com capacidade de 30 000 litros cada. Em qualquer transporte realizado por esses caminhões, um mesmo volume de combustível é descartado, pois fica com muitas impurezas. Esse volume descartado independe da quantidade transportada.

Um posto de combustível encomendou 10 000 litros de gasolina dessa distribuidora, que enviou 10 200 litros, considerando o volume descartado no transporte. Mesmo assim, a quantidade de gasolina entregue ao posto foi de 9 900 litros.

Em um novo pedido, esse posto solicitou que fosse entregue exatamente o dobro do volume de gasolina encomendado no pedido anterior.', 'Utilizando o mesmo caminhão da entrega anterior, qual é o volume mínimo de gasolina, em litro, que a distribuidora deverá enviar para garantir a entrega da quantidade encomendada nesse novo pedido?', 'C', 'Compare o que foi enviado com o que chegou: a diferença é o volume descartado em toda viagem.', 'Foram enviados 10 200 L e chegaram 9 900 L. Esse descarte é fixo, não depende da quantidade. Agora o posto quer receber exatamente 20 000 L.', 'Volume descartado: 10 200 − 9 900 = 300 L, e ele é o mesmo em qualquer transporte. Para entregar 20 000 L, a distribuidora precisa enviar 20 000 + 300 = 20 300 L, alternativa C. A alternativa B (20 200) usa a folga de 200 L do primeiro envio, que não bastou nem naquela vez.', 'fácil'),
('2025-D2-Q142', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 142, '5_alternativas', 'Matemática', 'Estatística', 'Mediana', null, null, 'Uma empresa de tecnologia vai padronizar a velocidade de conexão de internet que oferece a seus clientes em dez cidades. A direção da empresa decide que seu novo padrão de velocidade de referência será a mediana dos valores das velocidades de referência de conexões nessas dez cidades. Esses valores, em megabyte por segundo (MB/s), são apresentados no quadro.

| Cidades | Velocidade de referência (MB/s) |
|---|---|
| C1 | 390 |
| C2 | 380 |
| C3 | 320 |
| C4 | 390 |
| C5 | 340 |
| C6 | 380 |
| C7 | 390 |
| C8 | 400 |
| C9 | 350 |
| C10 | 360 |', 'A velocidade de referência, em megabyte por segundo, a ser adotada por essa empresa é', 'C', 'Ordene as 10 velocidades em ordem crescente antes de procurar o meio.', 'Com 10 valores, a mediana é a média do 5º e do 6º valores da lista ordenada.', 'Em ordem: 320, 340, 350, 360, 380, 380, 390, 390, 390, 400. O 5º e o 6º valores são 380 e 380, então a mediana é $\frac{380+380}{2} = 380$ MB/s, alternativa C. A alternativa D (390) é a moda, o valor que mais se repete, e não a mediana.', 'fácil'),
('2025-D2-Q143', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 143, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Comparação de quantidades por porção', null, null, 'Na cantina de uma escola, há cinco alimentos vendidos em pacotes com diferentes quantidades de porções.

As informações nutricionais contidas nos rótulos desses produtos estão indicadas nas imagens.

**Batata chips**
Pacote com 3 porções de 50 g
170 mg de sódio por porção

**Palitos salgados**
Pacote com 4 porções de 20 g
501 mg de sódio por porção

**Biscoito multigrãos**
Pacote com 8 porções de 25 g
264 mg de sódio por porção

**Biscoito de polvilho**
Pacote com 6 porções de 15 g
175 mg de sódio por porção

**Biscoito de água e sal**
Pacote com 5 porções de 40 g
166 mg de sódio por porção

Uma estudante opta sempre pelo alimento com a menor quantidade total de sódio por pacote.', 'Qual desses produtos deve ser o escolhido pela estudante?', 'A', 'O que importa é o sódio do pacote inteiro, não de uma porção. Multiplique pelo número de porções.', 'Faça sódio por porção × número de porções para os cinco produtos. O peso de cada porção em gramas não entra na conta.', 'Sódio por pacote: batata chips 3 × 170 = 510 mg; palitos 4 × 501 = 2 004 mg; multigrãos 8 × 264 = 2 112 mg; polvilho 6 × 175 = 1 050 mg; água e sal 5 × 166 = 830 mg. O menor total é o da batata chips, alternativa A. A alternativa E é tentadora porque tem o menor sódio por porção, mas o pacote tem mais porções.', 'fácil'),
('2025-D2-Q144', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 144, '5_alternativas', 'Matemática', 'Geometria espacial', 'Faces de poliedros', null, null, 'Uma fábrica utilizou uma impressora 3D para produzir o protótipo de uma peça. O protótipo tem forma de um poliedro convexo, obtido pela justaposição de dois sólidos distintos, um com a forma de um prisma hexagonal regular reto e o outro com a forma de um tronco de pirâmide hexagonal reta. A base maior do tronco de pirâmide coincide com uma das bases do prisma.

Após a impressão do protótipo, ele foi encaminhado ao setor de customização para realização da pintura de sua superfície. O critério definido para realização da pintura considera que faces congruentes entre si devem ser pintadas com uma mesma cor, e faces não congruentes entre si devem apresentar cores distintas.', 'Qual é a quantidade de cores utilizadas para pintar o protótipo?', 'D', 'Liste as faces que ficam visíveis no sólido juntado. A face em que o tronco encosta no prisma não é pintada.', 'Sobram: uma base hexagonal do prisma, as faces laterais do prisma (retângulos), as faces laterais do tronco (trapézios) e a base menor do tronco. Agrupe as que são congruentes.', 'As faces externas são: a base hexagonal livre do prisma, 6 retângulos laterais iguais, 6 trapézios laterais iguais do tronco e o hexágono menor do tronco. A base maior do tronco coincide com uma base do prisma e fica escondida. Isso dá 4 grupos de faces congruentes: hexágono grande, retângulos, trapézios e hexágono pequeno. São 4 cores, alternativa D. Quem conta as duas bases do prisma separadas ou a face interna chega a mais cores.', 'média'),
('2025-D2-Q145', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 145, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Interpretação de gráfico de linhas', null, null, 'Pesquisas na área de neurobiologia confirmam que a prática meditativa é responsável por diminuir consideravelmente a frequência respiratória para praticantes avançados, que, após iniciarem a meditação, têm suas frequências respiratórias reduzidas até se estabilizarem em um nível mais baixo. O gráfico apresenta a relação da frequência respiratória, em incursões de respirações por minuto (rpm), em relação ao tempo, em minuto, de um praticante avançado, em que (f₁) representa a frequência no instante t₁, no qual se inicia a prática meditativa; e (f₂), a frequência no instante t₂, a partir do qual esta se estabiliza durante a meditação.

{{figura:1}}

Fonte: Disponível em: www.redepsi.com.br. Acesso em: 3 dez. 2018 (adaptado).', 'A partir do instante t₁, em que se inicia a prática meditativa, o comportamento da frequência respiratória, em relação ao tempo,', 'D', 'Olhe o gráfico só a partir de t₁ e veja o que a curva faz em cada trecho.', 'Entre t₁ e t₂ a curva desce, mas não em linha reta. Depois de t₂, ela fica horizontal. "Proporcional" exigiria uma reta ou uma relação bem definida.', 'A partir de t₁, a frequência respiratória cai de f₁ até f₂, e depois de t₂ fica constante em f₂. Isso é exatamente o que diz a alternativa D. A alternativa E erra porque, depois de t₂, a frequência não diminui mais, e as alternativas B e C falam em proporcionalidade, que o gráfico não mostra.', 'fácil'),
('2025-D2-Q146', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 146, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Subtração de decimais', null, null, 'No atletismo, um grande desafio da prova de 100 metros rasos é a sua conclusão num tempo abaixo da marca de referência dos 10,00 segundos. Vários atletas já alcançaram esse feito. Em 2009, o jamaicano Usain Bolt estabeleceu o recorde mundial masculino dessa prova, com o tempo de 9,58 segundos.', 'Qual é a diferença, em segundo, entre a marca de referência e a marca estabelecida por Usain Bolt em 2009?', 'B', 'É só uma subtração de decimais: alinhe as vírgulas.', 'Faça 10,00 − 9,58. Para checar, some o resultado com 9,58 e veja se dá 10,00.', '10,00 − 9,58 = 0,42 segundo, alternativa B. Conferindo: 9,58 + 0,42 = 10,00. A alternativa E (1,42) aparece quando se erra o "empresta um" na subtração.', 'fácil'),
('2025-D2-Q147', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 147, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Porcentagem a partir de gráficos', null, null, 'Uma escola de idiomas oferece cursos de inglês, espanhol, francês e alemão. Os gráficos apresentam a distribuição percentual das matrículas, por idioma, em 2023, e a distribuição da quantidade de matrículas, por idioma, em 2024.

{{figura:1}}

Para planejar as atividades de 2025, o gerente da escola estimou que o total de matrículas será o mesmo de 2024, e a distribuição percentual das matrículas, por idioma, será igual à registrada em 2023.', 'Segundo essa estimativa, o número de matrículas no curso de francês para o ano de 2025 será', 'E', 'Use o total de matrículas de 2024 e a porcentagem do francês em 2023.', 'Some todas as colunas de 2024 para ter o total. Depois aplique os 10% do francês do gráfico de setores.', 'Total de 2024: 280 + 80 + 20 + 20 = 400 matrículas. Com a distribuição de 2023, o francês terá 10% de 400 = 40 matrículas, alternativa E. A alternativa C (20) é o número de matrículas de francês em 2024, que não serve para a estimativa, e a A (2) é 10% de 20.', 'fácil'),
('2025-D2-Q148', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 148, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Escala e comprimento real', null, null, 'O controle remoto de um carrinho de brinquedo vem equipado com uma tela que ajusta automaticamente a escala empregada na exibição de cada deslocamento. A tela apresenta a imagem do deslocamento, a escala utilizada na geração dessa imagem e o comprimento desse deslocamento, em centímetro, em conformidade com a escala empregada. As figuras representam a tela do controle remoto exibindo os dados de cinco deslocamentos realizados por esse carrinho.

{{figura:1}}', 'A opção que indica o deslocamento de maior comprimento realizado pelo carrinho de brinquedo é', 'C', 'Escala 1 : 100 quer dizer que cada 1 cm na tela vale 100 cm de verdade. Calcule o tamanho real de cada deslocamento.', 'Multiplique o comprimento na tela pelo número da escala em cada opção e compare. O maior número da escala sozinho não decide.', 'Comprimentos reais: I: 9 × 100 = 900 cm; II: 5 × 300 = 1 500 cm; III: 5 × 600 = 3 000 cm; IV: 3 × 700 = 2 100 cm; V: 2 × 1 000 = 2 000 cm. O maior é o III, alternativa C. A alternativa E tem a maior escala, e a I tem o maior traço na tela, mas nenhuma das duas dá o maior comprimento real.', 'fácil'),
('2025-D2-Q149', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 149, '5_alternativas', 'Matemática', 'Geometria espacial', 'Vértices de poliedro', null, null, 'A cúpula pentagonal giralongada é um poliedro de Johnson, cujas faces são polígonos regulares, mas que não é um poliedro de Platão, de Arquimedes, prisma ou antiprisma.

As figuras apresentam esse poliedro em duas posições e uma de suas planificações.

{{figura:1}}

{{figura:2}}', 'Quantos vértices tem esse poliedro?', 'B', 'Conte as faces de cada tipo na planificação e use a relação de Euler, ou conte os vértices por "andares".', 'Pela planificação: 1 decágono, 1 pentágono, 5 quadrados e 25 triângulos. Calcule as arestas como (soma dos lados de todas as faces) ÷ 2 e use $V - A + F = 2$.', 'Faces: $F = 1 + 1 + 5 + 25 = 32$. Arestas: $A = \frac{10 + 5 + 5\cdot 4 + 25\cdot 3}{2} = \frac{110}{2} = 55$. Por Euler, $V = A - F + 2 = 55 - 32 + 2 = 25$, alternativa B. Dá para conferir pelos andares: 5 vértices no pentágono, 10 no meio e 10 no decágono da base. As alternativas C (55) e E (110) são o número de arestas e a soma dos lados antes de dividir por 2.', 'difícil'),
('2025-D2-Q150', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 150, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Regra de três composta', null, null, 'Uma fábrica de tijolos ecológicos com 3 funcionários, cada um trabalhando 6 horas diárias, produz 720 unidades por dia. Para atender ao crescimento da demanda por esse tipo de tijolo, essa fábrica passou a ter 5 funcionários, cada um trabalhando 9 horas por dia, aumentando, assim, sua capacidade de produção. Todos os funcionários produzem igual quantidade de tijolos a cada hora, independentemente de trabalharem 6 ou 9 horas diárias.', 'O número de tijolos fabricados diariamente após o aumento da capacidade de produção é', 'D', 'Descubra quantos tijolos um funcionário faz por hora; essa taxa é a mesma antes e depois.', 'Antes: $3 \times 6 = 18$ horas de trabalho por dia geram 720 tijolos. Depois: $5 \times 9$ horas por dia.', 'Produtividade: $\frac{720}{3 \times 6} = 40$ tijolos por funcionário por hora. Depois do aumento: $5 \times 9 \times 40 = 1\,800$ tijolos por dia, alternativa D. A alternativa C (1 200) considera só o aumento de funcionários, e a B (1 080) considera só o aumento de horas.', 'fácil'),
('2025-D2-Q151', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 151, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Código numérico posicional', null, null, 'Para acompanhar o fluxo de visitantes em seu prédio, uma empresa estabeleceu um código de identificação para a visitação. De acordo com a regra estabelecida, cada visitante será identificado com um código sequencial numérico com 7 dígitos, determinado, da esquerda para a direita, da seguinte forma:

- o primeiro dígito indica o andar ao qual o visitante se dirige, que é um número de 1 a 4;
- os dois próximos dígitos correspondem ao número do setor da empresa ao qual o visitante se destina. Esse número varia de 01 a 20;
- os três dígitos seguintes correspondem ao número do funcionário da empresa com quem o visitante irá se reunir. Esse número varia de 001 a 135;
- o último dígito indica se o visitante chegou à empresa pela manhã, dígito 0, ou à tarde, dígito 1.

Um visitante chegou à empresa às 10 horas da manhã para se reunir com o funcionário identificado pelo número 109, que trabalha no setor 08 da empresa, localizado no 2º andar.', 'O código de identificação desse visitante é', 'D', 'Monte o código peça por peça, na ordem da regra: andar, setor, funcionário e turno.', 'O andar tem 1 dígito, o setor 2 dígitos (com zero à esquerda), o funcionário 3 dígitos e o turno 1 dígito. Chegar às 10h conta como manhã.', 'Seguindo a ordem: andar 2 → "2"; setor 08 → "08"; funcionário 109 → "109"; manhã → "0". Juntando: 2 | 08 | 109 | 0 = 2081090, alternativa D. A alternativa E (2810910) esquece o zero do setor e erra o turno.', 'fácil'),
('2025-D2-Q152', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 152, '5_alternativas', 'Matemática', 'Probabilidade', 'Probabilidade e permutações', null, null, 'Quatro candidatos se apresentaram para realizar a prova de um concurso. Antes de iniciar a prova, os celulares dos quatro candidatos foram recolhidos pelo aplicador, que os guardou, cada um, dentro de um envelope preto. Ao término da prova, o aplicador devolveu os quatro envelopes com os celulares aos quatro candidatos, de maneira aleatória, já que não havia feito a identificação dos envelopes.', 'A probabilidade de que todos os candidatos tenham recebido de volta os envelopes com os seus respectivos celulares é', 'D', 'Pense em quantas maneiras diferentes os 4 envelopes podem ser distribuídos entre os 4 candidatos.', 'O total de distribuições é uma permutação de 4 elementos. Só uma delas devolve cada celular ao dono certo.', 'Os 4 envelopes podem ser entregues de $4! = 4 \cdot 3 \cdot 2 \cdot 1 = 24$ maneiras, e apenas uma delas acerta todos os donos. Logo, a probabilidade é $\frac{1}{24}$, alternativa D. A alternativa E ($\frac{1}{256} = \frac{1}{4^4}$) trataria cada entrega como independente, permitindo repetir envelopes, o que não acontece.', 'fácil'),
('2025-D2-Q153', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 153, '5_alternativas', 'Matemática', 'Geometria analítica', 'Mediatriz e equação da reta', null, null, 'Em um jogo digital, há três personagens: um herói e dois vilões. A programação é feita de tal forma que o herói sempre será atacado pelo vilão que estiver mais próximo dele. Uma das maneiras de “confundir” os vilões é movimentar o herói por trajetórias que o mantenha equidistante dos vilões, gerando indefinição entre eles e, com isso, não sendo atacado.

Para a programação de uma das etapas desse jogo, o programador considerou, no plano cartesiano, o quadrado *STUV* como a região de movimentação dos personagens, onde *V* e *T* representam as posições fixas dos vilões, e *S*, a posição inicial do herói, como apresentado na figura.

{{figura:1}}', 'Qual é a equação da trajetória em que o herói poderá se movimentar sem ser atacado?', 'A', 'Os pontos equidistantes de dois pontos fixos formam a mediatriz do segmento entre eles.', 'Num quadrado, a mediatriz da diagonal TV é a outra diagonal, que passa por S e pelo centro. Ache T (os lados SV e ST são perpendiculares e iguais) e o ponto médio de TV.', 'De $S(6;2)$ para $V(8;6)$ o deslocamento é $(2;4)$; girando 90°, $T = S + (-4;2) = (2;4)$. O centro do quadrado é o ponto médio de TV: $(5;5)$. A trajetória é a reta por $S(6;2)$ e $(5;5)$: inclinação $\frac{5-2}{5-6} = -3$, então $y - 2 = -3(x-6)$, ou seja, $y = -3x + 20$, alternativa A. Confira: $S$ satisfaz, pois $-18+20 = 2$; já $y=-3x+16$ (B) não passa por S.', 'difícil'),
('2025-D2-Q154', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 154, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Gráfico de barras comparativo', null, null, 'Uma livraria comercializa livros dos seguintes gêneros literários: ficção científica, autoajuda, romance e biografia. O gráfico apresenta o estoque dos livros que essa livraria tem, por gênero literário e por nacionalidade do autor, bem como a demanda por gênero literário, obtida por meio de uma enquete feita com seus clientes habituais.

**Estoque e demanda por livros**

{{figura:1}}

O gerente da livraria fará a encomenda de novos exemplares somente do gênero cuja quantidade em estoque seja insuficiente para atender a demanda constatada pela enquete.', 'O gênero de livro do qual o gerente deverá encomendar mais exemplares é', 'C', 'Para cada gênero, some o estoque de autores brasileiros e estrangeiros e compare com a demanda.', 'O gerente só encomenda quando o estoque total é MENOR que a demanda. Ter a maior demanda ou o menor estoque, por si só, não basta.', 'Estoques totais: ficção 80 + 120 = 200 (demanda 160); autoajuda 50 + 80 = 130 (demanda cerca de 136); romance 40 + cerca de 106 ≈ 146 (demanda 140); biografia ≈ 96 (demanda 80). Só a autoajuda tem estoque inferior à demanda, alternativa C. A alternativa A é tentadora, mas a ficção já tem estoque de sobra.', 'fácil'),
('2025-D2-Q155', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 155, '5_alternativas', 'Matemática', 'Análise combinatória', 'Princípio fundamental da contagem', null, null, 'Dez casais fundaram um grupo de dança e decidiram constituir uma diretoria com três cargos: presidente, secretário e tesoureiro. Para maior representatividade, decidiu-se que no máximo uma pessoa por casal poderá ocupar um cargo nessa diretoria.', 'Quantas diretorias diferentes podem ser constituídas por esses 10 casais?', 'B', 'Os cargos são diferentes, então a ordem importa: use o princípio multiplicativo cargo por cargo.', 'Para o presidente há 20 pessoas. Escolhido ele, o cônjuge dele também fica de fora do próximo cargo. Quantas sobram a cada etapa?', 'Presidente: 20 opções. Secretário: saem o presidente e o cônjuge, restam 18. Tesoureiro: saem mais duas pessoas (o secretário e o cônjuge), restam 16. Total: $20 \times 18 \times 16$, alternativa B. A alternativa C ($20 \times 19 \times 18$) ignora a regra de no máximo uma pessoa por casal.', 'média'),
('2025-D2-Q156', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 156, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Escala de ampliação', null, null, 'Um artista, que costuma fazer desenhos com areia na praia, pediu a um banhista que fizesse um pequeno desenho, que serviria de esboço para uma grande obra de arte a ser feita na areia. Esse desenho está representado na figura.

{{figura:1}}

Após a conclusão, a obra de arte obtida manteve as mesmas proporções do desenho feito pelo banhista, sendo que as medidas indicadas na figura foram ampliadas para 30 m.', 'Em qual escala esse desenho representa a obra de arte?', 'E', 'Escala é a razão entre a medida no desenho e a medida real, sempre na mesma unidade.', 'Converta 30 m para centímetros antes de montar a razão com os 20 cm do desenho.', '30 m = 3 000 cm. A escala é $\frac{20}{3000} = \frac{1}{150}$, ou seja, 1 : 150, alternativa E. A alternativa A (1 : 1,5) aparece quando se divide 30 por 20 sem converter metros em centímetros.', 'fácil'),
('2025-D2-Q157', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 157, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Razão entre grandezas', null, null, 'O cortisol é um hormônio produzido pelas glândulas adrenais e pode ser considerado um importante marcador do estresse fisiológico. Em um estudo desenvolvido com enfermeiros, foi verificado que a concentração de cortisol salivar em um dia de trabalho, denotada por *T*, era, em média, 1,59 vezes a concentração de cortisol salivar em um dia de folga, denotada por *F*.

Fonte: ROCHA, M. C. P. et al. Estresse em enfermeiros: o uso do cortisol salivar no dia de trabalho e de folga. **Rev. Esc. Enferm. USP**, n. 5, 2013 (adaptado).', 'Nesse estudo, a relação obtida entre *T* e *F* foi', 'C', '"Uma coisa é 1,59 vezes a outra" indica multiplicação, não soma.', 'Escreva T = 1,59 · F e veja qual alternativa é equivalente a essa igualdade.', 'Se T é, em média, 1,59 vezes F, então $T = 1{,}59 \cdot F$. Dividindo os dois lados por F: $\frac{T}{F} = 1{,}59$, alternativa C. A alternativa D inverte a razão, e a alternativa A troca \"vezes\" por \"mais\".', 'fácil'),
('2025-D2-Q158', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 158, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Aumento percentual e custos', null, null, 'Um estacionamento possui 120 vagas para veículos, e todas essas vagas estão ocupadas. Cada cliente paga uma mensalidade para utilizar uma vaga, que é calculada com base nas despesas mensais do estacionamento e no lucro pretendido. As despesas mensais do estacionamento são: R\$ 14 240,00 com manutenção mais R\$ 36,00 de seguro por veículo. O lucro do estacionamento é determinado pela diferença do valor arrecadado com as mensalidades pelas despesas efetuadas. A partir do mês seguinte, o valor do seguro por veículo aumentará em 20%, e as despesas com manutenção permanecerão sem alterações. Com isso, o dono do estacionamento reajustará as mensalidades para obter um lucro mensal de R\$ 10 000,00. Apesar desse reajuste, todas as vagas continuarão ocupadas.', 'O valor, em real, da mensalidade reajustada será', 'C', 'Calcule o novo seguro por veículo, depois a despesa total do mês, e some o lucro desejado.', 'Seguro novo: 36 · 1,2 por carro. Arrecadação necessária = manutenção + seguro de 120 carros + 10 000. Depois divida pelas 120 vagas.', 'Seguro reajustado: $36 \cdot 1{,}2 = 43{,}20$ por veículo, ou $120 \cdot 43{,}20 = 5\,184$ no total. Despesas: $14\,240 + 5\,184 = 19\,424$. Com o lucro: $19\,424 + 10\,000 = 29\,424$. Mensalidade: $\frac{29\,424}{120} = 245{,}20$, alternativa C (R\$ 245,20).', 'média'),
('2025-D2-Q159', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 159, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Conversão de unidades de volume', null, null, 'O dono de uma sorveteria armazena sorvete em potes de 20 000 cm³. Ele serve o sorvete em taças, em porções de 250 mL.', 'A quantidade de taças que ele consegue servir a partir de um pote cheio de sorvete é', 'D', 'Lembre a relação entre cm³ e mL.', '1 cm³ equivale a 1 mL. Depois é só ver quantas porções de 250 mL cabem no pote.', 'Como 1 cm³ = 1 mL, o pote tem 20 000 mL. Número de taças: $\frac{20\,000}{250} = 80$, alternativa D. A alternativa E (800) aparece se você errar a divisão por um fator 10.', 'fácil'),
('2025-D2-Q160', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 160, '5_alternativas', 'Matemática', 'Trigonometria', 'Função tangente', null, null, 'Um recipiente tem um formato que faz com que, ao ser enchido de água com uma vazão constante, a distância $D$ da lâmina de água ao tampo da mesa, em centímetro, aumente em relação ao tempo $T$, em minuto, de acordo com uma função do tipo

$$D = k + \operatorname{tg}[p(T + m)],$$

sendo os parâmetros $k$, $p$ e $m$ números reais, para $T$ variando entre 0 e 4 minutos, conforme ilustrado na figura, na qual estão apresentadas assíntotas verticais da função tangente utilizada na definição de $D$.

{{figura:1}}', 'A expressão algébrica que representa a relação entre $D$ e $T$ é', 'E', 'Use o gráfico: a distância entre as assíntotas dá o período, e o ponto de inflexão dá o "centro" da tangente.', 'O período de $\operatorname{tg}(px)$ é $\frac{\pi}{p}$. No gráfico, as assíntotas distam $2\pi$, e o ponto de inflexão (2,5; 30) é onde a tangente vale zero.', 'Distância entre as assíntotas: $\frac{5+2\pi}{2} - \frac{5-2\pi}{2} = 2\pi$; então $\frac{\pi}{p} = 2\pi$ e $p = \frac{1}{2}$. No ponto de inflexão (2,5; 30) a tangente vale 0, logo $k = 30$ e o argumento zera em $T = \frac{5}{2}$. Fica $D = 30 + \operatorname{tg}\left[\frac{1}{2}\left(T - \frac{5}{2}\right)\right]$, alternativa E. A alternativa D zeraria o argumento em $T = 5$, deslocando o centro do gráfico.', 'difícil'),
('2025-D2-Q161', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 161, '5_alternativas', 'Matemática', 'Geometria plana', 'Localização e orientação espacial', null, null, 'Os quadrados em cinza na figura representam os quarteirões de uma parte do bairro onde moram João e seu amigo. O quadrado pequeno (A), pintado em preto e localizado no canto superior esquerdo de um quadrado maior, indica a casa do amigo de João. João também mora em uma casa de esquina, mas na extremidade nordeste de um quarteirão. Para chegar à casa de seu amigo, ao sair de casa, João deve caminhar pelo quarteirão onde mora na direção oeste, dobrar à direita, caminhar por três quarteirões na direção norte e dobrar à esquerda. A casa de seu amigo fica no segundo quarteirão a oeste.

{{figura:1}}', 'O quarteirão onde se encontra a casa de João é representado pelo quadrado com a letra', 'A', 'Faça o caminho de trás para frente, partindo da casa do amigo (A) no mapa.', 'A casa A está no canto noroeste de um quarteirão, de frente para a rua ao norte dele. Volte 2 quarteirões para leste, depois 3 para o sul, e veja de que quarteirão João saiu.', 'Desfazendo o trajeto: a casa do amigo fica no 2º quarteirão a oeste da esquina onde João dobrou, então essa esquina está na rua entre a 4ª e a 5ª coluna, logo acima da linha de A (4ª linha). Antes, ele andou 3 quarteirões para o norte; descendo 3, chega à esquina noroeste do quarteirão da 7ª linha, 5ª coluna. Como ele saiu da esquina nordeste e andou para oeste pelo próprio quarteirão, mora no quarteirão P, alternativa A. O quarteirão T fica uma coluna à direita do ponto certo.', 'média'),
('2025-D2-Q162', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 162, '5_alternativas', 'Matemática', 'Equações, inequações e sistemas', 'Inequação do 1º grau', null, null, 'Uma empresa produziu, em um determinado mês, 110 toneladas de plástico a partir de derivados de petróleo e 80 toneladas a partir de plásticos reciclados. O custo para reciclar uma tonelada de plástico é de R\$ 500,00, que equivale a 5% do custo para produzir a mesma quantidade de plástico a partir de derivados de petróleo. Para o mês seguinte, a meta dessa empresa é produzir a mesma quantidade de plástico que foi produzida nesse mês, mas com redução de, pelo menos, 50% no custo de produção.', 'Para que no mês seguinte a empresa atinja a meta, a quantidade mínima de toneladas de plástico que devem ser produzidas a partir de reciclagem deverá ser', 'B', 'Descubra primeiro o custo por tonelada do plástico de petróleo usando os 5%.', 'Se 500 é 5% do custo do petróleo, ele custa 10 000 por tonelada. Calcule o custo atual, tome metade e monte uma inequação com x toneladas recicladas, mantendo 190 t no total.', 'Petróleo: $500 / 0{,}05 = 10\,000$ por tonelada. Custo atual: $110 \cdot 10\,000 + 80 \cdot 500 = 1\,140\,000$; a meta é no máximo $570\,000$. Com x toneladas recicladas: $500x + 10\,000(190 - x) \le 570\,000 \Rightarrow 9\,500x \ge 1\,330\,000 \Rightarrow x \ge 140$. O mínimo é 140 toneladas, alternativa B.', 'difícil'),
('2025-D2-Q163', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 163, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Gráficos com dados incompletos', null, null, 'Em uma escola, todos os estudantes do ensino médio praticam uma das três modalidades esportivas oferecidas como atividade física, e cada um deles pratica somente uma dessas atividades. Os gráficos trazem alguns dados relativos aos quantitativos de estudantes que praticam essas modalidades esportivas nessa escola, apesar de algumas quantidades não terem sido informadas.

{{figura:1}}', 'Qual é a quantidade de estudantes no ensino médio dessa escola?', 'B', 'O gráfico de barras não tem números, mas você pode contar as linhas de grade como unidades.', 'Some as barras de cada esporte em unidades de grade. Depois use o valor 80 do basquete no gráfico de setores para descobrir quanto vale cada unidade.', 'Em unidades de grade: futebol 7 + 6 + 5 = 18, vôlei 3 + 3 + 4 = 10, basquete 1 + 3 + 4 = 8, total 36 (o futebol é metade, como no gráfico de setores). Se 8 unidades valem 80 alunos, cada unidade vale 10. Total: 36 · 10 = 360 estudantes, alternativa B.', 'média'),
('2025-D2-Q164', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 164, '5_alternativas', 'Matemática', 'Trigonometria', 'Lei dos cossenos', null, null, 'O dono de uma embarcação deve partir do ponto *P* e chegar ao ponto *R* por meio de dois deslocamentos lineares e navegando a uma velocidade constante. Essa viagem será feita durante a noite, e como ele dispõe somente de uma bússola e de um relógio, planejou sua rota da seguinte forma:

1º – partir do ponto *P* na direção 110 e navegar por 4 horas, alcançando um ponto *Q*;

2º – partir do ponto *Q* na direção 90 e navegar por 2 horas, alcançando o ponto de destino *R*.

No entanto, ao direcionar o barco para o primeiro deslocamento, o fez na direção 340, em vez de 110. Com isso, realizou os seguintes deslocamentos:

1º – partiu do ponto *P* na direção 340 e navegou por 4 horas, alcançando um ponto *S*;

2º – partiu do ponto *S* na direção 90 e navegou por 2 horas, alcançando o ponto *T*.

A figura apresenta a bússola, a rota planejada e a rota executada.

{{figura:1}}

O dono da embarcação só percebeu o equívoco ao chegar ao ponto *T*. Com isso, agora ele precisa definir a direção e o tempo de navegação que lhe permita, partindo do ponto *T*, chegar ao ponto de destino *R* por meio de uma rota retilínea.

Considere 0,64 como aproximação para cos 50°.', 'A direção e o tempo aproximado de navegação que o dono da embarcação deve utilizar são, respectivamente,', 'A', 'Os trechos QR e ST têm a mesma direção e a mesma duração. O que isso diz sobre o vetor de T até R?', 'Ir de T até R equivale a ir de S até Q. No triângulo PSQ, PS e PQ valem 4 horas de viagem e o ângulo em P é a diferença entre as direções 340 e 110. Use a lei dos cossenos.', 'Como ST e QR são iguais (direção 90, 2 h), o trajeto TR é igual a SQ. No triângulo PSQ: PS = PQ = 4 (em horas), ângulo em P = 130° e $\cos 130° = -0{,}64$. Assim, $SQ^2 = 16 + 16 - 2 \cdot 16 \cdot (-0{,}64) = 52{,}48$, e $SQ \approx 7{,}24$ h ≈ 7 h 15 min. O triângulo é isósceles, com 25° nos outros ângulos: saindo de S (direção 160 para voltar a P) e girando 25°, chega-se à direção 135 (sudeste). Resposta: alternativa A. A direção 45 (B, E) apontaria para nordeste, mas R está a sudeste de T.', 'difícil'),
('2025-D2-Q165', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 165, '5_alternativas', 'Matemática', 'Estatística', 'Medidas de tendência central e dispersão', null, null, 'Em um estudo clínico, 55 mulheres foram distribuídas, aleatoriamente, em 5 grupos de 11 pessoas. Para testar uma nova medicação, será escolhido um grupo no qual a maioria das mulheres tenham idades entre 20 e 30 anos. Os demais grupos tomarão placebo ou medicações já existentes no mercado. O quadro, parcialmente preenchido, informa alguns dados relativos às idades das mulheres desses grupos.

| Grupos | Menor idade | Maior idade | Média | Mediana | Moda | Desvio padrão |
|---|---|---|---|---|---|---|
| 1 | | | 25 | | | 10 |
| 2 | | | | 25 | | 9 |
| 3 | | | | | 25 | |
| 4 | | | 25 | | | 1 |
| 5 | 20 | 35 | | | | |

Mesmo com o quadro incompleto, foi possível selecionar um desses grupos porque, apenas com os dados apresentados no quadro, foi identificado um grupo que, certamente, atendia ao critério de escolha.', 'O grupo escolhido foi o', 'D', 'Procure o grupo em que os dados dados GARANTEM que a maioria está entre 20 e 30 anos, e não só permitem.', 'Média 25 com desvio padrão muito pequeno significa idades muito concentradas perto de 25. Em qual grupo isso aparece?', 'No grupo 4, a média é 25 e o desvio padrão é só 1: as idades ficam todas grudadas em 25. Uma mulher com menos de 20 ou mais de 30 anos estaria 5 anos ou mais longe da média, o que faria o desvio padrão passar bem de 1. Então todas estão entre 20 e 30, alternativa D. No grupo 2, mediana 25 não impede que muitas tenham 15 ou 40 anos; no grupo 5, as idades podem estar quase todas entre 30 e 35.', 'média'),
('2025-D2-Q166', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 166, '5_alternativas', 'Matemática', 'Estatística', 'Média aritmética', null, null, '*Pace* é um termo usado por um corredor para denominar o seu ritmo médio em uma corrida. Representa o tempo médio, em segundo, que esse corredor leva para percorrer 1 km.

O esquema apresenta o tempo, em segundo, que um corredor levou para cruzar as marcas que definem os quatro primeiros trechos de 1 km, em uma corrida de 5 km, e o tempo gasto para percorrer cada trecho de 1 km.

{{figura:1}}

O melhor *pace* que esse corredor alcançou em corridas de 5 km foi 281 s/km.', 'Para que consiga repetir nessa corrida seu melhor *pace* em corridas de 5 km, seu tempo, no 5º trecho, deve ser quantos segundos menor do que o que ele gastou para percorrer o 4º trecho?', 'E', 'Com o pace de 281 s/km, calcule o tempo total dos 5 km.', 'Tempo total desejado = 5 · 281. Subtraia o tempo já gasto até a marca de 4 km para achar quanto pode durar o 5º trecho.', 'Tempo total com o melhor pace: $5 \cdot 281 = 1\,405$ s. Até 4 km ele já gastou 1 132 s, então o 5º trecho deve durar $1\,405 - 1\,132 = 273$ s. Como o 4º trecho levou 288 s, ele precisa ser $288 - 273 = 15$ s mais rápido, alternativa E.', 'média'),
('2025-D2-Q167', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 167, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Rendimento a partir de gráficos', null, null, 'Uma pessoa tem um carro bicombustível, que funciona a gás natural veicular (GNV) e a gasolina. O rendimento do carro, medido em km/m³, no caso do gás, ou medido em km/L, no caso da gasolina, depende, entre outros fatores, da velocidade, em km/h, em que o carro trafega. Essa relação está em conformidade com estes gráficos.

{{figura:1}}

Durante um feriado, essa pessoa realizou uma viagem de 240 km. Para obter uma estimativa de gasto de combustível, assuma que em todo o trajeto se manteve uma velocidade constante de 60 km/h. Considere que, durante metade do caminho, foi utilizado apenas GNV e, na outra metade, apenas gasolina. O que foi pago pelo metro cúbico de GNV e pelo litro de gasolina correspondeu, respectivamente, a R\$ 2,00 e a R\$ 3,00.', 'Qual foi a diferença, em real, entre os gastos totais com gasolina e com GNV?', 'D', 'Leia no gráfico o rendimento de cada combustível a 60 km/h; cada um rodou metade dos 240 km.', 'A 60 km/h, o GNV rende 10 km/m³ e a gasolina 8 km/L. Calcule quanto de cada combustível foi usado em 120 km e multiplique pelo preço.', 'Cada combustível rodou 120 km. GNV: $120 / 10 = 12$ m³, custando $12 \cdot 2 = 24$ reais. Gasolina: $120 / 8 = 15$ L, custando $15 \cdot 3 = 45$ reais. Diferença: $45 - 24 = 21$ reais, alternativa D.', 'média'),
('2025-D2-Q168', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 168, '5_alternativas', 'Matemática', 'Aritmética e porcentagem', 'Comparação de custos totais', null, null, 'Em um país, a primeira etapa para obtenção da carteira de motorista é a contratação de três produtos:

- pacote com 20 aulas teóricas;
- pacote com 10 aulas práticas;
- aluguel do veículo para realização das aulas práticas.

Uma pessoa que pretende obter a carteira de motorista pesquisou o valor do aluguel do veículo e os valores de cada aula teórica e de cada aula prática em três autoescolas. O quadro apresenta esses valores.

| Autoescola | Valor de cada aula teórica (R\$) | Valor de cada aula prática (R\$) | Aluguel do veículo (R\$) |
|---|---|---|---|
| I | 10 | 80 | 400 |
| II | 30 | 50 | 200 |
| III | 20 | 40 | 400 |

Ela contratará os três produtos numa mesma autoescola de modo que o custo total nessa primeira etapa seja o menor possível.', 'A autoescola que será contratada é a', 'E', 'Calcule o custo total em cada autoescola: 20 aulas teóricas + 10 práticas + aluguel.', 'Não basta olhar a aula mais barata: multiplique o preço da teórica por 20, o da prática por 10 e some o aluguel.', 'I: 20 · 10 + 10 · 80 + 400 = 1 400. II: 20 · 30 + 10 · 50 + 200 = 1 300. III: 20 · 20 + 10 · 40 + 400 = 1 200. A mais barata é a III, com R$ 1 200,00, alternativa E. As alternativas B e D somam só os preços unitários, sem multiplicar pelo número de aulas.', 'fácil'),
('2025-D2-Q169', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 169, '5_alternativas', 'Matemática', 'Leitura de gráficos e tabelas', 'Construção de gráfico de linhas', null, null, 'A produtividade de soja em uma área cultivada é a média da quantidade de sacas de 50 quilogramas que são produzidas por hectare. O quadro apresenta a área cultivada e a produtividade de soja em certa propriedade, ao longo de cinco safras, com períodos de um ano, de 2011 a 2016.

| Safra | 11-12 | 12-13 | 13-14 | 14-15 | 15-16 |
|---|---|---|---|---|---|
| **Área cultivada (hectare)** | 200 | 220 | 250 | 250 | 200 |
| **Produtividade (sacas de 50 kg por hectare)** | 40 | 30 | 45 | 45 | 50 |', 'O gráfico de linhas que representa a produção de soja dessa propriedade, em tonelada, nessas cinco safras é', 'A', 'Produção = área × produtividade, que dá o número de sacas. Depois converta sacas de 50 kg em toneladas.', 'Cada saca tem 50 kg = 0,05 t. Calcule a produção da primeira safra (200 · 40 sacas) em toneladas e procure o gráfico que começa nesse valor.', '11-12: $200 \cdot 40 = 8\,000$ sacas $= 8\,000 \cdot 0{,}05 = 400$ t. 12-13: $220 \cdot 30 \cdot 0{,}05 = 330$ t. 13-14 e 14-15: $250 \cdot 45 \cdot 0{,}05 = 562{,}5$ t. 15-16: $200 \cdot 50 \cdot 0{,}05 = 500$ t. O gráfico com 400, 330, 562,5, 562,5 e 500 é o da alternativa A. A alternativa E mostra os mesmos formatos, mas em milhares de sacas, sem converter para toneladas.', 'média'),
('2025-D2-Q170', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 170, '5_alternativas', 'Matemática', 'Geometria espacial', 'Volume do paralelepípedo', null, null, 'Uma caixa de descarga, acoplada a um vaso sanitário, tem a forma de paralelepípedo reto retângulo cujas dimensões internas da base são 2,5 dm e 1,5 dm. Nessa caixa há uma boia que interrompe o abastecimento quando a altura da coluna de água atinge 2 dm, conforme a figura.

{{figura:1}}

{{figura:2}}

A cada acionamento da descarga, todo o volume de água contida na caixa é despejado no vaso. Para reduzir o volume de água despejado a cada acionamento, uma pessoa colocará, no interior dessa caixa, garrafas de 300 mL, cheias de areia e tampadas, de modo a ficarem submersas quando o abastecimento for interrompido.

Para garantir o funcionamento eficiente, o mínimo de água despejada a cada acionamento deve ser de 5 L.', 'A quantidade máxima de garrafas que serão colocadas nessa caixa, garantindo um funcionamento eficiente, é igual a', 'B', 'Calcule o volume de água da caixa cheia e lembre que 1 dm³ = 1 L.', 'A caixa cheia tem 7,5 L. As garrafas podem ocupar no máximo a diferença entre isso e os 5 L mínimos.', 'Volume da caixa até a boia: $2{,}5 \cdot 1{,}5 \cdot 2 = 7{,}5$ dm³ = 7,5 L. As garrafas podem ocupar até $7{,}5 - 5 = 2{,}5$ L = 2 500 mL. Como $\frac{2\,500}{300} \approx 8{,}3$, cabem no máximo 8 garrafas, alternativa B. Com 9 garrafas (2,7 L) sobrariam só 4,8 L, abaixo do mínimo.', 'média'),
('2025-D2-Q171', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 171, '5_alternativas', 'Matemática', 'Geometria espacial', 'Dimensões de prisma e cilindro', null, null, 'Um confeiteiro passou a produzir tortas em formato de cilindro circular reto, com raio da base variando entre 12 cm e 16 cm e altura de 6 cm. Essas tortas deverão ser embaladas em caixas com formato de prisma reto de base quadrada, de modo que seja possível acomodar a torta em seu interior e ainda restar pelo menos 1 cm de distância entre a torta e as superfícies internas da caixa, lateral e superior. Ele dispõe, originalmente, de caixas no formato pretendido, cujas dimensões internas são 14 cm de comprimento do lado da base e 7 cm de altura, que não atendem às suas necessidades. Portanto, ele comprará novas caixas, com o mesmo formato das caixas originais, mas com comprimento do lado da base maior, que sejam adequadas para embalar todos os tipos de torta que produz.', 'A aresta da base das novas caixas deve ser, no mínimo, quantos centímetros maior do que a das caixas originais?', 'E', 'A caixa precisa servir para a MAIOR torta que ele produz.', 'O lado da base deve ser o diâmetro da maior torta mais 1 cm de folga de cada lado. Compare com os 14 cm da caixa original.', 'A maior torta tem raio 16 cm, ou seja, diâmetro 32 cm. Somando 1 cm de folga em cada lado: 32 + 2 = 34 cm. A altura de 7 cm já serve (6 + 1). Diferença para a caixa original: 34 − 14 = 20 cm, alternativa E. A alternativa C (16) compara o raio, e não o diâmetro com folga.', 'média'),
('2025-D2-Q172', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 172, '5_alternativas', 'Matemática', 'Exponencial e logaritmo', 'Inequação logarítmica', null, null, 'Um empresário utiliza máquinas cuja pressão interna $P$, em atmosfera, depende do tempo contínuo de utilização $t$, em hora, e de um parâmetro positivo $K$, que define o modelo da máquina, segundo a expressão:

$$P = 4 \cdot \log[-K \cdot (t + 1) \cdot (t - 19)]$$

O fabricante dessas máquinas recomenda ao usuário que a pressão interna desse tipo de máquina não ultrapasse 10 atmosferas durante seu funcionamento.

O empresário pretende comprar novas máquinas desse tipo que deverão funcionar, diariamente, por um período contínuo de 10 horas. Para isso, precisa definir o modelo de máquina a ser adquirida escolhendo o maior valor possível do parâmetro $K$, atendendo à recomendação do fabricante.', 'O maior valor a ser escolhido para $K$ é', 'A', 'Transforme $P \le 10$ numa condição sem logaritmo e pense em qual instante a pressão é máxima.', '$P \le 10$ vira $-K(t+1)(t-19) \le 10^{2{,}5}$. A expressão $(t+1)(19-t)$ é uma parábola com máximo no meio das raízes, em $t = 9$, que está dentro das 10 horas.', '$4\log[\dots] \le 10 \Rightarrow \log[\dots] \le 2{,}5 \Rightarrow K(t+1)(19-t) \le 10^{2{,}5}$. A parábola $(t+1)(19-t)$ tem raízes $-1$ e $19$ e vértice em $t = 9$, onde vale $10 \cdot 10 = 100$. A condição precisa valer no pior momento: $100K \le 10^{2{,}5}$, então $K \le 10^{0{,}5}$, alternativa A. A alternativa D usa $t = 10$ (valor 99), mas a pressão é maior em $t = 9$.', 'difícil'),
('2025-D2-Q173', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 173, '5_alternativas', 'Matemática', 'Geometria plana', 'Área de semicírculos', null, null, 'Em uma cidade, será construído um túnel que atravessa uma montanha para facilitar o trânsito de automóveis e bicicletas. Dois projetos foram elaborados e os esquemas com as vistas frontais desses projetos são apresentados na figura.

{{figura:1}}

O Projeto 1 conta com dois túneis, um exclusivo para bicicletas e o outro, para automóveis. O Projeto 2 conta com um único túnel, com espaços reservados para o trânsito exclusivo de bicicletas e automóveis. Nos dois projetos, os túneis têm o formato de semicilindro reto de mesma extensão, com vias de ida e volta para os dois tipos de veículos, separados por muretas.

O projeto a ser aprovado será aquele que apresentar a menor área da seção transversal, pois implicará menor volume de material retirado da montanha.

Considere 3 como aproximação para π e desconsidere as espessuras das muretas.', 'O projeto a ser aprovado é', 'A', 'A seção transversal de cada túnel é um semicírculo: área = metade de $\pi r^2$.', 'No Projeto 1 há dois semicírculos (diâmetros 12 m e 6 m). No Projeto 2 há um só, com diâmetro 3 + 6 + 6 + 3 = 18 m.', 'Projeto 1: $\frac{\pi \cdot 6^2}{2} + \frac{\pi \cdot 3^2}{2} = \frac{3 \cdot 45}{2} = 67{,}5$ m². Projeto 2: $\frac{\pi \cdot 9^2}{2} = \frac{3 \cdot 81}{2} = 121{,}5$ m². O menor é o Projeto 1, com 67,5 m², alternativa A. A alternativa E é tentadora porque as larguras somam 18 m nos dois, mas a área cresce com o quadrado do raio.', 'média'),
('2025-D2-Q175', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 175, '5_alternativas', 'Matemática', 'Análise combinatória', 'Combinação com restrição', null, null, 'Um pai comprou oito presentes diferentes (dentre os quais, uma bicicleta e um celular) para dar a seus três filhos. Ele pretende distribuir os presentes de modo que o filho mais velho e o mais novo recebam três presentes cada um, e o do meio receba os dois presentes restantes. O mais velho ganhará, entre seus presentes, ou uma bicicleta ou um celular, mas não ambos.', 'De quantas maneiras distintas a distribuição dos presentes pode ser feita?', 'C', 'Comece pelo filho mais velho, que tem a restrição, e depois distribua o que sobrar.', 'O mais velho escolhe 1 entre bicicleta e celular e mais 2 dentre os 6 outros presentes. Depois, dos 5 restantes, o caçula escolhe 3 e o do meio fica com o resto.', 'Mais velho: 2 escolhas (bicicleta ou celular) vezes $C(6,2) = 15$, total 30. Sobram 5 presentes: o mais novo escolhe 3 de $C(5,3) = 10$ maneiras, e o do meio recebe os 2 restantes. Total: $30 \cdot 10 = 300$, alternativa C.', 'difícil'),
('2025-D2-Q176', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 176, '5_alternativas', 'Matemática', 'Razão, proporção e regra de três', 'Velocidade média', null, null, 'A final de um campeonato de futebol foi disputada em 2 tempos regulamentares, de 45 minutos cada, sem acréscimos, com uma prorrogação de 30 minutos, também sem acréscimos. Um jogador entrou no início do segundo tempo, com um equipamento para medir a distância percorrida durante sua participação no jogo. Ao final do segundo tempo regulamentar, esse jogador havia percorrido 4,5 km. Ele manteve na prorrogação a mesma velocidade média que havia mantido no segundo tempo regulamentar.', 'A distância percorrida por esse jogador durante sua participação na partida, em quilômetro, foi', 'C', 'Ele jogou só o 2º tempo e a prorrogação. Use a velocidade média do 2º tempo.', '4,5 km em 45 minutos dá 0,1 km por minuto. Mantendo isso nos 30 minutos de prorrogação, quanto ele correu a mais?', 'No 2º tempo: $\frac{4{,}5}{45} = 0{,}1$ km/min. Na prorrogação: $0{,}1 \cdot 30 = 3$ km. Total: $4{,}5 + 3 = 7{,}5$ km, alternativa C. A alternativa D (9,0) contaria o primeiro tempo, em que ele não jogou.', 'fácil'),
('2025-D2-Q177', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 177, '5_alternativas', 'Matemática', 'Geometria espacial', 'Volume de cilindro vazado', null, null, 'A figura ilustra o projeto visual para confecção de uma medalha comemorativa, com a forma de um cilindro circular reto, de diâmetro 6 cm e espessura 3 mm.

{{figura:1}}

A figura *ABCD* tem a forma de um quadrado e é a base de um prisma que atravessa toda a medalha. A região da medalha externa a esse prisma será cunhada em ouro. Pretende-se cunhar 100 dessas medalhas.

Considere 3,1 como valor aproximado para π.', 'Qual é o volume de ouro, em centímetro cúbico, necessário para a confecção dessas medalhas?', 'B', 'Ouro = volume do cilindro menos o volume do prisma quadrado. Os dois têm a mesma espessura.', 'O quadrado está inscrito no círculo, então sua diagonal é o diâmetro (6 cm). Área do quadrado = diagonal² / 2. Cuidado: 3 mm = 0,3 cm.', 'Área do círculo: $3{,}1 \cdot 3^2 = 27{,}9$ cm². Área do quadrado (diagonal 6): $\frac{6^2}{2} = 18$ cm². Área de ouro: $27{,}9 - 18 = 9{,}9$ cm². Volume por medalha: $9{,}9 \cdot 0{,}3 = 2{,}97$ cm³; para 100 medalhas, 297 cm³, alternativa B. A alternativa D (990) esquece a espessura em centímetros.', 'média'),
('2025-D2-Q178', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 178, '5_alternativas', 'Matemática', 'Probabilidade', 'Probabilidade com dados', null, null, 'Três dados cúbicos, com faces numeradas de 1 a 6, foram utilizados em um jogo. Artur escolheu dois dados, e João ficou com o terceiro. O jogo consiste em ambos lançarem seus dados, observarem os números nas faces voltadas para cima e compararem o maior número obtido por Artur com o número obtido por João. Vence o jogador que obtiver o maior número. Em caso de empate, a vitória é de João.', 'O jogador que tem a maior probabilidade de vitória é', 'E', 'É mais fácil calcular a chance de João vencer: o maior número de Artur precisa ser menor ou igual ao de João.', 'Se João tira $j$, os dois dados de Artur devem mostrar no máximo $j$: probabilidade $(j/6)^2$. Some isso para $j$ de 1 a 6, cada caso com chance $1/6$.', 'P(João vence) $= \frac{1}{6}\left(\frac{1^2+2^2+3^2+4^2+5^2+6^2}{36}\right) = \frac{91}{216}$. Então P(Artur vence) $= 1 - \frac{91}{216} = \frac{125}{216}$, maior que a de João. Resposta: alternativa E. A alternativa D traz a probabilidade correta de João, mas ela é a menor das duas.', 'difícil'),
('2025-D2-Q179', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 179, '5_alternativas', 'Matemática', 'Escalas, unidades e medidas', 'Unidades de medida compostas', null, null, 'A luminância de um objeto é a grandeza que descreve a quantidade de luz produzida ou refletida por sua superfície. Ela está definida como a razão entre a intensidade luminosa, medida em candela (cd), e o quadrado da distância do objeto até o foco de luz, medida em metro (m).', 'A unidade de medida da luminância de um objeto é', 'A', 'Siga a definição: a luminância é uma razão. Veja o que fica em cima e o que fica embaixo.', 'No numerador vai a intensidade luminosa (cd); no denominador, a distância ao quadrado.', 'Luminância = intensidade / distância². A unidade fica $\frac{\text{cd}}{\text{m}^2}$, alternativa A. A alternativa C esquece o quadrado da distância, e a alternativa B inverte a razão.', 'fácil'),
('2025-D2-Q180', 'enem', 'enem-MAT', 'INEP', null, null, 'Médio', 2025, 180, '5_alternativas', 'Matemática', 'Progressões', 'Progressão aritmética', null, null, 'Quatro amigos, cada um com 100 moedas, criaram um jogo, no qual cada um assume uma das quatro posições, 1, 2, 3 ou 4, indicadas na figura, e nela permanece até o final.

{{figura:1}}

O desenvolvimento do jogo se dá em rodadas e, em todas elas, cada jogador transfere e recebe uma quantidade de moedas, da seguinte maneira:

- o jogador na posição 1 transfere 1 moeda para o jogador na posição 2;
- o jogador na posição 2 transfere 2 moedas para o jogador na posição 3;
- o jogador na posição 3 transfere 3 moedas para o jogador na posição 4;
- o jogador na posição 4 transfere 4 moedas para o jogador na posição 1, completando a rodada.', 'Ao final da rodada *n*, qual é a expressão algébrica que representa o número de moedas do jogador na posição 1?', 'D', 'Veja quanto o jogador 1 dá e quanto recebe em cada rodada.', 'Em toda rodada, o jogador 1 entrega 1 moeda e recebe 4. O saldo é o mesmo a cada rodada, o que forma uma progressão aritmética começando em 100.', 'A cada rodada o jogador 1 perde 1 e ganha 4: saldo de +3. Começando com 100 moedas, após $n$ rodadas ele tem $100 + 3n$, alternativa D. A alternativa C ($100 + 4n$) esquece a moeda que ele entrega.', 'fácil')
on conflict (id) do update set exame_id = excluded.exame_id, recorte_id = excluded.recorte_id, banca = excluded.banca, orgao = excluded.orgao, cargo = excluded.cargo, nivel = excluded.nivel, ano = excluded.ano, numero = excluded.numero, formato = excluded.formato, disciplina = excluded.disciplina, assunto = excluded.assunto, topico = excluded.topico, lingua = excluded.lingua, texto_base_id = excluded.texto_base_id, texto_apoio = excluded.texto_apoio, comando = excluded.comando, gabarito = excluded.gabarito, dica1 = excluded.dica1, dica2 = excluded.dica2, explicacao = excluded.explicacao, dificuldade = excluded.dificuldade;
delete from public.alternativas where questao_id in ('2024-D2-Q136', '2024-D2-Q137', '2024-D2-Q138', '2024-D2-Q139', '2024-D2-Q140', '2024-D2-Q141', '2024-D2-Q142', '2024-D2-Q143', '2024-D2-Q144', '2024-D2-Q145', '2024-D2-Q146', '2024-D2-Q147', '2024-D2-Q148', '2024-D2-Q149', '2024-D2-Q150', '2024-D2-Q151', '2024-D2-Q152', '2024-D2-Q153', '2024-D2-Q154', '2024-D2-Q155', '2024-D2-Q156', '2024-D2-Q157', '2024-D2-Q158', '2024-D2-Q159', '2024-D2-Q160', '2024-D2-Q161', '2024-D2-Q162', '2024-D2-Q163', '2024-D2-Q164', '2024-D2-Q165', '2024-D2-Q166', '2024-D2-Q167', '2024-D2-Q168', '2024-D2-Q169', '2024-D2-Q170', '2024-D2-Q171', '2024-D2-Q172', '2024-D2-Q173', '2024-D2-Q174', '2024-D2-Q175', '2024-D2-Q176', '2024-D2-Q177', '2024-D2-Q178', '2024-D2-Q179', '2024-D2-Q180', '2025-D2-Q136', '2025-D2-Q137', '2025-D2-Q138', '2025-D2-Q139', '2025-D2-Q140', '2025-D2-Q141', '2025-D2-Q142', '2025-D2-Q143', '2025-D2-Q144', '2025-D2-Q145', '2025-D2-Q146', '2025-D2-Q147', '2025-D2-Q148', '2025-D2-Q149', '2025-D2-Q150', '2025-D2-Q151', '2025-D2-Q152', '2025-D2-Q153', '2025-D2-Q154', '2025-D2-Q155', '2025-D2-Q156', '2025-D2-Q157', '2025-D2-Q158', '2025-D2-Q159', '2025-D2-Q160', '2025-D2-Q161', '2025-D2-Q162', '2025-D2-Q163', '2025-D2-Q164', '2025-D2-Q165', '2025-D2-Q166', '2025-D2-Q167', '2025-D2-Q168', '2025-D2-Q169', '2025-D2-Q170', '2025-D2-Q171', '2025-D2-Q172', '2025-D2-Q173', '2025-D2-Q175', '2025-D2-Q176', '2025-D2-Q177', '2025-D2-Q178', '2025-D2-Q179', '2025-D2-Q180');
insert into public.alternativas (questao_id, letra, texto, imagem) values
('2024-D2-Q136', 'A', 'I.', null),
('2024-D2-Q136', 'B', 'II.', null),
('2024-D2-Q136', 'C', 'III.', null),
('2024-D2-Q136', 'D', 'IV.', null),
('2024-D2-Q136', 'E', 'V.', null),
('2024-D2-Q137', 'A', '4.', null),
('2024-D2-Q137', 'B', '5.', null),
('2024-D2-Q137', 'C', '6.', null),
('2024-D2-Q137', 'D', '19.', null),
('2024-D2-Q137', 'E', '21.', null),
('2024-D2-Q138', 'A', '11 520.', null),
('2024-D2-Q138', 'B', '14 400.', null),
('2024-D2-Q138', 'C', '18 000.', null),
('2024-D2-Q138', 'D', '312 000.', null),
('2024-D2-Q138', 'E', '390 000.', null),
('2024-D2-Q139', 'A', 'I, pois o valor é R\$ 7,00.', null),
('2024-D2-Q139', 'B', 'I, pois o valor é R\$ 4,00.', null),
('2024-D2-Q139', 'C', 'II, pois o valor é R\$ 6,00.', null),
('2024-D2-Q139', 'D', 'I, pois anuncia o componente com o menor preço.', null),
('2024-D2-Q139', 'E', 'II, pois o componente X, que é o mais utilizado, tem menor preço.', null),
('2024-D2-Q140', 'A', 'muito bom e bom.', null),
('2024-D2-Q140', 'B', 'muito bom e regular.', null),
('2024-D2-Q140', 'C', 'muito bom e insatisfatório.', null),
('2024-D2-Q140', 'D', 'bom e regular.', null),
('2024-D2-Q140', 'E', 'bom e insatisfatório.', null),
('2024-D2-Q141', 'A', '1,0.', null),
('2024-D2-Q141', 'B', '2,5.', null),
('2024-D2-Q141', 'C', '3,0.', null),
('2024-D2-Q141', 'D', '3,5.', null),
('2024-D2-Q141', 'E', '4,0.', null),
('2024-D2-Q142', 'A', '$3 \times 2^{19}$', null),
('2024-D2-Q142', 'B', '$3 \times 2^{20}$', null),
('2024-D2-Q142', 'C', '$3 \times 2^{21}$', null),
('2024-D2-Q142', 'D', '$3 \times 2^{20} - 1$', null),
('2024-D2-Q142', 'E', '$3 \times 2^{20} - 3$', null),
('2024-D2-Q143', 'A', '19,50.', null),
('2024-D2-Q143', 'B', '28,80.', null),
('2024-D2-Q143', 'C', '34,00.', null),
('2024-D2-Q143', 'D', '52,00.', null),
('2024-D2-Q143', 'E', '68,70.', null),
('2024-D2-Q144', 'A', 'cone.', null),
('2024-D2-Q144', 'B', 'cilindro.', null),
('2024-D2-Q144', 'C', 'pirâmide.', null),
('2024-D2-Q144', 'D', 'tronco de cone.', null),
('2024-D2-Q144', 'E', 'tronco de pirâmide.', null),
('2024-D2-Q145', 'A', '24', null),
('2024-D2-Q145', 'B', '35', null),
('2024-D2-Q145', 'C', '555', null),
('2024-D2-Q145', 'D', '1 110', null),
('2024-D2-Q145', 'E', '1 145', null),
('2024-D2-Q146', 'A', '85', null),
('2024-D2-Q146', 'B', '100', null),
('2024-D2-Q146', 'C', '175', null),
('2024-D2-Q146', 'D', '200', null),
('2024-D2-Q146', 'E', '350', null),
('2024-D2-Q147', 'A', 'I, II e IV.', null),
('2024-D2-Q147', 'B', 'II, IV e V.', null),
('2024-D2-Q147', 'C', 'II, III e V.', null),
('2024-D2-Q147', 'D', 'III, V e VI.', null),
('2024-D2-Q147', 'E', 'III, IV e VI.', null),
('2024-D2-Q148', 'A', '$a = 20;\ b = \log(0{,}5)$', null),
('2024-D2-Q148', 'B', '$a = 100;\ b = 0{,}5$', null),
('2024-D2-Q148', 'C', '$a = 20;\ b = (0{,}5)^{\frac{1}{10}}$', null),
('2024-D2-Q148', 'D', '$a = 20;\ b = \dfrac{(40)^{\frac{1}{10}}}{80}$', null),
('2024-D2-Q148', 'E', '$a = 20;\ b = 40$', null),
('2024-D2-Q149', 'A', '6', null),
('2024-D2-Q149', 'B', '18', null),
('2024-D2-Q149', 'C', '$6\sqrt{6}$', null),
('2024-D2-Q149', 'D', '$6\sqrt[3]{6}$', null),
('2024-D2-Q149', 'E', '$3\sqrt[3]{12}$', null),
('2024-D2-Q150', 'A', 'I.', null),
('2024-D2-Q150', 'B', 'II.', null),
('2024-D2-Q150', 'C', 'III.', null),
('2024-D2-Q150', 'D', 'IV.', null),
('2024-D2-Q150', 'E', 'V.', null),
('2024-D2-Q151', 'A', '4,18.', null),
('2024-D2-Q151', 'B', '8,36.', null),
('2024-D2-Q151', 'C', '41,80.', null),
('2024-D2-Q151', 'D', '83,60.', null),
('2024-D2-Q151', 'E', '418,00.', null),
('2024-D2-Q152', 'A', 'S₁, S₃ e S₂.', null),
('2024-D2-Q152', 'B', 'S₂, S₁ e S₃.', null),
('2024-D2-Q152', 'C', 'S₂, S₃ e S₁.', null),
('2024-D2-Q152', 'D', 'S₃, S₁ e S₂.', null),
('2024-D2-Q152', 'E', 'S₃, S₂ e S₁.', null),
('2024-D2-Q153', 'A', '13 525,0', null),
('2024-D2-Q153', 'B', '135,25', null),
('2024-D2-Q153', 'C', '13,525', null),
('2024-D2-Q153', 'D', '1,3525', null),
('2024-D2-Q153', 'E', '0,13525', null),
('2024-D2-Q154', 'A', '13,0.', null),
('2024-D2-Q154', 'B', '15,0.', null),
('2024-D2-Q154', 'C', '19,8.', null),
('2024-D2-Q154', 'D', '20,0.', null),
('2024-D2-Q154', 'E', '23,3.', null),
('2024-D2-Q155', 'A', 'I.', null),
('2024-D2-Q155', 'B', 'II.', null),
('2024-D2-Q155', 'C', 'III.', null),
('2024-D2-Q155', 'D', 'IV.', null),
('2024-D2-Q155', 'E', 'V.', null),
('2024-D2-Q156', 'A', '$2{,}00F + 0{,}26T + 1{,}40D$', null),
('2024-D2-Q156', 'B', '$2{,}00 + 0{,}26T + 1{,}40D$', null),
('2024-D2-Q156', 'C', '$2{,}00 + 0{,}26T + D$', null),
('2024-D2-Q156', 'D', '$0{,}26T + 1{,}40D$', null),
('2024-D2-Q156', 'E', '$F + T + D$', null),
('2024-D2-Q157', 'A', '12,50', null),
('2024-D2-Q157', 'B', '20,00', null),
('2024-D2-Q157', 'C', '24,00', null),
('2024-D2-Q157', 'D', '30,00', null),
('2024-D2-Q157', 'E', '37,50', null),
('2024-D2-Q158', 'A', '147,00.', null),
('2024-D2-Q158', 'B', '150,00.', null),
('2024-D2-Q158', 'C', '162,50.', null),
('2024-D2-Q158', 'D', '165,75.', null),
('2024-D2-Q158', 'E', '168,00.', null),
('2024-D2-Q159', 'A', '$\text{mL} \cdot \text{s} \cdot \text{cm}^2$', null),
('2024-D2-Q159', 'B', '$\dfrac{\text{mL}}{\text{s}} \cdot \text{cm}^2$', null),
('2024-D2-Q159', 'C', '$\dfrac{\text{mL}}{\text{cm}^2 \cdot \text{s}}$', null),
('2024-D2-Q159', 'D', '$\dfrac{\text{cm}^2 \cdot \text{s}}{\text{mL}}$', null),
('2024-D2-Q159', 'E', '$\dfrac{\text{cm}^2}{\text{mL} \cdot \text{s}}$', null),
('2024-D2-Q160', 'A', '8 250.', null),
('2024-D2-Q160', 'B', '7 920.', null),
('2024-D2-Q160', 'C', '6 545.', null),
('2024-D2-Q160', 'D', '5 500.', null),
('2024-D2-Q160', 'E', '5 280.', null),
('2024-D2-Q161', 'A', null, 'imagens/2024/D2/q161_alt_A.webp'),
('2024-D2-Q161', 'B', null, 'imagens/2024/D2/q161_alt_B.webp'),
('2024-D2-Q161', 'C', null, 'imagens/2024/D2/q161_alt_C.webp'),
('2024-D2-Q161', 'D', null, 'imagens/2024/D2/q161_alt_D.webp'),
('2024-D2-Q161', 'E', null, 'imagens/2024/D2/q161_alt_E.webp'),
('2024-D2-Q162', 'A', 'Fevereiro.', null),
('2024-D2-Q162', 'B', 'Abril.', null),
('2024-D2-Q162', 'C', 'Maio.', null),
('2024-D2-Q162', 'D', 'Junho.', null),
('2024-D2-Q162', 'E', 'Agosto.', null),
('2024-D2-Q163', 'A', '54.', null),
('2024-D2-Q163', 'B', '60.', null),
('2024-D2-Q163', 'C', '66.', null),
('2024-D2-Q163', 'D', '68.', null),
('2024-D2-Q163', 'E', '72.', null),
('2024-D2-Q164', 'A', '2 e 3.', null),
('2024-D2-Q164', 'B', '4 e 5.', null),
('2024-D2-Q164', 'C', '5 e 6.', null),
('2024-D2-Q164', 'D', '7 e 8.', null),
('2024-D2-Q164', 'E', '8 e 9.', null),
('2024-D2-Q165', 'A', '1,35.', null),
('2024-D2-Q165', 'B', '3,00.', null),
('2024-D2-Q165', 'C', '9,00.', null),
('2024-D2-Q165', 'D', '12,60.', null),
('2024-D2-Q165', 'E', '13,80.', null),
('2024-D2-Q166', 'A', '$d(Q) = \frac{1}{4}\,d(R)$', null),
('2024-D2-Q166', 'B', '$d(Q) = \frac{1}{2}\,d(R)$', null),
('2024-D2-Q166', 'C', '$d(Q) = \frac{3}{4}\,d(R)$', null),
('2024-D2-Q166', 'D', '$d(Q) = \frac{3}{2}\,d(R)$', null),
('2024-D2-Q166', 'E', '$d(Q) = \frac{2}{3}\,d(R)$', null),
('2024-D2-Q167', 'A', '0,1.', null),
('2024-D2-Q167', 'B', '0,5.', null),
('2024-D2-Q167', 'C', '1,0.', null),
('2024-D2-Q167', 'D', '1,3.', null),
('2024-D2-Q167', 'E', '1,8.', null),
('2024-D2-Q168', 'A', null, 'imagens/2024/D2/q168_alt_A.webp'),
('2024-D2-Q168', 'B', null, 'imagens/2024/D2/q168_alt_B.webp'),
('2024-D2-Q168', 'C', null, 'imagens/2024/D2/q168_alt_C.webp'),
('2024-D2-Q168', 'D', null, 'imagens/2024/D2/q168_alt_D.webp'),
('2024-D2-Q168', 'E', null, 'imagens/2024/D2/q168_alt_E.webp'),
('2024-D2-Q169', 'A', '$\frac{1}{25} + \frac{1}{25} + \frac{1}{25}$', null),
('2024-D2-Q169', 'B', '$\frac{24}{25} + \frac{23}{24} + \frac{1}{23}$', null),
('2024-D2-Q169', 'C', '$\frac{1}{25} \times \frac{1}{24} \times \frac{1}{23}$', null),
('2024-D2-Q169', 'D', '$\frac{24}{25} \times \frac{23}{25} \times \frac{1}{25}$', null),
('2024-D2-Q169', 'E', '$\frac{24}{25} \times \frac{23}{24} \times \frac{1}{23}$', null),
('2024-D2-Q170', 'A', '5,4.', null),
('2024-D2-Q170', 'B', '6,2.', null),
('2024-D2-Q170', 'C', '7,6.', null),
('2024-D2-Q170', 'D', '8,2.', null),
('2024-D2-Q170', 'E', '8,4.', null),
('2024-D2-Q171', 'A', 'hexágono regular, pois a área do jardim, em metro quadrado, será $\frac{k^2\sqrt{3}}{24}$.', null),
('2024-D2-Q171', 'B', 'hexágono regular, pois a área do jardim, em metro quadrado, será $\frac{3k^2\sqrt{3}}{2}$.', null),
('2024-D2-Q171', 'C', 'quadrado, pois a área do jardim, em metro quadrado, será $\frac{k^2}{16}$.', null),
('2024-D2-Q171', 'D', 'triângulo equilátero, pois a área do jardim, em metro quadrado, será $\frac{k^2\sqrt{3}}{36}$.', null),
('2024-D2-Q171', 'E', 'triângulo equilátero, pois a área do jardim, em metro quadrado, será $\frac{k^2\sqrt{3}}{4}$.', null),
('2024-D2-Q172', 'A', 'I', null),
('2024-D2-Q172', 'B', 'II', null),
('2024-D2-Q172', 'C', 'III', null),
('2024-D2-Q172', 'D', 'IV', null),
('2024-D2-Q172', 'E', 'V', null),
('2024-D2-Q173', 'A', 'entre 25 e 45 anos, pois é a faixa etária com maior quantidade de funcionários.', null),
('2024-D2-Q173', 'B', 'entre 25 e 45 anos, pois é a única faixa etária cujas porcentagens são maiores do que as porcentagens mínimas de cada setor.', null),
('2024-D2-Q173', 'C', 'até 25 anos, pois é a única faixa etária cujos percentuais associados aos setores aumentam com o aumento da quantidade de funcionários por setor.', null),
('2024-D2-Q173', 'D', 'até 25 anos, pois é a faixa etária que apresenta maior quantidade de funcionários no setor de produção, que é o setor que emprega metade dos funcionários dessa empresa.', null),
('2024-D2-Q173', 'E', 'a partir de 45 anos, pois a soma das porcentagens associadas a essa faixa etária é 110%, que é maior do que as respectivas somas associadas às outras faixas etárias, que são 105% e 85%.', null),
('2024-D2-Q174', 'A', null, 'imagens/2024/D2/q174_alt_A.webp'),
('2024-D2-Q174', 'B', null, 'imagens/2024/D2/q174_alt_B.webp'),
('2024-D2-Q174', 'C', null, 'imagens/2024/D2/q174_alt_C.webp'),
('2024-D2-Q174', 'D', null, 'imagens/2024/D2/q174_alt_D.webp'),
('2024-D2-Q174', 'E', null, 'imagens/2024/D2/q174_alt_E.webp'),
('2024-D2-Q175', 'A', '$4\,000\,\pi$', null),
('2024-D2-Q175', 'B', '$2\,000\,\pi$', null),
('2024-D2-Q175', 'C', '$\dfrac{4\,000}{\pi}$', null),
('2024-D2-Q175', 'D', '$\dfrac{1000}{\pi}$', null),
('2024-D2-Q175', 'E', '$\dfrac{500}{\pi}$', null),
('2024-D2-Q176', 'A', '7.', null),
('2024-D2-Q176', 'B', '8.', null),
('2024-D2-Q176', 'C', '9.', null),
('2024-D2-Q176', 'D', '10.', null),
('2024-D2-Q176', 'E', '11.', null),
('2024-D2-Q177', 'A', '2 400,00.', null),
('2024-D2-Q177', 'B', '2 520,00.', null),
('2024-D2-Q177', 'C', '2 550,00.', null),
('2024-D2-Q177', 'D', '2 700,00.', null),
('2024-D2-Q177', 'E', '2 800,00.', null),
('2024-D2-Q178', 'A', '56.', null),
('2024-D2-Q178', 'B', '58.', null),
('2024-D2-Q178', 'C', '59.', null),
('2024-D2-Q178', 'D', '60.', null),
('2024-D2-Q178', 'E', '62.', null),
('2024-D2-Q179', 'A', '1 000', null),
('2024-D2-Q179', 'B', '1 500', null),
('2024-D2-Q179', 'C', '3 500', null),
('2024-D2-Q179', 'D', '3 800', null),
('2024-D2-Q179', 'E', '5 250', null),
('2024-D2-Q180', 'A', '$\frac{7!}{4!} \times \frac{6!}{4!}$', null),
('2024-D2-Q180', 'B', '$\frac{7!}{3! \times 4!} \times \frac{6!}{2! \times 4!}$', null),
('2024-D2-Q180', 'C', '$\frac{7!}{3! \times 4!} + \frac{6!}{2! \times 4!} + \frac{5!}{1! \times 4!}$', null),
('2024-D2-Q180', 'D', '$\left(\frac{7!}{3! \times 4!} + \frac{6!}{2! \times 4!}\right) \times \left(\frac{7!}{4! \times 3!} + \frac{6!}{1! \times 5!}\right) \times \left(\frac{7!}{5! \times 2!} + \frac{6!}{0! \times 6!}\right)$', null),
('2024-D2-Q180', 'E', '$\left(\frac{7!}{3! \times 4!} \times \frac{6!}{2! \times 4!}\right) + \left(\frac{7!}{4! \times 3!} \times \frac{6!}{1! \times 5!}\right) + \left(\frac{7!}{5! \times 2!} \times \frac{6!}{0! \times 6!}\right)$', null),
('2025-D2-Q136', 'A', '10', null),
('2025-D2-Q136', 'B', '14', null),
('2025-D2-Q136', 'C', '17', null),
('2025-D2-Q136', 'D', '21', null),
('2025-D2-Q136', 'E', '25', null),
('2025-D2-Q137', 'A', '$\frac{30}{90}$', null),
('2025-D2-Q137', 'B', '$\frac{36}{100}$', null),
('2025-D2-Q137', 'C', '$\frac{40}{100}$', null),
('2025-D2-Q137', 'D', '$\frac{40}{90}$', null),
('2025-D2-Q137', 'E', '$\frac{46}{90}$', null),
('2025-D2-Q138', 'A', null, 'imagens/2025/D2/q138_alt_A.webp'),
('2025-D2-Q138', 'B', null, 'imagens/2025/D2/q138_alt_B.webp'),
('2025-D2-Q138', 'C', null, 'imagens/2025/D2/q138_alt_C.webp'),
('2025-D2-Q138', 'D', null, 'imagens/2025/D2/q138_alt_D.webp'),
('2025-D2-Q138', 'E', null, 'imagens/2025/D2/q138_alt_E.webp'),
('2025-D2-Q139', 'A', '4.', null),
('2025-D2-Q139', 'B', '8.', null),
('2025-D2-Q139', 'C', '15.', null),
('2025-D2-Q139', 'D', '30.', null),
('2025-D2-Q139', 'E', '60.', null),
('2025-D2-Q140', 'A', '0,0050', null),
('2025-D2-Q140', 'B', '0,0100', null),
('2025-D2-Q140', 'C', '0,5000', null),
('2025-D2-Q140', 'D', '4,9775', null),
('2025-D2-Q140', 'E', '5,0000', null),
('2025-D2-Q141', 'A', '20 100', null),
('2025-D2-Q141', 'B', '20 200', null),
('2025-D2-Q141', 'C', '20 300', null),
('2025-D2-Q141', 'D', '20 400', null),
('2025-D2-Q141', 'E', '20 600', null),
('2025-D2-Q142', 'A', '360.', null),
('2025-D2-Q142', 'B', '370.', null),
('2025-D2-Q142', 'C', '380.', null),
('2025-D2-Q142', 'D', '390.', null),
('2025-D2-Q142', 'E', '400.', null),
('2025-D2-Q143', 'A', 'Batata chips.', null),
('2025-D2-Q143', 'B', 'Palitos salgados.', null),
('2025-D2-Q143', 'C', 'Biscoito multigrãos.', null),
('2025-D2-Q143', 'D', 'Biscoito de polvilho.', null),
('2025-D2-Q143', 'E', 'Biscoito de água e sal.', null),
('2025-D2-Q144', 'A', '9', null),
('2025-D2-Q144', 'B', '8', null),
('2025-D2-Q144', 'C', '6', null),
('2025-D2-Q144', 'D', '4', null),
('2025-D2-Q144', 'E', '3', null),
('2025-D2-Q145', 'A', 'mantém-se constante.', null),
('2025-D2-Q145', 'B', 'é diretamente proporcional ao tempo.', null),
('2025-D2-Q145', 'C', 'é inversamente proporcional ao tempo.', null),
('2025-D2-Q145', 'D', 'diminui até o instante t₂, a partir do qual se torna constante.', null),
('2025-D2-Q145', 'E', 'diminui de forma proporcional ao tempo, tanto entre t₁ e t₂ quanto após t₂.', null),
('2025-D2-Q146', 'A', '0,02', null),
('2025-D2-Q146', 'B', '0,42', null),
('2025-D2-Q146', 'C', '0,52', null),
('2025-D2-Q146', 'D', '1,02', null),
('2025-D2-Q146', 'E', '1,42', null),
('2025-D2-Q147', 'A', '2.', null),
('2025-D2-Q147', 'B', '12.', null),
('2025-D2-Q147', 'C', '20.', null),
('2025-D2-Q147', 'D', '22.', null),
('2025-D2-Q147', 'E', '40.', null),
('2025-D2-Q148', 'A', 'I.', null),
('2025-D2-Q148', 'B', 'II.', null),
('2025-D2-Q148', 'C', 'III.', null),
('2025-D2-Q148', 'D', 'IV.', null),
('2025-D2-Q148', 'E', 'V.', null),
('2025-D2-Q149', 'A', '21', null),
('2025-D2-Q149', 'B', '25', null),
('2025-D2-Q149', 'C', '55', null),
('2025-D2-Q149', 'D', '80', null),
('2025-D2-Q149', 'E', '110', null),
('2025-D2-Q150', 'A', '800.', null),
('2025-D2-Q150', 'B', '1 080.', null),
('2025-D2-Q150', 'C', '1 200.', null),
('2025-D2-Q150', 'D', '1 800.', null),
('2025-D2-Q150', 'E', '2 520.', null),
('2025-D2-Q151', 'A', '0109082.', null),
('2025-D2-Q151', 'B', '0281090.', null),
('2025-D2-Q151', 'C', '1010982.', null),
('2025-D2-Q151', 'D', '2081090.', null),
('2025-D2-Q151', 'E', '2810910.', null),
('2025-D2-Q152', 'A', '$\frac{1}{2}$', null),
('2025-D2-Q152', 'B', '$\frac{1}{10}$', null),
('2025-D2-Q152', 'C', '$\frac{1}{16}$', null),
('2025-D2-Q152', 'D', '$\frac{1}{24}$', null),
('2025-D2-Q152', 'E', '$\frac{1}{256}$', null),
('2025-D2-Q153', 'A', '$y = -3x + 20$', null),
('2025-D2-Q153', 'B', '$y = -3x + 16$', null),
('2025-D2-Q153', 'C', '$y = -3x - 20$', null),
('2025-D2-Q153', 'D', '$y = 3x + 16$', null),
('2025-D2-Q153', 'E', '$y = 3x - 16$', null),
('2025-D2-Q154', 'A', 'ficção, pois é o que apresenta maior demanda.', null),
('2025-D2-Q154', 'B', 'biografia, pois é o gênero que tem a menor demanda.', null),
('2025-D2-Q154', 'C', 'autoajuda, pois a quantidade em estoque é inferior à demanda.', null),
('2025-D2-Q154', 'D', 'biografia, pois é o gênero que tem a menor quantidade de livros em estoque.', null),
('2025-D2-Q154', 'E', 'romance, pois é o que apresenta o menor estoque de livros de autores brasileiros.', null),
('2025-D2-Q155', 'A', '$10 \times 9 \times 8$', null),
('2025-D2-Q155', 'B', '$20 \times 18 \times 16$', null),
('2025-D2-Q155', 'C', '$20 \times 19 \times 18$', null),
('2025-D2-Q155', 'D', '$10 \times 9 \times 8 \times 2$', null),
('2025-D2-Q155', 'E', '$20 \times 18 \times 16 \times 2$', null),
('2025-D2-Q156', 'A', '1 : 1,5', null),
('2025-D2-Q156', 'B', '1 : 2,25', null),
('2025-D2-Q156', 'C', '1 : 10', null),
('2025-D2-Q156', 'D', '1 : 100', null),
('2025-D2-Q156', 'E', '1 : 150', null),
('2025-D2-Q157', 'A', '$T = 1{,}59 + F$', null),
('2025-D2-Q157', 'B', '$F = 1{,}59 + T$', null),
('2025-D2-Q157', 'C', '$\frac{T}{F} = 1{,}59$', null),
('2025-D2-Q157', 'D', '$\frac{F}{T} = 1{,}59$', null),
('2025-D2-Q157', 'E', '$F \cdot T = 1{,}59$', null),
('2025-D2-Q158', 'A', '185,60.', null),
('2025-D2-Q158', 'B', '226,09.', null),
('2025-D2-Q158', 'C', '245,20.', null),
('2025-D2-Q158', 'D', '268,93.', null),
('2025-D2-Q158', 'E', '285,60.', null),
('2025-D2-Q159', 'A', '5.', null),
('2025-D2-Q159', 'B', '8.', null),
('2025-D2-Q159', 'C', '50.', null),
('2025-D2-Q159', 'D', '80.', null),
('2025-D2-Q159', 'E', '800.', null),
('2025-D2-Q160', 'A', '$D = 2{,}5 + \operatorname{tg}\left[30\left(T - \frac{5-2\pi}{2}\right)\right]$', null),
('2025-D2-Q160', 'B', '$D = 4 + \operatorname{tg}\left[30\left(T + \frac{5}{2}\right)\right]$', null),
('2025-D2-Q160', 'C', '$D = 4 + \operatorname{tg}\left[2{,}5\left(T + \frac{5+2\pi}{2}\right)\right]$', null),
('2025-D2-Q160', 'D', '$D = 30 + \operatorname{tg}\left[\frac{1}{2}(T - 5)\right]$', null),
('2025-D2-Q160', 'E', '$D = 30 + \operatorname{tg}\left[\frac{1}{2}\left(T - \frac{5}{2}\right)\right]$', null),
('2025-D2-Q161', 'A', 'P.', null),
('2025-D2-Q161', 'B', 'Q.', null),
('2025-D2-Q161', 'C', 'R.', null),
('2025-D2-Q161', 'D', 'S.', null),
('2025-D2-Q161', 'E', 'T.', null),
('2025-D2-Q162', 'A', '135.', null),
('2025-D2-Q162', 'B', '140.', null),
('2025-D2-Q162', 'C', '155.', null),
('2025-D2-Q162', 'D', '160.', null),
('2025-D2-Q162', 'E', '175.', null),
('2025-D2-Q163', 'A', '720', null),
('2025-D2-Q163', 'B', '360', null),
('2025-D2-Q163', 'C', '320', null),
('2025-D2-Q163', 'D', '288', null),
('2025-D2-Q163', 'E', '240', null),
('2025-D2-Q164', 'A', '135 e 7 horas e 15 minutos.', null),
('2025-D2-Q164', 'B', '45 e 7 horas e 15 minutos.', null),
('2025-D2-Q164', 'C', '135 e 12 horas.', null),
('2025-D2-Q164', 'D', '135 e 6 horas.', null),
('2025-D2-Q164', 'E', '45 e 6 horas.', null),
('2025-D2-Q165', 'A', '1.', null),
('2025-D2-Q165', 'B', '2.', null),
('2025-D2-Q165', 'C', '3.', null),
('2025-D2-Q165', 'D', '4.', null),
('2025-D2-Q165', 'E', '5.', null),
('2025-D2-Q166', 'A', '1', null),
('2025-D2-Q166', 'B', '2', null),
('2025-D2-Q166', 'C', '8', null),
('2025-D2-Q166', 'D', '9', null),
('2025-D2-Q166', 'E', '15', null),
('2025-D2-Q167', 'A', '4', null),
('2025-D2-Q167', 'B', '8', null),
('2025-D2-Q167', 'C', '14', null),
('2025-D2-Q167', 'D', '21', null),
('2025-D2-Q167', 'E', '30', null),
('2025-D2-Q168', 'A', 'I, com o custo total de R\$ 1 400,00.', null),
('2025-D2-Q168', 'B', 'II, com o custo total de R\$ 280,00.', null),
('2025-D2-Q168', 'C', 'II, com o custo total de R\$ 1 300,00.', null),
('2025-D2-Q168', 'D', 'III, com o custo total de R\$ 460,00.', null),
('2025-D2-Q168', 'E', 'III, com o custo total de R\$ 1 200,00.', null),
('2025-D2-Q169', 'A', null, 'imagens/2025/D2/q169_alt_A.webp'),
('2025-D2-Q169', 'B', null, 'imagens/2025/D2/q169_alt_B.webp'),
('2025-D2-Q169', 'C', null, 'imagens/2025/D2/q169_alt_C.webp'),
('2025-D2-Q169', 'D', null, 'imagens/2025/D2/q169_alt_D.webp'),
('2025-D2-Q169', 'E', null, 'imagens/2025/D2/q169_alt_E.webp'),
('2025-D2-Q170', 'A', '10.', null),
('2025-D2-Q170', 'B', '8.', null),
('2025-D2-Q170', 'C', '4.', null),
('2025-D2-Q170', 'D', '3.', null),
('2025-D2-Q170', 'E', '2.', null),
('2025-D2-Q171', 'A', '4', null),
('2025-D2-Q171', 'B', '12', null),
('2025-D2-Q171', 'C', '16', null),
('2025-D2-Q171', 'D', '18', null),
('2025-D2-Q171', 'E', '20', null),
('2025-D2-Q172', 'A', '$10^{0{,}5}$', null),
('2025-D2-Q172', 'B', '$10^{8}$', null),
('2025-D2-Q172', 'C', '$\frac{10^{2{,}5}}{84}$', null),
('2025-D2-Q172', 'D', '$\frac{10^{2{,}5}}{99}$', null),
('2025-D2-Q172', 'E', '$25 \times 10^{-2}$', null),
('2025-D2-Q173', 'A', 'o 1, pois apresenta área de seção transversal medindo 67,5 m².', null),
('2025-D2-Q173', 'B', 'o 2, pois apresenta área de seção transversal medindo 121,5 m².', null),
('2025-D2-Q173', 'C', 'o 1, pois apresenta área de seção transversal medindo 135 m².', null),
('2025-D2-Q173', 'D', 'o 2, pois apresenta área de seção transversal medindo 243 m².', null),
('2025-D2-Q173', 'E', 'qualquer um dos dois, pois apresentam áreas de suas seções transversais com medidas iguais.', null),
('2025-D2-Q175', 'A', '36', null),
('2025-D2-Q175', 'B', '53', null),
('2025-D2-Q175', 'C', '300', null),
('2025-D2-Q175', 'D', '360', null),
('2025-D2-Q175', 'E', '560', null),
('2025-D2-Q176', 'A', '4,5.', null),
('2025-D2-Q176', 'B', '6,0.', null),
('2025-D2-Q176', 'C', '7,5.', null),
('2025-D2-Q176', 'D', '9,0.', null),
('2025-D2-Q176', 'E', '12,0.', null),
('2025-D2-Q177', 'A', '288', null),
('2025-D2-Q177', 'B', '297', null),
('2025-D2-Q177', 'C', '567', null),
('2025-D2-Q177', 'D', '990', null),
('2025-D2-Q177', 'E', '1 134', null),
('2025-D2-Q178', 'A', 'Artur, com probabilidade de $\frac{2}{3}$', null),
('2025-D2-Q178', 'B', 'João, com probabilidade de $\frac{4}{9}$', null),
('2025-D2-Q178', 'C', 'Artur, com probabilidade de $\frac{91}{216}$', null),
('2025-D2-Q178', 'D', 'João, com probabilidade de $\frac{91}{216}$', null),
('2025-D2-Q178', 'E', 'Artur, com probabilidade de $\frac{125}{216}$', null),
('2025-D2-Q179', 'A', '$\frac{\text{cd}}{\text{m}^2}$', null),
('2025-D2-Q179', 'B', '$\frac{\text{m}^2}{\text{cd}}$', null),
('2025-D2-Q179', 'C', '$\frac{\text{cd}}{\text{m}}$', null),
('2025-D2-Q179', 'D', '$\frac{\text{m}}{\text{cd}}$', null),
('2025-D2-Q179', 'E', '$\frac{\text{m}}{\text{cd}^2}$', null),
('2025-D2-Q180', 'A', '$103 + 4n$', null),
('2025-D2-Q180', 'B', '$103 + 3n$', null),
('2025-D2-Q180', 'C', '$100 + 4n$', null),
('2025-D2-Q180', 'D', '$100 + 3n$', null),
('2025-D2-Q180', 'E', '$99 + 4n$', null);
delete from public.questao_figuras where questao_id in ('2024-D2-Q136', '2024-D2-Q137', '2024-D2-Q138', '2024-D2-Q139', '2024-D2-Q140', '2024-D2-Q141', '2024-D2-Q142', '2024-D2-Q143', '2024-D2-Q144', '2024-D2-Q145', '2024-D2-Q146', '2024-D2-Q147', '2024-D2-Q148', '2024-D2-Q149', '2024-D2-Q150', '2024-D2-Q151', '2024-D2-Q152', '2024-D2-Q153', '2024-D2-Q154', '2024-D2-Q155', '2024-D2-Q156', '2024-D2-Q157', '2024-D2-Q158', '2024-D2-Q159', '2024-D2-Q160', '2024-D2-Q161', '2024-D2-Q162', '2024-D2-Q163', '2024-D2-Q164', '2024-D2-Q165', '2024-D2-Q166', '2024-D2-Q167', '2024-D2-Q168', '2024-D2-Q169', '2024-D2-Q170', '2024-D2-Q171', '2024-D2-Q172', '2024-D2-Q173', '2024-D2-Q174', '2024-D2-Q175', '2024-D2-Q176', '2024-D2-Q177', '2024-D2-Q178', '2024-D2-Q179', '2024-D2-Q180', '2025-D2-Q136', '2025-D2-Q137', '2025-D2-Q138', '2025-D2-Q139', '2025-D2-Q140', '2025-D2-Q141', '2025-D2-Q142', '2025-D2-Q143', '2025-D2-Q144', '2025-D2-Q145', '2025-D2-Q146', '2025-D2-Q147', '2025-D2-Q148', '2025-D2-Q149', '2025-D2-Q150', '2025-D2-Q151', '2025-D2-Q152', '2025-D2-Q153', '2025-D2-Q154', '2025-D2-Q155', '2025-D2-Q156', '2025-D2-Q157', '2025-D2-Q158', '2025-D2-Q159', '2025-D2-Q160', '2025-D2-Q161', '2025-D2-Q162', '2025-D2-Q163', '2025-D2-Q164', '2025-D2-Q165', '2025-D2-Q166', '2025-D2-Q167', '2025-D2-Q168', '2025-D2-Q169', '2025-D2-Q170', '2025-D2-Q171', '2025-D2-Q172', '2025-D2-Q173', '2025-D2-Q175', '2025-D2-Q176', '2025-D2-Q177', '2025-D2-Q178', '2025-D2-Q179', '2025-D2-Q180');
insert into public.questao_figuras (questao_id, ordem, imagem, descricao) values
('2024-D2-Q136', 1, 'imagens/2024/D2/q136_fig1.webp', 'Desenho de um microscópio óptico visto de lado. Uma seta aponta para o tubo superior com o rótulo "Lente ocular"; duas setas apontam para as lentes do revólver, abaixo do tubo, com o rótulo "Lentes objetivas".'),
('2024-D2-Q138', 1, 'imagens/2024/D2/q138_fig1.webp', 'Teclado alfanumérico com 12 teclas em 4 linhas e 3 colunas: 1 (sem letras); 2 ABC; 3 DEF; 4 GHI; 5 JKL; 6 MNO; 7 PQRS; 8 TUV; 9 WXYZ; na última linha, uma tecla com traço (—), a tecla 0 (sem letras) e outra tecla com traço (—).'),
('2024-D2-Q141', 1, 'imagens/2024/D2/q141_fig1.webp', 'Gráfico formado por segmentos de reta com eixo horizontal "Grandeza I" (0 a 4) e eixo vertical "Grandeza II" (0 a 4), com malha tracejada. Pontos destacados: (0, 0), (2, 3) e (4, 4), ligados por segmentos de (0, 0) a (2, 3) e de (2, 3) a (4, 4).'),
('2024-D2-Q141', 2, 'imagens/2024/D2/q141_fig2.webp', 'Gráfico formado por segmentos de reta com eixo horizontal "Grandeza II" (0 a 4) e eixo vertical "Grandeza III" (0 a 4), com malha tracejada. Pontos destacados: (0, 4), (3, 1) e (4, 3), ligados por segmentos de (0, 4) a (3, 1) e de (3, 1) a (4, 3).'),
('2024-D2-Q144', 1, 'imagens/2024/D2/q144_fig1.webp', 'Trapézio retângulo azul PQRS com o lado vertical PS (à direita) apoiado sobre uma reta vertical rotulada "Vareta". P fica em cima e S embaixo, ambos com marca de ângulo reto. A base menor PQ (em cima) é mais curta que a base maior SR (embaixo); o lado QR é inclinado. Setas curvas acima e abaixo do trapézio, em torno da vareta, indicam o sentido de giro.'),
('2024-D2-Q147', 1, 'imagens/2024/D2/q147_fig1.webp', 'Máquina caça-níquel com a placa "Encontre três quantidades iguais" no topo e uma alavanca com bola vermelha na lateral direita. O visor tem seis compartimentos, numerados abaixo de I a VI, mostrando: I) 4 elevado a 1/2 ($4^{\frac{1}{2}}$); II) o número misto quatro e um meio ($4\frac{1}{2}$); III) $\frac{10}{45}$; IV) $\frac{18}{4}$; V) 4,5; VI) $\frac{4}{5}$.'),
('2024-D2-Q148', 1, 'imagens/2024/D2/q148_fig1.webp', 'Gráfico intitulado "Temperatura da caneca (em grau Celsius)". Eixo vertical "Temperatura" de 40 a 100 (marcas de 10 em 10); eixo horizontal "Tempo (em minuto)" de 0 a 20 (marcas de 2 em 2). Uma curva vermelha decrescente e côncava para cima parte de 100 no tempo 0 e chega a 40 no tempo 20, passando por cerca de 60 no tempo 10.'),
('2024-D2-Q150', 1, 'imagens/2024/D2/q150_fig1.webp', 'Planta retangular de uma sala, com cota de 6 m na largura (horizontal) e 3 m na altura (vertical). No meio da sala, uma fileira vertical de círculos azuis (colunas) vai de uma parede longa à outra: três círculos em cima, reticências verticais e três círculos embaixo. Na parede inferior há duas portas (aberturas com arco tracejado), uma de cada lado da fileira de colunas.'),
('2024-D2-Q152', 1, 'imagens/2024/D2/q152_fig1.webp', 'Gráfico de linhas mensais de jun. 2009 a jun. 2010, eixo vertical "Em bilhão de dólares" de 9 a 18. Legenda: Importações (linha cinza) e Exportações (linha preta); a área entre as linhas é sombreada. Meses destacados com linhas verticais: Jun. 2009 (exportações ≈ 14,5; importações ≈ 10), Jan. 2010 (exportações ≈ 11,3, abaixo das importações ≈ 11,6) e Jun. 2010 (exportações 17,1 e importações 14,8, valores indicados no gráfico). Nos meses intermediários, as exportações ficam quase sempre acima das importações, com pico de exportações ≈ 17,7 em maio de 2010.'),
('2024-D2-Q155', 1, 'imagens/2024/D2/q155_fig1.webp', 'Semicírculo de centro S (ponto no meio do diâmetro horizontal, na parte de cima), com o raio R indicado por uma cota horizontal de S até a extremidade direita. Dentro dele, um setor circular azul com vértice em S, abrindo-se para baixo e simétrico em relação à vertical, com o ângulo α marcado no vértice.'),
('2024-D2-Q158', 1, 'imagens/2024/D2/q158_fig1.webp', 'Cartaz amarelo com um balão em forma de estrela contendo: "PROMOÇÃO: Compre pelo menos 35 litros de defensivos do TIPO A e ganhe a máscara para aplicação." Abaixo, a lista de preços: "Defensivo Tipo A - R\$ 4,20/litro", "Defensivo Tipo B - R\$ 3,00/litro", "Máscara para aplicação - R\$ 12,50".'),
('2024-D2-Q161', 1, 'imagens/2024/D2/q161_fig1.webp', 'Tanque em perspectiva (paralelepípedo) de altura H e comprimento L, com a base dividida em três partes de comprimento L/3 cada. Dois anteparos verticais atravessam a largura do tanque: o da esquerda, na divisa entre o 1º e o 2º terço, tem altura H/4; o da direita, na divisa entre o 2º e o 3º terço, tem altura H/2. No teto, sobre o terço da direita, há um círculo indicado como "Entrada para abastecimento".'),
('2024-D2-Q163', 1, 'imagens/2024/D2/q163_fig1.webp', 'Duas polias circulares: a menor, à esquerda, de centro A e raio r = 4 cm; a maior, à direita, de centro B e raio R = 8 cm. Uma correia envolve as duas, formada por dois segmentos tangentes (superior e inferior), cada um indicado com 15 cm, e por arcos em contato com as polias. Na polia menor, o ângulo central correspondente ao arco em contato com a correia (do lado esquerdo) está marcado como 150°. Setas verdes indicam o sentido de rotação.'),
('2024-D2-Q164', 1, 'imagens/2024/D2/q164_fig1.webp', 'Esquema com os pontos P₁ (em cima), P₂ (embaixo à direita) e P₃ (embaixo à esquerda), vértices de um triângulo equilátero, e o ponto H no centro. Cotas indicam 10 km entre P₁ e P₃, 10 km entre P₁ e P₂ e 10 km entre P₃ e P₂. Os segmentos HP₁, HP₂ e HP₃ têm marcas iguais (dois tracinhos), indicando comprimentos iguais.'),
('2024-D2-Q167', 1, 'imagens/2024/D2/q167_fig1.webp', 'Dois celulares lado a lado com a diagonal da tela indicada por uma seta dupla. "Celular 1" (menor, à esquerda): "3 1/2 polegadas" ($3\frac{1}{2}$). "Celular 2" (maior, à direita): "4 5/6 polegadas" ($4\frac{5}{6}$).'),
('2024-D2-Q172', 1, 'imagens/2024/D2/q172_fig1.webp', 'Segmento horizontal do "Terminal 1" (esquerda) ao "Terminal 2" (direita), dividido em 10 partes iguais por marcas. Abaixo dele, cinco câmeras (pontos) com seus campos de visão em triângulos azuis cobrindo trechos consecutivos, da esquerda para a direita: câmera I (2 partes), câmera II (3 partes), câmera III (1 parte), câmera IV (1 parte) e câmera V (3 partes).'),
('2024-D2-Q173', 1, 'imagens/2024/D2/q173_fig1.webp', 'Gráfico de barras empilhadas: eixo vertical "Quantidade de funcionários" (marcas 0, 80, 120 e 200) e eixo horizontal "Setor". Administrativo: total 80, com Até 25 anos 20%, Entre 25 e 45 anos 30% e A partir de 45 anos 50%. Logística: total 120, com Até 25 anos 25%, Entre 25 e 45 anos 40% e A partir de 45 anos 35%. Produção: total 200, com Até 25 anos 40%, Entre 25 e 45 anos 35% e A partir de 45 anos 25%. Legenda: azul = "A partir de 45 anos"; amarelo = "Entre 25 e 45 anos"; vermelho = "Até 25 anos".'),
('2024-D2-Q174', 1, 'imagens/2024/D2/q174_fig1.webp', 'Perspectiva de duas paredes verticais quadriculadas e paralelas (esquerda e direita) sobre uma base quadriculada. A trajetória em vermelho: A está no canto superior traseiro da parede direita; segue até B, na borda frontal da parede esquerda (parte alta); desce verticalmente até C, logo abaixo de B, na mesma parede; segue até D, na parede direita (parte do segmento atrás da parede é tracejada); desce até E, também na parede direita, mais à frente e mais abaixo; e segue até F, ponto no meio da borda frontal da base.'),
('2024-D2-Q175', 1, 'imagens/2024/D2/q175_fig1.webp', 'Duas opções. "Embalagem 1": retângulo de 10 cm de largura e 20 cm de altura, com uma seta indicando que vira um cilindro alto e fino (altura 20 cm). "Embalagem 2": retângulo de 20 cm de largura e 10 cm de altura, com uma seta indicando que vira um cilindro baixo e largo (altura 10 cm).'),
('2024-D2-Q176', 1, 'imagens/2024/D2/q176_fig1.webp', 'Gráfico de dispersão com malha tracejada: eixo vertical "Receita anual (em milhão de reais)" de 0 a 7 e eixo horizontal "Ano" de 2014 a 2021. Pontos aproximados: 2014 ≈ 3,4; 2015 ≈ 5,0; 2016 ≈ 4,9; 2017 ≈ 4,6; 2018 ≈ 5,6; 2019 = 6,0; 2020 ≈ 5,2; 2021 ≈ 6,7. Uma reta crescente de tendência passa pelos cruzamentos da malha em 2014 com 4, em 2017 com 5 e em 2020 com 6.'),
('2025-D2-Q137', 1, 'imagens/2025/D2/q137_fig1.webp', 'Infográfico em tons de cinza. Na parte superior, um balão com o texto "90% dos internautas brasileiros acessam redes sociais" sobre uma fileira de 10 bonecos, 9 escuros e 1 claro. No meio, a faixa "MULHERES × HOMENS". Na parte inferior, o texto "60% da quantidade de internautas brasileiros que acessam redes sociais são mulheres", com uma seta apontando para 20 bonecos: 12 figuras femininas escuras e 8 figuras masculinas claras.'),
('2025-D2-Q138', 1, 'imagens/2025/D2/q138_fig1.webp', 'Sistema de eixos x, y e z em perspectiva, com os três planos coordenados (xy, xz e yz) quadriculados em unidades por linhas tracejadas. Um cubo azul de aresta 1 unidade está no espaço, próximo ao plano xz e na parte alta da figura; linhas pontilhadas ligam o cubo às suas três projeções ortogonais (quadrados azuis): uma no plano xz (à esquerda), uma no plano yz (ao fundo, no alto) e uma no plano xy (embaixo).'),
('2025-D2-Q139', 1, 'imagens/2025/D2/q139_fig1.webp', 'Lagoa circular (azul) cercada por uma faixa branca que representa a ciclovia. Na parte superior direita, um trecho da ciclovia está pintado de cinza escuro, com o ponto P (amarelo) no meio desse trecho; cotas indicam 200 m de cada lado de P, ao longo da ciclovia.'),
('2025-D2-Q145', 1, 'imagens/2025/D2/q145_fig1.webp', 'Gráfico com eixo vertical "Frequência respiratória (rpm)" e eixo horizontal "Tempo (min)". A curva começa constante no nível f₁ até o instante t₁ (marcado "Início da prática meditativa"), depois decresce suavemente até atingir o nível f₂ no instante t₂, e a partir daí permanece constante em f₂.'),
('2025-D2-Q147', 1, 'imagens/2025/D2/q147_fig1.webp', 'Dois gráficos. À esquerda, gráfico de setores "Porcentagem de matrículas por idioma – 2023": Inglês 60%, Espanhol 25%, Francês 10%, Alemão 5%. À direita, gráfico de colunas "Quantidade de matrículas por idioma – 2024": Inglês 280, Espanhol 80, Francês 20, Alemão 20.'),
('2025-D2-Q148', 1, 'imagens/2025/D2/q148_fig1.webp', 'Cinco telas retangulares numeradas de I a V, cada uma com um segmento orientado, seu comprimento e a escala. I: de A até B, 9 cm, escala 1 : 100. II: de B até C, 5 cm, escala 1 : 300. III: de C até D, 5 cm, escala 1 : 600. IV: de D até E, 3 cm, escala 1 : 700. V: de E até F, 2 cm, escala 1 : 1 000.'),
('2025-D2-Q149', 1, 'imagens/2025/D2/q149_fig1.webp', 'O poliedro visto em duas posições. À esquerda, vista lateral mostrando faces triangulares azuis, quadradas amarelas e uma face pentagonal verde no topo. À direita, vista mostrando uma grande face decagonal vermelha (a base) cercada por faces triangulares azuis.'),
('2025-D2-Q149', 2, 'imagens/2025/D2/q149_fig2.webp', 'Planificação do poliedro: um decágono regular vermelho no centro; em cada um de seus 10 lados há faces triangulares azuis (formando uma faixa de triângulos ao redor do decágono); presas a alguns triângulos estão 5 quadrados amarelos, e um dos quadrados está ligado a um pentágono regular verde.'),
('2025-D2-Q153', 1, 'imagens/2025/D2/q153_fig1.webp', 'Plano cartesiano com origem 0 e eixos x e y. Um quadrado azul-claro STUV, inclinado, com vértices S (6 ; 2) embaixo, V (8 ; 6) à direita, U no alto e T à esquerda (U e T sem coordenadas indicadas).'),
('2025-D2-Q154', 1, 'imagens/2025/D2/q154_fig1.webp', 'Gráfico de colunas agrupadas com linha, eixo vertical de 0 a 170 (de 10 em 10). Para cada gênero: Ficção — Autor brasileiro 80, Autor estrangeiro 120, Demanda 160; Autoajuda — Autor brasileiro 50, Autor estrangeiro 80, Demanda cerca de 136; Romance — Autor brasileiro 40, Autor estrangeiro cerca de 106, Demanda 140; Biografia — Autor brasileiro cerca de 46, Autor estrangeiro 50, Demanda 80. Legenda: Autor brasileiro (laranja), Autor estrangeiro (verde), Demanda (linha azul com marcadores quadrados).'),
('2025-D2-Q156', 1, 'imagens/2025/D2/q156_fig1.webp', 'Desenho de um sol amarelo: um círculo central cercado por oito raios triangulares. Cotas indicam 20 cm na horizontal (da ponta do raio esquerdo à ponta do raio direito) e 20 cm na vertical (da ponta do raio superior à ponta do raio inferior).'),
('2025-D2-Q160', 1, 'imagens/2025/D2/q160_fig1.webp', 'À esquerda, desenho de um recipiente (estreito na base e largo em cima, com bojo arredondado) apoiado sobre o "Tampo da mesa". À direita, gráfico de D em função de T: curva vermelha contínua crescente com forma de tangente, de T = 0 (ponto aberto, na altura do fundo do recipiente) até T = 4 (ponto aberto, na altura da borda do recipiente), passando pelo ponto (2,5 ; 30), que é o ponto de inflexão; fora desse intervalo a curva continua tracejada. Linhas pontilhadas verdes verticais marcam as assíntotas em $T = \frac{5-2\pi}{2}$ (à esquerda da origem) e $T = \frac{5+2\pi}{2}$ (à direita). Linhas tracejadas azuis ligam o fundo e a borda do recipiente aos pontos da curva.'),
('2025-D2-Q161', 1, 'imagens/2025/D2/q161_fig1.webp', 'Malha de 7 linhas por 6 colunas de quadrados cinza (quarteirões), com uma rosa dos ventos ao lado (N para cima, S para baixo, L para a direita, O para a esquerda). Numerando linhas de cima para baixo (1 a 7) e colunas da esquerda para a direita (1 a 6): Q está na linha 1, coluna 5; o quadradinho preto A está no canto superior esquerdo do quarteirão da linha 4, coluna 3; S está na linha 4, coluna 5; R está na linha 7, coluna 1; P está na linha 7, coluna 5; T está na linha 7, coluna 6.'),
('2025-D2-Q163', 1, 'imagens/2025/D2/q163_fig1.webp', 'Dois gráficos. Gráfico de colunas "Modalidades esportivas no ensino médio, por série", eixo vertical "Quantidade de estudantes" sem valores numéricos, apenas linhas de grade igualmente espaçadas. Em unidades de grade: 1ª série — Futebol 7, Vôlei 3, Basquete 1; 2ª série — Futebol 6, Vôlei 3, Basquete 3; 3ª série — Futebol 5, Vôlei 4, Basquete 4. Gráfico de setores "Quantidade de estudantes, por modalidade esportiva": Futebol ocupa metade do círculo, Vôlei e Basquete o restante; apenas o setor de Basquete traz o valor 80. Legenda: Futebol (azul), Vôlei (laranja), Basquete (roxo).'),
('2025-D2-Q164', 1, 'imagens/2025/D2/q164_fig1.webp', 'Acima, uma bússola com os pontos cardeais N (0, no alto), L (90, à direita), S (180, embaixo) e O (270, à esquerda), graduada de 20 em 20 no sentido horário (0, 20, 40, 60, 80, 90, 100, 120, 140, 160, 180, 200, 220, 240, 260, 270, 280, 300, 320, 340), com a agulha vermelha apontando para N. Abaixo, o esquema das rotas: rota planejada em laranja, de P até Q (para baixo e à direita) e de Q até R (horizontal para a direita); rota executada em verde, de P até S (para cima e à esquerda) e de S até T (horizontal para a direita); uma linha azul tracejada liga T a R.'),
('2025-D2-Q166', 1, 'imagens/2025/D2/q166_fig1.webp', 'Esquema de uma reta com marcas em 0 km, 1 km, 2 km, 3 km, 4 km e 5 km ("Comprimento do percurso"), dividida em 1º, 2º, 3º, 4º e 5º trecho. "Tempo de corrida" ao cruzar cada marca: 0 s (0 km), 272 s (1 km), 556 s (2 km), 844 s (3 km) e 1 132 s (4 km). "Tempo gasto em cada trecho de 1 km": 272 s (1º trecho), 284 s (2º), 288 s (3º) e 288 s (4º). Um corredor aparece sobre a marca de 4 km; o 5º trecho, até 5 km, ainda não foi percorrido.'),
('2025-D2-Q167', 1, 'imagens/2025/D2/q167_fig1.webp', 'Dois gráficos com eixo horizontal Velocidade (km/h), de 0 a 140 (marcas de 20 em 20), e malha quadriculada. À esquerda, Rendimento (km/m³), de 0 a 14, curva GNV: 8 em 20 km/h, cerca de 9 em 40 km/h, 10 em 60 km/h, cerca de 11 em 80 km/h, máximo de 12 em 100 km/h, cerca de 11 em 120 km/h e 10 em 140 km/h. À direita, Rendimento (km/L), de 0 a 14, curva Gasolina: 6 em 20 km/h, cerca de 7 em 40 km/h, 8 em 60 km/h, 10 em 80 km/h, máximo de 11 em 100 km/h, 10 em 120 km/h e 9 em 140 km/h.'),
('2025-D2-Q170', 1, 'imagens/2025/D2/q170_fig1.webp', 'Caixa de descarga em forma de paralelepípedo, com base de 2,5 dm por 1,5 dm, contendo pouca água no fundo; a boia (esfera preta presa a uma haste) está abaixada, e um fio de água entra pela torneira, enchendo a caixa.'),
('2025-D2-Q170', 2, 'imagens/2025/D2/q170_fig2.webp', 'A mesma caixa (base de 2,5 dm por 1,5 dm) cheia de água até a altura de 2 dm; a boia flutua na superfície com a haste horizontal, interrompendo o abastecimento.'),
('2025-D2-Q173', 1, 'imagens/2025/D2/q173_fig1.webp', 'Vistas frontais dos dois projetos, com túneis semicirculares escavados na montanha. Projeto 1: "Túnel para automóveis" com diâmetro de 12 m, dividido ao meio por uma mureta em "volta" e "ida"; ao lado, "Túnel para bicicletas" com diâmetro de 6 m, também dividido em "volta" e "ida". Projeto 2: um único "Túnel de uso misto", com a base dividida por muretas em quatro faixas: volta 3 m, volta 6 m, ida 6 m e ida 3 m (diâmetro total de 18 m).'),
('2025-D2-Q177', 1, 'imagens/2025/D2/q177_fig1.webp', 'À esquerda, vista frontal da medalha: um círculo dourado de diâmetro 6 cm com um quadrado cinza ABCD inscrito, com os vértices A (no alto), B (à direita), C (embaixo) e D (à esquerda) sobre a circunferência. À direita, a medalha em perspectiva, mostrando a espessura de 3 mm e o quadrado cinza atravessando-a.'),
('2025-D2-Q180', 1, 'imagens/2025/D2/q180_fig1.webp', 'Quatro círculos coloridos numerados dispostos sobre uma circunferência: 1 (no alto), 2 (à direita), 3 (embaixo) e 4 (à esquerda), ligados por arcos com setas no sentido horário: de 1 para 2, de 2 para 3, de 3 para 4 e de 4 para 1.');
commit;
