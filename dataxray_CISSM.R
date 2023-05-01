library(correlationfunnel)
library(dataxray)
library(tidyverse)

setwd("~/code/R/CISSM-EDA")
cissm <- read_csv("CISSM-export.csv")

cissm %>%
  make_xray() %>%
  view_xray()

cissm %>%
  report_xray(data_name = 'CISSM', study = 'ggplot2')