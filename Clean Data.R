
# CLEAN DATA

library(data.table)
library(readr)
library(dplyr)

crew <- read_delim("crew.csv", delim = "\t", col_names = TRUE)
ratings <- read_delim("ratings.csv", delim = "\t", col_names = TRUE)
name <- read_delim("name.csv", delim = "\t", col_names = TRUE)
basics <-read_delim("basics.csv", delim = "\t", col_names = TRUE)

# FILTER
# Filter for Movies
library(dplyr)

movies <- basics %>%
  filter(titleType == "movie") %>%
  select(tconst) # Keeping only the tconst identifier for merging

# Filter to include only those whose primaryProfession includes 'director' in "name" file
# Load necessary libraries
library(stringr)

directors_dt <- name %>%
  filter(str_detect(primaryProfession, "director")) %>%
  select(-birthYear, -deathYear, -knownForTitles)

# for "crew" file writers column removed
crew_filtered <- crew %>%
  select(tconst, directors)
