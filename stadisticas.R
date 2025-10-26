#librerias
library(httr)
library(tidyverse)

# fecha y hora de la úrltima extracción
today <- format(as.POSIXct(Sys.time(), tz = "UTC"),
                                       tz = "Europe/Madrid", usetz = FALSE,
                                       format = "%d-%m-%Y %H:%M:%S")

# asegurar que la carpeta data existe
if (!dir.exists("data")) dir.create("data")

#codigo
euroligaStats <- GET(Sys.getenv("JSON_STATS_EUROLEAGUE"), query = list()) %>%
  content() %>% 
  pluck("players") %>%
  tibble(value = .) %>%
  unnest_wider(value) %>% 
  unnest_wider(player) %>% 
  unnest_wider(team, names_sep = "_") %>% 
  mutate(a_fecha = today, .before = "playerRanking" )

#escribir el dataframe en la carpeta "data/"
write.csv(euroligaStats, "data/euroligaStats.csv", row.names = F)
