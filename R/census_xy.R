#' Geocode Addresses Batches Using the Census Bureau API
#'
#'
#' @param .data A properly formatted data.frame containing addresses to geocode
#'
#' @description It is recomended that `census_batch()` be used in a pipe with `census_prep()`. See `vignette("censusxy")` for more details and example code.
#' Since the census API will only accept batches of 10000, for more than 10000 addresses you can use a for loop or apply function to iterate multiple batches. As there is no limit on the Census API, but please use this functionality responsibly.
#'
#'@export
census_batch <- function(.data, sf = FALSE){
  #check that data is specified and meets the format requirements.
  if(length(.data) > 10000){stop("The Census API only supports up to 10000 Requests")}

  #

  # check if sf package is installed, return warning if not
  if(isTRUE(sf)&!requireNamespace("sf")){stop("The `sf` package does not seem to be installed")}

  # project to sf object
  sf::st_as_sf()

}
