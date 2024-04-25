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
library(broom)
library(broom.mixed)
library(knitr)
library(modelsummary)
library(purrr)
library(testthat)
library(tidyverse)


# Set seed for reproducibility
set.seed(2024)


#### Simulate data ####

num_songs <- 100

simulated_data <- tibble(
  popularity = sample(0:100, num_songs, replace = TRUE),
  song = stri_rand_strings(num_songs, 10), # Random strings of length 10 for song titles
  artist = stri_rand_strings(num_songs, 7), # Random strings of length 7 for artist names
  valence = runif(num_songs, 0, 1),
  danceability = runif(num_songs, 0, 1),
  explicit = sample(0:1, num_songs, replace = TRUE), # Binary variable, assuming 0 is not explicit, 1 is explicit
  duration_ms = sample(150000:300000, num_songs, replace = TRUE), # Duration in milliseconds, example range
  mode = sample(0:1, num_songs, replace = TRUE) # Binary variable, assuming 0 is minor, 1 is major
)

# View the first few rows of the simulated data
head(simulated_data)


## Test simulated Data using TestThat

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
range_checks <- sapply(
  simulated_data[c("valence", "danceability")],
  function(x) all(x >= 0 & x <= 1)
)
print(range_checks)


## Simulate some graphs (because the API kicked me out lol)


## Popularity
ggplot(simulated_data, aes(x = popularity)) +
  geom_histogram(bins = 45, fill = "blue", color = "black") + # Adjust the number of bins as needed
  labs(
    title = "Histogram of Popularity",
    x = "Popularity",
    y = "Density"
  ) +
  theme_minimal()

# Explicit or Not

ggplot(simulated_data, aes(x = explicit)) +
  geom_bar(fill = "blue", color = "black") +
  labs(
    title = "Count of Explicit vs Non-Explicit Songs",
    x = "Explicit",
    y = "Count"
  ) +
  theme_minimal()

# duration

ggplot(simulated_data, aes(x = duration_secs)) +
  geom_histogram(bins = 45, fill = "blue", color = "black") + # Adjust the number of bins as needed
  labs(
    title = "Histogram of Popularity",
    x = "Popularity",
    y = "Density"
  ) +
  theme_minimal()
