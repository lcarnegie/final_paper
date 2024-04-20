#### Preamble ####
# Purpose: Simulates Spotify API dataset
# Author: Luca Carnegie
# Date: 18 April 2024
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(tidyverse)
library(stringi)
library(ggplot2)
library(beepr)
library(broom)
library(broom.mixed)
library(knitr)
library(modelsummary)
library(purrr)
library(rstanarm)
library(testthat)
library(tidyverse)


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


## Test simulated Data 

# 1. Summary Statistics Check
summary_stats <- simulated_data |> 
  summarise(across(everything(), list(mean = mean, sd = sd, min = min, max = max)))
print(summary_stats)

# 2. Data Integrity Check (Verify that the data types and formats are correct)
data_types <- sapply(simulated_data, class)
print(data_types)

# 3. Missing Values Test 
missing_vals <- sum(is.na(simulated_data))
print(missing_vals)

# 4. Uniqueness Test
duplicated_songs <- simulated_data$song |> 
                           duplicated() |> 
                           sum()

duplicated_artists <- simulated_data$artist |> 
                               duplicated() |> 
                               sum()

print(c(duplicated_songs, duplicated_artists))

# 5. Range Validation Test
range_checks <- sapply(simulated_data[c("energy", "valence", "danceability", "liveness", "instrumentalness")], 
                       function(x) all(x >= 0 & x <= 1))
print(range_checks)


## Simulate some graphs (because the API kicked me out lol)

## Liveness
ggplot(simulated_data, aes(x = liveness)) +
  geom_histogram(bins = 45, fill = "blue", color = "black") + # You can adjust the number of bins as needed
  labs(title = "Histogram of Liveness",
       x = "Liveness",
       y = "Density") +
  theme_minimal()

## Popularity
ggplot(simulated_data, aes(x = popularity)) +
  geom_histogram(bins = 45, fill = "blue", color = "black") + # Adjust the number of bins as needed
  labs(title = "Histogram of Popularity",
       x = "Popularity",
       y = "Density") +
  theme_minimal()

# Explicit or Not 

ggplot(simulated_data, aes(x = explicit)) +
  geom_bar(fill = "blue", color = "black") +
  labs(title = "Count of Explicit vs Non-Explicit Songs",
       x = "Explicit",
       y = "Count") +
  theme_minimal()

# Try doing a model

sim_run_data_first_model_rstanarm <-
  stan_glm(
    formula = popularity ~ energy + valence + danceability + liveness + explicit + instrumentalness + duration_ms, 
    data = simulated_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5),
    prior_intercept = normal(location = 0, scale = 2.5),
    prior_aux = exponential(rate = 1),
    seed = 853
  )

beep()

saveRDS(
  sim_run_data_first_model_rstanarm,
  file = "sim_run_data_first_model_rstanarm.rds"
)






