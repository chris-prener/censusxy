context("test cxy_geocode function")

# load data -------------------------------------------------

x <- stl_homicides_small

# test inputs ------------------------------------------------

test_that("misspecified functions return errors", {
  expect_error(cxy_geocode(address = street_address, city = city, state = state),
               "An existing data frame or tibble must be specified for '.data'.")
  expect_error(cxy_geocode(x, city = city, state = state),
               "A column containing address must be supplied for 'address'.")
  expect_error(cxy_geocode(x, address = street_address, city = city, zip = postal_code, state = state,
                           timeout = "ham"),
               "A numeric value must be specified for 'timeout'.")
  expect_error(cxy_geocode(x, address = street_address, city = city, state = state, zip = postal_code, output = "ham"),
               "Please choose one of 'tibble' or 'sf' for 'output'.")
  expect_error(cxy_geocode(x, address = street_address, city = city, state = state, zip = postal_code, style = "ham"),
               "Please choose one of 'minimal' or 'full' for 'style'.")
})

# test warnings ------------------------------------------------

test_that("warning of ommission triggers for city, state, or zip", {
  skip_on_cran()
  skip_if_offline(host = "r-project.org")
  expect_warning(cxy_geocode(x, address = street_address, city = city, state = state),
                 "Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder")
  expect_warning(cxy_geocode(x, address = street_address, city = city, zip = postal_code),
                 "Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder")
  expect_warning(try(cxy_geocode(x, address = street_address, state = state, zip = postal_code), silent = TRUE),
                 "Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder")
})

# test output, non-standard evaluation, and ---------------------------------------------

test_that("output type produces correct output class", {
  skip_on_cran()
  skip_if_offline(host = "r-project.org")
  expect_s3_class(cxy_geocode(x, address = street_address, city = city, state = state, zip = postal_code,
                              output = "sf", style = "minimal"), "sf")
  expect_s3_class(cxy_geocode(x, address = "street_address", city = "city", state = "state", zip = "postal_code",
                              output = "tibble", style = "full"), "tbl_df")
})

# test no-matches ----------------------------------------------

test_that("error is returned for zero matches", {
  skip_on_cran()
  skip_if_offline(host = "r-project.org")
  expect_error(suppressWarnings(cxy_geocode(x, address = "street_address")),
               "No matches found for any of the supplied addresses. Make sure to include city, state and zip for best results")
})
