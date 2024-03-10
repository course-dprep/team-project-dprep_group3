#download data
download_data <- function(url, filename){
  download.file(url = url, destfile = paste0(filename, ".csv"))
}

url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
url_ratings <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
url_name <- "https://datasets.imdbws.com/name.basics.tsv.gz"
url_basics <- "https://datasets.imdbws.com/title.basics.tsv.gz"


download_data(url_crew, "crew")
download_data(url_ratings, "ratings")
download_data(url_name, "name")
download_data(url_basics, "basics")

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

# MERGE

# Merge movies with ratings
movies_with_ratings <- left_join(movies, ratings, by = "tconst")

crew_directors <- left_join(crew_filtered, directors_dt, by = c("directors" = "nconst"))

movies_ratings_with_directors <- left_join(movies_with_ratings, crew_directors, by = "tconst")


# REMOVE MISSING VALUES
movies_ratings_with_directors_cleaned <- movies_ratings_with_directors %>%
  filter(complete.cases(.))

movies_ratings_with_directors_cleaned <- movies_ratings_with_directors_cleaned %>%
  filter(across(everything(), ~ !grepl("\\\\N", .x)))

# Store the final data frame as aggregated_df.csv
write_csv(movies_ratings_with_directors_cleaned, "aggregated_df.csv")