
library(tidyverse)
library(xts)
library(PerformanceAnalytics)
library(quantmod)
library(rbcb)


# Variação financeira do BOVA11

getSymbols("BOVA11.SA",
           from = "2020-01-31",
           to = "2020-10-01")

Cl(BOVA11.SA)[c("2020-01-31", "2020-09-30")] %>% as.numeric()

Cl(BOVA11.SA)[c("2020-01-31", "2020-09-30")] %>%
  as.numeric() %>%
  diff()

# Variação financeira do USD em BRL

USDBRL <- get_currency("USD", start_date = "2020-01-31", end_date = "2020-10-01", as = "xts")

Ask(USDBRL)[c("2020-01-31", "2020-09-30")] %>%
  as.numeric()

Ask(USDBRL)[c("2020-01-31", "2020-09-30")] %>%
  as.numeric() %>%
  diff()

# Variação diária BOVA11

Cl(BOVA11.SA) %>% diff()

Ask(USDBRL) %>% diff()

# Retorno simples BOVA11

diff_ <- Cl(BOVA11.SA)[c("2020-01-31", "2020-09-30")] %>%
  as.numeric() %>%
  diff()

ini_price <- Cl(BOVA11.SA)["2020-01-31"] %>% as.numeric()

diff_ / ini_price

# Retorno simples USDBRL

diff_ <- Ask(USDBRL)[c("2020-01-31", "2020-09-30")] %>%
  as.numeric() %>%
  diff()

ini_price <- Ask(USDBRL)["2020-01-31"] %>% as.numeric()

diff_ / ini_price


# Retorno simples multiperiodo

USDBRL <- get_currency("USD",
                       start_date = "2020-09-01",
                       end_date = "2020-09-04",
                       as = "xts") %>%
  Ask()

merge(
  USDBRL %>% setNames("P_t"),
  diff(USDBRL) %>% setNames("diff")
)

merge(
  USDBRL %>% setNames("P_t"),
  lag.xts(USDBRL) %>% setNames("P_t1"),
  diff(USDBRL) %>% setNames("diff")
)

(100 * diff(USDBRL) / lag.xts(USDBRL)) %>% setNames("R_t")

# Retorno simples multiperiodo para série

USDBRL <- get_currency("USD",
                       start_date = "2020-01-01",
                       end_date = "2020-09-30",
                       as = "xts") %>%
  Ask()


USDBRL_ret <- diff(USDBRL) / lag.xts(USDBRL) %>% setNames("R_t")

plot(USDBRL)

plot(USDBRL_ret)

# Retorno simples multiperiodo com PerformanceAnalytics

USDBRL_ret <- 100 * Return.calculate(USDBRL, method = "discrete") %>%
  setNames("R_t")

plot(USDBRL_ret)

# Retorno simples multiperiodo mensal

USDBRL_2019 <- get_currency("USD",
                            start_date = "2018-12-31",
                            end_date = "2019-12-31",
                            as = "xts") %>%
  Ask()

plot(USDBRL_2019)

USDBRL_2019_monthly <- to.monthly(USDBRL_2019, indexAt = "firstof") %>%
  Cl()

USDBRL_2019_monthly

plot(USDBRL_2019_monthly)

Return.calculate(USDBRL_2019_monthly, method = "discrete") %>%
  setNames("R_t") -> USDBRL_2019_monthly_returns

100 * USDBRL_2019_monthly_returns

barplot(USDBRL_2019_monthly_returns * 100, las = 2, ylim = c(-5, 10))

## colocando apenas 2019

barplot(USDBRL_2019_monthly_returns["2019"] * 100, las = 2, ylim = c(-5, 10))

# chart.Bar

get_currency("USD",
             start_date = "2018-12-31",
             end_date = "2019-12-31",
             as = "xts") %>%
  Ask() %>%
  Return.calculate(method = "discrete") %>%
  charts.Bar(main = "Retornos do Dólar")


# composição de retornos

prod(1 + USDBRL_2019_monthly_returns, na.rm = TRUE)

100 * (prod(1 + USDBRL_2019_monthly_returns, na.rm = TRUE) - 1)

100 * (prod(1 + na.trim(USDBRL_2019_monthly_returns)) - 1)


# limpeza de dados

na.trim(USDBRL_2019_monthly_returns)

na.omit(USDBRL_2019_monthly_returns)


# retornos simples acumulados

cumprod(1 + na.trim(USDBRL_2019_monthly_returns))
prod(1 + na.trim(USDBRL_2019_monthly_returns))

barplot(100 * (cumprod(1 + na.trim(USDBRL_2019_monthly_returns)) - 1),
        las = 2, ylim = c(-5, 10))

chart.CumReturns(USDBRL_2019_monthly_returns,
                 begin = "axis",
                 wealth.index = TRUE,
                 main = "Retornos Acumulados",
                 legend.loc = 'topleft')

get_currency("USD",
             start_date = "2018-12-31",
             end_date = "2019-12-31",
             as = "xts") %>%
  Ask() %>%
  Return.calculate(method = "discrete") %>%
  chart.CumReturns(begin = "axis",
                   wealth.index = TRUE,
                   main = "Retornos Acumulados",
                   legend.loc = 'topleft')

list("USD", "CNY", "GBP") %>%
  map(get_currency,
      start_date = "2018-12-31",
      end_date = "2019-12-31",
      as = "xts") %>%
  map(Ask) %>%
  reduce(function(x, y) merge(x, y)) %>%
  Return.calculate(method = "discrete") %>%
  chart.CumReturns(begin = "axis",
                   wealth.index = TRUE,
                   main = "Retornos Acumulados - Moedas x BRL",
                   legend.loc = 'topleft')

list("USD", "CNY", "GBP") %>%
  map(get_currency,
      start_date = "2018-12-31",
      end_date = "2019-12-31",
      as = "xts") %>%
  map(Ask) %>%
  reduce(function(x, y) merge(x, y)) %>%
  Return.calculate(method = "discrete") %>%
  chart.CumReturns(begin = "axis",
                   wealth.index = TRUE,
                   main = "Retornos Acumulados - Moedas x BRL",
                   legend.loc = 'topleft',
                   col = c('gray', 'red', 'gray'))


fortify(USDBRL_2019_monthly_returns)


# Retorno médio

R_med <- ( prod(1 + na.trim(USDBRL_2019_monthly_returns)) ) ^ (1/length(na.trim(USDBRL_2019_monthly_returns))) - 1
100 * R_med


# Log-retorno

100 * diff(log(USDBRL)) %>%
  setNames("r_t")


100 * Return.calculate(USDBRL, method = "log") %>%
  setNames("r_t")


# risco e retorno esperado

100 * mean(Return.calculate(USDBRL_2019, method = "log"), na.rm = TRUE)

100 * sd(Return.calculate(USDBRL_2019, method = "log"), na.rm = TRUE)


mean(Return.calculate(USDBRL_2019, method = "log"), na.rm = TRUE) / sd(Return.calculate(USDBRL_2019, method = "log"), na.rm = TRUE)

