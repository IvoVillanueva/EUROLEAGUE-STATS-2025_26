library(httr)
library(purrr)
library(tidyr)
library(dplyr)
library(tibble)
library(jsonlite)

# fecha y hora de la úrltima extracción
today <- format(as.POSIXct(Sys.time(), tz = "UTC"),
                tz = "Europe/Madrid", usetz = FALSE,
                format = "%d-%m-%Y %H:%M:%S")

# asegurar que la carpeta data existe
if (!dir.exists("data")) dir.create("data")