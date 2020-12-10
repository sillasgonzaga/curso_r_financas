
library(tidyverse)
library(xts)
library(PerformanceAnalytics)
library(quantmod)
library(rbcb)

IBOVESPA <- getSymbols("^BVSP",
                       from = "2009-12-31",
                       to = "2019-12-31",
                       auto.assign = FALSE)

IBOVESPA %>%
  Ad() %>%
  autoplot()

# EDA retornos

IBOVESPA_rets <- IBOVESPA %>%
  Cl() %>%
  log() %>%
  diff()


IBOVESPA_rets %>% autoplot()

summary(IBOVESPA_rets %>% coredata())

var(IBOVESPA_rets %>% as.numeric(), na.rm = TRUE)

sd(IBOVESPA_rets, na.rm = TRUE)

skewness(IBOVESPA_rets, na.rm = TRUE)

kurtosis(IBOVESPA_rets, na.rm = TRUE, method = "moment")

x_norm <- rnorm(length(IBOVESPA_rets))

plot(x_norm, type = "l")

mean(x_norm, na.rm = TRUE)

sd(x_norm, na.rm = TRUE)

skewness(x_norm, na.rm = TRUE)

kurtosis(x_norm, na.rm = TRUE, method = "moment")


IBOVESPA_rets %>%
  chart.Histogram(breaks = 50,
                  main = "Histograma de retornos do IBOVESPA",
                  show.outliers = TRUE,
                  methods = "add.normal", lwd = 1)

x_norm %>%
  chart.Histogram(breaks = 50,
                  main = "Histograma de retornos da Normal",
                  show.outliers = TRUE,
                  methods = "add.normal", lwd = 1)
