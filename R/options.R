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
  req <- httr::GET('https://geocoding.geo.census.gov/geocoder/benchmarks',
                   httr::config(
                     connecttimeout = 30
                   ),
                   httr::timeout(30))
  cnt <- httr::content(req)
  df <- do.call(rbind.data.frame, cnt$benchmarks)
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
#' @examples cxy_vintages('Public_AR_Census2010')
#'
#' @export
cxy_vintages <- function(benchmark){
  if(missing(benchmark)){
    stop('`benchmark` is a required argument')
  }

  req <-
    httr::GET('https://geocoding.geo.census.gov/geocoder/vintages',
              query = list(
                benchmark = benchmark
              ),
              httr::config(
                connecttimeout = 30
              ),
              httr::timeout(30)
    )
  cnt <- httr::content(req)
  if(length(cnt) < 1){
    stop('Not a Valid Benchmark')
  }
  df <- do.call(rbind.data.frame, cnt$vintages)
  return(df)
}
