library(shiny)
library(shinydashboard)
library(dplyr)
library(highcharter)
library(shinyWidgets)
library(DT)

Sys.setenv("R_CONFIG_ACTIVE" = "default")
app_config <- config::get()
conn <- tychobratools::db_connect(app_config$db)

options(encoding = 'UTF-8')

lexique_data <- list(
  one = readRDS("data/lexique_len_1.RDS"),
  two = readRDS("data/lexique_len_2.RDS"),
  three = readRDS("data/lexique_len_3.RDS"),
  four = readRDS("data/lexique_len_4.RDS"),
  five = readRDS("data/lexique_len_5.RDS")
)
