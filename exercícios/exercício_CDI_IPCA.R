
library(tidyverse)
library(rbcb)

x <- get_series(c(IPCA = 433, CDI = 4389), start_date = "2003-01-01")

x$CDI <- x$CDI %>%
  mutate(BOM = as.Date(format(date, "%Y-%m-01"))) %>%
  group_by(BOM) %>%
  summarise(CDI = prod((1 + CDI/100)^(1/252)) - 1) %>%
  mutate(date = BOM, CDI = CDI * 100) %>%
  select(date, CDI)

x %>% reduce(function(x, y) merge(x, y, by = "date")) %>%
  gather(var, value, -date) %>%
  ggplot(aes(x = date, y = value, colour = var)) +
  geom_line(size = 1) +
  geom_point() +
  theme(legend.position = "top", legend.title = element_blank())
