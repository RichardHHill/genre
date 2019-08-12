
head <- dashboardHeader(
  title = "Dashboard",
  tags$li(
    class = "dropdown"
  )
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    id = "sidebarmenu",
    menuItem(
      text = "Dashboard",
      tabName = "dashboard"
    ),
    menuItem(
      text = "Input Words",
      tabName = "input_words"
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
    source("ui/01_ui_dashboard.R", local = TRUE)$value,
    source("ui/02_ui_input_words.R", local = TRUE)$value
  )
)


dashboardPage(
  head,
  sidebar,
  body,
  skin = "black"
)
