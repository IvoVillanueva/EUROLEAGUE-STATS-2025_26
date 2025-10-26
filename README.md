# 🏀 Euroleague Traditional Stats Archive

Este repositorio **recopila y actualiza automáticamente las estadísticas tradicionales de la Euroliga**, utilizando los datos proporcionados por la API de [Euroleague Stats](https://www.euroleaguebasketball.net/) (a través de un endpoint definido como secreto en GitHub Actions).

El archivo `euroligaStats.csv` se actualiza en las fechas programadas y contiene una columna que indica la **fecha y la hora de la última actualización**.

---

## 📋 Qué hace este repositorio

- Ejecuta un script en R (`stadisticas.R`) que obtiene las estadísticas de jugadores desde una **URL secreta** (`JSON_STATS_EUROLEAGUE`).
- Procesa los datos con `httr` y `tidyverse`, desanidando la información de jugadores y equipos.
- Añade una columna llamada **`a_fecha`**, que indica **la fecha en la que se actualizaron los datos**.
- Sobrescribe el archivo `data/euroligaStats.csv` con la versión más reciente.
- Se ejecuta automáticamente de **martes a sábado a las 03:00 (hora de Madrid)**, o manualmente desde la pestaña *Actions* de GitHub.
- Si hay cambios, los **commitea y empuja automáticamente** al repositorio.

---

## ⚙️ Cómo funciona

1. **GitHub Actions** inicia el flujo de trabajo:
   - Automáticamente según el cron configurado (`0 1` y `0 2` UTC → 03:00 hora de Madrid).
   - Manualmente mediante *Run workflow*.
2. Configura un entorno **R (versión release)** con las librerías necesarias (`tidyverse`, `httr`).
3. Ejecuta el script `stadisticas.R`:
   - Lee la URL desde la variable de entorno `JSON_STATS_EUROLEAGUE`.
   - Extrae los datos JSON con `httr::GET()` y los transforma con `tidyverse`.
   - Añade la columna `a_fecha` con la fecha actual del sistema.
   - Sobrescribe el CSV `data/euroligaStats.csv`.
4. Si hay cambios, hace **commit** y **push** automáticos al repositorio.

---

## 🔐 Variables y secretos

El workflow usa una variable secreta llamada:

- `JSON_STATS_EUROLEAGUE` → URL del endpoint con los datos de jugadores.

---

## 🗓️ Programación automática

El workflow se ejecuta automáticamente:
- **Martes a sábado a las 03:00 (hora de Madrid)**  
  (equivalente a `01:00 UTC` en verano y `02:00 UTC` en invierno)


