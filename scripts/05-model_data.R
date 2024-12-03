#### Preamble ####
# Purpose: Models grocery store pricing for dozen eggs
# Author: Cher Ning-Li
# Date: 28 November 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - Have downloaded + cleaned data by running 02-clean_data.R
# - `tidyverse`, `rstanarm` packages must be installed


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(here)

#### Read data ####
#analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")
analysis_data <- read_parquet(file = here("data/02-analysis_data/analysis_data.parquet"), show_col_types = FALSE)


### Model data ####

# Create models
model1 <- 
  lm(formula = current_price ~ month + vendor + old_price,
    data = analysis_data)

model2 <- 
  lm(formula = current_price ~ month + vendor + old_price*prev_month_avg,
     data = analysis_data)

#### Save models ####
saveRDS(
  model1,
  file = "models/lm_model1.rds"
)

saveRDS(
  model2,
  file = "models/lm_model2.rds"
)
