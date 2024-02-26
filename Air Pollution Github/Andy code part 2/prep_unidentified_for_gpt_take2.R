unidentified_df <- read.csv(paste0(interimFolder, "/unidentified.csv"))
error_df <- subset(unidentified_df, location == 'ERROR')
raw_df <- read.csv(paste0(rawFolder, '/possible_air_corpus_with_meta_and_text.csv'))
raw_append <- read.csv(paste0(rawFolder, '/case_data_final_with_additional_variables.csv'))

raw_df<- select(raw_df, kanoon_id, text)
raw_append <- select(raw_append, Kanoon_ID, text)
raw_append <- raw_append %>%
  rename(kanoon_id = Kanoon_ID)

raw_case_df <- rbind(raw_df, raw_append)

error_df <- select(error_df, kanoon_id, location)


unidentified_text_df <- merge(unidentified_df, raw_case_df, by = 'kanoon_id', all = F)
unidentified_text_df <- unidentified_text_df %>%
  mutate(index = row_number())


raw_error_df <- merge(error_df, raw_case_df, by = 'kanoon_id', all = F)
raw_error_df <- raw_error_df %>%
  mutate(index = row_number())

#Somehow there are only 41 matches from the original raw file. Not sure where the 
#kanoon id went? Shouldn't them be  1-1 match? 
#So imma test if the chatgpt can be entirely matched to the raw file and figure out why some 
#ids are missing. 

write.csv(unidentified_text_df, paste0(interimFolder, '/unidentified_text.csv'))
write.csv(raw_error_df, paste0(interimFolder, '/error_text.csv'))





chatgptfull <- read.csv(paste0(rawFolder, '/chatgptfull.csv'))

merge_check <- merge(chatgptfull, raw_df, by = 'kanoon_id', all=F)

merged_unidentified <- merge(unidentified_df, raw_df, by = 'kanoon_id', all=F)

set.seed(2639)

random_ids <- sample(merged_unidentified$kanoon_id, 100, replace = F)
tests <- subset(merged_unidentified, kanoon_id %in% random_ids)

# Add an index column to the tests data frame
tests <- tests %>%
  mutate(index = row_number())


source(paste0(dofilesFolder, '/gpt_take2.r'))
