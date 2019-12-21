
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
  ),
  br(),
  fluidRow(
    column(
      12,
      align = "center",
      h2(textOutput("quiz_current_word"))
    )
  ),
  br(),
  fluidRow(
    column(
      4,
      offset = 2,
      align = "center",
      actionButton("quiz_select_m", "Mâle")
    ),
    column(
      4,
      align = "center",
      actionButton("quiz_select_f", "Femelle")
    )
  ),
  br(),
  fluidRow(
    column(5),
    valueBoxOutput("quiz_answer_feedback", width = 2)
  )
)