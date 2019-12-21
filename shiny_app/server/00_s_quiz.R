
observeEvent(input$end_quiz, {
  hideElement("quiz_page")
  showElement("main_page")
  
  hideElement("quiz_results_box")
  showElement("quiz_content")
  
  last_question(NULL)
  quiz_questions_table(NULL)
})

current_question <- reactiveVal(list(word = "", number = 1))
last_question <- reactiveVal(NULL)
quiz_questions_table <- reactiveVal(NULL)
  
observeEvent(question_numbers(), {
  req(length(question_numbers()) > 0)
  out <- lexique[question_numbers(), ]
  
  out <- out[sample(nrow(out)), ] %>% 
    mutate(
      number = seq_len(nrow(out)),
      correct = TRUE
    )
  
  current_question(list(word = out$word[[1]], number = 1))
  
  quiz_questions_table(out)
})

observeEvent(input$quiz_select_m, {
  n <- current_question()$number
  q <- quiz_questions_table()[n, ]
  
  if (n == length(question_numbers())) {
    showElement("see_quiz_results")
  } else {
    next_q <- quiz_questions_table()[n + 1, ]
    
    current_question(list(word = next_q$word, number = q$number + 1))
  }
  
  if (q$genre == "m") {
    last_question(list(correct = TRUE, word = q$word, genre = "Mâle"))
  } else {
    last_question(list(correct = FALSE, word = q$word, genre = "Femelle"))
    
    new_table <- quiz_questions_table()
    new_table$correct[[n]] <- FALSE
    quiz_questions_table(new_table)
  }
})

observeEvent(input$quiz_select_f, {
  n <- current_question()$number
  q <- quiz_questions_table()[n, ]
  
  if (n == length(question_numbers())) {
    showElement("see_quiz_results")
  } else {
    next_q <- quiz_questions_table()[n + 1, ]
    
    current_question(list(word = next_q$word, number = q$number + 1))
  }
  
  if (q$genre == "f") {
    last_question(list(correct = TRUE, word = q$word, genre = "Femelle"))
  } else {
    last_question(list(correct = FALSE, word = q$word, genre = "Mâle"))
    
    new_table <- quiz_questions_table()
    new_table$correct[[n]] <- FALSE
    quiz_questions_table(new_table)
  }
})

output$quiz_answer_feedback <- renderValueBox({
  req(current_question()$number > 1)
  if (last_question()$correct) {
    v <- "Correct"
    color <- "green"
  } else {
    v <- "Incorrect"
    color <- "red"
  }
  
  valueBox(
    v,
    paste0("\"", last_question()$word, "\" is ", last_question()$genre),
    color = color
  )
})

output$quiz_current_word <- renderText({
  paste0(current_question()$number, ". ", current_question()$word)
})


observeEvent(input$see_quiz_results, {
  showElement("quiz_results_box")
  hideElement("quiz_content")
})

output$quiz_results_table <- renderDT({
  out <- quiz_questions_table() %>% 
    select(number, word, genre, correct)
  
  datatable(
    out
  )
})