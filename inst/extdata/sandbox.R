

x <- function(.data, address, city, state, zip){

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

  out <- c(address, cityX, stateX, zipX)
  out <- out[!is.na(out)]

  return(out)

}

x(address = "manufacturer", city = "model")
