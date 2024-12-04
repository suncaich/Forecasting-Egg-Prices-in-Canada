
# Influences on Egg Pricing in Canadian Retail

## Overview

This repository contains the materials and code for the study **"Influences on Egg Pricing: The Role of Brands and Vendors in Canadian Retail"**. The study explores factors influencing egg prices across major Canadian grocery vendors using a linear regression model, focusing on brand recognition, vendor strategies, and seasonal trends.

## File Structure

- **`data/`**: Contains datasets for the project:
  - `raw_data/`: Raw data files used in the analysis.
  - `analysis_data/`: Cleaned datasets prepared for analysis.
- **`scripts/`**: R scripts for data cleaning, transformation, and analysis.
- **`model/`**: Fitted models and related outputs.
- **`paper/`**: Files used to produce the study paper:
  - Quarto files, reference bibliography, and the final PDF report.
- **`other/`**: Supplementary files, including:
  - Literature and research notes.
  - Documentation of interactions with LLM tools (e.g., ChatGPT, Codriver).

## Key Components

### Data Preparation
The cleaned dataset focuses on egg prices extracted from Jacob Filipp's publicly accessible groceries dataset (2024), covering transactions from February to November 2024. Data was processed using R and libraries such as `tidyverse`, `dplyr`, and `lubridate`.

### Analysis and Modeling
A linear regression model predicts egg prices based on:
- Historical prices.
- Brand and vendor effects.
- Monthly trends.

### Results
Findings indicate significant price variation influenced by:
- **Brand**: Premium brands like "Gold Egg" command higher prices, while budget brands like "No Name" offer more economical options.
- **Vendor**: Pricing strategies vary, with Walmart and Loblaws exhibiting broader price ranges compared to Metro and No Frills.
- **Seasonality**: Prices fluctuate seasonally, influenced by holidays and supply-demand dynamics.

### Paper
The final paper, included in the `paper/` directory, details the methodology, results, and discussions, providing insights for retailers, consumers, and policymakers.

### Survey
The project also incorporates a survey on egg consumption behavior, targeting Canadian consumers. Survey results complement the dataset for deeper insights into market dynamics.

## Usage of LLM Tools

Aspects of the code and documentation were developed with the assistance of AI tools like ChatGPT and Codriver. The chat history and AI interactions are documented in `other/llm_usage/usage.txt`.

## Getting Started

### Prerequisites
- R version 4.2.0 or later.
- Required libraries: `tidyverse`, `dplyr`, `arrow`, `ggplot2`, and `lubridate`.

### Running the Code
1. Clone the repository.
2. Navigate to the `scripts/` directory.
3. Execute the cleaning and analysis scripts in sequence:
   ```bash
   Rscript data_cleaning.R
   Rscript regression_analysis.R
   
## For LLM Usage

Some portions of the code and text in this project were generated with the assistance of ChatGPT. The specific details, including the prompts and responses, are documented in `other/llm_usage/llm.txt`. This ensures transparency in the usage of AI tools throughout the development process.
