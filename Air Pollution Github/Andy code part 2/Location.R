chatgptfull <- read.csv(paste0(rawFolder, "/chatgptfull.csv"))

# How many are errors? What's the share? 
error_key <- c("ERROR","NOT POSSIBLE")
error_count <- sapply(error_key, function(key) sum(grepl(key, chatgptfull$location, fixed = T)))

valid_entries <- nrow(chatgptfull) - sum(error_count)
all_counts <- c(error_count, "Valid Entries"=valid_entries)
# Define colors
colors <- rainbow(length(all_counts))

# Create the pie chart
pie(all_counts, labels = names(all_counts), main = "Share of Errors and Placeholders in Location Column", 
    col = colors, radius = 1)

# Display percentages on the pie chart
slices <- all_counts / sum(all_counts)
lbls <- sprintf("%1.1f%%", slices * 100)
pie(slices, labels = lbls, main = "Share of Errors and Placeholders in Location Column",
    col = colors, radius = 1)

# Add legend
legend("topright", legend = names(all_counts), fill = colors, title = "Categories")


# Traditional cleaning -----------------------------------
## Pre Cleaning: removing unecessary words and phrases -----------------

cleaned_df <- chatgptfull[!grepl("ERROR|NOT POSSIBLE", chatgptfull$location, ignore.case = T),]
original_row_count <- nrow(chatgptfull)
cleaned_row_count <- nrow(cleaned_df)

# Display the row counts
print(paste("Original row count: ", original_row_count))
print(paste("Cleaned row count: ", cleaned_row_count))

### Removing the filler words ------------------------------
cleaned_df$location <- gsub("The jurisdiction of this judgement is ", "", cleaned_df$location)
cleaned_df$location <- trimws(cleaned_df$location)
cleaned_df$location <- gsub("\\[|\\]", "", cleaned_df$location)

write.csv(cleaned_df, paste0(interimFolder, "/CleanedGptFull.csv"))

# Ditionary -------------------------------------
df_divisions <- readxl::read_excel(paste0(rawFolder, "/India States Wiki.xlsx"))

# Function to split districts based on delimiters
split_districts <- function(districts_str) {
  # Remove any content within parentheses
  districts_str <- gsub("\\(.*?\\)", "", districts_str)
  
  # Replace "and" (case insensitive) with a comma for uniformity
  districts_str <- gsub("\\s*[Aa]nd\\s*", ",", districts_str)
  
  # Split by commas and remove empty or null values
  strsplit(districts_str, ",")[[1]] %>% 
    lapply(str_trim) %>% 
    unlist() %>% 
    .[. != ""]
}

# Apply the function to the 'Districts' column
df_divisions$Districts <- lapply(df_divisions$Districts, split_districts)

# Expand the data frame to be at the district level
expanded_rows <- do.call("rbind", lapply(1:nrow(df_divisions), function(i) {
  single_row <- df_divisions[i, ]
  districts <- unlist(single_row$Districts)
  expanded_row <- lapply(districts, function(d) {
    single_row$Districts <- d
    single_row
  })
  do.call("rbind", expanded_row)
}))

# Save the cleaned data to a new Excel file
writexl::write_xlsx(expanded_rows, paste0(interimFolder, "/India_Districts_Transformed.xlsx"))


