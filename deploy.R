
Sys.setenv(R_CONFIG_ACTIVE = "default")
#Sys.setenv(R_CONFIG_ACTIVE = "production")

rsconnect::deployApp(
  appDir = "shiny_app",
  account = "richardh",
  appName = "genre"
)

