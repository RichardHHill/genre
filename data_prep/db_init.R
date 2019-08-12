
Sys.setenv("R_CONFIG_ACTIVE" = "default")
app_config <- config::get(file = "shiny_app/config.yml")
conn <- tychobratools::db_connect(app_config$db)

query <- "CREATE TABLE genre (
  id              SERIAL PRIMARY KEY,
  time_created    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  word            TEXT,
  genre           TEXT
);"

DBI::dbExecute(conn, query)

DBI::dbDisconnect(conn)
