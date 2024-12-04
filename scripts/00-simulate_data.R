#### Preamble ####
# Purpose: Simulates a dataset of Australian electoral divisions, including the 
#          state and party that won each division.
# Author: Caichen Sun
# Date: 1 December 2024
# Contact: caichen.sun@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed.
#                 Ensure that you are in the `starter_folder` R project.


#### Workspace setup ####
library(tidyverse)

set.seed(123)


#### Simulate data ####
# Simulating current and old price data
current_price <- runif(2500, min = 0.33, max = 69.99)
old_price <- runif(2500, min = 0.55, max = 76.99)

# Generating random months
month <- sample(1:12, 2500, replace = TRUE)

# Simulating character data with sample product names, brands, and vendors
product_names <- c("Egg Regular", "Egg Organic", "Egg Free Range")
brands <- c("Brand A", "Brand B", "Brand C")
vendors <- c("Loblaws", "TandT", "NoFrills")

product_name <- sample(product_names, 2500, replace = TRUE)
brand <- sample(brands, 2500, replace = TRUE)
vendor <- sample(vendors, 2500, replace = TRUE)

# Creating a tibble instead of a data frame
simulate_data <- tibble(current_price, old_price, product_name, brand, vendor, month)

# Viewing the structure of the simulated data
print(simulate_data)

write_csv(simulate_data, "data/00-simulated_data/simulated_data.csv")
