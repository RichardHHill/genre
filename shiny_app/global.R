library(shiny)
library(shinydashboard)
library(dplyr)
library(highcharter)
library(shinyWidgets)
library(DT)
library(magrittr)

# Sys.setenv("R_CONFIG_ACTIVE" = "default")
# app_config <- config::get()
# conn <- tychobratools::db_connect(app_config$db)

options(encoding = 'UTF-8')

complete_lexique <- readRDS("data/lexique.RDS")

lexique_data <- list(
  one = readRDS("data/lexique_len_1.RDS"),
  two = readRDS("data/lexique_len_2.RDS"),
  three = readRDS("data/lexique_len_3.RDS"),
  four = readRDS("data/lexique_len_4.RDS"),
  five = readRDS("data/lexique_len_5.RDS")
)

suf_select = JS("function(event) {
  Shiny.setInputValue('sel_suf', { suf: event.target.category.name }, { priority: 'event' });

  // scroll down the page
  $('html, body').animate({scrollTop: $(document).height()}, 'slow');

}")

# abb_unselect = JS("function(event) {
# 
#   Shiny.setInputValue('unsel_state', { abb: event.target['hc-a2'] }, { priority: 'event' });
# }")
