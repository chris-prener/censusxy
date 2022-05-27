#' Get Current Valid Benchmarks
#'
#' @usage cxy_benchmarks()
#'
#' @return A data.frame containing valid Census Benchmarks
#'
#' @importFrom httr GET content timeout config
#'
#' @examples cxy_benchmarks()
#'
#' @export
cxy_benchmarks <- function(){

  try(
    expr = req <- httr::GET('https://geocoding.geo.census.gov/geocoder/benchmarks',
                            httr::config(
                              connecttimeout = 30
                            ),
                            httr::timeout(30)),
    silent = TRUE
  )

  cnt <- httr::content(req)

  if (inherits(cnt, what = "list") == TRUE){

    df <- do.call(rbind.data.frame, cnt$benchmarks)

  } else if (inherits(cnt, what = "try-error") == TRUE) {
    df <- data.frame()
    message("Census API currently unavailable")
  }

  return(df)
}

#' Get Current Valid Vintages
#'
#' @usage cxy_vintages(benchmark)
#'
#' @param benchmark Name or ID of Census Benchmark
#'
#' @return A data.frame containing valid Census Vintages for a given benchmark
#'
#' @importFrom httr GET content timeout config
#'
#' @examples cxy_vintages("Public_AR_Current")
#'
#' @export
cxy_vintages <- function(benchmark){

  if(missing(benchmark)){
    stop('`benchmark` is a required argument')
  }

  req <- try(
    expr = httr::GET('https://geocoding.geo.census.gov/geocoder/vintages',
                     query = list(
                       benchmark = benchmark
                     ),
                     httr::config(
                       connecttimeout = 30
                     ),
                     httr::timeout(30)),
    silent = TRUE
  )

  cnt <- httr::content(req)

  if (inherits(cnt, what = "list") == TRUE){

    if("errors" %in% names(cnt) == TRUE){
      stop('Not a Valid Benchmark')
    }

    df <- do.call(rbind.data.frame, cnt$vintages)

    if (length(df) == 0){
      message("Census API issue detected - vintages not returned by the API")
    }

  } else if (inherits(cnt, what = "try-error") == TRUE) {
    df <- data.frame()
    message("Census API currently unavailable")
  }

  return(df)

}
