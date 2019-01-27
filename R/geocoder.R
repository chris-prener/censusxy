# This is the internal function for geocoding
# much of the code is borrowed from https://github.com/dmwelgus/MapChi
#
#
census_geocoder <- function (df){

  # convert a df to a csv in a temporary directory.
  tmp <- tempdir()
  readr::write_csv(df, path = paste0(tmp, "addresses.csv"), col_names = FALSE)
  file <- paste0(tmp, "addresses.csv")

  # This part posts a file of addresses
  response <- httr::POST("https://geocoding.geo.census.gov/geocoder/locations/addressbatch",
                    body = list(addressFile = httr::upload_file(file),
                                benchmark = 9, vintage = "Census2010_Census2010"),
                    encode = "multipart")

  ###### Functions need to be defined----------------------------------
  length_15 <- function(x) {
    if (length(x) == 15) {
      x <- x
    } else {
      x <- c(x, rep(NA, 15-length(x)))
    }
    return(x)
  }
  strip_both <- function(x) {
    n <- nchar(x)
    return(substr(x, 2, n - 1))
  }
  strip_left <- function(x) {
    n <- nchar(x)
    return(substr(x, 2, n))
  }
  strip_right <- function(x) {
    n <- nchar(x)
    return(substr(x, 1, n - 1))
  }
  #####--------------------------------------------------

  # begin parsing
  content <- httr::content(response, encoding = "UTF-8")
  df1 <- strsplit(content, split = "\\\n")[[1]]
  df2 <- sapply(df1, strsplit, split = ",")
  clean <- lapply(df2, length_15)

  ####
  h1   <- t(as.data.frame(clean)) #transpose df
  h2   <- as.data.frame(h1)
  h2[] <- lapply(h2, as.character)

  both_vars <- c("V1", "V5", "V6", "V7", "V11", "V14", "V15")
  left_vars <- c("V2", "V8", "V12")
  h2[, both_vars] <- lapply(h2[, both_vars], strip_both)
  h2[, left_vars] <- lapply(h2[, left_vars], strip_left)

  h2$V13 <- strip_right(h2$V13)

  h2[] <- lapply(h2, stringr::str_trim)
  names(h2) <- c("id", "o_address", "o_city", "o_state", "o_zip", "status", "quality",
                "m_address", "m_city", "m_state", "m_zip", "long", "lat", "TIGER_line_id", "side")

  return(data.frame(h2, row.names = NULL)) # return df with no row names

}
