
observeEvent(c(input$end_quiz, input$key_esc), {
  hideElement("quiz_page")
  showElement("main_page")
  
  hideElement("quiz_results_box")
  showElement("quiz_content")
  
  last_question(NULL)
  quiz_questions_table(NULL)
  question_numbers(NULL)
})

current_question <- reactiveVal(list(word = "", number = 1))
last_question <- reactiveVal(NULL)
quiz_questions_table <- reactiveVal(NULL)
  
observeEvent(question_numbers(), {
  req(length(question_numbers()) > 0)
  out <- complete_lexique[question_numbers(), ]
  
  out <- out[sample(nrow(out)), ] %>% 
    mutate(
      number = seq_len(nrow(out)),
      correct = TRUE
    )
  
  current_question(list(word = out$word[[1]], number = 1))
  
  quiz_questions_table(out)
})

observeEvent(c(input$quiz_select_m, input$key_m), {
  req(quiz_questions_table())
  
  n <- current_question()$number
  req(n <= length(question_numbers()))
  
  q <- quiz_questions_table()[n, ]
  
  if (n == length(question_numbers())) {
    showElement("see_quiz_results")
    current_question(list(word = "", number = n + 1))
  } else {
    next_q <- quiz_questions_table()[n + 1, ]
    current_question(list(word = next_q$word, number = n + 1))
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

observeEvent(c(input$quiz_select_f, input$key_f), {
  req(quiz_questions_table())
  
  n <- current_question()$number
  req(n <= length(question_numbers()))
  
  q <- quiz_questions_table()[n, ]
  
  if (n == length(question_numbers())) {
    showElement("see_quiz_results")
    current_question(list(word = "", number = n + 1))
  } else {
    next_q <- quiz_questions_table()[n + 1, ]
    current_question(list(word = next_q$word, number = n + 1))
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
  req(quiz_questions_table())
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
  req(question_numbers())
  
  if (current_question()$number > length(question_numbers())) {
    "Quiz Complete"
  } else {
    paste0(current_question()$number, ". ", current_question()$word)
  }
})


observeEvent(c(input$see_quiz_results, input$key_enter), {
  req(quiz_questions_table())
  showElement("quiz_results_box")
  hideElement("quiz_content")
})

output$quiz_results_score <- renderText({
  req(quiz_questions_table())
  
  score <- quiz_questions_table() %>% 
    filter(correct) %>% 
    nrow()
  
  paste0(score, "/", length(question_numbers()))
})

output$quiz_results_table <- renderDT({
  req(quiz_questions_table())
  out <- quiz_questions_table() %>% 
    mutate(genre = ifelse(genre == "m", "Mâle", "Femelle")) %>% 
    mutate(correct = ifelse(correct, "&#9989", "&#10060")) %>% 
    select(word, genre, correct)
  
  datatable(
    out,
    colnames = c("Word", "Genre", "Correct"),
    options = list(
      dom = "t",
      pageLength = length(question_numbers()),
      ordering = FALSE
    ),
    escape = FALSE
  )
})