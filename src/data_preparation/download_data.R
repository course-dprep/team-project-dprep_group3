#download data

library(data.table)
library(readr)
library(dplyr)
library(stringr)

download_data <- function(url, filename){
  download.file(url = url, destfile = paste0(filename, ".csv"))
}

url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
url_ratings <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
url_names <- "https://datasets.imdbws.com/name.basics.tsv.gz"
url_basics <- "https://datasets.imdbws.com/title.basics.tsv.gz"
url_top_100 <- "https://www.imdb.com/list/ls020777593/export?ref_=nmls_otexp"

download_data(url_crew, "crew")
download_data(url_ratings, "ratings")
download_data(url_names, "names")
download_data(url_basics, "basics")
download_data(url_top_100, "top_100")
