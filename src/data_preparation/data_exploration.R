library(ggplot2)

#DATA EXPLORATION 
#PREPARATION FOR ANALYSIS

#Summary Statistics
summary(pivot_table)
head(pivot_table)
tail(pivot_table)

#Checking the summary of average ratings of directors
summary(df$avg_director_rating)

#Checking the standart deviation and variance in order to see if our data has the variability
sd_avg_ratings <- sd(df$avg_director_rating)
print(sd_avg_ratings)

variance_avg_ratings <- var(df$avg_director_rating)
print(variance_avg_ratings)

#Plotting the average ratings of directors to see the distribution
hist(df$avg_director_rating, main = "Histogram of Average Director Ratings", 
     xlab = "Average Ratings")

# Plotting the top 100 listed directors and the rest to see the distribution of the groups
ggplot(pivot_table, aes(x = top_100, y = avg_director_rating, color = factor(top_100))) +
  geom_jitter(width = 0.2, alpha = 0.5) +
  theme_minimal() +
  labs(title = "Jittered Scatter Plot of Average Ratings",
       x = "Directors",
       y = "Average Ratings",
       color = "Directors") +
  scale_color_manual(values = c("0" = "magenta", "1" = "lime green"))

# Scatter plot for exploring the relationship average ratings vs. average number of votes
plot(movies_directors_df$avg_director_rating, movies_directors_df$avg_num_votes,
     xlab = "Average Director Ratings", ylab = "Average Number of Votes",
     main = "Average Director Ratings vs. Average Number of Votes")
