#### Preamble ####
# Purpose: Tests cleaned data
# Author: Cher Ning-Li
# Date: 28 November 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - Have downloaded + cleaned data by running 02-clean_data.R
# - `tidyverse`, `testthat`, `here` packages must be installed


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(here)

analysis_data <- read_csv(here::here("data/02-analysis_data/analysis_data.csv"), show_col_types = FALSE)

#### Test data ####

# Test that the dataset has 6 columns
test_that("dataset has 6 columns", {
  expect_equal(ncol(analysis_data), 6)
})

# Test that the 'product_name' column is character type
test_that("'product_name' is character", {
  expect_type(analysis_data$product_name, "character")
})

# Test that the 'vendor' column is character type
test_that("'vendor' is character", {
  expect_type(analysis_data$vendor, "character")
})

# Test that the 'month' column is character type
test_that("'month' is character", {
  expect_type(analysis_data$month, "character")
})

# Test that the 'current_price' column is numeric type
test_that("'current_price' is numeric", {
  expect_true(is.numeric(analysis_data$current_price))
})

# Test that the 'old_price' column is numeric type
test_that("'old_price' is numeric", {
  expect_true(all(is.numeric(analysis_data$old_price)))
})

# Test that the 'prev_month_avg' column is numeric type
test_that("'prev_month_avg' is numeric", {
  expect_true(all(is.numeric(analysis_data$prev_month_avg)))
})

# Test that there are no missing values in the current_price and old_price columns
test_that("no missing values in current_price and old_price", {
  expect_true(all(!is.na(analysis_data$current_price) & !is.na(analysis_data$old_price)))
})

# Test that 'current_price', 'old_price', 'prev_month_avg' contains no negative values
test_that("no negative values in 'current_price', 'old_price', and 'prev_month_avg", {
  expect_true(all(analysis_data$current_price >= 0 & 
                    analysis_data$old_price >= 0 & 
                    (analysis_data$prev_month_avg >= 0 | is.na(analysis_data$prev_month_avg)) ))
})

# Test that 'vendor' contains only valid vendor names
valid_vendors <- c("Galleria", "TandT", "Voila", "Loblaws", "Metro", 
                  "NoFrills", "SaveOnFoods", "Walmart")
test_that("'vendor' contains valid vendor names", {
  expect_true(all(analysis_data$vendor %in% valid_vendors))
})

# Test that there are no empty strings in 'vendor', 'month', 'product_name' columns
test_that("no empty strings in 'vendor', 'month', 'product_name' columns", {
  expect_false(any(analysis_data$vendor == "" | analysis_data$month == "" | 
                     analysis_data$product_name == ""))
})

# Test that 'month' column is a valid month, between March and November inclusive
valid_months <- c("Mar", "Apr", "May", "Jun", "Jul", 
                   "Aug", "Sep", "Oct", "Nov")
test_that("'month' contains valid months", {
  expect_true(all(analysis_data$month %in% valid_months))
})

# Test that product_name contains egg
test_that("'product_name' contains egg", {
  expect_true(all(grepl('Eggs|eggs', analysis_data$product_name)))
})
