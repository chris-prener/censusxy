#' Join the geocoding result with original data
#'
#'
#' @param .data data.frame containing Census API Return (What is returned by `cxy_geocode`)
#' @param original data.frame containg the original data to join to
#' @param id Name of id variable in original data
#' @param exact Logical, if TRUE only joins coordinates from Exact Matches
#' @param simple Logical, if TRUE only appends longitude (lon) and latitude (lat) columns
#'
#' @usage
#'
#' @importFrom dplyr left_join filter %>%
#'
#' @return the original data.frame with full data or just coordinates appended
#'
#'@export
cxy_join <- function(.data, original, id, exact = TRUE, simple = TRUE){

  if(exact == TRUE){
    .data <- dplyr::filter(.data, status == "Match") %>%
             dplyr::filter(quality == "Exact")
  }

  if(simple == TRUE){
    .data <- dplyr::select(.data, lon, lat)
  }

  join <- left_join(original, .data, by = c(id = "id"))


  return(join)
}
