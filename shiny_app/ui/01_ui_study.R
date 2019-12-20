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
    fluidRow(
      column(
        3,
        actionButton("quiz_1_20", "1 - 20")
      )
    )
  )
)