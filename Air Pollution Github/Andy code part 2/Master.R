
package_vector <- c("foreign", "sandwich","ggplot2", "tidyverse", "plm", "dplyr",
                    "purrr", "haven", "jsonlite", "sf", "rnaturalearth",
                    "rnaturalearthdata", "ggforce", "patchwork", 
                    "stringdist", "readxl","knitr", "writexl", 
                    "stringr", "textTinyR", "fuzzywuzzyR","tm", "SnowballC", 
                    "superml","countrycode", "pbapply","tidytext", "data.table",
                    "reshape2", "spacyr", "ggmap", 'httr', 'jsonlite', 'stringi',
                    'openai')

install_and_load_packages <- function(packages) {
  for(package in packages) {
    if(!require(package, character.only = TRUE)) {
      install.packages(package)
      library(package, character.only = TRUE)
    }
  }
}

install_and_load_packages(package_vector)

setwd("C:/Users/andre/OneDrive - AWJCorp/Work/Georgetown RA/Joshi-DeJure")

projectFolder <- "C:/Users/andre/OneDrive - AWJCorp/Work/Georgetown RA/Joshi-DeJure"
dataFolder <- paste0(projectFolder,"/0_data")
finalFolder <- paste0(dataFolder,"/final")
interimFolder <- paste0(dataFolder,"/interim")
rawFolder <- paste0(dataFolder,"/raw")
dofilesFolder <- paste0(projectFolder,"/1_dofiles")
outputFolder <- paste0(projectFolder,"/2_output")
figuresFolder <- paste0(outputFolder,"/figures")
logsFolder <- paste0(outputFolder,"/logs")
tablesFolder <- paste0(outputFolder,"/tables")
literatureFolder <- paste0(projectFolder,"/3_literature")
documentationFolder <- paste0(projectFolder,"/4_documentation")



#source(paste0(dofilesFolder, "Locations.R"))
