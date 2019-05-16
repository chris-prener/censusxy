# One Function Geocoding

cxy_full_geocode <- function(.data, address, id, city = NA, state = NA, zip = NA){

  #TODO ADD NSE

## Prepare a Subset that's formatted correctly

# warn for ommitted city state zip
if(is.na(city) | is.na(state) | is.na(zip)){warning('Omission of City, State or Zip drastically reduces the rate of successful geocoding, only omit if absolutely neccessary.')}

# prepare vectors
address_v <- dplyr::select(.data, address)
id_v <- dplyr::select(.data, id)

if(!is.na(city)) {city_v  <- dplyr::select(.data, city)}
if(!is.na(state)){state_v <- dplyr::select(.data, state)}
if(!is.na(zip))  {zip_v   <- dplyr::select(.data, zip)}

# build a data frame
prep <- data.frame(id_v, address_v, city_v, state_v, zip_v)

# enforce naming
names(prep) <- c("id", "address", "city", "state", "zip")

prep_uniq <- dplyr::filter(prep, !duplicated(stringr::str_c(address, city, state, zip)))

## Geocode it

# split df into 1000 count dataframes
splits <- split(prep_uniq, (seq(nrow(prep_uniq))-1) %/% 1000)

# prepare a vector for the results
batch <- vector("list", length(splits))

# try to geocode everything
try(
  for (i in seq_along(splits)) {
    batch[[i]] <- censusxy:::census_geocoder(splits[[i]])
  }
)

# combine rows to df
df <- dplyr::bind_rows(batch)

## Join it to the original
# match names
.data <- dplyr::rename_(.data, "o_address" = address, "o_city" = city, "o_state" = state)

# join and remove extraneous vars
join <- dplyr::left_join(.data, df, by = c("o_address", "o_city", "o_state")) %>% dplyr::select(-"o_zip", - "id")


return(join)

}
