tabItem(
  tabName = "dashboard",
  fluidRow(
    column(
      2,
      textInput("add_word", "Add Word"),
      actionButton("submit_word", "Submit")
    ),
    column(
      10,
      uiOutput("accent_buttons")
    )
  ),
  fluidRow(
    box(
      width = 12,
      fluidRow(
        column(
          2,
          numericInput(
            "suffix_length",
            "Suffix Length",
            value = 1,
            min = 1
          )
        )
      ),
      fluidRow(
        highchartOutput("suffix_chart")
      )
    )
  )
)