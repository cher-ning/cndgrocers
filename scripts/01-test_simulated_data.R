#### Preamble ####
# Purpose: Tests the structure and validity of the simulated data
# Author: Cher Ning-Li
# Date: 28 November 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("simulated_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 151 rows
if (nrow(simulated_data) == 500) {
  message("Test Passed: The dataset has 500 rows.")
} else {
  stop("Test Failed: The dataset does not have 500 rows.")
}

# Check if the dataset has 4 columns
if (ncol(simulated_data) == 4) {
  message("Test Passed: The dataset has 4 columns.")
} else {
  stop("Test Failed: The dataset does not have 4 columns.")
}

# Check if the 'vendor' column contains only valid vendors
valid_vendors <-c("NoFrills", "Voila", "Loblaws", "SaveOnFoods", "Metro", "TandT", "Galleria", "Walmart")
if (all(simulated_data$vendor %in% valid_vendors)) {
  message("Test Passed: The 'vendor' column contains only valid vendors")
} else {
  stop("Test Failed: The 'vendor' column contains invalid vendors")
}

# Check if the 'month' column contains only valid months
valid_months <- c(1:12)
if (all(simulated_data$month %in% valid_months)) {
  message("Test Passed: The 'month' column contains only valid months")
} else {
  stop("Test Failed: The 'party' column contains invalid months")
}

# Check if there are any missing values in the dataset
if (all(!is.na(simulated_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'month', 'vendor', and 'current_price' columns
if (all(simulated_data$month != "" & simulated_data$vendor != "" & simulated_data$current_price != "")) {
  message("Test Passed: There are no empty strings in 'month', 'vendor', or 'current_price'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if the 'vendor' column has at least two unique vendors
if (n_distinct(simulated_data$vendor) >= 2) {
  message("Test Passed: The 'vendor' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'vendor' column contains less than two unique values.")
}

# Check if the 'current_price' and 'old_price' columns contain no negative values
if (all(simulated_data$current_price >= 0 & simulated_data$old_price >= 0)) {
  message("Test Passed: There are no negative values in 'current_price'.")
} else {
  stop("Test Failed: There are one or more negative values in 'current_price' or 'old_price'.")
}
