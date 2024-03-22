#PIVOT TABLE
library(dplyr)
##import the data
df <- read_csv("movies_directors_avg_ratings.csv")


## Create pivot table 
# Pivot the data to get average rating for each director
pivot_table <- df %>%
  group_by(directors, primaryName,top_100) %>%
  summarize(avg_director_rating = mean(avg_director_rating, na.rm = TRUE),
            num_movies = mean(num_movies, na.rm= TRUE),
            avg_num_votes = mean(numVotes, na.rm= TRUE))
#Changing the column order
new_order <- c("directors","primaryName","num_movies","avg_num_votes","avg_director_rating","top_100")
pivot_table <- pivot_table %>% 
  select(new_order)

write_csv(pivot_table, "pivot_table.csv")
