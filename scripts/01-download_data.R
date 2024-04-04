#### Preamble ####
# Purpose: Downloads and saves the data from Spotify and FRED
# Author: Luca Carnegie
# Date: 28 March 2023
# Contact: luca.carnegie@mail.utoronto.ca
# License: MIT
# Pre-requisites: none


#### Workspace setup ####
library(tidyverse)
library(spotifyr)
library(eFRED)

# [...UPDATE THIS...]

#### Download Spotify Data for songs released since  ####

beyonce <- get_artist_audio_features("beyonce")
saveRDS(beyonce, "data/raw_data/beyonce.rds")

beyonce <- 
  readRDS(here::here("data/raw_data/beyonce.rds"))

beyonce




## Download FRED Data




#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
