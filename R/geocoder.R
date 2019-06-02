# This is the internal function for geocoding
#
#' @importFrom readr write_csv
#' @importFrom dplyr %>% mutate
#' @importFrom httr POST upload_file timeout content
#' @importFrom tidyr separate_
#
census_geocoder <- function(.data, timeout){

  # create and store a csv in a temp dir
  tmp <- tempdir()
  readr::write_csv(.data, path = paste0(tmp, "addresses.csv"), col_names = FALSE, na = "")
  file <- paste0(tmp, "addresses.csv")

  # send file as request
  response <- httr::POST("https://geocoding.geo.census.gov/geocoder/locations/addressbatch",
                         body = list(addressFile = httr::upload_file(file),
                                     benchmark = "Public_AR_Current", vintage = "Current_Current"),
                         encode = "multipart", httr::timeout(timeout))

  # parse as csv
  text <- httr::content(response, as = "text", encoding = "UTF-8")
  df <- read.csv(text = text, header = FALSE, stringsAsFactors = FALSE)

  # split original address into components
  df <- tidyr::separate_(df, "V2", c("address", "city" ,"state", "zip"), sep = ",")

  # coerce zip to numeric, and remove spaces from state and city
  df <- dplyr::mutate(df, zip = as(zip, "numeric"),
                      city = trimws(city, "left"),
                      state = trimws(state, "left"))

  # special parse case for no matches so that it can bind in large batches
  if(length(df) < 7){
    warning("No Matches Found for this Batch")
    l = rep_len(NA, nrow(df))
    non <- data.frame(quality = l, match_address = l, lon = l, lat = l, TIGER_line_id = l, side = l)
    df <- cbind(df, non)
  }
  else{
  # split and coerce class of coords
  df <- tidyr::separate_(df, "V6", c("lon", "lat"), sep = ",") %>%
    dplyr::mutate(lon = as(lon, "numeric"),
                  lat = as(lat, "numeric"))
  }
  # apply names
  names(df) <- c("id", "address", "city" ,"state", "zip", "status", "quality", "match_address", "lon", "lat", "TIGER_line_id", "side")

  return(df)
}
