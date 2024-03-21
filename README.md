# Starter folder

## Overview

This repo provides students with a foundation for their own projects associated with *Telling Stories with Data*. You do not need every aspect for every paper and you should delete aspects that you do not need.

To use this folder, click the green "Code" button", then "Download ZIP". Move the downloaded folder to where you want to work on your own computer, and then modify it to suit.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Reproducing Graphs and Tables
Here is a quick guide to reproducing my graphs and tables.

1. Clone this repository to your computer
2. Download the data from OpenDataToronto using scripts/01-download_data.R
3. Clean it using 02-data_cleaning.R
4. Open [] to test the R code that generated my plots
   
Note: My folder structure and workflow is based on one created by the legendary Rohan Alexander, available at https://github.com/RohanAlexander/starter_folder

## Statement on LLM usage

Aspects of my R code and paper were written and edited with the assistance of Large Language Models, in particular Claude-2 and GPT-4 (Microsoft Copilot). The chat history with both models are available in inputs/llms
