
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
      updateTextInput(session, "single_word", value = paste0(input$single_word, substr(single_word_accents(), i, i)))
    })
  })
})

single_word_genre <- reactive({
  complete_lexique %>% 
    filter(word == input$single_word) %>% 
    pull(genre)
})

single_word_breakdown <- reactive({
  word <- input$single_word
  
  bind_rows(lapply(seq_len(min(5, nchar(word))), function(x) {
    lexique_data[[x]] %>% 
      filter(suffixe == substr(word, nchar(word) - x + 1, nchar(word))) %>% 
      mutate(percent_male = male / (male + femelle) * 100) %>% 
      select(suffixe, male, femelle, percent_male)
  }))
})
  
output$single_word_text <- renderText(input$single_word)

output$genre_text <- renderText({
  if (length(single_word_genre()) == 0) {
    "Word Not Found"
  } else {
    paste0("Genre: ", single_word_genre())
  }
})

output$word_breakdown_table <- renderDT({
  out <- single_word_breakdown()
  req(nrow(out) > 0)
  
  datatable(
    out,
    rownames = FALSE,
    colnames = c("Suffixe", "Mâle", "Femelle", "% Mâle")
  ) %>% 
    formatRound(4)
})

output$word_breakdown_chart <- renderHighchart({
  out <- single_word_breakdown()
  req(nrow(out) > 0)
  
  highchart() %>% 
    hc_title(text = "% Mâle With Same Ending") %>%
    hc_chart(type = "area") %>% 
    hc_yAxis(min = 0, max = 100) %>% 
    hc_xAxis(
      title = list(text = "Suffix Length"),
      tickInterval = 1
    ) %>% 
    hc_add_series(
      name = "% Mâle",
      data = out$percent_male,
      tooltip = list(
        valueDecimals = 2
      )
    )
})
