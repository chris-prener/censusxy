# internal functions for geocoder
# no dependencies

# prep
census_prep <- function(.data, id = NA, address, city = NA, state = NA, zip = NA){

  # Prepare the data for sending to geocoder

  # dataframe method
  if(!missing(.data)){
    # init a df of appropriate length
    l = rep_len(NA, length(.data[[address]]))
    prep <- data.frame(id = l, address = l, city = l, state = l, zip = l)

    # id
    if(!is.na(id)){
      prep["id"] <- .data[[id]]
    }
    else{
      prep["id"] <- seq_along(.data[[address]])
    }
    # address
    prep["address"] <- .data[[address]]
    # city
    if(!is.na(city)){
      prep["city"] <- .data[[city]]
    }
    # state
    if(!is.na(state)){
      prep["state"] <- .data[[state]]
    }
    # zip
    if(!is.na(zip)){
      prep["zip"] <- .data[[zip]]
    }
  }
  # vector method
  else{
    # init a df of appropriate length
    l = rep_len(NA, length(address))
    prep <- data.frame(id = l, address = l, city = l, state = l, zip = l)

    # id
    if(!is.na(id)){
      prep["id"] <- id
    }
    else{
      prep["id"] <- seq_along(address)
    }
    # address
    prep["address"] <- address
    # city
    if(!is.na(city)){
      prep["city"] <- city
    }
    # state
    if(!is.na(state)){
      prep["state"] <- state
    }
    # zip
    if(!is.na(zip)){
      prep["zip"] <- zip
    }
  }
  # enforce data types
  prep["id"]      <- methods::as(prep[["id"]], "numeric")
  prep["address"] <- methods::as(prep[["address"]], "character")
  prep["city"]    <- methods::as(prep[["city"]], "character")
  prep["state"]   <- methods::as(prep[["state"]], "character")
  prep["zip"]     <- methods::as(prep[["zip"]], "numeric")

  return(prep)
}

# split and uniques (must be result from prep due to strict naming)
census_split <- function(.data, rows = 1000){
  uniq <- .data[!duplicated(.data[,c("address", "city", "state", "zip")]),]

  splits <- split(uniq, (seq(nrow(uniq))-1) %/% rows)
  # returns a list of length `rows` elements
  return(splits)
}

