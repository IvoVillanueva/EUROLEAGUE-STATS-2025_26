source(scripts/helpers.R)

#codigo
euroliga_stats <- GET(Sys.getenv("JSON_STATS_EUROLEAGUE"), query = list()) %>%
  content() %>% 
  pluck("players") %>%
  tibble(value = .) %>%
  unnest_wider(value) %>% 
  unnest_wider(player) %>% 
  unnest_wider(team, names_sep = "_") %>% 
  mutate(a_fecha = today, .before = "playerRanking" )
