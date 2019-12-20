
head <- dashboardHeader(
  title = "Dashboard",
  tags$li(
    class = "dropdown"
  )
)

sidebar <- dashboardSidebar(
  pickerInput(
    "language_selected",
    "Language",
    choices = list(
      "French" = "french",
      "Spanish" = "spanish",
      "German" = "german",
      "Italian" = "italian"
      )
  ),
  sidebarMenu(
    id = "sidebarmenu",
    menuItem(
      text = "Study",
      tabName = "study"
    ),
    menuItem(
      text = "Lexique",
      tabName = "lexique"
    ),
    menuItem(
      text = "Word Breakdown",
      tabName = "single_word"
    )
  )
)

body <- dashboardBody(
  tags$head(
    tags$script(src = "custom.js"),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"),
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css")
  ),
  shinyalert::useShinyalert(),
  tabItems(
    source("ui/01_ui_study.R", local = TRUE)$value,
    source("ui/02_ui_lexique.R", local = TRUE)$value,
    source("ui/03_ui_single_word.R", local = TRUE)$value
  )
)


dashboardPage(
  head,
  sidebar,
  body,
  skin = "black"
)
