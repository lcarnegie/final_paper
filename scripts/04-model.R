#### Preamble ####
# Purpose: Models Spotify popularity scores as a function of various audio features
# Author: Luca Carnegie
# Date: April 21, 2024
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01 -download_data.R, 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(modelsummary)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/dataset.parquet")

numeric_data <- analysis_data |> select(-song_name, -artist_name)


### Model data ####

model <-
  lm(
    popularity ~ valence + danceability + mode + explicit + loudness + duration_secs,
    data = numeric_data
  )


#### Save model ####
saveRDS(
  model,
  file = "models/model.rds"
)
