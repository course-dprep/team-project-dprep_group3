
#PIVOT TABLE

## import the data
df <- read_csv("aggregated_df.csv")


## Create pivot table 
# Pivot the data to get average rating for each director
pivot_table <- df %>%
  group_by(directors, primaryName, tconst) %>%
  summarize(avg_rating = mean(averageRating, na.rm = TRUE),
            total_votes = sum(numVotes, na.rm = TRUE)) %>%
  arrange(desc(avg_rating))  # Sort by average rating in descending order


write_csv(pivot_table, "pivot_table.csv")
