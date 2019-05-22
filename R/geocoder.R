# This is the internal function for geocoding

census_geocoder <- function(.data, timeout){

  # create and store a csv in a temp dir
  tmp <- tempdir()
  readr::write_csv(.data, path = paste0(tmp, "addresses.csv"), col_names = FALSE)
  file <- paste0(tmp, "addresses.csv")

  # send file as request
  response <- httr::POST("https://geocoding.geo.census.gov/geocoder/locations/addressbatch",
                         body = list(addressFile = httr::upload_file(file),
                                     benchmark = "Public_AR_Current", vintage = "Current_Current"),
                         encode = "multipart", timeout(timeout))

  # parse as csv
  text <- httr::content(response, as = "text", encoding = "UTF-8")
  df <- read.csv(text = text, header = FALSE, stringsAsFactors = FALSE)

  # split and coerce class of coords
  df <- tidyr::separate(df, V6, c("lon", "lat"), sep = ",") %>%
    dplyr::mutate(lon = as(lon, "numeric"),
                  lat = as(lat, "numeric"))

  # split o_address into components
  df <- tidyr::separate(df, V2, c("address", "city" ,"state", "zip"), sep = ",")

  # apply names
  names(df) <- c("id", "address", "city" ,"state", "zip", "status", "quality", "match_address", "lon", "lat", "TIGER_line_id", "side")

  # coerce zip to numeric, and remove spaces from state and
  df <- dplyr::mutate(df, zip = as(zip, "numeric"),
                      city = trimws(city, "left"),
                      state = trimws(state, "left"))

  return(df)
}
