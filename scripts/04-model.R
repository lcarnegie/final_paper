#### Preamble ####
# Purpose: Models Spotify popularity scores as a function of various audio features
# Author: Luca Carnegie
# Date: April 21, 2024
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01 -download_data.R, 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(beepr)
library(modelsummary)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/dataset.parquet")


### Model data ####

model <-
  lm(
    popularity ~ energy + valence + danceability + explicit + loudness + duration_secs,
    data = analysis_data
  )

summary(sim_run_data_first_model)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


