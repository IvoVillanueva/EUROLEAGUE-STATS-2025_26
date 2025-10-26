#librerias
library(httr)
library(tidyverse)

# asegurar que la carpeta data existe
if (!dir.exists("data")) dir.create("data")

#codigo
euroligaStats <- GET("https://feeds.incrowdsports.com/provider/euroleague-feeds/v3/competitions/E/statistics/players/traditional?seasonMode=Single&limit=1000&sortDirection=descending&seasonCode=E2025&statisticMode=perGame&statisticSortMode=perGame", query = list()) %>%
  content() %>% 
  pluck("players") %>%
  tibble(value = .) %>%
  unnest_wider(value) %>% 
  unnest_wider(player) %>% 
  unnest_wider(team, names_sep = "_")

#escribir el dataframe en la carpeta "data/"
write.csv(euroligaStats, "data/euroligaStats.csv", row.names = F)
