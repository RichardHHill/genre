
fluidPage(
  br(),
  fluidRow(
    column(
      2,
      actionButton("end_quiz", "End Quiz", style = "color: #ffffff; background-color: #c62300")
    )
  ),
  fluidRow(
    column(
      12,
      align = "center",
      h1("Quiz")
    )
  )
)