# Load Test Data. Homicides = 1822
load("homicides.rda")
load("test.rda")

# geocode once with the large data
out <- cxy_geocode(stl_homicides, address = "address", city = "city", state = "state", timeout = 30, output = "tibble")
out_sf <- cxy_geocode(df, address = "address", city = "city", state = "state", zip = "zip", timeout = 30, output = "sf")

# Errors and Warnings
test_that("missing argument errors trigger", {
  # missing address
  expect_error(
    cxy_geocode(), "A data.frame must be supplied for .data"
  )
  expect_error(
    cxy_geocode(df), "A column containing address must be supplied for address"
  )
})

test_that("omission of city/state/zip warning triggers", {
  expect_warning(
    try(cxy_geocode(df, id = "id", address = "address"), silent = TRUE), "Omission of city, state or zip code greatly reduces the speed and accuracy of the geocoder"
  )
})

test_that("Error is returned for zero matches", {
  expect_error(
    suppressWarnings(cxy_geocode(df, address = "address")), "No matches found for any of the supplied addresses. Make sure to include city, state and zip for best results"
  )
})

# Non Standard Eval
test_that("non-standard evaluation works", {
  expect_silent(
    cxy_geocode(df, id, address, city, state, zip)
  )
})
# Standard Evaluation
test_that("standard evaluation works", {
  expect_silent(
    cxy_geocode(df, "id", "address", "city", "state", "zip")
  )
})

# Output Types
test_that("output to tibble works", {
  expect_s3_class(out, "tbl_df")
})

test_that("output to sf works",{
  expect_s3_class(out_sf, "sf")
})


# Removing Errors and Batch Binding

# fake list
response <- list("a", try(stop(), silent = TRUE), "c")

test_that("Removing try-catch from lists work",{
  # sample code
  expect_length( response[sapply(response, function(x) class(x) != "try-error")], 2)
})




