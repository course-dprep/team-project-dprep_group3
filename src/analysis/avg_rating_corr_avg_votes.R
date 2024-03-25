# ANALYSIS FOR RESEARCH QUESTION 2
install.packages("corrplot")
library(tidyverse)

# RESEARCH QUESTION 2: Is there a correlation between the average ratings of movies directed by a director and the average number of votes those movies receive?

# Read data from CSV file
movies_directors_df <- read_csv("../../gen/data_preparation/output/pivot_table.csv")

# Open PDF
pdf("../../gen/analysis/output/correlation_matrix_avg_rating_vs_avg_votes.pdf")

# Calculate Pearson correlation coefficient
correlation <- cor(movies_directors_df$avg_director_rating, movies_directors_df$avg_num_votes)
print(paste("Pearson correlation coefficient:", correlation))

# Calculating correlations and creating correlation matrix
correlation_matrix <- cor(movies_directors_df[, c("avg_director_rating", "avg_num_votes")])
print(correlation_matrix)

# Plotting correlation matrix
library(corrplot)
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