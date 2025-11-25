source("scripts/helpers.R")

# codigo
eurocup_stats <- GET(Sys.getenv("JSON_STATS_EUROCUP"), query = list()) %>%
  content() %>%
  pluck("players") %>%
  tibble(value = .) %>%
  unnest_wider(value) %>%
  unnest_wider(player) %>%
  unnest_wider(team, names_sep = "_") %>%
  mutate(a_fecha = today, .before = "playerRanking")
