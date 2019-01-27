#' Prepare Data for Geocoding with Addresses Using the Census Bureau API
#'
#'
#' @param .data Name of the data.frame containing address component variables
#' @param address Name of column containing house number and street name
#' @param id Name of column containing unique identifier for every observation
#' @param city Name of column containing city
#' @param state Name of column containing state
#' @param zip Name of column containing zipcode
#'
#' @importFrom dplyr select
#'
#'@export
census_prep <- function(.data, address, id = NA, city = NA, state = NA, zip = NA){

  # check for missing values
  if(missing(.data)){stop('Please specify an argument for .data')}
  if(missing(address)){stop('Please specify an argument for address')}

  # warn for ommitted city state zip
  if(is.na(city) | is.na(state) | is.na(zip)){warning('Omission of City, State or Zip drastically reduces the rate of successful geocoding, only omit if absolutely neccessary.')}

  # prepare vectors
  n_obs <- nrow(.data)

  if(is.na(id)){id <- seq(from = 1, to = n_obs, by = 1)
  message('Unique ID Automatically Generated')}
  else if(!is.na(id)){id <- dplyr::select(.data, id)}

  if(!is.na(city)){city <- dplyr::select(.data, city)}
  if(!is.na(state)){state <- dplyr::select(.data, state)}
  if(!is.na(zip)){zip <- dplyr::select(.data, zip)}

  # prepare a data frame

  prep <- data.frame(id = id, address = .data[address], city = city, state = state, zip = zip)

  ## return output
  return(prep)

}
