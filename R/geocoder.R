# This is the internal function for geocoding

census_geocoder <- function(.data){

  # create and store a csv in a temp dir
  tmp <- tempdir()
  readr::write_csv(.data, path = paste0(tmp, "addresses.csv"), col_names = FALSE)
  file <- paste0(tmp, "addresses.csv")

  # send file as request
  response <- httr::POST("https://geocoding.geo.census.gov/geocoder/locations/addressbatch",
                         body = list(addressFile = httr::upload_file(file),
                                     benchmark = "Public_AR_Current", vintage = "Current_Current"),
                         encode = "multipart")

  # parse as csv
  text <- httr::content(response, as = "text", encoding = "UTF-8")
  df <- read.csv(text = text, header = FALSE, stringsAsFactors = FALSE)

  # split and coerce class of coords
  df <- tidyr::separate(df, V6, c("lon", "lat"), sep = ",") %>%
    dplyr::mutate(lon = as(lon, "numeric"),
                  lat = as(lat, "numeric"))

  # split o_address into components
  df <- tidyr::separate(df, V2, c("o_address", "o_city" ,"o_state", "o_zip"), sep = ",")

  # apply names
  names(df) <- c("id", "o_address", "o_city" ,"o_state", "o_zip", "status", "quality", "m_address", "lon", "lat", "TIGER_line_id", "side")


  return(df)
}
