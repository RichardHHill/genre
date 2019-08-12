
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
