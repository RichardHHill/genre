tabItem(
  tabName = "lexique",
  fluidRow(
    box(
      title = "table",
      DTOutput("lexique_suffix_table")
    ),
    box(
      title = "filters",
      fluidRow(
        column(
          6,
          radioButtons(
            "lexique_suffix_length",
            "Suffix Length",
            choices = c("1" = "one", "2" = "two", "3" = "three", "4" = "four", "5" = "five"),
            inline = TRUE
          )
        ),
        column(
          6,
          radioButtons(
            "lexique_order",
            "Order",
            choices = c("Number", "Female", "Male"),
            inline = TRUE
          )
        )
      ),
      fluidRow(
        column(
          4,
          sliderInput("percent_male_range", "% Mâle", min = 0, max = 100, value = c(0, 100), ticks = FALSE)
        ),
        column(
          4,
          numericInput("min_words", "Min Words", NA, min = 0)
        ),
        column(
          4,
          numericInput("max_words", "Max Words", NA, min = 0)
        )
      )
    ),
    box(
      width = 12,
      highchartOutput("lexique_suffix_chart")
    ),
    box(
      width = 12,
      DTOutput("suf_table")
    )
  )
)