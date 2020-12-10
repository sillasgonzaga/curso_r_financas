
library(xts)
library(rbcb)
library(tidyverse)
library(PerformanceAnalytics)
library(bizdays)

bizdays.options$set(default.calendar = "Brazil/ANBIMA")

currency <- "USD"

c_ <- get_currency(currency, "2017-01-01", "2020-11-30", as = "xts")

return_ <- c_ %>% Ask() %>% Return.calculate("log")

ix <- return_[which.max(return_)] %>% index()

return_[bizseq(bizdays::offset(ix, -6), ix)] %>%
  fortify.zoo() %>%
  set_names(c("Date", "Return")) %>%
  mutate(Currency = currency)

# df <- fortify.zoo(return_[bizseq(bizdays::offset(ix, -6), ix)])
# df <- set_names(df, c("Date", "Return"))
# mutate(df, Currency = currency)
