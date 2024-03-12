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