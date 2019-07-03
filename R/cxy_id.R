# indentify distinct observations
cxy_id <- function(.data, inputs){

  # set global bindings
  ...address = NULL

  # convert input vector to unquoted list
  varList <- rlang::syms(inputs)

  # concatenate input elements into single variable
  .data <- dplyr::mutate(.data, ...address = paste(!!!varList))

  # add unique id numbers for each address string
  dis <- dplyr::distinct(.data, ...address)
  dis <- tibble::rowid_to_column(dis, var = "cxy_uid")
  .data <- dplyr::left_join(.data, dis, by = "...address")

  # remove ...address and place cxy_uid
  .data <- dplyr::select(.data, -...address)

}
