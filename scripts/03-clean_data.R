#### Preamble ####
# Purpose: Cleans the raw plane data about grocery store prices obtained from Project Hammer
# Author: Cher Ning-Li
# Date: 25 November 2024
# Contact: cher.ning@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have downloaded and unzipped the raw data CSV files from 
#   Project Hammer, and placed them into data/01-raw_data/.
#   The `tidyverse` package must be installed.
# Any other information needed? 

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw <- read_csv("data/01-raw_data/hammer-4-raw.csv")
product <- read_csv("data/01-raw_data/hammer-4-product.csv")
raw_data <- 


cleaned_data <-
  raw_data |>
  janitor::clean_names() |>
  select(wing_width_mm, wing_length_mm, flying_time_sec_first_timer) |>
  filter(wing_width_mm != "caw") |>
  mutate(
    flying_time_sec_first_timer = if_else(flying_time_sec_first_timer == "1,35",
                                   "1.35",
                                   flying_time_sec_first_timer)
  ) |>
  mutate(wing_width_mm = if_else(wing_width_mm == "490",
                                 "49",
                                 wing_width_mm)) |>
  mutate(wing_width_mm = if_else(wing_width_mm == "6",
                                 "60",
                                 wing_width_mm)) |>
  mutate(
    wing_width_mm = as.numeric(wing_width_mm),
    wing_length_mm = as.numeric(wing_length_mm),
    flying_time_sec_first_timer = as.numeric(flying_time_sec_first_timer)
  ) |>
  rename(flying_time = flying_time_sec_first_timer,
         width = wing_width_mm,
         length = wing_length_mm
         ) |> 
  tidyr::drop_na()

#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
