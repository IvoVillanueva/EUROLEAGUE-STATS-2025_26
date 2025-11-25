source("scripts/stadisticas_eurocup.R")
source("scripts/stadisticas_euroleague.R")


# escribir csvs
write.csv(euroliga_stats, "data/euroleague/euroliga_stats.csv", row.names = F)
write.csv(eurocup_stats, "data/eurocup/eurocup_stats.csv", row.names = F)
