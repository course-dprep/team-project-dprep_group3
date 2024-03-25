OUTPUT = ../../gen/analysis/output

first: $(OUTPUT)/scatterplot_avg_ratings_vs_top100.pdf $(OUTPUT)/correlation_matrix_avg_rating_vs_avg_votes.pdf $(Output)/anova_interaction_model.pdf


../../gen/data_preparation/output/pivot_table.csv:
	make -C ../data_preparation -f Makefile first
	
#Analysis Visualisation RQ3
$(Output)/anova_interaction_model.pdf: ../../gen/data_preparation/output/pivot_table.csv anova_avg_rating_interaction_model.Rmd
	R -e "Sys.setenv(RSTUDIO_PANDOC='C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools'); rmarkdown::render('anova_avg_rating_interaction_model.Rmd', output_file='../../gen/analysis/output/anova_interaction_model.pdf')"

#Analysis Visualisation RQ2
$(OUTPUT)/correlation_matrix_avg_rating_vs_avg_votes.pdf: ../../gen/data_preparation/output/pivot_table.csv avg_rating_corr_avg_votes.R
	Rscript avg_rating_corr_avg_votes.R

#Analysis Visualisation RQ1
$(OUTPUT)/scatterplot_avg_ratings_vs_top100.pdf: ../../gen/data_preparation/output/pivot_table.csv regression_ratings_vs_top100.R
	Rscript regression_ratings_vs_top100.R
	
clean:
	R -e "unlink('../../gen/analysis/temp/*.*')"