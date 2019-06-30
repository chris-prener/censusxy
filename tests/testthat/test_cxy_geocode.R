context("test cxy_geocode function")

# load data ------------------------------------------------

load(system.file("extdata", "homicides.rda", package = "censusxy", mustWork = TRUE))
load(system.file("extdata", "test.rda", package = "censusxy", mustWork = TRUE))

# test inputs ------------------------------------------------

test_that("misspecified functions return errors", {
  # missing address
  expect_error(cxy_geocode(),
               "A data.frame must be supplied for .data")
  expect_error(cxy_geocode(df),
               "A column containing address must be supplied for address")
})

# test function ------------------------------------------------

# geocode once with the large data
# out <- cxy_geocode(homicides, address = "street_address", city = "city", state = "state", timeout = 30, output = "tibble")
# out_sf <- cxy_geocode(df, address = "address", city = "city", state = "state", zip = "zip", timeout = 30, output = "sf")
