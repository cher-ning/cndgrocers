# Impacts of Month, Grocery Vendor, Presale Prices, and Historical Pricing on Discounted Egg Dozen Prices

## Overview

This repository contains all files needed to generate the graphs and pdf for the paper *Impacts of Month, Grocery Vendor, Presale Prices, and Average Historical Pricing on Discounted Egg Dozen Prices*.

Some of the code used to create this work was adapted from Alexander (2023).

## Data

Please download the data as CSV files [here](https://jacobfilipp.com/hammer/), then unzip the files into `data/raw_data`.


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as downloaded directly from [Project Hammer](https://jacobfilipp.com/hammer/).
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains the linear regression model. 
-   `other` contains sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean data, and test data.


## Statement on LLM usage

No aspects of the code or paper have been written using LLMs 