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
library(spotifyr)

## Scrape the Greatest of All Time Hot 100 Artists from Billboard and store them in a vector.

raw_data <-
  read_html(
    "https://www.billboard.com/charts/greatest-hot-100-artists/"
  )

write(as.character(raw_data), "data/rawdata/greatestartists.html")

raw_data <- 

names <- raw_data |> html_elements("h3") |> html_text() |> head(100)

clean_names <- trimws(gsub("\\s+", " ", names))

clean_names


## For each artist in the vector, call the Spotify API for artist's top tracks and for audio features

## Save each dataset as .csv or parquet? 



#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
