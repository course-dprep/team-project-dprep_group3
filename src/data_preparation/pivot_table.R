#PIVOT TABLE

## import the data
df <- read_csv("aggregated_df.csv")


## Create pivot table 
# Pivot the data to get average rating for each director
pivot_table <- df %>%
  group_by(directors, primaryName,top_100) %>%
  summarize(avg_director_rating = mean(avg_director_rating, na.rm = TRUE))
            ##top_100 = mean(top_100, na.rm= TRUE)) 


write_csv(pivot_table, "pivot_table.csv")



