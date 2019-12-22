
fluidPage(
  br(),
  fluidRow(
    column(
      2,
      actionButton("end_quiz", "End Quiz", style = "color: #ffffff; background-color: #c62300")
    )
  ),
  div(
    id = "quiz_content",
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
        6,
        align = "right",
        actionButton(
          "quiz_select_f",
          "Femelle (f)",
          style = "background-color: #F7AC2A; width: 300px; height: 300px; font-size: 25px;"
        )
      ),
      column(
        6,
        actionButton(
          "quiz_select_m",
          "Mâle (m)",
          style = "background-color: #DC99F3; width: 300px; height: 300px; font-size: 25px;"
        )
      )
    ),
    br(),
    fluidRow(
      column(5),
      valueBoxOutput("quiz_answer_feedback", width = 2)
    ),
    fluidRow(
      column(
        12,
        align = "center",
        actionButton("see_quiz_results", "See Results") %>% hidden()
      )
    )
  ),
  div(
    id = "quiz_results_box",
    fluidRow(
      column(
        12,
        align = "center",
        h1("Quiz Results")
      )
    ),
    fluidRow(
      column(
        4,
        offset = 4,
        align = "center",
        DTOutput("quiz_results_table")
      )
    )
  ) %>% hidden
)