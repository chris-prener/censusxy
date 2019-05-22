#' Geocode Address Batches Using the Census Bureau API
#'
#'
#' @param .data A properly formatted data.frame containing addresses to geocode
#' @param timeout
#'
#' @description It is recommended that `cxy_geocode()` be used in a pipe with `cxy_prep()`. See `vignette("censusxy")` for more details and example code.
#' When 1,000 or more addresses are specified, the function will parse the data into smaller chunks. The start option allows you to resume geocoding at a specific index.
#'
#' @importFrom dplyr filter
#'
#'@export
cxy_geocode <- function(.data, timeout = 30){

  #check for missing variables
  if(missing(.data)){stop("Please specify an arugment for .data")}

  # subset for only unique addresses
  uniq <- dplyr::filter(.data, !duplicated(stringr::str_c(address, city, state, zip)))

  #check length and enter batch mode
  if(nrow(.data) > 999){message("Function now entering batch mode, this may take a while...")

  # split df into 1000 count dataframes
  splits <- split(uniq, (seq(nrow(uniq))-1) %/% 1000)

  # convert timeout from min to seconds
  timeout <- 60 * timeout

  # prepare a vector for the results
  batch <- vector("list", length(splits))

  # try to geocode everything
  try(
    for (i in seq_along(splits)) {
    batch[[i]] <- censusxy:::census_geocoder(splits[[i]], timeout)
    }
  )

  # combine rows to df
  df <- dplyr::bind_rows(batch)
  }

  # for fewer than 1k addresses
  else {df <- censusxy:::census_geocoder(uniq, timeout)}

  # join uniq sends to full data (done for efficiency)
  df <- dplyr::left_join(.data, df, by = c("address", "city", "state", "zip")) %>% dplyr::rename(id = id.x) %>% dplyr::select(-"id.y")

  return(df)
}

