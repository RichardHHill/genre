
observeEvent(input$submit_word, {
  info <- strsplit(input$add_word, " ")[[1]]
  
  if (length(info) != 2) {
    session$sendCustomMessage(
      "show_toast",
      message = list(
        type = "error",
        title = "Invalid word",
        message = NULL
      )
    )
  } else if (!(info[[2]] %in% c("m", "f"))) {
    session$sendCustomMessage(
      "show_toast",
      message = list(
        type = "error",
        title = "Genre must be \"m\" or \"f\"",
        message = NULL
      )
    )
  } else {
    out <- list(
      word = info[[1]],
      genre = info[[2]]
    )
    
    tryCatch({
      tychobratools::add_row(conn, "genre", out)
    }, error = function(error) {
      session$sendCustomMessage(
        "show_toast",
        message = list(
          type = "error",
          title = "Error adding word",
          message = NULL
        )
      )
      print(error)
    })
    
    updateTextInput(session, "add_word", value = "")
  }
})

words_table <- reactiveVal(
  conn %>% 
    tbl("genre") %>% 
    collect
)

suffix_chart_prep <- reactive({
  length <- input$suffix_length
  words_table <- words_table()
  words <- words_table$word[nchar(words_table$word) >= length] 
  suffixes <- substr(words, nchar(words) - length + 1, nchar(words)) %>% 
    unique
  
  male <- lapply(suffixes, function(x) {
    words_table %>% 
      filter(
        genre == "m",
        endsWith(word, x)
        ) %>% 
      nrow()
  })
  
  femelle <- lapply(suffixes, function(x) {
    words_table %>% 
      filter(
        genre == "f",
        endsWith(word, x)
      ) %>% 
      nrow()
  })
  
  list(male = male, femelle = femelle, suffixes = suffixes)
})

output$suffix_chart <- renderHighchart({
  out <- suffix_chart_prep()
  print(out)
  
  highchart() %>% 
    hc_chart(type = "column") %>% 
    hc_plotOptions(
      column = list(
        stacking = "normal"
      )
    ) %>% 
    hc_xAxis(
      categories = out$suffixes
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
