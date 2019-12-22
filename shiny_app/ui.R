
head <- dashboardHeader(
  title = "Genre",
  tags$li(
    class = "dropdown"
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebarmenu",
    menuItem(
      text = "Study",
      tabName = "study"
    ),
    menuItem(
      text = "Suffix Data",
      tabName = "suffix_analysis"
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
  shinyjs::useShinyjs(),
  tabItems(
    source("ui/01_ui_study.R", local = TRUE)$value,
    source("ui/02_ui_suffix.R", local = TRUE)$value,
    source("ui/03_ui_single_word.R", local = TRUE)$value
  )
)

div(
  div(
    id = "main_page",
    dashboardPage(
      head,
      sidebar,
      body,
      skin = "black"
    )
  ),
  div(
    id = "quiz_page",
    source("ui/00_ui_quiz.R", local = TRUE)$value
  ) %>% hidden()
)