tabItem(
  tabName = "single_word",
  fluidRow(
    column(
      2,
      textInput("check_single_word", "Word"),
      actionButton("submit_single_word", "Submit")
    ),
    column(
      10,
      uiOutput("single_word_accent_buttons")
    )
  ),
  br(),
  uiOutput("word_breakdown")
)