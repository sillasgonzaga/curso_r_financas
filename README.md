
# Módulo 1 - Introdução ao R e Fontes de Dados

## Primeiros passos com R

- Introdução ao Rstudio
- Operações aritméticas
- Criação de variáveis e objetos
- Estruturas de dados
- Vetores
- Matrizes
- Data frames

### Case

- Dada série de preços de 2 ativos
  - fazer gráfico com 2 ativos
  - calcular série de variação de preços dos ativos (retorno aritimético) - fazer gráfico do retorno
  - com retornos dos 2 ativos calcular série de índices (usando cumprod) para cada ativo - fazer gráfico comparando 2 ativos dá até pra criar uma série de taxa de juros fixa acumulada (simulando um CDI no período)

## R básico

- Trabalhando com datas
- If-else
- Loops
- Funções
- purrr::map

### Case

- Dada uma matriz de variação de preços de ativos calcular para cada ativo as estatísticas descritivas: média, desvio padrão, máximo, mínimo e mediana.
- Calcular o IBOVESPA: pegar, no site da B3, os ativos que constituem o IBOVESPA, os pesos e as cotações e calcular o valor do índice.

## Fontes de dados financeiros

- Pacotes:
	- `quantmod`: séries de preços de ações e índices
	- `rbcb`: séries de preços de moedas: Mostrar *helpers* `bid` e `ask`
	- `GetTDData`: séries de preços do tesouro direto
- Manipulação de dados com xts e quantmod
  - Criação de objetos `xts`: uso de dados do `GetTDData` usando LFT, LTN e NTN-B
  - Usar função `to.period` para obter dados semanais/mensais OHLC para séries de preços e fazer gráficos de candle
  - *Helpers* do `quantmod`: `Cl`, `Op`, `Hi`, `Lo`. Obter dados de fechamento com `Cl`
  - Juntar múltiplas séries temporais: fazer merge das séries de fechamento.

### Case

- Calcular o IBOVESPA em Dólar
  - Obter `^BVSP` com quantmod
  - Obter `USDBRL` com rbcb usando preço de venda (`Ask`)
  - Fazer a conversão do IBOVESPA em dólar e fazer gráficos

### Referências

- Dados abertos:
	- http://dados.cvm.gov.br/
	- https://dadosabertos.bcb.gov.br/


# Módulo 2 - Aplicações

## Análise retornos

- Retorno logaritmo e retorno aritimético
- Retorno esperado
- Risco esperado: volatilidade
- Volatilidade e retorno anualizados: comparação com taxas de juros

### Exercícios

- Para séries de preços de ações, ETFs e Índices, calcular:
  - Retornos logaritmicos mensais
  - Retorno esperado anualizado
  - Volatilidade esperada anualizada
  - Comparar os retornos e volatilidades esperadas dos ativos
- Para a série de preços do ativo selecionado.
  - Calcular os retornos diários aritméticos.
  - Dividir as séries em 4 períodos com a mesma quantidade de dados e calcule as estatísticas: média, desvio padrão e correlação, para cada sub-período.
  - O que se observa?
  - As medidas permanecem constantes ao longo do tempo?
  - Fazer a mesma análise para retornos diários logaritmicos - as medidas mudam substancialmente?
  - Fazer o boxplot para cada sub-período com os 2 tipos de retornos.

## Análise de risco

- Análise estatística dos retornos - distribuição normal
- Estatística Descritivas
- Volatilidade em janela móvel
- Túnel de volatilidade
- Outras medidas de risco:
  - Value at risk
  - Drawdown
  - Expected shortfall
- Comparando ativos
  - Comparação de risco e retorno de diversos ativos: gráfico de risco x retorno
  - Gráfico violinplot com as distribuições de retornos dos ativos
  - Gráfico boxplot com retorno dos ativos
  - Correlação entre séries de retornos de 2 ativos

### Exercícios

- Escolher 1 série de preços de ações, ETFs ou Índices, calcular:
  - Retornos diários logaritmicos
  - Volatilidade em janela móvel
  - Gráfico de túnel de volatilidade
- Para a série de retornos diários logaritmicos
  - Fazer o gráfico do histograma
  - Com a média e variância da amostra fazer o gráfico da densidade de probabilidade da distribuição normal. Comparar os gráficos. O histograma da amostra *parece* com uma distribuição normal?
- Selecionar 5 ativos:
  - Fazer o gráfico de risco x retorno
- Selecionar 5 ativos:
  - Calcular os retornos mensais logaritmicos
  - Fazer os gráficos de boxplot para os retornos dos 5 ativos no mesmo gráfico
  - Fazer os gráficos de violinplot para os retornos dos 5 ativos no mesmo gráfico
Fazer estes gráficos para um conjunto de ativos

## Análise de carteiras - Diversificação

- Simulação para cenários de alocação para 2 ativos: risco x retorno
- Montar carteira com 2 ativos
- Rebalanceamento da carteira
- Backtesting da estratégia de rebalanceamento
- Técnicas para encontrar carteiras ótimas
- Carteira de Mínima-Variância

### Exercício

- TODO

## Referências:

- [Blog RViews - Category Finance](https://rviews.rstudio.com/categories/finance/)
- [Blog do Wilson Freitas - Categoria Finanças](http://wilsonfreitas.github.io/category/finance.html)
- [Curso de Estratégias de Trading com R](http://wilsonfreitas.github.io/estrategias-de-trading/)
- [Importando e Manipulando Dados Financeiros no R](http://wilsonfreitas.github.io/slides/ser-maio-2018/)


