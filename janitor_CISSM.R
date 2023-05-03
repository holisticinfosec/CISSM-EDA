setwd("~/code/R/CISSM-EDA")

# janitor, CGPfunctions, vtree

library(CGPfunctions)
library(janitor)
library(tidyverse)
library(vtree)

df <- read.csv("CISSM-export.csv")
str(df)

table(df$event_type)

df %>% 
  count(event_type)

tabyl(df, evtDate, motive)
tabyl(df, evtDate, event_type)

tabyl(df, event_type, motive) %>%
  adorn_percentages("col") %>%
  adorn_pct_formatting(digits = 1)

PlotXTabs2(df, event_type, motive, title = "Event Type by Motive")

vtree(df, "event_type")
vtree(df, "motive", showcount = FALSE)
vtree(df, c("event_type", "motive"), showcount = FALSE)

# References:
# https://www.marsja.se/r-count-the-number-of-occurrences-in-a-column-using-dplyr/ 
# https://stackoverflow.com/questions/55303573/count-new-values-per-date-per-group
# https://www.infoworld.com/article/3573577/how-to-count-by-groups-in-r.html