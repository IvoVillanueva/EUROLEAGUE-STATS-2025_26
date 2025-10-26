library(tidyverse)
library(httr)
library(jsonlite)
library(chromote)
library(rvest)
library(curl)

euroliga_stats <- function(type){

url <- paste0("https://feeds.incrowdsports.com/provider/euroleague-feeds/v3/competitions/E/statistics/players/",type,
              "?seasonMode=Single&limit=1000&sortDirection=descending&seasonCode=E2025&statisticMode=perGame&statisticSortMode=perGame")

raw_players <- httr::GET(url, query = list()) %>%
  httr::content()

players <- purrr::pluck(raw_players, "players") %>%
  dplyr::tibble(value=.) %>%
  tidyr::unnest_wider(value) %>% 
  unnest_wider(player) %>% 
  unnest_wider(team, names_sep = "_")
}

map_df("misc",euroliga_stats)

library(tidyverse)
library(httr)

euroliga_stats <- function(
    type = c("traditional", "advanced", "misc", "scoring"),
    season = "E2025"
){
  type <- match.arg(type)
  
  url <- paste0(
    "https://feeds.incrowdsports.com/provider/euroleague-feeds/v3/competitions/E/statistics/players/",
    type,
    "?seasonMode=Single&limit=1000&sortDirection=descending&seasonCode=", season,
    "&statisticMode=perGame&statisticSortMode=perGame"
  )
  
  raw_players <- httr::GET(url) %>% httr::content()
  
  purrr::pluck(raw_players, "players") %>%
    tibble(value = .) %>%
    tidyr::unnest_wider(value) %>%
    unnest_wider(player) %>%
    unnest_wider(team, names_sep = "_") %>%
    dplyr::mutate(stat_type = type)
}

# Ejemplo:
df <- purrr::map_dfr(c("traditional","advanced","misc","scoring"), euroliga_stats)



write_csv(players, "euroliga.csv")



enlaces <- "https://www.euroleaguebasketball.net/es/euroleague/stats/players/?size=1000&viewType=traditional&statisticMode=perGame&seasonCode=E2025&seasonMode=Single&sortDirection=descending"

b <- ChromoteSession$new()
b$Page$navigate("https://www.euroleaguebasketball.net/es/euroleague/stats/players/?size=1000&viewType=traditional&statisticMode=perGame&seasonCode=E2025&seasonMode=Single&sortDirection=descending")
b$Page$loadEventFired()        # espera a que cargue
html <- b$DOM$getDocument()$root$nodeId |> 
  (\(id) b$DOM$getOuterHTML(nodeId = id)$outerHTML)()

page <- read_html(html)

# ahora ya hay todo el contenido renderizado https://www.euroleaguebasketball.net/es/euroleague/players/will-clyburn/004888/

enlaces_df <- tibble(
name = page %>% html_elements("p.complex-stat-table_longValue__c7emT") %>% html_text(trim = TRUE),
link =paste0("https://www.euroleaguebasketball.net", page %>% html_elements("a.complex-stat-table_playerLink__y9Nyp") %>% html_attr("href"))
)


link <- enlaces_df %>% 
  filter(str_detect(name, "VEZENKOV")) %>% 
  pull(link)

library(tidyverse)
library(httr)

euroliga_stats <- function(type = c("traditional","advanced","misc","scoring"),
                           season = 2025) {
  type <- match.arg(type)
  scodes <- paste0("E", sub("^E", "", as.character(season)))  # normaliza: 2025 -> E2025
  
  purrr::map_dfr(scodes, \(sc) {
    url <- paste0(
      "https://feeds.incrowdsports.com/provider/euroleague-feeds/v3/competitions/E/statistics/players/",
      type,
      "?seasonMode=Single&limit=1000&sortDirection=descending&seasonCode=", sc,
      "&statisticMode=perGame&statisticSortMode=perGame"
    )
    
    httr::GET(url) %>% httr::content() %>%
      purrr::pluck("players") %>%
      tibble(value = .) %>%
      tidyr::unnest_wider(value) %>%
      unnest_wider(player) %>%
      unnest_wider(team, names_sep = "_") %>%
      dplyr::mutate(season = sub("^E","",sc), .before = 1)  # guardo la temporada sin “E”
  })
}
df_misc_sel   <- euroliga_stats("misc", season = c(2010:2025))



