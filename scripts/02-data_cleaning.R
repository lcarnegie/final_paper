#### Preamble ####
# Purpose: Cleans the raw Spotify popularity/audio feature data and combines it 
#          into a single dataset. 
# Author: Luca Carnegie
# Date: 19 April 2024
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 01-download_data.R to get the data

#### Workspace setup ####
library(tidyverse)
library(janitor)


top_tracks <- read.csv("data/raw_data/top_tracks.csv")
audio_features <- read.csv("data/raw_data/audio_features.csv")

#Get columns from top_tracks

#Clean the two CSVs
cleaned_top_tracks <- top_tracks |> 
                      select(Artist_Name, name, popularity) |>
                      rename(song_name = name) |>
                      clean_names() |>
                      mutate(song_id = paste(artist_name, song_name, sep = " - "))
                      
                      
                          
cleaned_audio_features <- audio_features|>
                          mutate(explicit_ = if_else(explicit, 1, 0)) |>
                          select(artist_name, 
                                 track_name,
                                 energy,
                                 valence,
                                 danceability,
                                 explicit_,
                                 loudness,
                                 duration_ms
                                 ) |>
                          rename(song_name = track_name) |>
                          clean_names() |>
                          mutate(song_id = paste(artist_name, song_name, sep = " - "))
                          

#Merge based on song name
cleaned_ds <- cleaned_audio_features |>
  # Perform an inner join on 'song_name' to filter only relevant songs from audio features
  inner_join(cleaned_top_tracks, by = "song_id") 

# There were duplicate songs, so drop ones with the lower popularity score 
# After all, we are interested in what makes a song "more" popular. 

# Remove duplicates by keeping the entry with the highest popularity score
cleaned_ds <- cleaned_ds |>
  group_by(song_id) |>
  slice_max(order_by = popularity, with_ties = FALSE) |>
  ungroup() |>
  select(-artist_name.y, -song_name.y) |>
  clean_names() |>
  rename(
    song_name = song_name_x, 
    artist_name = artist_name_x
  ) |>
  select(
    song_id, 
    artist_name, 
    song_name,
    popularity, 
    energy, 
    valence, 
    danceability, 
    explicit, 
    loudness, 
    duration_ms
  )
  

# Check the top entries of the merged dataset to ensure correctness
head(cleaned_ds)


#### Save data ####
write_csv(cleaned_ds, "data/analysis_data/analysis_data.csv")
