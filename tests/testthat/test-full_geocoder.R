# Load Test Data. Homicides = 1822
load("homicides.rda")
load("test.rda")

# geocode once with the large data
out <- cxy_geocode(stl_homicides, address = address, city = "St Louis", state = "MO", timeout = 30, output = "tibble")
out_sf <- cxy_geocode(df, address = address, city = "city", state = "state", zip = "zip", timeout = 30, output = "sf")

# Errors and Warnings
test_that("missing address error triggers", {
  # missing address
  expect_error(
    cxy_geocode(), "A character vector or column containing address must be supplied"
  )
})

test_that("omission of city/state/zip warning triggers", {
  expect_warning(
    cxy_geocode(address = df$address), "Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder"
  )
})

# Non Standard Eval
test_that("non-standard evaluation works", {

})

# Output Types
test_that("output to tibble works", {
  expect_s3_class(out, "tbl_df")
})

test_that("output to sf works",{
  expect_s3_class(out_sf, "sf")
})

# Prepping

## Df method
## Vector method

# Splitting

# Timeout
test_that("API Timeout works", {

})

# Removing Errors and Batch Binding

# Parsing of matched return

# Parsing of no matched return





