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

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")

### Model data ####

# Convert variables to factors
analysis_data <- analysis_data %>% 
  mutate(month = as.factor(month), vendor = as.factor(vendor))

set.seed(520)


test_model <- 
  stan_glm(
    formula = current_price ~ month + vendor + old_price,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

pp_check(test_model)


test2_model <- 
  lm(
    formula = current_price ~ month + vendor + old_price,
    data = analysis_data
  )

summary(test2_model) # R squared = 0.8085, adj = 0.806

# Model 3: Bayes, with account for prev month avg
# Calculate average prices over all stores that month
analysis2 <- analysis_data %>%
  mutate(month = recode(month,
                      Mar = 3,
                      Apr = 4,
                      May = 5,
                      Jun = 6,
                      Jul = 7,
                      Aug = 8,
                      Sep = 9,
                      Oct = 10,
                      Nov = 11))

month_avg <- analysis2 %>%
  group_by(month) %>%
  summarize(month_avgprice = mean(current_price))

analysis2 <- analysis2 |> mutate(prev_month = month-1)

# adds into each row the avg price of eggs the month before under the column month_avgprice
merged <- merge(analysis2, month_avg, by.x = "prev_month", by.y = "month") |> 
  mutate(month = month.abb[month], 
         month = as.factor(month), vendor = as.factor(vendor))

test3_model <-
  stan_glm(
    formula = current_price ~ month + vendor + old_price + month_avgprice,
    data = merged,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

pp_check(test3_model)

test4_model <- 
  stan_glm(
    formula = current_price ~ month + vendor + old_price,
    data = merged,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 520
  )

modelsummary(
  list(
    "Without Prev Month Avg" = test_model,
    "With Prev Month Avg" = test3_model
    )
)
