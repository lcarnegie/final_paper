#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(readr)


# Load the dataset
cleaned_ds <- read_parquet("data/analysis_data/dataset.parquet")

# Begin defining tests
test_that("Data loads correctly", {
  expect_true(nrow(cleaned_ds) > 0)
})

test_that("Data columns are of correct type", {
  expect_type(cleaned_ds$artist_name, "character")
  expect_type(cleaned_ds$song_name, "character")
  expect_type(cleaned_ds$energy, "double")
  expect_type(cleaned_ds$valence, "double")
  expect_type(cleaned_ds$danceability, "double")
  expect_type(cleaned_ds$explicit, "double")
  expect_type(cleaned_ds$loudness, "double")
  expect_type(cleaned_ds$duration_secs, "double")
  expect_type(cleaned_ds$song_id, "character")
  expect_type(cleaned_ds$popularity, "integer")
})

test_that("Numeric values are within expected ranges", {
  expect_true(all(cleaned_ds$energy >= 0 & cleaned_ds$energy <= 1))
  expect_true(all(cleaned_ds$valence >= 0 & cleaned_ds$valence <= 1))
  expect_true(all(cleaned_ds$danceability >= 0 & cleaned_ds$danceability <= 1))
  expect_true(all(cleaned_ds$explicit %in% c(0, 1)))
  expect_true(all(cleaned_ds$popularity >= 0 & cleaned_ds$popularity <= 100))
})

test_that("Song IDs are unique", {
  expect_true(length(unique(cleaned_ds$song_id)) == nrow(cleaned_ds))
})

test_that("There are no missing values in key columns", {
  key_columns <- c("artist_name", "song_name", "song_id", "popularity")
  for (col in key_columns) {
    expect_true(all(!is.na(cleaned_ds[[col]])))
  }
})

# You can run the tests with the following line
test_dir("tests/")
