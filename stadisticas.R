library(httr)
library(tidyverse)

euroligaStats <- GET(JSON_STATS_EUROLEAGE) %>%
  content() %>% 
  pluck("players") %>%
  tibble(value = .) %>%
  unnest_wider(value) %>% 
  unnest_wider(player) %>% 
  unnest_wider(team, names_sep = "_")
