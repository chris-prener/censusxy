# internal functions for preparing data for geocoding

# prepare the dataframe to the geocoder standards
cxy_prep <- function(.data, id, address, city, state, zip){

  # id
  if (is.na(id)) {
    idX <- 1:nrow(.data)
  } else {
    idX <- .data[[id]]
  }

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

# split and uniques (must be result from prep due to strict naming)
cxy_split <- function(.data, rows = 1000){

  uniq <- .data[!duplicated(.data[,c("address", "city", "state", "zip")]),]

  splits <- split(uniq, (seq(nrow(uniq))-1) %/% rows)

  # returns list of length `rows` elements
  return(splits)

}
