error_csv <- read.csv(paste0(interimFolder, '/error_text.csv'))
colnames(error_csv)
error_count <- sum(error_csv$location == 'ERROR')
print(error_count)


df_take2 <- read.csv(paste0(finalFolder, '/combined_gpt_take2.2.csv'))

# Function to parse and associate the significance of locations for each case
parse_and_associate_significance <- function(row) {
  if (is.na(row)) {
    return(list())
  }
  
  parsed_dict <- list()
  patterns <- data.frame(Key = c("State", "District", "City"),
                         Pattern = c("The State is: ([^\\n]*)", 
                                     "The District is: ([^\\n]*)", 
                                     "The City is: ([^\\n]*)"))
  
  for (i in 1:nrow(patterns)) {
    key <- patterns$Key[i]
    pattern <- patterns$Pattern[i]
    match <- str_match(row, pattern)
    
    if (!is.na(match[2])) {
      locations_and_significance <- str_split(match[2], ", \\(")[[1]]
      locations <- str_split(locations_and_significance[1], ", ")[[1]]
      significance <- if (length(locations_and_significance) > 1) gsub("\\)$", "", locations_and_significance[2]) else NA
      
      cat("Locations:", locations, "\n")
      cat("Significance:", significance, "\n")
      
      if (!is.na(significance)) {
        significance_list <- str_split(significance, ", ")[[1]]
        cat("Significance List:", significance_list, "\n")
        
        if (length(locations) == length(significance_list)) {
          parsed_dict[[key]] <- setNames(significance_list, locations)
        } else {
          cat("Length mismatch in:", key, "\n")
        }
      } else {
        parsed_dict[[key]] <- setNames(rep(NA, length(locations)), locations)
      }
    }
  }
  
  return(parsed_dict)
}

# Apply the function to the 'gpt_output' column
df_take2$parsed_gpt_output_with_significance <- sapply(df_take2$gpt_output, parse_and_associate_significance, simplify = FALSE)


####################################################################################





flattened_df <- data.frame()

# Loop through each row in the original data frame
for(i in 1:nrow(error_csv)) {
  kanoon_id <- error_csv$Kanoon_ID[i]
  nested_list <- error_csv$parsed_gpt_output_with_significance[[i]]  # Directly use the column value as a list
  
  # Initialize an empty list to hold the flattened row
  flat_row <- list(Kanoon_ID = kanoon_id)
  
  # Loop through each attribute in the nested list
  for(attribute in names(nested_list)) {
    locations <- nested_list[[attribute]]
    idx <- 1
    
    # Loop through each location and its significance
    for(location in names(locations)) {
      significance <- locations[[location]]
      
      # Create dynamic column names based on the attribute and index
      location_col_name <- paste(attribute, "Location", idx, sep = "_")
      significance_col_name <- paste(attribute, "Significance", idx, sep = "_")
      
      # Populate the location and significance in the flat row
      flat_row[[location_col_name]] <- location
      flat_row[[significance_col_name]] <- significance
      
      idx <- idx + 1
    }
  }
  
  # Convert the list to a data frame and bind it to the flattened data frame
  flat_row_df <- as.data.frame(as.list(flat_row), stringsAsFactors = FALSE)
  flattened_df <- bind_rows(flattened_df, flat_row_df)
}

# Fill NAs with empty strings
flattened_df[is.na(flattened_df)] <- ""

# Write the flattened data frame to a new CSV file
write.csv(flattened_df, paste0(interimFolder, '/flattened_df.csv'), row.names = FALSE)
