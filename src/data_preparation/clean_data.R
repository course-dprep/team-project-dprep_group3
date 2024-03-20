
# CLEAN DATA

crew <- read_delim("crew.csv", delim = "\t", col_names = TRUE)
ratings <- read_delim("ratings.csv", delim = "\t", col_names = TRUE)
name <- read_delim("name.csv", delim = "\t", col_names = TRUE)
basics <-read_delim("basics.csv", delim = "\t", col_names = TRUE)
directors <- read.csv("top.100.directors.csv", header = TRUE, sep = ",")

# FILTER
# Filter for Movies

movies <- basics %>%
  filter(titleType == "movie") %>%
  select(tconst) # Keeping only the tconst identifier for merging

# Filter to include only those whose primaryProfession includes 'director' in "name" file
# Load necessary libraries


directors_dt <- name %>%
  filter(str_detect(primaryProfession, "director")) %>%
  select(-birthYear, -deathYear, -knownForTitles)

# for "crew" file writers column removed
crew_filtered <- crew %>%
  select(tconst, directors)

# Calculate the average of numVotes 
average_numVotes <- mean(ratings$numVotes)

# Create a new data frame containing rows where numVotes is above the average
above_average_ratings <- ratings[ratings$numVotes > average_numVotes, ]

write.csv(above_average_ratings, file = "above_average_numVotes.csv", row.names = FALSE)

# Group by directors and calculate the average rating for each director
director_avg_rating <- directors %>%
  group_by(directors) %>%
  summarize(avg_rating = mean(avgRating, na.rm = TRUE))

# Save the summarized data to a CSV file
write.csv(director_avg_rating, file = "director_avg_rating.csv", row.names = FALSE)

#Cleaning the top 100 directors data set
top_100_directors_filtered <- directors %>%
  select(Position, Const)

#Match the column names of top 100 directors with other data sets
colnames(top_100_directors_filtered) <- c("position", "directors")
