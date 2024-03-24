
library(tidyverse)

load("../../gen/data_preparation/temp/test.RData")

# MERGE

# Merge movies with ratings
movies_with_ratings <- left_join(movies, above_average_ratings, by = "tconst")

crew_directors <- left_join(crew_filtered, directors_dt, by = c("directors" = "nconst"))

movies_ratings_with_directors <- left_join(movies_with_ratings, crew_directors, by = "tconst")


# REMOVE MISSING VALUES
movies_ratings_with_directors_cleaned <- movies_ratings_with_directors %>%
  filter(complete.cases(.))

movies_ratings_with_directors_cleaned <- movies_ratings_with_directors_cleaned %>%
  filter(across(everything(), ~ !grepl("\\\\N", .x)))

# Group by directors and calculate the average rating for each director
director_avg_rating <- movies_ratings_with_directors_cleaned %>%
  group_by(directors) %>%
  summarize(avg_director_rating = mean(averageRating, na.rm = TRUE))

# Save the summarized data to a CSV file
write.csv(director_avg_rating, file = "../../gen/data_preparation/temp/director_avg_rating.csv", row.names = FALSE)

# Perform a left join between the original data frame and the summarized data frame
merged_movies_directors_avgratings <- left_join(movies_ratings_with_directors_cleaned, director_avg_rating, by = "directors")

##Getting the directors who have movies above the average # of movies for each director

# Step 1: Count the number of movies each director has
directors_count <- merged_movies_directors_avgratings  %>%
  group_by(directors) %>%
  summarise(num_movies = n())

# Step 2: Get the Average of # of movies
average_numMovies_directors <- mean(directors_count$num_movies)
average_numMovies_directors

# Create a new data frame containing rows where # of movies are above the average
above_average_movies <- directors_count[directors_count$num_movies > average_numMovies_directors, ]

write.csv(above_average_movies, file = "../../gen/data_preparation/temp/above_average_movies.csv", row.names = FALSE)

# Step 3: Merge the dataset by removing movies directed by those directors
merged_movies_directors_avg_ratings <- left_join(above_average_movies, merged_movies_directors_avgratings, by = "directors")


# Perform a left join for top 100 directors with average ratings of directors 
top_100_director_ratings <- left_join(top_100_directors_filtered , merged_movies_directors_avgratings, by = "directors")

top_100_directors_filtered <- directors %>%
  select(Position, Const)

# REMOVE MISSING VALUES from Imbd top 100 directors list 
top_100_director_ratings_cleaned <- top_100_director_ratings %>%
  filter(complete.cases(.))

top_100_director_ratings_cleaned <- top_100_director_ratings_cleaned %>%
  filter(across(everything(), ~ !grepl("\\\\N", .x)))

#adding 0-1 column for top 100 directors to see which directors are in top 100 directors list of Imdb and which are not
merged_movies_directors_avg_ratings <- merged_movies_directors_avg_ratings %>%
  mutate(top_100 = if_else(directors %in% top_100_director_ratings_cleaned$directors, 1, 0))

# Store the final data frame as movies_directors_avg_ratings.csv
write.csv(merged_movies_directors_avg_ratings, "../../gen/data_preparation/output/movies_directors_avg_ratings.csv")