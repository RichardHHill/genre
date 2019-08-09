
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
