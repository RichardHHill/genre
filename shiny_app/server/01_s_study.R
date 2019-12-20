
quiz_questions <- reactiveVal(NULL)

observeEvent(input$quiz_1_20, {
  quiz_questions(1:20)
  
  showElement("quiz_page")
  hideElement("main_page")
})
