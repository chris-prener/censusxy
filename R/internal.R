# Interal Function for Geocoding with the Batch Endpoint

batch_geocoder <- function(df, return, timeout, benchmark, vintage){
  # Write a Temporary CSV
  tmp <- tempfile(fileext = '.csv')
  utils::write.table(df, tmp, col.names = FALSE, row.names = FALSE,
                     na = '', sep = ',')

  url <- paste0('https://geocoding.geo.census.gov/geocoder/',return,'/addressbatch')
  req <-
    httr::POST(url,
               body = list(
                 addressFile = httr::upload_file(tmp),
                 benchmark = benchmark,
                 vintage = vintage,
                 format = 'json'
               ),
               encode = 'multipart',
               httr::timeout(timeout * 60)
    )
  cnt <- httr::content(req, as = 'text', encoding = 'UTF-8')

  cols <- switch (return,
                  'locations' = c('id', 'address', 'status', 'quality', 'matched_address', 'coords', 'tiger_line_id', 'tiger_side'),
                  'geographies' = c('id', 'address', 'status', 'quality', 'matched_address', 'coords', 'tiger_line_id', 'tiger_side', 'state_id', 'county_id', 'tract_id', 'block_id')
  )
  df <- utils::read.csv(text = cnt, header = FALSE,
                        col.names = cols,
                        fill = TRUE, stringsAsFactors = FALSE,
                        na.strings = '')

  # Split Lon/Lat
  df$coords <- as.character(df$coords)
  lonlat <- strsplit(df$coords, split = ',')

  df$lon <- vapply(lonlat,function(x){x[1]}, 'numeric')
  df$lat <- vapply(lonlat,function(x){x[2]}, 'numeric')

  return(df)
}
