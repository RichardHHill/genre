
observeEvent(input$end_quiz, {
  hideElement("quiz_page")
  showElement("main_page")
})

quiz_questions_prep <- reactive({
  out <- lexique[question_numbers(), ]
  
  out[sample(nrow(out)), ]
})

output$quiz_questions <- renderUI({
  lapply(quiz_questions_prep()$word, function(i) {
    fluidRow(
      column(
        4, 
        offset = 2,
        align = "center",
        h3(i)
      ),
      column(
        4,
        align = "center",
        checkboxGroupInput(paste0("question_", i), "", choices = c("Mâle", "Femelle"), inline = TRUE)
      )
    )
  })
})