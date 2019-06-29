#' Geocode Addresses Using the Census Bureau Geocoder
#'
#' @param .data dataframe containing address data. Mandatory if using column names
#' @param id (Optional) Unique identifier for each observation
#' @param address Either a character vector or column name containing address
#' @param city (Optional) Either a character vector or column name containing city
#' @param state (Optional) Either a character vector or column name containing state
#' @param zip (Optional) Either a character/numeric vector or column name containing 5-digit zip code
#' @param timeout Maximum number of minutes for each API call to the geocoder.
#' @param output Either "tibble" or "sf"
#'
#' @description This is the single function of the censusxy package, allowing for the easy geocoding of US Addresses using the US Census Bureau Geocoder. This function allows for flexible input and virtually unlimited batch sizes. See the vignette \code{vignette(censusxy)} for more details
#'
#' @importFrom dplyr bind_rows left_join filter as_tibble select rename %>%
#' @importFrom rlang quo_name enquo
#'
#' @return either a tibble or sf object containing the census geocoder response
#'
#' @export
cxy_geocode <- function(.data, id, address, city, state, zip, timeout = 30, output = "tibble"){

  # global bindings
   id.y = id.x = lon = lat = NULL

  # Non-Standard Evaluation
  if(!missing(id)){
    idX <- rlang::quo_name(rlang::enquo(id))
  }
  else{
    idX <- NA
  }

  # address
  addressX <- rlang::quo_name(rlang::enquo(address))

  # city
  if(!missing(city)){
    cityX <- rlang::quo_name(rlang::enquo(city))
  }
  else{
    cityX <- NA
  }

  # state
  if(!missing(state)){
    stateX <- rlang::quo_name(rlang::enquo(state))
  }
  else{
    stateX <- NA
  }

  # zip
  if(!missing(zip)){
    zipX <- rlang::quo_name(rlang::enquo(zip))
  }
  else{
    zipX <- NA
  }

  # errors and warnings
    if(missing(.data)){
      stop("A data.frame must be supplied for .data")
    }
    if(missing(address)){
      stop("A column containing address must be supplied for address")
    }
    if(any(missing(city), missing(state), missing(zip))){
      warning("Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder")
    }

  # prepare and split
  census_prep(.data, idX, addressX, cityX, stateX, zipX) -> prep
  census_split(prep) -> split

  # convert timeout to min
  timeout <- timeout * 60

  response <- vector("list", length(split))

  for (i in seq_along(split)) {
   response[[i]] <- try(
     census_geocoder(split[[i]], timeout)
     )
  }
  # remove any list element of class try-catch
  response <- response[sapply(response, function(x) class(x) != "try-error")]

  suppressWarnings({response <- dplyr::bind_rows(response)}) # supress warning of filling with NAs, this is anticipated behavior

  # error if no matches found for batch
  if(all(response[["status"]] ==  "No_Match")){
    stop("No matches found for any of the supplied addresses. Make sure to include city, state and zip for best results")
  }

  result <- dplyr::left_join(prep, response, by = c("address", "city", "state", "zip")) %>% dplyr::select(-id.y) %>% dplyr::rename(id = id.x)

  # output type
  if(output == "tibble"){
    result <- dplyr::as_tibble(result)
  }
  if(requireNamespace("sf", quietly = TRUE)){
    if(output == "sf"){
    result %>%
      dplyr::filter(!is.na(lon) & !is.na(lat)) %>%
      sf::st_as_sf(coords = c("lon", "lat"), crs = 4326) -> result
    }
  }
  # return result
  return(result)
}
