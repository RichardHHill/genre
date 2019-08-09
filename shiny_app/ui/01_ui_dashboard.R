tabItem(
  tabName = "dashboard",
  fluidRow(
    column(
      2,
      textInput("add_word", "Add Word"),
      actionButton("submit_word", "Submit")
    )
  ),
  h1("Gonna do some analytics")
)