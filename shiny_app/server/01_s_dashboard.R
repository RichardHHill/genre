
accents <- reactive("àâæèéêëîïôùûüçœ")

output$accent_buttons <- renderUI({
  accents <- accents()
  lapply(seq_len(nchar(accents)), function(i) {
    char <- substr(accents , i, i)
    actionButton(paste0("accent_button_", i), char, width = "3%")
  })
})

observe({
  lapply(seq_len(nchar(accents())), function(i) {
    observeEvent(input[[paste0("accent_button_", i)]], {
      updateTextInput(session, "add_word", value = paste0(input$add_word, substr(accents(), i, i)))
    })
  })
})

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
    
    if (out$word %in% words_table()$word) {
      existing_genre <- words_table()$genre[[match(out$word, words_table()$word)]]
      if (out$genre != existing_genre) {
        shinyalert::shinyalert(
          title = "Word already exists, and with different genre!",
          text = existing_genre,
          closeOnEsc = TRUE,
          closeOnClickOutside = TRUE,
          html = FALSE,
          type = "error",
          showConfirmButton = TRUE,
          showCancelButton = FALSE,
          confirmButtonText = "OK",
          confirmButtonCol = "#3c8dbc",
          timer = 0,
          imageUrl = "",
          animation = TRUE
        )
      } else {
        session$sendCustomMessage(
          "show_toast",
          message = list(
            type = "error",
            title = "Word already input",
            message = NULL
          )
        )
      }
    } else {
      tryCatch({
        tychobratools::add_row(conn, "genre", out)
        words_table_reload_trigger(words_table_reload_trigger() + 1)
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
  }
})

words_table <- reactiveVal()
words_table_reload_trigger <- reactiveVal(0)

observeEvent(words_table_reload_trigger(), {
  words_table(
    conn %>%
      tbl("genre") %>%
      collect
  )
})

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
  
  highchart() %>% 
    hc_chart(type = "column") %>% 
    hc_plotOptions(
      column = list(
        stacking = "normal"
      )
    ) %>% 
    hc_xAxis(
      categories = as.list(out$suffixes)
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
