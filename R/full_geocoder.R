#' Geocode Addresses Using the Census Bureau Geocoder
#'
#' @param .data dataframe containing address data. Mandatory if using column names
#' @param id (Optional) Unique identifier for each observation
#' @param address Either a character vector or column name containing address
#' @param city (Optional) Either a character vector or column name containing city
#' @param state (Optional) Either a character vector or column name containing state
#' @param zip (Optional) Either a character/numeric vector or column name containing 5-digit zip code
#' @param timeout Maximum number of minutes for each API call to the geocoder.
#'
#' @description This is the single function of the censusxy package, allowing for the easy geocoding of US Addresses using the US Census Bureau Geocoder. This function allows for flexible input and virtually unlimited batch sizes. See the vignette \code{vignette(censusxy)} for more details
#'
#' @importFrom dplyr bind_rows left_join
#'
#' @return a dataframe containing a parsed census geocoder response
#'
#' @export
cxy_geocode <- function(.data, id = NA, address, city = NA, state = NA, zip = NA, timeout = 30){

  #Non Standard Eval
  if(!missing(.data)){
    # save parameters to list for quoting
    paramList <- as.list(match.call())

    if(!is.na(id)){
      id <- rlang::quo_name(rlang::enquo(id))
    }
      address <- rlang::quo_name(rlang::enquo(address))
    if(!is.na(city)){
      city <- rlang::quo_name(rlang::enquo(city))
    }
    if(!is.na(state)){
      state <- rlang::quo_name(rlang::enquo(state))
    }
    if(!is.na(zip)){
      zip <- rlang::quo_name(rlang::enquo(zip))
    }
  }

  # errors and warnings
    if(missing(address)){stop("A character vector or column containing address must be supplied")}
    if(any(is.na(city), is.na(state), is.na(zip))){warning("Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder")}

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

  suppressWarnings({response <- dplyr::bind_rows(response)}) # supress warning of filling with NAs, this is anticipated behavior
  result <- dplyr::left_join(prep, response, by = c("address", "city", "state", "zip"))

  # return result
  return(result)
}
