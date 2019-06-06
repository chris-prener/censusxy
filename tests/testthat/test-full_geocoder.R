# Load Test Data. Homicides = 1822
load("homicides.rda")
load("test.rda")

# geocode once with the large data
out <- cxy_geocode(stl_homicides, address = address, city = "St Louis", state = "MO", timeout = 30, output = "tibble")

# Errors and Warnings
test_that("missing address error triggers", {
  # missing address
  expect_error(
    cxy_geocode(), "A character vector or column containing address must be supplied"
  )
})

test_that("omission of city/state/zip warning triggers", {
  expect_warning(
    cxy_geocode(address = df$address)
  )
})

# Non Standard Eval
test_that("non-standard evaluation works", {

})

# Output Types
test_that("output to tibble works", {
  expect_type()
})

test_that("output to sf works",{
  expect_type()
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





