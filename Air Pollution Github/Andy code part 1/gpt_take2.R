split_text <- function(text, window_size, step_size) {
  tokens <- unlist(stri_split_boundaries(text, type = "word"))
  
  # If the text is shorter than the window_size, return the entire text as one chunk
  if (length(tokens) < window_size) {
    print(paste("Text is too short with", length(tokens), "tokens."))
    return(list(text))
  }
  
  
  # Otherwise, split the text into overlapping chunks
  chunks <- list()
  for (start_idx in seq(1, length(tokens) - window_size + 1, by = step_size)) {
    end_idx <- start_idx + window_size - 1
    chunk <- paste(tokens[start_idx:end_idx], collapse = " ")
    chunks <- c(chunks, list(chunk))
  }
  
  return(chunks)
}


get_last_processed <- function(log_file_path, index) {
  if (!file.exists(log_file_path)) {
    return(data.frame(index = index, kanoon_id = 0, iteration = 0))
  }
  
  log <- read.csv(log_file_path, stringsAsFactors = FALSE)
  if (nrow(log) == 0) {
    return(data.frame(index = index, kanoon_id = 0, iteration = 0))
  }
  
  # Filter the log for entries with the specified index
  log_filtered <- log[log$index == index,]
  
  # If there are no entries for the specified index, return 0 for kanoon_id and iteration
  if (nrow(log_filtered) == 0) {
    return(data.frame(index = index, kanoon_id = 0, iteration = 0))
  }
  
  # Find the last processed iteration for the specified index
  last_entry <- log_filtered[nrow(log_filtered),]
  last_kanoon_id <- as.numeric(last_entry$kanoon_id)
  last_iteration <- as.numeric(last_entry$iteration)
  
  # Check for any NAs introduced by coercion to numeric
  if (is.na(last_kanoon_id) || is.na(last_iteration)) {
    stop("Error: Non-numeric values found in log file.")
  }
  
  return(data.frame(index = index, kanoon_id = last_kanoon_id, iteration = last_iteration))
}



load_log <- function(log_file_path) {
  if (file.exists(log_file_path)) {
    log <- read.table(log_file_path, header = TRUE, sep = ",", stringsAsFactors = FALSE)
    return(log)
  } else {
    return(data.frame(kanoon_id = integer(), iteration = integer()))
  }
}


prompt = "You are an Indian legal clerk. You extract and classify locations from legal cases. \
\nIn the following judgment order chunk, extract all the location names mentioned and tell me their significance in the case. \
\nA location could be the jurisdiction, where the defendant is, where the court is, where the plaintiff is, etc. \
\nThen you will give me the admin level of what the location name represents. \
\nThere are 3 admin levels: state, district, or city. \
\nYour output should be: \"`location`: `significance in the context of the case` (`admin level`)"

# Set the API key as an environment variable
Sys.setenv(OPENAI_API_KEY = "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")

# Now in your process_chunk function, you can use the following code to access the API key:
openai_api_key <- Sys.getenv("OPENAI_API_KEY")

# Function to process a chunk of text with GPT-4
process_chunk <- function(chunk, index, kanoon_id, iteration, log_file_path) {
  library(reticulate)
  
  # Print chunk
  #print(chunk)
  
  openai <- import('openai')
  
  response <- openai$ChatCompletion$create(
    model = "gpt-3.5-turbo-16k",
    messages = list(
      list(
        role = "system",
        content = prompt
      ),
      list(
        role = "user",
        content = chunk
      )
    ),
    temperature = 0,
    max_tokens = as.integer(6000),  # Adjusted to integer value
    top_p = 1,
    frequency_penalty = 0,
    presence_penalty = 0,
    headers = list(organization = "org-UaMva0BnUO2695kGQuXuvI6l")
  )
  # Convert the Python object to a JSON string using Python's json module
  json <- import('json')
  json_string <- json$dumps(response)
  
  # Create a temporary folder if it doesn't exist
  temp_folder <- paste0(interimFolder, '/temp_gpt_take2.1')
  if (!dir.exists(temp_folder)) {
    dir.create(temp_folder, recursive = TRUE)
  }
  
  # Save the JSON string as a file
  json_file_path <- file.path(temp_folder, paste0(kanoon_id, "-", iteration, ".json"))
  writeLines(json_string, json_file_path)
  Sys.sleep(8)  # Pause to avoid rate limiting
  
  # Log the successful processing of this chunk
  log_entry_df <- data.frame(index = index, kanoon_id = kanoon_id, iteration = iteration)
  if (!file.exists(log_file_path)) {
    # If the log file doesn't exist, create it and add a header row
    write.table(log_entry_df, log_file_path, sep = ",", col.names = TRUE, row.names = FALSE, append = FALSE)
  } else {
    # If the log file already exists, append to it without adding a header row
    write.table(log_entry_df, log_file_path, sep = ",", col.names = FALSE, row.names = FALSE, append = TRUE)
  }
}



# Set window size and step size
window_size <- 7000  # Adjust as needed
step_size <- 6750  # Adjust as needed

# Set the path to the log file
log_file_path <- paste0(interimFolder, '/logs.txt')

# Read the log file into an object in R
log_data <- if (file.exists(log_file_path)) {
  read.csv(log_file_path, header = TRUE)
} else {
  data.frame(kanoon_id = integer(), iteration = integer())  # Create an empty data.frame with the correct column names
}

# Prompt the user to input the last processed index
user_input <- readline(prompt = "Enter the last processed index: ")
last_index <- as.numeric(user_input)  # Convert the input to numeric

# Check if the input is a valid number
if (is.na(last_index) || last_index < 1 || last_index > nrow(raw_error_df)) {
  stop("Invalid input. Please enter a valid index.")
}

# Iterate over the rows of `tests` starting from the user-specified index
for (i in seq(last_index, nrow(raw_error_df))) {
  index <- raw_error_df$index[i]
  kanoon_id <- raw_error_df$kanoon_id[i]
  print(paste("Processing index:", index, "kanoon_id:", kanoon_id))
  
  text <- raw_error_df$text[i]
  chunks <- split_text(text, window_size, step_size)
  
  # Use pbapply to iterate over chunks, passing index, kanoon_id and iteration number to process_chunk
  pbapply::pblapply(seq_along(chunks), function(iteration) {
    process_chunk(chunks[[iteration]], index, kanoon_id, iteration, log_file_path)
  })
}



############################# Parsing the output ##########################

# Initialize an empty data frame to store results
kanoon_df <- data.frame(Kanoon_ID = character(), Content = character(), stringsAsFactors = FALSE)

temp_folder <- paste0(interimFolder, '/temp_gpt_take2.1')


# Automatically list all JSON files in the directory 
file_names <- list.files(path = temp_folder, pattern = "*.json", full.names = TRUE)

# Loop through each file
for (file in file_names) {
  tryCatch({
    # Extract Kanoon ID from the file name
    kanoon_id <- unlist(strsplit(basename(file), "-"))[1]
    
    # Read the JSON file
    json_data <- fromJSON(file)
    
    # Extract the assistant's content
    content <- json_data$choices[[1]]$message$content
    
    # Check if Kanoon ID already exists in the data frame
    existing_row <- which(kanoon_df$Kanoon_ID == kanoon_id)
    
    if (length(existing_row) > 0) {
      # Append the new content to the existing content for the same Kanoon ID
      kanoon_df[existing_row, "Content"] <- paste(kanoon_df[existing_row, "Content"], content)
    } else {
      # Add a new row for the new Kanoon ID
      kanoon_df <- rbind(kanoon_df, data.frame(Kanoon_ID = kanoon_id, Content = content, stringsAsFactors = FALSE))
    }
  }, error=function(e) {
    cat("Error in file:", file, "\n", e$message, "\n")
  })
}


# Save the data frame to a CSV file (Replace the path with your desired output path)
write_csv(kanoon_df, paste0(finalFolder, '/testers.csv'))




















