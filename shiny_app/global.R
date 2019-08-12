library(shiny)
library(shinydashboard)
library(dplyr)
library(highcharter)

Sys.setenv("R_CONFIG_ACTIVE" = "default")
app_config <- config::get()
conn <- tychobratools::db_connect(app_config$db)
