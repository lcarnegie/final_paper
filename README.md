# The Anatomy of a Hit: Statistically Learning from the Best

## Overview

What makes a hit pop song? This paper examines the audio features that characterize mainstream music's biggest hits. This self-directed study utilizes audio feature data from top artists' discographies, accessed through the Spotify API, to analyze via multiple linear regression which specific musical qualities significantly impact a song's assigned popularity score on Spotify.

## File Structure and Workflow

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from the Spotify API using spotifyr.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and rough sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

My workflow is one based, in part, on an open-source data science workflow devised by the legendary Rohan Alexander. 

## Reproducing Graphs and Tables
Here is a brief guide to reproducing my graphs and tables.

1. Clone this repository to your computer. 
2. Install RStudio (recommended), copy this repository to Posit Cloud (meh), or any other R language interpreter (not recommended). Install the libaries indicated in the `setup` chunk at the top of `paper\paper.qmd`. 
3. In `scripts`, run each of the files to get a sense of how I simulated, downloaded, cleaned, modeled, and tested my data. 
4. Navigate to any of the R chunks in `paper.qmd` to run the code as I did.
   
## Statement on LLM usage

Aspects of my R code and paper were written and edited with the assistance of Large Language Models, in particular variants of Claude-3 (Claude.ai) by Anthropic and GPT-4 (ChatGPT) by OpenAI. 

Claude-3 Sonnet/Haiku was used for:
- Writing and editing parts of the paper

GPT-4 was used for: 
- Coding some of the R graphs
- Debugging and troubleshooting

The complete chat history with both models are available in inputs/llms. 
