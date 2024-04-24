#### Preamble ####
# Purpose: Downloads and saves data from the Spotify API
# Author: Luca Carnegie
# Date: 28 March 2023
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
library(rvest)
library(xml2)
library(spotifyr)
library(usethis)

#### Download Data ####

# Scrape the Greatest of All Time Hot 100 Artists from Billboard and store them in a vector.

raw_data <-
  read_html(
    "https://www.billboard.com/charts/greatest-hot-100-artists/"
  )

write_html(raw_data, 'data/raw_data/greatest100.html')

raw_data <- read_html('data/raw_data/greatest100.html')

names <- raw_data |> 
          html_elements("h3") |> 
          html_text() |> 
          head(100)

artists <- trimws(gsub("\\s+", " ", names))

artists <- trimws(gsub("/", " and ", names))


# Take the list of artists and get data for each one

# Initialize lists to store the tibbles for each artist
artist_audio_features_list <- list()
artist_top_tracks_list <- list()

# Loop through each artist and store their data
for (artist_name in artists) {
  
  # Get audio features
  audio_features <- get_artist_audio_features(artist_name)
  # Extract artist_id and use it to get top tracks
  artist_id <- audio_features$artist_id[1] # Assuming 'artist_id' is correctly named and not null
  
  # Get top tracks for the US market
  top_tracks <- get_artist_top_tracks(artist_id, market = "US")
  
  # Store data frames in respective lists
  artist_audio_features_list[[artist_name]] <- audio_features
  artist_top_tracks_list[[artist_name]] <- top_tracks
  
  Sys.sleep(sample(0:12)) #Stop for a random time to not get kicked out of API
  print(paste("Got", artist_name, "'s data"))
}


# Merge lists of tibbles into single tibbles
audio_features_spotify <- bind_rows(artist_audio_features_list, .id = "Artist_Name")
top_tracks_tibble_spotify <- bind_rows(artist_top_tracks_list, .id = "Artist_Name")

audio_features <- as_tibble(audio_features_spotify)
top_tracks <- as_tibble(top_tracks_tibble_spotify)


#### Save data ####

write_csv(audio_features, "data/raw_data/audio_features.csv")
write_csv(top_tracks, "data/raw_data/top_tracks.csv")

         
