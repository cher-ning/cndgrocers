#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
# state and party that won each division.
# Author: Cher Ning-Li
# Date: 25 November 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `cndgrocers` rproj


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
simulated_data <- tibble(
  month = sample(1:12, 500, replace = TRUE),
  vendor = sample(c("NoFrills", "Voila", "Loblaws", "SaveOnFoods", "Metro", "TandT", "Galleria", "Walmart"), 500, replace = TRUE),
  current_price = round(runif(500, min=1, max=10), digits=2),
  old_price = round(current_price + runif(500, min=0.1, max=4), 2)
)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")
