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
library(modelsummary)
library(arrow)
library(here)

#### Read data ####
# analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")
analysis_data <- read_parquet(file = here("data/02-analysis_data/analysis_data.parquet"), show_col_types = FALSE)

### Model data ####

# Convert variables to factors
analysis_data <- analysis_data %>% 
  mutate(month = as.factor(month), vendor = as.factor(vendor))

set.seed(520)

# Model 1: Bayes
test1_model <- 
  stan_glm(
    formula = current_price ~ month + vendor + old_price,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

pp_check(test1_model)
summary(test1_model)

# Model 3: Bayes, with account for prev month avg

test3_model <-
  stan_glm(
    formula = current_price ~ month + vendor + old_price + prev_month_avg,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

pp_check(test3_model)
summary(test3_model)

# t1 R square = 0.807, adj = 0.804
# t3 R square = 0.813, adj = 0.810
modelsummary(
  list(
    "Without Prev Month Avg" = test1_model,
    "With Prev Month Avg" = test3_model
    )
)


## Model 2: linear regression model

test2_model <- 
  lm(
    formula = current_price ~ month + vendor + old_price,
    data = analysis_data
  )

summary(test2_model) # R squared = 0.8085, adj = 0.806



test4_model <- 
  lm(
    formula = current_price ~ month + vendor + old_price*prev_month_avg,
    data = analysis_data
  )

summary(test4_model) # R squared = 0.8181, adj = 0.8155
