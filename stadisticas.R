#librerias
library(httr)
library(tidyverse)

# asegurar que la carpeta data existe
if (!dir.exists("data")) dir.create("data")

#codigo
euroligaStats <- GET("JSON_STATS_EUROLEAGE", query = list() %>%
  content() %>% 
  pluck("players") %>%
  tibble(value = .) %>%
  unnest_wider(value) %>% 
  unnest_wider(player) %>% 
  unnest_wider(team, names_sep = "_")

#escribir el dataframe en la carpeta data
write.csv(euroligaStats, paste0("data/*.csv", row.names = F)
