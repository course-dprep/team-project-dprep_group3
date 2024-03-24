#download data

library(tidyverse)

options(timeout = max(1000, getOption("timeout")))

download_data <- function(url, filename, output_directory){
  if (!dir.exists(output_directory)) {
    dir.create(output_directory, recursive = TRUE)
  }
  download.file(url = url, destfile = file.path(output_directory, paste0(filename, ".csv")))
}

output_directory <- '../../data'

url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
url_ratings <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
url_names <- "https://datasets.imdbws.com/name.basics.tsv.gz"
url_basics <- "https://datasets.imdbws.com/title.basics.tsv.gz"
url_top_100 <- "https://www.imdb.com/list/ls020777593/export?ref_=nmls_otexp"

download_data(url_crew, "crew", output_directory)
download_data(url_ratings, "ratings", output_directory)
download_data(url_names, "names", output_directory)
download_data(url_basics, "basics", output_directory)
download_data(url_top_100, "top_100", output_directory)

