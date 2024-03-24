OUTPUT = ../../gen/analysis/output

first: $(OUTPUT)/scatterplot_avg_ratings_vs_top100.pdf $(OUTPUT)/correlation_matrix_avg_rating_vs_avg_votes.pdf $(OUTPUT)/anova_interaction_top100_directors.pdf

../../gen/data_preparation/output/pivot_table.csv:
	make -C ../data_preparation -f Makefile first

$(OUTPUT)/scatterplot_avg_ratings_vs_top100.pdf $(OUTPUT)/correlation_matrix_avg_rating_vs_avg_votes.pdf $(OUTPUT)/anova_interaction_top100_directors.pdf: ../../gen/data_preparation/output/pivot_table.csv analysis_model.R
	Rscript --vanilla analysis_model.R
	
clean:
	R -e "unlink('../../gen/analysis/temp/*.*')"