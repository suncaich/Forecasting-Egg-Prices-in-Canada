#### Preamble ####
# Purpose: Cleans the raw product data and prepares it for analysis.
# Author: Caichen Sun
# Date: 3 December 2024
# Contact: caichen.sun@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Raw data files must be available in the 'data/01-raw_data/' directory.
#   - Required R libraries (`tidyverse`, `dplyr`, `arrow`, `lubridate`, `here`) must be installed.

#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(arrow)
library(lubridate)
library(here)

#### Load raw data ####
raw_data <- read_csv("data/01-raw_data/hammer-4-raw.csv")
product_data <- read_csv("data/01-raw_data/hammer-4-product.csv")

#### Combine and clean data ####
clean_data <- raw_data %>%
  left_join(product_data, by = c("product_id" = "id")) %>%
  select(nowtime, current_price, old_price, price_per_unit, product_name, brand, vendor) %>%
  filter(
    str_detect(product_name, "Eggs") & 
      !str_detect(product_name, "Chocolate|Candy|Kinder|Cadbury|Eggies|Mini|Decorating|Creme|Toy|Plush|Quail|Duck|Hot Sauce|Sauce|Biscuit|Gummy|Fried|Mayonnaise|Oatmeal|Joint Care|Fish|Plate|Bowl|Potatoes|Pickled|Preserved|Marinated|Tea|Pepper|Boiled|Yolk") &
      vendor %in% c("Loblaws", "Metro", "Walmart", "NoFrills")
  ) %>%
  mutate(
    current_price = as.numeric(current_price),
    old_price = as.numeric(old_price)
  ) %>%
  filter(!is.na(current_price) & !is.na(old_price)) %>%
  mutate(
    nowtime = as.POSIXct(nowtime, tz = "UTC"),
    year_month = format(nowtime, "%Y-%m"),
    price_diff = current_price - old_price
  ) %>%
  select(year_month, current_price, old_price, price_diff, product_name, brand, vendor)



#### Save cleaned data ####
write_csv(clean_data, "data/02-analysis_data/analysis_data.csv")
write_parquet(clean_data, "data/02-analysis_data/analysis_data.parquet")
