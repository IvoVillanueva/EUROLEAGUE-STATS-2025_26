# 🏀 Euroleague Traditional Stats Archive

Este repositorio **recopila y archiva automáticamente las estadísticas tradicionales actualizadas de la Euroliga**, utilizando los datos proporcionados por la API de [Euroleague Stats](https://www.euroleaguebasketball.net/) (a través de un endpoint definido como secreto en GitHub Actions).

Los datos se guardan diariamente como archivos CSV dentro de la carpeta `data/`.

---

## 📋 Qué hace este repositorio

- Ejecuta un script en R (`stadisticas.R`) que obtiene las estadísticas de jugadores desde una **URL secreta** (`JSON_STATS_EUROLEAGUE`).
- Procesa los datos para expandir la información de jugadores y equipos.
- Guarda el resultado como un archivo `euroligaStats.csv` en la carpeta `data/`.
- Se ejecuta automáticamente de **martes a sábado a las 03:00 (hora de Madrid)**, o manualmente desde la pestaña *Actions* de GitHub.
- Si hay nuevos datos, los **commitea y empuja automáticamente** al repositorio.

---

## ⚙️ Cómo funciona

1. **GitHub Actions** inicia el flujo de trabajo:
   - Automáticamente según el cron configurado (`0 1` y `0 2` UTC → 03:00 hora de Madrid).
   - Manualmente mediante *Run workflow*.
2. Configura un entorno **R (versión release)** con las librerías necesarias (`tidyverse`, `httr`).
3. Ejecuta el script `stadisticas.R`:
   - Lee la URL de la variable de entorno `JSON_STATS_EUROLEAGUE`.
   - Extrae los datos JSON con `httr::GET()` y los transforma con `tidyverse`.
   - Guarda el CSV actualizado en `data/euroligaStats.csv`.
4. Si hay cambios, hace **commit** y **push** automáticos al repositorio.

