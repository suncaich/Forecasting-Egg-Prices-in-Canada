#### Preamble ####
# Purpose: Models and visualizes product pricing trends over time.
# Author: Caichen Sun
# Date: 3 December 2024
# Contact: caichen.sun@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
#   - Cleaned data file ('analysis_data.parquet') must be available in the 'data/02-analysis_data/' directory.
#   - Required R libraries (`arrow`, `ggplot2`, `dplyr`, `lubridate`, `gridExtra`, `readr`) must be installed.
#   - Ensure that the necessary workspace is correctly set up.


#### Workspace setup ####
library(arrow)
library(ggplot2)
library(dplyr)
library(lubridate)
library(gridExtra)
library(readr)

#### Load data ####
data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Visualization 1: Number of Product Entries Per Month
ggplot1 <- ggplot(data %>%
                    group_by(year_month) %>%
                    summarise(Entries = n()), aes(x=year_month, y=Entries)) +
  geom_line(aes(group=1), color="orange", size=1) +
  geom_point(color="red") +
  labs(title="Number of Product Entries Per Month", x="Month", y="Entries") +
  theme_minimal()

# Visualization 2: Average Current Price Per Month
ggplot2 <- ggplot(data %>%
                    group_by(year_month) %>%
                    summarise(AverageCurrentPrice = mean(current_price, na.rm=TRUE)), aes(x=year_month, y=AverageCurrentPrice)) +
  geom_line(aes(group=1), color="blue", size=1) +
  geom_point(color="darkblue") +
  labs(title="Average Current Price Per Month", x="Month", y="Average Current Price") +
  theme_minimal()

# Visualization 3: Average Old Price Per Month
ggplot3 <- ggplot(data %>%
                    group_by(year_month) %>%
                    summarise(AverageOldPrice = mean(old_price, na.rm=TRUE)), aes(x=year_month, y=AverageOldPrice)) +
  geom_line(aes(group=1), color="green", size=1) +
  geom_point(color="blue") +
  labs(title="Average Old Price Per Month", x="Month", y="Average Old Price") +
  theme_minimal()

# Visualization 4: Average Price Difference Per Month
data$price_diff <- data$current_price - data$old_price
ggplot4 <- ggplot(data %>%
                    group_by(year_month) %>%
                    summarise(AveragePriceDiff = mean(price_diff, na.rm=TRUE)), aes(x=year_month, y=AveragePriceDiff)) +
  geom_line(aes(group=1), color="red", size=1) +
  geom_point(color="purple") +
  labs(title="Average Price Difference Per Month", x="Month", y="Average Price Difference") +
  theme_minimal()

# Visualization 5: Comparison of Average Prices Per Month
data$price_diff <- data$current_price - data$old_price
ggplot5 <- ggplot(data %>%
                    group_by(year_month) %>%
                    summarise(AveragePriceDiff = mean(price_diff, na.rm=TRUE)), aes(x=year_month, y=AveragePriceDiff)) +
  geom_bar(stat="identity", fill="red") +
  labs(title="Average Price Difference Per Month", x="Month", y="Average Price Difference") +
  theme_minimal()

# Visualization 6: Scatter Plot of Old Price vs. Current Price
ggplot1 <- ggplot(data, aes(x=old_price, y=current_price)) +
  geom_point(alpha=0.5, color="blue") +
  labs(title="Scatter Plot of Old Price vs. Current Price", x="Old Price", y="Current Price") +
  theme_minimal() +
  geom_smooth(method="lm", se=FALSE, color="red") # Adding a linear regression line

# Visualization 7: Scatter Plot of Old Price vs. Current Price
ggplot7 <- ggplot(data, aes(x=old_price, y=current_price)) +
  geom_point(alpha=0.5, color="blue") +
  labs(title="Scatter Plot of Old Price vs. Current Price", x="Old Price", y="Current Price") +
  theme_minimal() +
  geom_smooth(method="lm", se=FALSE, color="red") # Adding a linear regression line

# Visualization 8: Histogram of Price Differences
data$price_diff <- data$current_price - data$old_price
ggplot8 <- ggplot(data, aes(x=price_diff)) +
  geom_histogram(bins=30, fill="green", color="black") +
  labs(title="Histogram of Price Differences", x="Price Difference", y="Frequency") +
  theme_minimal()

# Visualization 9: Density Plot of Old and Current Prices
ggplot9 <- ggplot(data) +
  geom_density(aes(x=old_price, fill="Old Price"), alpha=0.5) +
  geom_density(aes(x=current_price, fill="Current Price"), alpha=0.5) +
  labs(title="Density Plot of Old and Current Prices", x="Price", y="Density") +
  scale_fill_manual(values=c("Old Price"="red", "Current Price"="blue")) +
  theme_minimal()

# Visualization 10:Box plot of Different vendors
ggplot(data, aes(x = vendor, y = current_price, fill = vendor)) +
  geom_boxplot() +
  labs(title = "Distribution of Current Prices by Vendor",
       x = "Vendor",
       y = "Current Price ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Grouping data by brand and calculating the average current price
brand_price <- data %>%
  group_by(brand) %>%
  summarise(Average_Current_Price = mean(current_price, na.rm = TRUE)) %>%
  arrange(Average_Current_Price)

#Visualization 11: Bar chart of brands
ggplot(brand_price, aes(x = reorder(brand, Average_Current_Price), y = Average_Current_Price, fill = brand)) +
  geom_col() +
  labs(title = "Average Current Price by Brand",
       x = "Brand",
       y = "Average Current Price") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Adjust text angle for better readability



# Display all plots
grid.arrange(ggplot2, ggplot3, ggplot4, ggplot5, ncol=1)
grid.arrange(ggplot7, ggplot8, ggplot9, ncol=1)

#### Save model ####


