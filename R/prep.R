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

# indentify all observations
cxy_id <- function(.data, inputs){

  # add id numbers to each row
  .data <- tibble::rowid_to_column(.data, var = "cxy_id")

  # add unique identifiers to each row
  full

}

# identify unique observations
cxy_unique_id <- function(.data){

  # set global bindings
  . = ...address = NULL

  # add unique id numbers for each address string
  full %>%
    dplyr::distinct(...address) %>%
    tibble::rowid_to_column(var = "...uid") %>%
    dplyr::left_join(full, ., by = "...address") -> .data

}

# subset to return only unique observations
cxy_unique <- function(.data){

  # set global bindings
  cxy_uid = ...address = NULL

  # return only distinct addresses
  .data %>%
    dplyr::distinct(...uid, .keep_all = TRUE) %>%
    dplyr::select(...uid, ...address) -> .data

}

# replace data
cxy_replace <- function(source, target, batch = FALSE){

  # set global bindings
  . = ...id = ...uid = ...address = NULL

  # optionally prepare
  if (batch == FALSE){
    target <- dplyr::select(target, -...address)
  }

  # join parsed and source data
  out <- dplyr::left_join(source, target, by = "...uid")
  out <- dplyr::select(out, -...id, -...uid)

}
