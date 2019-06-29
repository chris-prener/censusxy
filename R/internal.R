# internal functions for geocoder

# prepare the dataframe to the geocoder standards
census_prep <- function(.data, id, address, city, state, zip){

  # id
  if(is.na(id)){
    idX <- 1:nrow(.data)
  }
  else{
    idX <- .data[[id]]
  }

  # address
  addressX <- .data[[address]]

  # city
  if(is.na(city)){
    cityX <- NA
  }
  else{
    cityX <- .data[[city]]
  }

  # state
  if(is.na(state)){
    stateX <- NA
  }
  else{
    stateX <- .data[[state]]
  }

  # zip
  if(is.na(zip)){
    zipX <- NA
  }
  else{
    zipX <- .data[[zip]]
  }

  prep <- data.frame(stringsAsFactors = FALSE,
                     id = idX,
                     address = addressX,
                     city = cityX,
                     state = stateX,
                     zip = zipX)

  return(prep)
}

# split and uniques (must be result from prep due to strict naming)
census_split <- function(.data, rows = 1000){
  uniq <- .data[!duplicated(.data[,c("address", "city", "state", "zip")]),]

  splits <- split(uniq, (seq(nrow(uniq))-1) %/% rows)
  # returns a list of length `rows` elements
  return(splits)
}

