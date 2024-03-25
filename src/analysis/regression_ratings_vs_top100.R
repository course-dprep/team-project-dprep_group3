#ANALYSIS FOR RESEARCH QUSTIONS

library(tidyverse)

# Read data from CSV file
movies_directors_df <- read_csv("../../gen/data_preparation/output/pivot_table.csv")  


#RESEARCH QUESTION 1:Are directors listed in the top 100 more likely to receive higher average ratings compared to those who are not listed?
# Fit a linear regression model
lm_model <- lm(avg_director_rating ~ top_100, data = movies_directors_df)

# Print the summary of the model
summary(lm_model)
# Plot average ratings vs. top 100 with regression line

pdf("../../gen/analysis/output/scatterplot_avg_ratings_vs_top100.pdf")

# Plotting average director ratings vs. top 100 with regression line 
plot(movies_directors_df$top_100, movies_directors_df$avg_director_rating, 
     xlab = "Top 100 Directors", ylab = "Average Director Ratings", 
     main = "Average Director Ratings vs. Top 100 Directors",
     pch = 19, col = "lightblue")  
abline(lm_model, col = "salmon") 
legend("topleft", legend = c("Data", "Regression Line"), 
       col = c("lightblue", "salmon"), pch = c(19, NA)) 

# Close the PDF device
dev.off()

pdf("../../gen/analysis/output/correlation_matrix_avg_rating_vs_avg_votes.pdf")

#RESEARCH QUESTION 2: Is there a correlation between the average ratings of movies directed by a director and the average number of votes those movies receive?

# Calculate Pearson correlation coefficient
correlation <- cor(movies_directors_df$avg_director_rating, movies_directors_df$avg_num_votes)
print(paste("Pearson correlation coefficient:", correlation))

# Calculating correlations and creating correlation matrix
correlation_matrix <- cor(movies_directors_df[, c("avg_director_rating", "avg_num_votes")])
print(correlation_matrix)

# Plotting correlation matrix
corrplot(cor(movies_directors_df[, c("avg_director_rating", "avg_num_votes")]), method="number")

# Plotting
ggplot(movies_directors_df, aes(x = avg_director_rating, y = avg_num_votes)) +
  geom_point() +
  labs(title = "Average Ratings vs Average Votes for Directors",
       x = "Average Director Rating",
       y = "Average Number of Votes") +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +  # Add linear regression line
  geom_text(x = 4, y = 100000, label = paste("Correlation Coefficient:", round(correlation, 2)), color = "red") +
  theme_minimal()

# Close the PDF device
dev.off()