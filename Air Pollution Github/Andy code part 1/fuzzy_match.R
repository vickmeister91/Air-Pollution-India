identified_df <- read.csv(paste0(interimFolder, '/identified.csv'))
canon_districts <- read_excel(paste0(rawFolder, '/List_state_district.xlsx'))
canon_districts <- canon_districts %>%
  rename(
    canon_state = State, 
    canon_district = District
  )
colnames(canon_districts)
colnames(identified_df)

canon_districts$canon_district <- trimws(canon_districts$canon_district)
identified_df$District <- trimws((identified_df$District))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'New Delhi', 'Delhi', District))

canon_districts <- canon_districts%>%
  mutate(canon_district = ifelse(str_detect(canon_district, 'Thiruvallur'),
                                 'Tiruvallur', 
                                 canon_district))

canon_districts <- canon_districts%>%
  mutate(canon_district = ifelse(str_detect(canon_district, 'Bangalore'),
                                 'Bangalore', 
                                 canon_district))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Mumbai', 'Mumbai City', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Dholpur', 'Dhaulpur', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Sri Ganganagar', 'Ganganagar', District))
identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Bengaluru Urban', 'Bhagalpur', District))
identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Mysuru', 'Mysore', District))
identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Bangaluru', 'Bangalore', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Gurugram', 'Gurgaon', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Kheri', 'Lakhimpur Kheri', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Krishnagiri', 'Krishna', District))
identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Mehsana', 'Mahesana', District))



identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(City, 'Bangalore'),
                           'Bangalore', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(City, 'Delhi'),
                           'Delhi', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(District, 'Delhi'),
                           'Delhi', District))
identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(District, 'Bangalore'),
                           'Bangalore', District))
identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(District, 'kutch'),
                           'Kachchh', District))

identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(District, 'Tirunelveli'),
                           'Tirunelveli Kattabo', District))




identified_df<- identified_df %>%
  mutate(District = ifelse(str_detect(City, 'Hyderabad'),
                           'Hyderabad', District))

identified_df <- identified_df %>%
  mutate(District = ifelse(str_detect(District, 'Ranga Reddy'),
                           'Rangareddi',
                           District))
identified_df<- identified_df %>%
  mutate(District = ifelse(District == 'Ballari', 'Ballary', District))



# Remove the trailing ' District' using stringr
identified_df$District <- str_replace(identified_df$District, " District$", "")




dist_matrix <- stringdistmatrix(a = canon_districts$canon_district,
                                b = identified_df$District,
                                method = 'lv')
min_values <- apply(dist_matrix, 1, min)
min_index <- apply(dist_matrix, 1, which.min)

matched_df <- data.frame()

# Loop through each row in identified_df
for(i in 1:nrow(identified_df)) {
  dist_vector <- stringdist::stringdist(a = canon_districts$canon_district,
                                        b = identified_df$District[i],
                                        method = 'lv')
  
  min_value <- min(dist_vector)
  min_index <- which.min(dist_vector)
  
  similarity_score = 1 - (min_value / nchar(identified_df$District[i]))
  
  temp_df <- data.frame(identified_df[i, ], 
                        matched_canon_district = canon_districts$canon_district[min_index],
                        similarity_score = similarity_score)
  
  matched_df <- rbind(matched_df, temp_df)
}
perfect_fuzz <-filter(matched_df, similarity_score ==1)
good_fuzz <- filter(matched_df, similarity_score >= 0.75)
bad_fuzz <- filter(matched_df, similarity_score <0.75)

View(bad_fuzz)


write.csv(good_fuzz, paste0(interimFolder, '/canon_identified.csv'))
write.csv(bad_fuzz, paste0(interimFolder, '/bad_matches_fuzz.csv'))

