
question_numbers <- reactiveVal(NULL)

output$quiz_buttons <- renderUI({
  lapply(1:60, function(i) {
    brightness <- ((i - 1) %/% 6 / 10 + 1) / 2
    
    red <- if (i %% 6 %in% c(1, 2, 0)) brightness else 0
    green <- if (i %% 6 %in% 2:4) brightness else 0
    blue <- if (i %% 6 %in% c(4, 5, 0)) brightness else 0
    
    column(
      2,
      align = "center",
      actionButton(
        paste0("quiz_button", i * 20 - 19, "_", i * 20), 
        paste0(i * 20 - 19, "-", i * 20),
        style = paste0("color: #ffffff; background-color: ", rgb(red, green, blue), "; margin: 10px; width: 150px; height: 50px")
      )
    )
  })
})

observeEvent(input$quiz_1_20, {
  question_numbers(1:20)
  
  showElement("quiz_page")
  hideElement("main_page")
})
