library(dplyr)

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

  out <- c(addressX, cityX, stateX, zipX)
  out <- out[!is.na(out)]

  return(out)

}

vars <- x(address = manufacturer, city = model)

y <- ggplot2::mpg

vars2 <- rlang::syms(vars)

dplyr::distinct(y, !!!vars2, .keep_all = TRUE)
dplyr::mutate(y, y = paste(!!!vars2))

test <- dplyr::tibble(
  address = c("750 N 16th St", "3106 Olive St", "750 N 16th St", "4431 Lindell Blvd"),
  city = c("St. Louis", "St. Louis", "St. Louis", "St. Louis"),
  zip = c(63103, 63103, 63103, 63108),
  state = c("MO", "MO", "MO", "MO")
)
