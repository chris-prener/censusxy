# split and uniques (must be result from prep due to strict naming)
cxy_split <- function(.data, rows = 1000){

  uniq <- .data[!duplicated(.data[,c("address", "city", "state", "zip")]),]

  splits <- split(uniq, (seq(nrow(uniq))-1) %/% rows)

  # returns list of length `rows` elements
  return(splits)

}
