#' Geocode Addresses Batches Using the Census Bureau API
#'
#'
#' @param .data A properly formatted data.frame containing addresses to geocode
#' @param sf If TRUE, returns data in an SF class object
#' @param batch If TRUE, allows for the geocoding of 10,000 or more addresses
#'
#' @description It is recomended that `census_batch()` be used in a pipe with `census_prep()`. See `vignette("censusxy")` for more details and example code.
#' Since the census API will only accept batches of 10000, for more than 10000 addresses you can use a for loop or apply function to iterate multiple batches. As there is no limit on the Census API, but please use this functionality responsibly.
#'
#'@export
census_batch <- function(.data, sf = FALSE, batch = FALSE){
  #check that data is specified and meets the format requirements.
  if(isFALSE(batch)&{length(.data) > 9999}){stop("For 10,000 or more requests, please set the batch argument to TRUE")}

  #

  # save as a csv in a temp file

  # query the census bureau API

  # convert resultant csv back to data.frame

  # project if neccessary

  if(isTRUE(sf)){
  # check if sf package is installed, stop and warn if not
  if(!requireNamespace("sf")){stop("The `sf` package does not seem to be installed")}

  # remove missing observations (Mandatory for sf) and return warning
  input <- length(.data) # original data length

  sf_prep <- dplyr::filter(response, !is.na(lat)) # remove missing spatial

  # warn and report number filtered
  warning(paste0(input - length(sf_prep)," Observations with missing spatial data were removed in order to create an SF object"))

  # project to sf object
  sf::st_as_sf(sf_prep, coords = c(x = lat, y = long), crs = 4326)

  }
}
