#' Geocode Addresses Using the Census Bureau Geocoder
#'
#' @param .data Dataframe containing address data
#' @param id Unique identifier for
#' @param address
#' @param city
#' @param state
#' @param zip
#'
#' @return
#' @export
#'
#' @examples
cxy_geocode <- function(.data, id = NA, address, city = NA, state = NA, zip = NA, timeout = 30){

  #TODO Add NSE

  #TODO Add warnings
    # omission of City, State, Zip makes lesss accurate and significantly slower

  # prepare and split
  censusxy:::census_prep(.data, id, address, city, state, zip) -> prep
  censusxy:::census_split(prep) -> split

  # convert timeout to min
  timeout <- timeout * 60

  response <- vector("list", length(split))

  for (i in seq_along(split)) {
   response[[i]] <- try(
     censusxy:::census_geocoder(split[[i]], timeout)
     )
  }
  # remove any list element of class try-catch
  response <- response[sapply(response, function(x) class(x) != "try-error")]

  response <- dplyr::bind_rows(response)
  result <- left_join(prep, response, by = c("address", "city", "state", "zip"))

  # return result
  return(result)
}
