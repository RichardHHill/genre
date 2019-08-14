
selected_data <- reactive(
  lexique_data[[input$lexique_suffix_length]] %>% 
    mutate(
      total = male + femelle,
      percent_male = male / (total) * 100
    ) %>% 
    filter(
      percent_male >= input$percent_male_range[1],
      percent_male <= input$percent_male_range[2],
      if (is.na(input$min_words)) TRUE else total >= input$min_words,
      if (is.na(input$max_words)) TRUE else total <= input$max_words
    )
)

output$lexique_suffix_table <- renderDT({
  datatable(
    selected_data(),
    rownames = FALSE,
    colnames = c("Mâle", "Femelle", "Suffixe", "% Mâle")
  ) %>% formatRound(
    4,
    digits = 2
  )
})
