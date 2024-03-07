#download data

download_data <- function(url, filename){
  download.file(url = url, destfile = paste0(filename, ".csv"))
}

url_crew <- "https://datasets.imdbws.com/title.crew.tsv.gz"
url_ratings <- "https://datasets.imdbws.com/title.ratings.tsv.gz"

download_data(url_crew, "crew")
download_data(url_ratings, "ratings")

