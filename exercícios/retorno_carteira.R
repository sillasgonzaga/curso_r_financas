
library(xts)
library(tidyverse)
library(PerformanceAnalytics)
library(quantmod)

stocks_names <- c(
  "ABEV3.SA",
  "B3SA3.SA",
  "CNTO3.SA",
  "EGIE3.SA",
  "LEVE3.SA",
  "LREN3.SA",
  "PSSA3.SA",
  "RAIL3.SA",
  "LREN3.SA",
  "ARZZ3.SA"
)

weights <- c(3.72,
             34.31,
             4.59,
             5.12,
             11.64,
             13.66,
             1.15,
             12.11,
             9.92,
             3.77) / 100

names(weights) <- stocks_names

getSymbols(stocks_names, from = "2009-01-01", to = Sys.Date() - 1,
           auto.assign = TRUE, warnings = FALSE)

prices <- stocks_names %>%
  map(~Ad(get(.))) %>%
  reduce(merge) %>%
  `colnames<-`(stocks_names)

prices_monthly <- to.monthly(prices, indexAt = "lastof", OHLC = FALSE)
prices_rets_monthly <- Return.calculate(prices_monthly,  method = "log") %>%  na.omit()

portfolio_rets <- PerformanceAnalytics::Return.portfolio(prices_rets_monthly, weights = weights)

Return.annualized(portfolio_rets)
