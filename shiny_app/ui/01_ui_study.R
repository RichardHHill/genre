tabItem(
  tabName = "study",
  box(
    width = 12,
    fluidRow(
      column(
        12,
        align = "center",
        h1("Select Quiz")
      )
    ),
    br(),
    fluidRow(
      uiOutput("quiz_buttons")
    )
  )
)