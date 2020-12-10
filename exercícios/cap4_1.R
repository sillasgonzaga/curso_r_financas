
# cap 4 ex 1

library(quantmod)
library(tidyverse)

getSymbols("PETR4.SA",
           from = "2010-01-01",
           to = "2020-01-01")

# Contagem de NA
head(PETR4.SA)
length(PETR4.SA %>% Ad())
sum(is.na( PETR4.SA %>% Ad() ))

# Limpeza de dados

PETR4_clean <- PETR4.SA %>% Ad() %>% na.omit()
plot(PETR4_clean)

# Cálculo do log-retorno diário

PETR4_ret <- PETR4_clean %>% Return.calculate("log") %>% na.omit()
plot(PETR4_ret)

# Retorno anualizado

mean(PETR4_ret) * 252

PETR4_ret %>% Return.annualized(geometric = FALSE)

# volatilidade anualizada

sd(PETR4_ret) * sqrt(252)

PETR4_ret %>% StdDev.annualized()


# EX 2

PETR4_ret["2010/2011"] %>% StdDev.annualized()
PETR4_ret["2012/2013"] %>% StdDev.annualized()
PETR4_ret["2014/2015"] %>% StdDev.annualized()
PETR4_ret["2016/2017"] %>% StdDev.annualized()
PETR4_ret["2018/2019"] %>% StdDev.annualized()

periods <- list("2010/2011",
                "2012/2013",
                "2014/2015",
                "2016/2017",
                "2018/2019")

periods %>%
  map(function(x) PETR4_ret[x] %>% StdDev.annualized() %>% as.numeric()) %>%
  set_names(periods)


