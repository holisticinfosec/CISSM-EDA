setwd("~/code/R/CISSM-EDA")

library(forecast)
library(fpp2)
library(ggpubr)
library(janitor)
library(tidyverse)
library(tsibble)
library(TTR)

df <- read_csv("CISSM-export.csv")

evtType <- tabyl(df, evtDate, event_type)

df <- as_tibble(evtType)

# create all event tsibble
df |>
  mutate(evtDate = yearmonth(evtDate)) |>
  as_tsibble(index = evtDate) -> AllEvents

# create disruptive events tsibble
AllEvents |> select(evtDate,Disruptive) -> disruptive

# create exploitative events tsibble
AllEvents |> select(evtDate,Exploitative) -> exploitative

# model disruptive events

naive_model_disruptive <- naive(disruptive, h = 12) # RMSE = 22.6, MAE = 15.9
summary(naive_model_disruptive)

ses_model_disruptive <- ses(disruptive$Disruptive, h = 12) # RMSE = 19.5, MAE = 13.9
summary(ses_model_disruptive)

arima_model_disruptive <- auto.arima(disruptive) # RMSE = 18.3, MAE = 13.5
summary(arima_model_disruptive)

# model exploitative events

naive_model_exploitative <- naive(exploitative, h = 12) # RMSE = 20.5, MAE = 15.4
summary(naive_model_exploitative)

ses_model_exploitative <- ses(exploitative$Exploitative, h = 12) # RMSE = 18.8, MAE = 13.9
summary(ses_model_exploitative)

arima_model_exploitative <- auto.arima(exploitative) # RMSE = 18.2, MAE = 13.6
summary(arima_model_exploitative)

# plot

# https://community.rstudio.com/t/can-not-use-autoplot-with-a-tsibble/41297

# plot all event types
autoplot(as.ts(AllEvents))

# plot disruptive events only
autoplot(as.ts(disruptive))

# forecast disruptive models with individual plots
forecast(naive_model_disruptive) %>% autoplot()
forecast(ses_model_disruptive) %>% autoplot()
forecast(arima_model_disruptive) %>% autoplot()

# forecast disruptive models with joined plot
naiveDIS = forecast(naive_model_disruptive) %>% autoplot()
sesDIS = forecast(ses_model_disruptive) %>% autoplot()
arimaDIS = forecast(arima_model_disruptive) %>% autoplot()

multi.pageDIS <- ggarrange(naiveDIS, sesDIS, arimaDIS,
                        nrow = 3, ncol = 1)

# plot exploitative events only
autoplot(as.ts(exploitative))

# forecast exploitative models with individual plots
forecast(naive_model_exploitative) %>% autoplot()
forecast(ses_model_exploitative) %>% autoplot()
forecast(arima_model_exploitative) %>% autoplot()

# forecast disruptive models with joined plot
naiveEXP = forecast(naive_model_exploitative) %>% autoplot()
sesEXP = forecast(ses_model_exploitative) %>% autoplot()
arimaEXP = forecast(arima_model_exploitative) %>% autoplot()

multi.pageEXP <- ggarrange(naiveEXP, sesEXP, arimaEXP,
                        nrow = 3, ncol = 1)