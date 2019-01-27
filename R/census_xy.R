#' Geocode Addresses Batches Using the Census Bureau API
#'
#'
#' @param .data A properly formatted data.frame containing addresses to geocode
#' @param sf If TRUE, returns data in an SF class object
#'
#' @description It is recommended that `census_geo()` be used in a pipe with `census_prep()`. See `vignette("censusxy")` for more details and example code.
#' When 10,000 or more addresses are specified, the function will parse the data into smaller chunks in order to overcome the limit of 10,000 requests. This functionality should be used responsibly.
#'
#'@importFrom dplyr filter
#'
#'@export
census_geo <- function(.data, sf = FALSE){
### Function Setup and Batching

  #check for missing variables
  if(missing(.data)){stop("Please specify an arugment for .data")}

  #check length and enter batch mode
  if(nrow(.data) > 9999){message("Function now entering batch mode, this may take a while...")

  # split df into 5000 count dframes
  splits <- split(.data, (seq(nrow(.data))-1) %/% 5000)

  n_splits <- ceiling(nrow(.data) / 5000)

  batch <- vector("list", length = n_splits)

    for (i in 1:n_splits) {
    batch[i] <- census_geocoder(data.frame(splits[i]))
    }

  df <- rbind(batch[1:n_splits])
  }
  else {df <- census_geocoder(.data)}

### Projection to SF

  if(sf == TRUE){
  # check if sf package is installed, stop and warn if not
  if(!requireNamespace("sf")){stop("The `sf` package does not seem to be installed")}

  # remove missing observations (Mandatory for sf) and return warning
  input <- length(.data) # original data length

  sf_prep <- dplyr::filter(df, !is.na(lat)) # remove missing spatial

  # warn and report number filtered
  warning(paste0(input - length(sf_prep)," Observations with missing spatial data were removed in order to create an SF object"))

  # project to sf object
  sf <- sf::st_as_sf(sf_prep, coords = c(x = lat, y = long), crs = 4326)

  return(sf)
  }
  else{return(df)}
}
