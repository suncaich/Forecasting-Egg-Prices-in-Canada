#### Preamble ####
# Purpose: Tests the cleaned product data for expected structure, values, and quality.
# Author: Caichen Sun
# Date: 3 December 2024
# Contact: caichen.sun@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Requires cleaned data file ('analysis_data.parquet') in 'data/02-analysis_data/' directory.
#   - Required R libraries (`tidyverse`, `testthat`, `arrow`, `lubridate`) must be installed.

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)
library(lubridate)

#### Read the cleaned analysis data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Define tests ####

# Test that the dataset has a reasonable number of rows
test_that("dataset has a non-zero number of rows", {
  expect_gt(nrow(analysis_data), 0)
})

# Test that the dataset contains specific columns
expected_columns <- c("year_month", "current_price", "old_price", "price_diff", "product_name", "brand", "vendor")
test_that("dataset contains expected columns", {
  expect_true(all(expected_columns %in% colnames(analysis_data)))
})

# Test that the 'vendor' column contains only specified vendors
predefined_vendors <- c("Loblaws", "Metro", "Walmart", "NoFrills")
test_that("'vendor' column contains only specified vendors", {
  expect_true(all(analysis_data$vendor %in% predefined_vendors))
})

# Test that 'current_price' and 'old_price' are numeric and contain no NA values
test_that("'current_price' and 'old_price' are numeric and non-missing", {
  expect_type(analysis_data$current_price, "double")
  expect_type(analysis_data$old_price, "double")
  expect_true(all(!is.na(analysis_data$current_price)))
  expect_true(all(!is.na(analysis_data$old_price)))
})

# Test that 'year_month' is formatted correctly as YYYY-MM
test_that("'year_month' is formatted correctly", {
  expect_true(all(grepl("^\\d{4}-\\d{2}$", analysis_data$year_month)))
})

# Test that 'price_diff' is correctly calculated
test_that("'price_diff' is calculated as current_price - old_price", {
  expect_equal(analysis_data$price_diff, analysis_data$current_price - analysis_data$old_price)
})

# Test that the 'product_name' column contains only relevant product names (e.g., "Eggs")
excluded_keywords <- c("Chocolate", "Candy", "Kinder", "Cadbury", "Eggies", "Mini", "Decorating", "Creme", "Toy", 
                       "Plush", "Quail", "Duck", "Hot Sauce", "Sauce", "Biscuit", "Gummy", "Fried", "Mayonnaise", 
                       "Oatmeal", "Joint Care", "Fish", "Plate", "Bowl", "Potatoes", "Pickled", "Preserved", 
                       "Marinated", "Tea", "Pepper", "Boiled", "Yolk")
test_that("'product_name' column excludes irrelevant keywords", {
  expect_false(any(str_detect(analysis_data$product_name, paste(excluded_keywords, collapse = "|"))))
})

# Test that there are no missing values in critical columns
critical_columns <- c("current_price", "old_price", "product_name", "vendor")
test_that("critical columns have no missing values", {
  expect_true(all(sapply(analysis_data[critical_columns], function(col) all(!is.na(col)))))
})
