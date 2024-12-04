#### Preamble ####
# Purpose: Models current price prediction based on historical data and contextual factors.
# Author: Caichen Sun
# Date: 3 December 2024
# Contact: caichen.sun@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Requires cleaned analysis data in 'data/02-analysis_data/' directory.
#   - Required R libraries (`tidyverse`, `lubridate`, `arrow`) must be installed.

#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(arrow)

#### Read data ####
data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

#### Prepare data for modeling ####
# Extract month as a factor variable from year_month


#### Model data ####
# Linear regression model predicting current price based on old price, month, brand, and vendor
model <- lm(current_price ~ old_price + year_month + brand + vendor, data = data)

# Model summary
summary(model)

#### Save model ####
saveRDS(
  model,
  file = "models/first_model.rds"
)
