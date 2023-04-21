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

report_xray <- function(data, by = NULL, data_name, study, loc = NULL){
  
  if (is.null(loc)) {
    loc <- getwd()
  } 
  
  if(!dir.exists(loc)) stop (paste0(loc," is not a valid directory"))
  
  report_template <- system.file("templates/report_xray.rmd", package = "dataxray")
  
  report_out <- file.path(loc, paste0(study,"_",data_name,"_xray")) 
  
  params_in <- list(data = data,
                    data_name = data_name,
                    study = study,
                    by = by)
  
  file.copy(report_template, paste0(report_out,".rmd"), overwrite = TRUE)
  
  
  rmarkdown::render(input = paste0(report_out,".rmd"), 
                    output_file = paste0(report_out,".html"),
                    params = params_in)
  report2browser <- paste0(report_out,".html")
  
  browseURL(report2browser)
}