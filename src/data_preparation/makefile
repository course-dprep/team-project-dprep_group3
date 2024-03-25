DATA = ../../data
GEN = ../../gen

first: $(GEN)/data_preparation/output/pivot_table.csv $(GEN)/data_preparation/output/data_exploration.html

#Data Exploration
$(GEN)/data_preparation/output/data_exploration.html: $(GEN)/data_preparation/output/pivot_table.csv data_exploration.Rmd
	R -e "Sys.setenv(RSTUDIO_PANDOC='C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools'); rmarkdown::render('data_exploration.Rmd', output_file='$(GEN)/data_preparation/output/data_exploration.html')"

#Pivot table
$(GEN)/data_preparation/output/pivot_table.csv: $(GEN)/data_preparation/output/movies_directors_avg_ratings.csv pivot_table.R
	Rscript pivot_table.R

#Merged data
$(GEN)/data_preparation/temp/director_avg_rating.csv $(GEN)/data_preparation/temp/above_average_movies.csv $(GEN)/data_preparation/output/movies_directors_avg_ratings.csv: $(GEN)/data_preparation/temp/above_average_numVotes.csv $(GEN)/data_preparation/temp/cleaned_data.RData merged_data.R
	Rscript merged_data.R

#Clean data
$(GEN)/data_preparation/temp/above_average_numVotes.csv $(GEN)/data_preparation/temp/cleaned_data.RData: $(DATA)/crew.csv $(DATA)/ratings.csv $(DATA)/name.csv $(DATA)/basics.csv $(DATA)/top_100.csv clean_data.R
	Rscript clean_data.R
	
#Download data
$(DATA)/crew.csv $(DATA)/ratings.csv $(DATA)/name.csv $(DATA)/basics.csv $(DATA)/top_100.csv: download_data.R
	Rscript download_data.R
	
clean:
	R -e "unlink('$(GEN)/data_preparation/temp/*.*')"