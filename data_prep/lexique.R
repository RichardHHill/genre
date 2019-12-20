library(dplyr)
library(magrittr)

lexique <- readRDS("data_prep/provided/Lexique383.rds") %>% 
  filter(cgram == "NOM", !is.na(genre)) %>% 
  mutate(word = ifelse(substr(ortho, nchar(ortho), nchar(ortho)) %in% c("'", "."), substr(ortho, 1, nchar(ortho) - 1), ortho)) %>% 
  select(word, genre, freqlivres) %>% 
  arrange(desc(freqlivres)) %T>% 
  saveRDS("shiny_app/data/lexique.RDS")

save_for_suffix <- function(length) {
  words <- lexique$word[nchar(lexique$word) >= length] 
  suffixes <- substr(words, nchar(words) - length + 1, nchar(words)) %>% 
    unique
  
  male <- lapply(suffixes, function(x) {
    lexique %>% 
      filter(
        genre == "m",
        endsWith(word, x)
      ) %>% 
      nrow()
  })
  
  femelle <- lapply(suffixes, function(x) {
    lexique %>% 
      filter(
        genre == "f",
        endsWith(word, x)
      ) %>% 
      nrow()
  })
  
  out <- tibble(
    male = unlist(male),
    femelle = unlist(femelle),
    suffixe = suffixes
  )
  
  saveRDS(
    out,
    paste0("shiny_app/data/lexique_len_", length, ".RDS")
  )
}

for (i in 1:5) {
  save_for_suffix(i)
}
