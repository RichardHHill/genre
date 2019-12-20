
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
    filter(word == !!word) %>% 
    pull(genre)
  
  table_prep <- bind_rows(lapply(seq_len(min(5, nchar(word))), function(x) {
    lexique_data[[x]] %>% 
      filter(suffixe == substr(word, nchar(word) - x + 1, nchar(word))) %>% 
      mutate(percent_male = male / (male + femelle) * 100) %>% 
      select(suffixe, male, femelle, percent_male)
  }))
  
  if (length(genre) == 0) {
    genre <- ""
    word <- "Word not found"
  }
  
  
  output$word_breakdown_table <- renderDT({
    datatable(
      table_prep,
      rownames = FALSE,
      colnames = c("Suffixe", "Male", "Femelle", "% Male")
    )
  })
  
  output$word_breakdown_chart <- renderHighchart({
    
    highchart() %>% 
      hc_chart(type = "line") %>% 
      hc_yAxis(min = 0, max = 100) %>% 
      hc_add_series(
        table_prep$percent_male
      )
  })
  
  output$word_breakdown <- renderUI({
    fluidRow(
      box(
        column(
          12,
          align = "center",
          h2(word),
          br(),
          h3(paste0("Genre: ", genre)),
          br(),
          DTOutput("word_breakdown_table")
        )
      ),
      box(
        column(
          12,
          highchartOutput("word_breakdown_chart")
        )
      )
    )
  })
})
