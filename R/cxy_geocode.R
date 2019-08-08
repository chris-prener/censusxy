#' Geocode Addresses Using the Census Bureau Geocoder
#'
#' @description This is the single function of the censusxy package, allowing
#'     for the easy geocoding of US Addresses using the US Census Bureau
#'     Geocoder. This function allows for flexible input and virtually
#'     unlimited batch sizes. See the vignette \code{vignette(censusxy)}
#'     for more details
#'
#' @usage cxy_geocode(.data, address, city, state, zip,
#'     style = "minimal", output = "tibble", timeout = 30)
#'
#' @param .data Data frame or tibble containing address data
#' @param address Column name containing address
#' @param city Optional; column name containing city
#' @param state Optional; column name containing state
#' @param zip Optional; column name containing 5-digit zip code
#' @param style One of either \code{"minimal"} or \code{"full"}
#' @param output One of either \code{"tibble"} or \code{"sf"}
#' @param timeout Maximum number of minutes for each API call to the geocoder.
#'
#' @return Either a tibble or sf object containing the census geocoder response.
#'
#' @importFrom dplyr as_tibble bind_rows filter left_join rename select
#' @importFrom rlang enquo quo_name
#' @importFrom sf st_as_sf
#'
#' @examples
#' \donttest{
#' # load sample data
#' data <- stl_homicides_small
#'
#' # geocode data
#' data <- cxy_geocode(data, address = "street_address", city = "city",
#'     state = "state", zip = "postal_code")
#'
#' # preview data
#' data
#' }
#'
#' @export
cxy_geocode <- function(.data, address, city, state, zip, style = "minimal", output = "tibble", timeout = 30){

   # global bindings
   lon = lat = NULL

   # check for missing parameters
   if (missing(.data)){
     stop("An existing data frame or tibble must be specified for '.data'.")
   }

   if(missing(address)){
     stop("A column containing address must be supplied for 'address'.")
   }

   # check for incorrectly specified parameters
   if (is.numeric(timeout) == FALSE){
     stop("A numeric value must be specified for 'timeout'.")
   }

   if (style %in% c("minimal", "full") == FALSE){
     stop("Please choose one of 'minimal' or 'full' for 'style'.")
   }

   if (output %in% c("tibble", "sf") == FALSE){
     stop("Please choose one of 'tibble' or 'sf' for 'output'.")
   }

  # non-standard evaluation
  # address
  addressX <- rlang::quo_name(rlang::enquo(address))

  # city
  if (!missing(city)) {
    cityX <- rlang::quo_name(rlang::enquo(city))
  } else {
    cityX <- NA
  }

  # state
  if (!missing(state)) {
    stateX <- rlang::quo_name(rlang::enquo(state))
  } else {
    stateX <- NA
  }

  # zip
  if (!missing(zip)) {
    zipX <- rlang::quo_name(rlang::enquo(zip))
  } else {
    zipX <- NA
  }

  # warning about missing geographies
  if(any(missing(city), missing(state), missing(zip))){
    warning("Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder")
  }

  # construct vector of valid input variables
  invars <- c(addressX, cityX, stateX, zipX)
  invars <- invars[!is.na(invars)]

  # prepare and split
  .data <- cxy_id(.data, inputs = invars)
  prep <- cxy_prep(.data, address = addressX, city = cityX, state = stateX, zip = zipX)
  split <- cxy_split(prep)
  response <- vector("list", length(split))

  # convert timeout to min
  timeout <- timeout * 60

  # iterate over splits
  for (i in seq_along(split)) {
   response[[i]] <- try(
     cxy_geocoder(split[[i]], timeout)
     )
  }

  # remove any list element of class try-catch
  response <- response[sapply(response, function(x) class(x) != "try-error")]

  # supress warning of filling with NAs, this is anticipated behavior
  suppressWarnings({response <- dplyr::bind_rows(response)})

  # error if no matches found for batch
  if(all(response[["status"]] ==  "No_Match")){
    stop("No matches found for any of the supplied addresses. Make sure to include city, state and zip for best results.")
  }

  # construct output
  out <- cxy_replace(source = .data, result = response, style = style)

  # optionally convert to sf
  if (output == "sf"){

    out <- dplyr::filter(out, !is.na(lon) & !is.na(lat))
    out <- sf::st_as_sf(out, coords = c("lon", "lat"), crs = 4326)

  }

  # return result
  return(out)

}
