tabItem(
  tabName = "single_word",
  fluidRow(
    column(
      2,
      textInput("single_word", "Word", value = "fenêtre")
    ),
    column(
      10,
      uiOutput("single_word_accent_buttons")
    )
  ),
  br(),
  fluidRow(
    box(
      column(
        12,
        align = "center",
        h2(textOutput("single_word_text")),
        br(),
        h3(textOutput("genre_text")),
        br(),
        DTOutput("word_breakdown_table")
      )
    ),
    box(
      column(
        12,
        highchartOutput("word_breakdown_chart")
      )
    )
  )
)