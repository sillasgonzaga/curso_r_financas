
# Módulo 1 - Introdução ao R e Fontes de Dados

## Primeiros passos com R

- Introdução ao Rstudio
- Operações aritméticas
- Criação de variáveis e objetos
- Estruturas de dados
- Vetores
- Matrizes
- Data frames
- Case: Dada uma matriz de variação de preços de ativos calcular a matriz de correlação dos ativos.

## R básico

- Trabalhando com datas
- If-else
- Loops
- Funções
- purrr::map
- Case: Dada uma matriz de variação de preços de ativos calcular para cada ativo as estatísticas descritivas: média, desvio padrão, máximo, mínimo e mediana.

## Fontes de dados financeiros

- Pacotes:
	- `quantmod`
	- `Quandl`
	- `rbcb`
	- `GetTDData`
- Case: Montar uma carteira com títulos do Tesouro Direto e construir histórico de preços da carteira. Os dados dão obtidos do Tesouro Direto com o pacote `GetTDData`

# Módulo 2 - Manipulação de Dados e Aplicações

## Manipulação de dados com xts e quantmod

- *Helpers* do `quantmod`: `Cl`, `Op`, `Hi`, `Lo`, `Vo`
- Indexação de objetos `xts`
- Funções para obter períodos específicos da série temporal: primeira semana, último mês, etc.
- Conversão de frequência das séries temporais: diária para mensal e vice-versa.
- Juntar múltiplas séries temporais: análise multivariada.
- Case: Calcular a série mensal do IBOVESPA em Dólar, Calcular o IBOVESPA deflacionado pelo IPCA.

## Visualização com `quantmod` e `PerformanceAnalytics`

- Visualização de séries temporais com `PerformanceAnalytics`: gráficos de barra, rentabilidade acumulada, rentabilidade anualizada, correlação, risco e retorno.
- Visualização de séries temporais com `quantmod`: gráficos de *candlesticks*, gráfico de volume, gráficos de barra OHLC

## Aplicações

- Indicadores de Análise Técnica: IFR, Média Móvel, MACD, Bandas de Bollinger, Momento, Estocástico.
- Análise de risco e retorno
- Simulação de Monta-Carlo de uma série temporal

## Referências:

- [Blog RViews - Category Finance](https://rviews.rstudio.com/categories/finance/)
- [Blog do Wilson Freitas - Categoria Finanças](http://wilsonfreitas.github.io/category/finance.html)
- [Curso de Estratégias de Trading com R](http://wilsonfreitas.github.io/estrategias-de-trading/)
