unidentified_df <- read.csv(paste0(interimFolder, "/unidentified.csv"))

errors_df <- unidentified_df %>% 
  filter(location == "ERROR")
head(errors_df)

## See what I can extract from the summary response variable for the errors

location_dict <- read_excel(paste0(rawFolder, "/India States Wiki.xlsx"))
expanded_loc_dict <- location_dict %>%
  separate_rows(Districts, sep = ',')%>%
  select(State = `State/Union Territory`, Division = Divisions, District = Districts )

write.csv(expanded_loc_dict, paste0(rawFolder, 'district dictionary.csv'))

district_names <- as.vector(expanded_loc_dict$District)


all_loc_names <- unique(c(
  as.vector(location_dict$`State/Union Territory`),
  as.vector(location_dict$Divisions),
  district_names
))

# Update pattern to include all location names
all_loc_pattern <- paste(all_loc_names, collapse = "|")

# Extract all types of location names from summary_response in errors_df
extracted_locs <- str_extract_all(errors_df$summary_response, all_loc_pattern)

# Add the extracted locations back to errors_df
errors_df$Extracted_Locations <- extracted_locs

errors_df %>%
  filter(kanoon_id == '161378671')%>%
  select(summary_response)%>%
  pull()

## Making sure that Delhi are considered as a unique entity for all admin levels. 
unidentified_df<- unidentified_df %>%
  rowwise() %>%
  mutate(across(c('Zone', 'State', 'Union_Territory', 'Autonomous_Division', 
                  'Division', 'District', 'Subdistrict', 'City'),
                ~ ifelse(any(c(Zone, State, Union_Territory, Autonomous_Division, 
                               Division, District, Subdistrict, City) == "Delhi"), 
                         "Delhi", .)))


unidentified_df <- unidentified_df %>%
  mutate(across(c('State', 'Union_Territory', 'Division', 'District', 'Subdistrict', 'City'),
                ~ifelse(tolower(.) == "delhi", "Delhi", .)))

newly_identified_df <- unidentified_df %>%
  filter((State != "" & !is.na(State)) &
           (District != "" & !is.na(District)))

# Use anti_join to filter out the newly_identified cases from the unidentified_df
updated_unid_df <- unidentified_df %>%
  anti_join(newly_identified_df, by = "kanoon_id")

# View the first few rows of the updated unidentified DataFrame
head(updated_unid_df)


## Fuzzy matching
### First find all the observation that have non missing district (or below)

nonempty_admin <- updated_unid_df %>%
  filter(District != "" |
           Subdistrict != "" |
           City != "")

write.csv(nonempty_admin, paste0(interimFolder, "/nonempty_admin.csv"))
### Now attempt to identify these named locations using google map api

register_google(key = "AIzaSyD0QRf3SB_1FAR6Kt8bnK2-72YpVn9M19Q")

# Function to fetch missing administrative levels based on coordinates
get_missing_admin_levels <- function(lat, lon) {
  # Perform reverse geocoding
  address_components <- revgeocode(c(lon, lat), output = "all")
  
  # Extract administrative levels from the address components
  admin_levels <- address_components$address_components
  
  # Initialize a list to hold the admin levels
  admin_info <- list()
  
  # Populate the list with available administrative levels
  if (!is.null(admin_levels$administrative_area_level_1)) {
    admin_info$State <- admin_levels$administrative_area_level_1$long_name
  }
  if (!is.null(admin_levels$administrative_area_level_2)) {
    admin_info$District <- admin_levels$administrative_area_level_2$long_name
  }
  
  return(admin_info)
}


get_location_by_admin_levels <- function(city_name=NULL, district_name=NULL, state_name=NULL, union_territory=NULL) {
  # Initialize an empty query string
  query <- c()
  
  # Append available admin levels to the query string
  if (!is.null(city_name) && city_name != "") query <- c(query, city_name)
  if (!is.null(district_name) && district_name != "") query <- c(query, district_name)
  if (!is.null(state_name) && state_name != "") query <- c(query, state_name)
  if (!is.null(union_territory) && union_territory != "") query <- c(query, union_territory)
  
  # Combine the query components and append the country name
  query <- paste(query, collapse = ", ")
  query <- paste0(query, ", India")
  
  # Fetch location data
  location <- geocode(query, source = "google")
  
  if (nrow(location) > 0) {
    return(location)
  } else {
    return(NULL)
  }
}


# Initialize an empty list to store location details and missing admin levels
location_mapping <- list()

# Loop through the filtered DataFrame
for (i in 1:nrow(nonempty_admin)) {
  city <- nonempty_admin$City[i]
  district <- nonempty_admin$District[i]
  state <- nonempty_admin$State[i]
  union_territory <- nonempty_admin$Union_Territory[i]
  
  # Get coordinates using available admin levels
  location_data <- get_location_by_admin_levels(city, district, state, union_territory)
  
  # If coordinates are found, get missing admin levels
  if (!is.null(location_data)) {
    lat <- location_data$lat
    lon <- location_data$lon
    
    # Get missing administrative levels
    missing_admin_levels <- get_missing_admin_levels(lat, lon)
    
    # Store both coordinates and missing admin levels
    location_mapping[[paste0(city, district, state, union_territory)]] <- list("coordinates" = location_data, "missing_admin_levels" = missing_admin_levels)
  } else {
    location_mapping[[paste0(city, district, state, union_territory)]] <- "Could not find data"
  }
  
  # Pause to respect rate limits
  Sys.sleep(0.1)
}










