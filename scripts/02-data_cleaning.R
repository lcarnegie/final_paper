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

# Do the cleaning and merging based on two simulated datasets 



#### Save data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
