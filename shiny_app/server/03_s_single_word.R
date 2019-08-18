
single_word_accents <- reactive("àâæèéêëîïôùûüçœ")

output$single_word_accent_buttons <- renderUI({
  accents <- single_word_accents()
  lapply(seq_len(nchar(accents)), function(i) {
    char <- substr(accents , i, i)
    actionButton(paste0("single_word_accent_button_", i), char, width = "3%")
  })
})

observe({
  lapply(seq_len(nchar(single_word_accents())), function(i) {
    observeEvent(input[[paste0("single_word_accent_button_", i)]], {
      updateTextInput(session, "check_single_word", value = paste0(input$check_single_word, substr(single_word_accents(), i, i)))
    })
  })
})

observeEvent(input$submit_single_word, {
  word <- input$check_single_word
  
  genre <- complete_lexique %>% 
    filter(word == word) %>% 
    pull(genre)
  
  output$word_breakdown <- renderUI({
    fluidRow(
      column(
        12,
        align = "center",
        h2(word),
        br(),
        h3(paste0("Genre: ", genre))
      )
    )
  })
})
