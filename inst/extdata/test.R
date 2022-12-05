devtools::load_all()
library(dplyr)
library(tibble)

x <- stl_homicides[1:10,]

x %>%
  rowid_to_column(var = "id") %>%
  select(
    id,
    street = street_address,
    city, state,
    zip = postal_code
  ) -> y

batch_geocoder(y, return = "locations", timeout = 30, benchmark = "ham", vintage = NULL)
