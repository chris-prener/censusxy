# internal functions for preparing data for geocoding

# prepare the dataframe to the geocoder standards
cxy_prep <- function(.data, address, city, state, zip){

  # global binding
  cxy_uid = NULL

  # limit to distinct obervations
  .data <- dplyr::distinct(.data, cxy_uid, .keep_all = TRUE)

  # id
  idX <- .data[["cxy_uid"]]

  # address
  addressX <- .data[[address]]

  # city
  if (is.na(city)) {
    cityX <- NA
  } else {
    cityX <- .data[[city]]
  }

  # state
  if (is.na(state)) {
    stateX <- NA
  } else {
    stateX <- .data[[state]]
  }

  # zip
  if (is.na(zip)) {
    zipX <- NA
  } else {
    zipX <- .data[[zip]]
  }

  # prepare data frame
  prep <- data.frame(id = idX,
                     address = addressX,
                     city = cityX,
                     state = stateX,
                     zip = zipX,
                     stringsAsFactors = FALSE)

  # return result
  return(prep)

}
