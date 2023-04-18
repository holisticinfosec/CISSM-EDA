library(correlationfunnel)
library(dataxray)
library(dplyr)
library(tidyverse)

setwd("~/code/R/forecasts")

cissm <- readr::read_csv("CISSM-export.csv")
glimpse(cissm)

cissm %>%
  make_xray() %>%
  view_xray()
