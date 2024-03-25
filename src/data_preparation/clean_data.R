library(tidyverse)

# CLEAN DATA
crew <- read_delim("../../data/crew.csv", delim = "\t", col_names = TRUE)
ratings <- read_delim("../../data/ratings.csv", delim = "\t", col_names = TRUE)
name <- read_delim("../../data/names.csv", delim = "\t", col_names = TRUE)
basics <-read_delim("../../data/basics.csv", delim = "\t", col_names = TRUE)
directors <- read_csv("../../data/top_100.csv")

# FILTER
# Filter for Movies
movies <- basics %>%
  filter(titleType == "movie") %>%
  select(tconst) # Keeping only the tconst identifier for merging

# Filter to include only those whose primaryProfession includes 'director' in "name" file
directors_dt <- name %>%
  filter(str_detect(primaryProfession, "director")) %>%
  select(-birthYear, -deathYear, -knownForTitles)

# for "crew" file writers column removed
crew_filtered <- crew %>%
  select(tconst, directors)

# Calculate the average of numVotes from ratings dataset
average_numVotes <- mean(ratings$numVotes)

# Create a new data frame containing rows where numVotes is above the average
above_average_ratings <- ratings[ratings$numVotes > average_numVotes, ]

write_csv(above_average_ratings, file = "../../gen/data_preparation/temp/above_average_numVotes.csv")

#Cleaning the top 100 directors data set
top_100_directors_filtered <- directors %>%
  select(Position, Const)

#Match the column names of top 100 directors with other data sets
colnames(top_100_directors_filtered) <- c("position", "directors")

# Save cleaned data
save.image("../../gen/data_preparation/temp/cleaned_data.RData")

