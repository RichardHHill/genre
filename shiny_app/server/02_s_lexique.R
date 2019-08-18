
selected_data <- reactive({
  out <- lexique_data[[input$lexique_suffix_length]] %>% 
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
  
  if (input$lexique_order == "Number") {
    out %<>% arrange(desc(total))
  } else if (input$lexique_order == "Female") {
    out %<>% arrange(percent_male)
  } else {
    out %<>% arrange(desc(percent_male))
  }
  
  out
})

output$lexique_suffix_table <- renderDT({
  datatable(
    selected_data(),
    rownames = FALSE,
    colnames = c("Mâle", "Femelle", "Suffixe", "Total", "% Mâle")
  ) %>% formatRound(
    5,
    digits = 2
  )
})

output$lexique_suffix_chart <- renderHighchart({
  out <- selected_data()
  
  highchart() %>% 
    hc_chart(type = "column") %>% 
    hc_plotOptions(
      column = list(
        stacking = "normal"
      ),
      series = list(
        allowPointSelect = TRUE,
        point = list(
          events = list(
            #unselect = abb_unselect,
            select = suf_select
          )
        )
      )
    ) %>% 
    hc_xAxis(
      categories = as.list(out$suffixe)
    ) %>% 
    hc_add_series(
      data = out$male,
      name = "male"
    ) %>% 
    hc_add_series(
      data = out$femelle,
      name = "femelle"
    )
})

suf_table_prep <- reactiveVal()

observeEvent(input$sel_suf, {
  suffix <- input$sel_suf
  out <- complete_lexique %>%
    filter(endsWith(word, as.character(input$sel_suf)))
  
  suf_table_prep(out)
})

output$suf_table <- renderDT({
  out <- suf_table_prep()
  
  datatable(
    out,
    rownames = FALSE,
    colnames = c("Word", "Genre")
  )
})
