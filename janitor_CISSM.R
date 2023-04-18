setwd("~/code/R/janitor")

library(CGPfunctions)
library(janitor)
library(tidyverse)
library(vtree)

# References:
# https://www.marsja.se/r-count-the-number-of-occurrences-in-a-column-using-dplyr/ 
# https://stackoverflow.com/questions/55303573/count-new-values-per-date-per-group
# https://www.infoworld.com/article/3573577/how-to-count-by-groups-in-r.html

df <- read.csv("CISSM-export.csv")
str(df)
table(df$motive)
table(df$event_type)

df %>% 
  count(event_type)

df %>% 
  count(motive)

df %>% 
  count(actor_type)

tabyl(df, evtDate, motive)
tabyl(df, evtDate, event_type)
evtType <- tabyl(df, evtDate, event_type)

tabyl(df, event_type, motive) %>%
  adorn_percentages("col") %>%
  adorn_pct_formatting(digits = 1)

tabyl(df, event_type, motive, evtDate) %>%
  adorn_percentages("col") %>%
  adorn_pct_formatting(digits = 1)

PlotXTabs(df, evtDate, event_type)
PlotXTabs(df, evt_type, evtDate)

vtree(df, "event_type")
vtree(df, "motive")
vtree(df, c("event_type", "actor_type"),
      fillcolor = c( event_type = "#e7d4e8", actor_type = "#99d8c9"),
      horiz = FALSE)

