#### Preamble ####
# Purpose: Tests variables for correctness proper format using testthat
# Author: Luca Carnegie
# Date: April 21 2023
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: 01-download_data.R and 02-data_cleaning.R


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
  expect_type(cleaned_ds$valence, "double")
  expect_type(cleaned_ds$danceability, "double")
  expect_type(cleaned_ds$explicit, "integer")
  expect_type(cleaned_ds$mode, "integer")
  expect_type(cleaned_ds$loudness, "double")
  expect_type(cleaned_ds$duration_secs, "double")
  expect_type(cleaned_ds$popularity, "integer")
})

test_that("Numeric values are within expected ranges", {
  expect_true(all(cleaned_ds$valence >= 0 & cleaned_ds$valence <= 1))
  expect_true(all(cleaned_ds$danceability >= 0 & cleaned_ds$danceability <= 1))
  expect_true(all(cleaned_ds$explicit %in% c(0, 1)))
  expect_true(all(cleaned_ds$mode %in% c(0, 1)))
  expect_true(all(cleaned_ds$popularity >= 0 & cleaned_ds$popularity <= 100))
})

test_that("There are no missing values in key columns", {
  key_columns <- c("artist_name", "song_name", "popularity")
  for (col in key_columns) {
    expect_true(all(!is.na(cleaned_ds[[col]])))
  }
})

test_that("Loudness values are within realistic ranges", {
  expect_true(all(cleaned_ds$loudness >= -60 & cleaned_ds$loudness <= 0))
})

test_that("Duration of songs is within plausible limits", {
  expect_true(all(cleaned_ds$duration_secs >= 30 & cleaned_ds$duration_secs <= 1500))
})

# You can run the tests with the following line
test_dir("tests/")
