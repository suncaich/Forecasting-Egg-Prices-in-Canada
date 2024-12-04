#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
#          electoral divisions dataset.
# Author: Caichen Sun
# Date: 26 September 2024
# Contact: caichen.sun@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - The `tidyverse` package must be installed and loaded.
#   - `00-simulate_data.R` must have been run.
# Any other information needed? Ensure that you are in the `starter_folder` R project.


#### Workspace setup ####
library(testthat)
library(dplyr)
library(readr)

simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Start writing tests

# Test 1: Check that the dataset has the correct number of rows
# Ensuring the data was generated with the expected number of records
test_that("Data has the correct number of rows", {
  expect_equal(nrow(simulated_data), 2500)  # Adjust the number as per your data specifics
})

# Test 2: Validate vendor column values
# Verifying that the vendor names in the dataset only include the expected predefined values
test_that("Vendor column contains only predefined values", {
  predefined_vendors <- c("Loblaws", "TandT", "NoFrills")  # Update with the correct list of vendors
  expect_true(all(simulated_data$vendor %in% predefined_vendors))
})

# Test 3: Check data types for price columns
# Ensuring that the price information is stored as numeric data for proper calculations and comparisons
test_that("Price columns are numeric", {
  expect_type(simulated_data$current_price, "double")
  expect_type(simulated_data$old_price, "double")
})

# Test 4: Validate month column values
# Ensuring the 'month' column only contains values that represent actual months of the year
test_that("Month column contains values from 1 to 12", {
  expect_true(all(simulated_data$month %in% 1:12))
})

# Test 5 to verify that no prices are negative
test_that("No negative prices", {
  expect_true(all(simulated_data$current_price >= 0))
  expect_true(all(simulated_data$old_price >= 0))
})

# Test 6 to verify that no prices are negative
test_that("No negative prices", {
  expect_true(all(simulated_data$current_price >= 0))
  expect_true(all(simulated_data$old_price >= 0))
})

# Test 7 to check that product names, brands, and vendors are within the expected set of categories
test_that("Valid categories for names, brands, and vendors", {
  expected_product_names <- c("Egg Regular", "Egg Organic", "Egg Free Range")
  expected_brands <- c("Brand A", "Brand B", "Brand C")
  expected_vendors <- c("Loblaws", "TandT", "NoFrills")
  
  expect_true(all(simulated_data$product_name %in% expected_product_names))
  expect_true(all(simulated_data$brand %in% expected_brands))
  expect_true(all(simulated_data$vendor %in% expected_vendors))
})

