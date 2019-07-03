# internal function for constructing output

cxy_replace <- function(source, result, style){

  # global bindings
  TIGER_line_id = address = city = cxy_uid = id = lat = lon = match_address = quality =
    side = state = status = zip = NULL

  # rename id
  result <- dplyr::rename(result, cxy_uid = id)

  # modify output
  if (style == "minimal"){

    result <- dplyr::select(result, cxy_uid, status, quality, match_address, lon, lat)
    result <- dplyr::rename(result,
                            cxy_status = status,
                            cxy_quality = quality,
                            cxy_match = match_address)

  } else if (style == "full"){

    result <- dplyr::select(result, cxy_uid, status, quality, match_address, lon, lat, dplyr::everything())
    result <- dplyr::rename(result,
                            cxy_address = address,
                            cxy_city = city,
                            cxy_state = state,
                            cxy_zip = zip,
                            cxy_status = status,
                            cxy_quality = quality,
                            cxy_match = match_address,
                            cxy_tiger_id = TIGER_line_id,
                            cxy_side = side)

  }

  # combine with source data
  out <- dplyr::left_join(source, result, by = "cxy_uid")

  # drop unique id
  out <- dplyr::select(out, -cxy_uid)

}
