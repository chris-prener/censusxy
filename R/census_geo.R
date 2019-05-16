#' Geocode Address Batches Using the Census Bureau API
#'
#'
#' @param .data A properly formatted data.frame containing addresses to geocode
#' @param start Integer for the first thousand rows to begin geocoding
#'
#' @description It is recommended that `cxy_geocode()` be used in a pipe with `cxy_prep()`. See `vignette("censusxy")` for more details and example code.
#' When 1,000 or more addresses are specified, the function will parse the data into smaller chunks. The start option allows you to resume geocoding at a specific index.
#'
#' @importFrom dplyr filter
#'
#'@export
cxy_geocode <- function(.data, start = 1){

  #check for missing variables
  if(missing(.data)){stop("Please specify an arugment for .data")}

  # check valid start else subset
  if(start > nrow(.data) %/% 1000){stop("Specified argument for `start` is out of valid range")}

  #check length and enter batch mode
  if(nrow(.data) > 999){message("Function now entering batch mode, this may take a while...")

  # split df into 1000 count dataframes
  splits <- split(.data, (seq(nrow(.data))-1) %/% 1000)

  #

  # prepare a vector for the results
  batch <- vector("list", length(splits))

  # try to geocode everything
  try(
    for (i in seq_along(splits)) {
    batch[[i]] <- censusxy:::census_geocoder(splits[[i]])
    }
  )

  # combine rows to df
  df <- dplyr::bind_rows(batch)
  }

  # for fewer than 1k addresses
  else {df <- censusxy:::census_geocoder(.data)}


  return(df)
}

