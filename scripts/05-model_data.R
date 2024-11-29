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

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

### Model data ####

# Create models
bayes_model <- 
  stan_glm(
    formula = current_price ~ month + vendor,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

pp_check(bayes_model)
summary(bayes_model)


lm_model <- 
  lm(
    formula = current_price ~ month + vendor,
    data = analysis_data
  )

summary(lm_model)

#### Save model 1 ####
saveRDS(
  bayes_model,
  file = "models/bayes_model.rds"
)

saveRDS(
  lm_model,
  file = "models/lm_model.rds"
)
