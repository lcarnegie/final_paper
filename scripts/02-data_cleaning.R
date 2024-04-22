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
library(arrow)

top_tracks <- read.csv("data/raw_data/top_tracks.csv")
audio_features <- read.csv("data/raw_data/audio_features.csv")


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
                                 valence,
                                 danceability,
                                 explicit_,
                                 loudness,
                                 mode, 
                                 duration_ms
                                 ) |>
                          rename(song_name = track_name) |>
                          clean_names() |>
                          mutate(song_id = paste(artist_name, song_name, sep = " - "))
                          

#Merge based on song name
cleaned_ds <- cleaned_audio_features |>
  # Perform an inner join on 'song_name' to filter only relevant songs from audio features
  inner_join(cleaned_top_tracks, by = "song_id") 

# We lose a few songs from each artist in the inner join because of a disconnect 
# between the top_songs dataset and the audio_features dataset - some songs on the
# top 10 don't seem to have audio features that are query-able. 

# There were also duplicates, so drop ones with the lower popularity score.  
# After all, we are interested in what makes a song "more" popular. 

cleaned_ds <- cleaned_ds |>
  group_by(song_id) |>
  slice_max(order_by = popularity, with_ties = FALSE) |> # Remove duplicates 
  ungroup() |>
  select(-artist_name.y, -song_name.y) |> #drop artifacts from inner join
  clean_names() |>
  mutate(
    duration_ms = duration_ms/1000,  #convert to seconds
    explicit  = as.integer(explicit)
  ) |>
  rename(
    song_name = song_name_x, 
    artist_name = artist_name_x,
    duration_secs = duration_ms
  ) |>
  select(
    artist_name, 
    song_name,
    popularity, 
    mode, 
    valence, 
    danceability, 
    explicit, 
    loudness, 
    duration_secs
  )
  
  

# Check the top entries of the merged dataset to ensure correctness
head(cleaned_ds)


#### Save data ####

# Assume 'cleaned_ds' is your DataFrame that you want to save
file_path <- "data/analysis_data/dataset.parquet"

# Write the DataFrame to a Parquet file at the specified file path
write_parquet(cleaned_ds, file_path)

