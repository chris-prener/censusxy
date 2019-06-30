context("test cxy_geocode function")

# load data ------------------------------------------------

load(system.file("extdata", "homicides.rda", package = "censusxy", mustWork = TRUE))
load(system.file("extdata", "test.rda", package = "censusxy", mustWork = TRUE))

# test inputs ------------------------------------------------

test_that("misspecified functions return errors", {
  expect_error(cxy_geocode(address = street_address, city = city, state = state),
               "A existing data frame or tibble must be specified for '.data'.")
  expect_error(cxy_geocode(homicides, city = city, state = state),
               "A column containing address must be supplied for 'address'.")
  expect_error(cxy_geocode(homicides, address = street_address, city = city, state = state,
                           timeout = "ham"),
               "A numeric value must be specified for 'timeout'.")
  expect_error(cxy_geocode(homicides, address = street_address, city = city, state = state, output = "ham"),
               "Please choose one of 'tibble' or 'sf' for 'output'.")
})

# test function ------------------------------------------------

# geocode once with the large data
# out <- cxy_geocode(homicides, address = "street_address", city = "city", state = "state", timeout = 30, output = "tibble")
# out_sf <- cxy_geocode(df, address = "address", city = "city", state = "state", zip = "zip", timeout = 30, output = "sf")
