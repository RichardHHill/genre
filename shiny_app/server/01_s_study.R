
question_numbers <- reactiveVal(NULL)

observeEvent(input$quiz_1_20, {
  question_numbers(1:20)
  
  showElement("quiz_page")
  hideElement("main_page")
})
