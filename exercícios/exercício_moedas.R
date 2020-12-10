
library(xts)
library(rbcb)
library(tidyverse)
library(PerformanceAnalytics)
library(bizdays)

USD <- get_currency("USD", "2020-01-01", "2020-07-31")

BRL <- USD %>% mutate(ask = 1 / ask)
attr(BRL, "symbol") <- "BRL"

CNY <- get_currency("CNY", "2020-01-01", "2020-07-31") %>%
  mutate(ask = ask / USD$ask)

ZAR <- get_currency("ZAR", "2020-01-01", "2020-07-31") %>%
  mutate(ask = ask / USD$ask)

INR <- get_currency("INR", "2020-01-01", "2020-07-31") %>%
  mutate(ask = ask / USD$ask)

RUB <- get_currency("RUB", "2020-01-01", "2020-07-31") %>%
  mutate(ask = ask / USD$ask)

cum_returns <- function(x) {
  name <- attr(x, "symbol")
  r <- log(x$ask) %>% diff()
  s <- c(1, cumprod(1 + r))
  tibble(x$date, s) %>%
    set_names(c("date", name))
}

compute_returns <- function(x) {
  name <- attr(x, "symbol")
  r <- log(x$ask) %>% diff()
  tibble(x$date[-1], r) %>%
    set_names(c("date", name))
}


cur_list <- list(CNY, ZAR, BRL, INR, RUB) %>%
  map(cum_returns)

cur_list %>%
  reduce(function(x, y) merge(x, y, by = "date")) %>%
  gather(currency, price, -date) %>%
  ggplot(aes(x = date, y = price, colour = currency)) +
  geom_line(size = 1) +
  labs(x = NULL, y = NULL,
       title = "Desvalorização das moedas de Brasil, China, Índia, Rússia e África do Sul em Dólar",
       subtitle = "Período: 2020/jan - 2020/jul",
       caption = "Fonte: BCB") +
  theme(legend.position = "top", legend.title = element_blank())


cur_ret_list <- list(CNY, ZAR, BRL, INR, RUB) %>%
  map(compute_returns)

cur_ret_list %>%
  reduce(function(x, y) merge(x, y, by = "date")) %>%
  gather(currency, price, -date) %>%
  ggplot(aes(x = price, fill = currency)) +
  geom_histogram(bins = 30) +
  facet_wrap(. ~ currency, nrow = length(cur_ret_list)) +
  labs(x = NULL, y = NULL,
       title = "Histogramas de moedas",
       caption = "Fonte: BCB") +
  theme(legend.position = "top", legend.title = element_blank())

