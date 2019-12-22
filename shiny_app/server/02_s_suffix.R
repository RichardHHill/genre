
selected_data <- reactiveVal(NULL)

observe({
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
  
  selected_data(out)
  
  if (!is.null(selected_data)) replaceData(lexique_suffix_table_proxy, out, rownames = FALSE)
})

output$lexique_suffix_table <- renderDT({
  datatable(
    isolate(selected_data()),
    rownames = FALSE,
    colnames = c("Mâle", "Femelle", "Suffixe", "Total", "% Mâle"),
    selection = "single",
  ) %>% formatRound(
    5,
    digits = 2
  )
})

lexique_suffix_table_proxy <- dataTableProxy("lexique_suffix_table")

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

observeEvent(input$lexique_suffix_table_rows_selected, {
  suffix <- selected_data()$suffixe[[input$lexique_suffix_table_rows_selected]]
  
  updateTextInput(session, "drilldown_suffix", value = suffix)
})

observeEvent(input$sel_suf, {
  suffix <- as.character(input$sel_suf)
  
  updateTextInput(session, "drilldown_suffix", value = suffix)
})

suf_table_prep <- reactiveVal(NULL)

observe({
  out <- complete_lexique %>% 
    filter(endsWith(word, input$drilldown_suffix)) %>% 
    select(word, genre)
  
  if (is.null(suf_table_prep())) {
    suf_table_prep(out)
  } else {
    replaceData(suf_table_proxy, out, rownames = FALSE)
  }
})

output$suf_table <- renderDT({
  req(suf_table_prep())
  out <- suf_table_prep()
  
  datatable(
    out,
    rownames = FALSE,
    colnames = c("Word", "Genre")
  )
})

suf_table_proxy <- dataTableProxy("suf_table")
