#' Prepare Data for Geocoding with Addresses Using the Census Bureau API
#'
#'
#' @param .data Name of the data.frame containing address component variables
#' @param id Vector or name of column containing unique identifier for every observation
#' @param address Name of column containing house number and street name
#' @param city Name of column containing city
#' @param state Name of column containing state
#' @param zip Name of column containing zipcode
#'
#'@export
census_prep <- function(.data, id, address, city = NA, state = NA, zip = NA){
  # check for missing values

  # check length of data.frame
  if(length(.data) > 9999){stop("The Census API only supports up to 10,000 addresses at a time.")}

  # setup non-standard evaluation

  # prepare a data frame

  # save as a csv in a temp file

  # query the census bureau API

  # convert resultant csv back to data.frame

  ## project if neccessary

  # check if sf package is installed, return warning if not
  if(isTRUE(sf)&!requireNamespace("sf")){stop("The `sf` package does not seem to be installed")}

  # project to sf object
  sf::st_as_sf()

  ## return output
}
