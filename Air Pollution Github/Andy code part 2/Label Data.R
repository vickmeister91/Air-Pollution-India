# Load necessary library
library(dplyr)

# Load identified data
identified <- read.csv(paste0(interimFolder, '/canon_identified.csv'))

# Set fuzzy_matched flag
identified$fuzzy_matched = ifelse(identified$similarity_score == 1, 0, 1)
identified <- subset(identified, select = c(kanoon_id, fuzzy_matched))

# Load fulldata
fulldata <- read.csv(paste0(finalFolder, '/location_cleaned.csv'))

# Perform left join
merged_data <- left_join(fulldata, identified, by = "kanoon_id")


# Create IDed flag based on whether the merge found a match
merged_data <- merged_data %>%
  mutate(IDed = ifelse(is.na(fuzzy_matched), 0, 1))

