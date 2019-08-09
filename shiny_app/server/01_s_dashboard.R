
observeEvent(input$submit_word, {
  info <- strsplit(input$add_word, " ")[[1]]
  
  if (length(info) != 2) {
    print("invalid format")
  } else if (!(info[[2]] %in% c("m", "f"))) {
    print("genre must be m or f")
  } else {
    out <- tibble(
      word = info[[1]],
      genre = info[[2]]
    )
    print(out)
    
    updateTextInput(session, "add_word", value = "")
  }
})
