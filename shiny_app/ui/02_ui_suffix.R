tabItem(
  tabName = "suffix_analysis",
  fluidRow(
    box(
      title = "Filters",
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
            "Chart Order",
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
          numericInput("min_words", "Min Words", 100, min = 0)
        ),
        column(
          4,
          numericInput("max_words", "Max Words", NA, min = 0)
        )
      ),
      br(),
      fluidRow(
        column(
          12,
          align = "center",
          h3("Use these filters to analyze genre frequencies of different suffixes. Click on the graph or table to see all words of a single suffix.")
        )
      )
    ),
    box(
      title = "Suffix Table",
      DTOutput("lexique_suffix_table")
    )
  ),
  fluidRow(
    box(
      width = 12,
      title = "Suffix Chart",
      highchartOutput("lexique_suffix_chart")
    )
  ),
  fluidRow(
    box(
      width = 12,
      title = "Suffix Drilldown",
      fluidRow(
        column(
          2,
          offset = 5,
          align = "center",
          textInput("drilldown_suffix", "")
        )
      ),
      DTOutput("suf_table")
    )
  )
)