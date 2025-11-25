source(c("stadisticas_eurocup.R", "stadisticas_euroleague.R"))


# escribir csvs
write.csv(euroliga_stats, "data/euroliga_stats.csv", row.names = F)
write.csv(eurocup_stats, "data/eurocup_stats.csv", row.names = F)
