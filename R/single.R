#' Geocode Single Parsed Address
#'
#' @description Provides access to the structured single address geocoding API from the US Census Bureau.
#'
#' @param street String containing street address
#' @param city Optional String containing city
#' @param state Optional String containing state
#' @param zip Optional String or Integer containing 5-digit Zip Code
#' @param return One of 'locations' or 'geographies' See Details.
#' @param benchmark Optional ID or Name of Census Benchmark. See Details.
#' @param vintage Optional ID or Name of Census Vintage. See Details.
#'
#' @return A data.frame containing matched address or NULL if not matches
#'
#' @importFrom httr GET content
#'
#' @details
#' To obtain current valid benchmarks, use the \code{cxy_benchmarks()} function.
#'
#' If you want to append census geographies, you must specify a valid vintage for your benchmark.
#'     You may use the \code{cxy_vintages()} function to obtain valid Vintages. See \code{vignette('censusxy')}
#'     for a full walkthrough.
#'
#' @examples
#' cxy_single(street = "20 N Grand Blvd", city = "St Louis", state = "MO", zip = "63108",
#'     return = "locations")
#'
#' @export
cxy_single <- function(street, city = NULL, state = NULL, zip = NULL, return = 'locations', benchmark = 'Public_AR_Current', vintage = NULL){

  # Check Specification of Arguments
  if(missing(street)){
    stop('`street` is a required argument')
  }

  if(!return %in% c('locations', 'geographies')){
    stop("`return` must be one of 'locations' or 'geographies'")
  }

  if(return == 'locations' & !is.null(vintage)){
    warning("Vintage ignored for return = 'locations'")
  }

  if(return == 'geographies' & is.null(vintage)){
    stop("`vintage` must be specified for return = 'geographies'")
  }

  # Warn for Omission
  if(is.null(city) | is.null(state) | is.null(zip)){
    warning('Omission of `city`, `state` or `zip` greatly reduces the speed and accuracy of the geocoder.')
  }

  url <- paste0('https://geocoding.geo.census.gov/geocoder/',return,'/address')
  req <-
    httr::GET(url,
              query = list(
                benchmark = benchmark,
                vintage = vintage,
                street = street,
                city = city,
                state = state,
                zip = zip,
                format = 'json'
              )
    )
  cnt <- httr::content(req)

  # Check for API Errors
  if(!is.null(cnt$errors)){
    stop(cnt$errors[[1]])
  }

  matches <- cnt$result$addressMatches
  if(length(matches) < 1){
    return(NULL)
  }
  df <- data.frame(matches)
  return(df)
}

#' Geocode Single One Line Address
#'
#' @description Provides access to the oneline single address geocoding API from the US Census Bureau.
#'   This can be used with an address that is not parsed.
#'
#' @param address String containing a single line address
#' @param return One of 'locations' or 'geographies' See Details.
#' @param benchmark Optional ID or Name of Census Benchmark. See Details.
#' @param vintage Optional ID or Name of Census Vintage. See Details.
#'
#' @return A data.frame containing matched address or NULL if not matches
#'
#' @importFrom httr GET content
#'
#' @details
#' To obtain current valid benchmarks, use the \code{cxy_benchmarks()} function.
#'
#' If you want to append census geographies, you must specify a valid vintage for your benchmark.
#'     You may use the \code{cxy_vintages()} function to obtain valid Vintages. See \code{vignette('censusxy')}
#'     for a full walkthrough.
#'
#' @examples
#' cxy_oneline(address = "20 N Grand Blvd, St Louis, MO 63108", return = "locations")
#'
#' @export
cxy_oneline <- function(address, return = 'locations', benchmark = 'Public_AR_Current', vintage = NULL){

  # Check Specification of Arguments
  if(missing(address)){
    stop('`address` is a required argument')
  }

  if(!return %in% c('locations', 'geographies')){
    stop("`return` must be one of 'locations' or 'geographies'")
  }

  if(return == 'locations' & !is.null(vintage)){
    warning("Vintage ignored for return = 'locations'")
  }

  if(return == 'geographies' & is.null(vintage)){
    stop("`vintage` must be specified for return = 'geographies'")
  }

  url <- paste0('https://geocoding.geo.census.gov/geocoder/',return,'/onelineaddress')
  req <-
    httr::GET(url,
              query = list(
                benchmark = benchmark,
                vintage = vintage,
                address = address,
                format = 'json'
              )
    )
  cnt <- httr::content(req)

  # Check for API Errors
  if(!is.null(cnt$errors)){
    stop(cnt$errors[[1]])
  }

  matches <- cnt$result$addressMatches
  if(length(matches) < 1){
    return(NULL)
  }
  df <- data.frame(matches)
  return(df)
}


#' Geocode Single Coordinate Pair
#'
#' @description Provides access to the GeoLookup API of the US Census Bureau. Returns census
#'     geographies for a single geographic point.
#'
#' @param lon Numeric or String Containing Longitude (x) of Point
#' @param lat Numeric or String Containing Latitude (y) of Point
#' @param benchmark Optional ID or Name of Census Benchmark. See Details.
#' @param vintage Optional ID or Name of Census Vintage. See Details.
#'
#' @return A data.frame containing matched address or NULL if not matches
#'
#' @details
#' This function can be used to locate geographic information given a geographic point.
#'     It does not provide an address like a reverse-geocoder
#'
#' To obtain current valid benchmarks, use the \code{cxy_benchmarks()} function
#'
#' To use this function, you must specify a valid vintage for your benchmark. You may use
#'     the \code{cxy_vintages()} function to obtain valid Vintages for a given benchmark.
#'     See \code{vignette('censusxy')} for a full walkthrough.
#'
#' @importFrom httr GET content
#'
#' @examples
#' cxy_geography(lon = -90.23324, lat = 38.63593)
#'
#' @export
cxy_geography <- function(lon, lat, benchmark = 'Public_AR_Current', vintage = 'Current_Current'){
  url <- 'https://geocoding.geo.census.gov/geocoder/geographies/coordinates'
  req <-
    httr::GET(url,
              query = list(
                benchmark = benchmark,
                vintage = vintage,
                x = lon,
                y = lat,
                format = 'json'
              )
    )
  cnt <- httr::content(req)

  # Check for API Errors
  if(!is.null(cnt$errors)){
    stop(cnt$errors[[1]])
  }

  # Check for Matches
  matches <- cnt$result$geographies
  if(length(matches) < 1){
    return(NULL)
  }

  df <- data.frame(matches)

  return(df)
}

