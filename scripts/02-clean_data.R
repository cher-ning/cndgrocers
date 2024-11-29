#### Preamble ####
# Purpose: Cleans the raw plane data about grocery store prices obtained from 
#   Project Hammer
# Author: Cher Ning-Li
# Date: 25 November 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have downloaded and unzipped the raw data CSV files from 
#   Project Hammer, and placed them into data/01-raw_data/.
#   The `tidyverse`, `arrow` packages must be installed.
# Any other information needed? 

#### Workspace setup ####
library(tidyverse)
library(arrow) # for saving file as parquet

#### Clean data ####
raw <- read_csv("data/01-raw_data/hammer-4-raw.csv")
product <- read_csv("data/01-raw_data/hammer-4-product.csv")
merged <- merge(raw, product, by.x = "product_id", by.y = "id")

# cleans column names, filters for only dozen egg item prices
# then selecting only columns of interest
egg_merged <- merged |> janitor::clean_names() |> 
  filter(grepl('Eggs|eggs', product_name), !grepl('Kinder', product_name)) |>
  filter(grepl('Dozen|dozen|12', product_name) | grepl('12', units)) |>
  select(nowtime, current_price, old_price, vendor, product_name)

# removes rows that have NA in the current_price column, generalizes nowtime to
# only month data, removes February entries due to only data from Feb 28
# onwards being available
cleaned_data <- egg_merged |> drop_na(current_price) |>
  mutate(current_price = as.numeric(current_price), month = month.abb[month(nowtime)]) |>
  filter(month != 'Feb') |> select(-nowtime) 

#### Save data ####
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(x = cleaned_data, sink = "data/02-analysis_data/analysis_data.parquet")
