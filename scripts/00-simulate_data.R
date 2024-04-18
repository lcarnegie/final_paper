#### Preamble ####
# Purpose: Simulates Spotify API dataset
# Author: Luca Carnegie
# Date: 18 April 2024
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(tidyverse)
library(stringi)


# Set seed for reproducibility
set.seed(2024)


#### Simulate data ####

simulated_data <- tibble(
  popularity = sample(0:100, 100, replace = TRUE), 
  song = stri_rand_strings(100, 10), # Random strings of length 10 for song titles
  artist = stri_rand_strings(100, 7), # Random strings of length 7 for artist names
  energy = runif(100, 0, 1), # Uniform distribution between 0 and 1
  valence = runif(100, 0, 1),
  danceability = runif(100, 0, 1),
  liveness = runif(100, 0, 1),
  explicit = sample(0:1, 100, replace = TRUE), # Binary variable, assuming 0 is not explicit, 1 is explicit
  instrumentalness = runif(100, 0, 1),
  duration_ms = sample(150000:300000, 100, replace = TRUE), # Duration in milliseconds, example range
  mode = sample(0:1, 100, replace = TRUE) # Binary variable, assuming 0 is minor, 1 is major
)

# View the first few rows of the simulated data
head(simulated_data)


## Simulate some graphs







