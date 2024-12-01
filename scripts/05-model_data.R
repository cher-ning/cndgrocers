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
library(rstanarm)
library(arrow)
library(here)

#### Read data ####
#analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")
analysis_data <- read_parquet(file = here("data/02-analysis_data/analysis_data.parquet"), show_col_types = FALSE)


### Model data ####

# Create models
bayes_model1 <- 
  stan_glm(
    formula = current_price ~ month + vendor + old_price,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

bayes_model2 <-
  stan_glm(
    formula = current_price ~ month + vendor + old_price + prev_month_avg,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

#### Save models ####
saveRDS(
  bayes_model1,
  file = "models/bayes_model1.rds"
)

saveRDS(
  bayes_model2,
  file = "models/bayes_model2.rds"
)
