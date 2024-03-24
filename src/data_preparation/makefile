DATA = ../../data
GEN = ../../gen

#pivot table
$(GEN)/data_preparation/output/pivot_table.csv: $(GEN)/data_preparation/output/movies_directors_avg_ratings.csv pivot_table.R
	Rscript --vanilla pivot_table.R

#merged data
$(GEN)/data_preparation/temp/director_avg_rating.csv $(GEN)/data_preparation/temp/above_average_movies.csv $(GEN)/data_preparation/output/movies_directors_avg_ratings.csv: $(GEN)/data_preparation/temp/above_average_numVotes.csv $(GEN)/data_preparation/temp/test.RData merged_data.R
	Rscript --vanilla merged_data.R

#clean data
$(GEN)/data_preparation/temp/above_average_numVotes.csv $(GEN)/data_preparation/temp/test.RData: $(DATA)/crew.csv $(DATA)/ratings.csv $(DATA)/name.csv $(DATA)/basics.csv $(DATA)/top_100.csv clean_data.R
	Rscript --vanilla clean_data.R
	
#download data
$(DATA)/crew.csv $(DATA)/ratings.csv $(DATA)/name.csv $(DATA)/basics.csv $(DATA)/top_100.csv: download_data.R
	Rscript --vanilla download_data.R