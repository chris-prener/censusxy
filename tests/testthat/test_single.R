# Test Single Functions
context('test single address functions')

# Single ----------------------------------------------------------------------

test_that('Invalid Argument Specifications fail', {
  expect_error(
    cxy_single(),
    '`street` is a required argument'
  )
  expect_error(
    cxy_single('20 N Grand Blvd', return = 'BAD INPUT'),
    "`return` must be one of 'locations' or 'geographies'"
  )
  expect_error(
    cxy_single('20 N Grand Blvd', return = 'geographies'),
    "`vintage` must be specified for return = 'geographies'"
  )
  expect_error(
    cxy_oneline(),
    '`address` is a required argument'
  )
  expect_error(
    cxy_oneline('20 N Grand Blvd, St. Louis MO 63018', return = 'BAD INPUT'),
    "`return` must be one of 'locations' or 'geographies'"
  )
  expect_error(
    cxy_oneline('20 N Grand Blvd, St. Louis MO 63018', return = 'geographies'),
    "`vintage` must be specified for return = 'geographies'"
  )
})

test_that('Warnings for specified arguments are triggered', {
  skip_on_cran()
  skip_if_offline()

  expect_warning(
    cxy_single('101 Marietta St', 'Atlanta', 'GA', 30303, return = 'locations', vintage = 'Current_Current'),
    "Vintage ignored for return = 'locations'"
  )
  expect_warning(
    cxy_single('101 Marietta St', 'Atlanta', 'GA'),
    'Omission of `city`, `state` or `zip` greatly reduces the speed and accuracy of the geocoder.'
  )
  expect_warning(
    cxy_oneline('101 Marietta St, Atlanta, GA 30303', return = 'locations', vintage = 'Current_Current'),
    "Vintage ignored for return = 'locations'"
  )
})

test_that('Valid Structured Geocodes Work', {
  skip_on_cran()
  skip_if_offline()

  expect_s3_class(
    cxy_single('101 Marietta St', 'Atlanta', 'GA', 30303),
    'data.frame'
  )
  expect_s3_class(
    cxy_single('101 Marietta St', 'Atlanta', 'GA', 30303, return = 'geographies', vintage = 'Current_Current'),
    'data.frame'
  )
})

test_that('Valid Oneline Geocodes Work', {
  skip_on_cran()
  skip_if_offline()

  expect_s3_class(
    cxy_oneline('101 Marietta St, Atlanta, GA 30303'),
    'data.frame'
  )
  expect_s3_class(
    cxy_oneline('101 Marietta St, Atlanta, GA 30303', return = 'geographies', vintage = 'Current_Current'),
    'data.frame'
  )
})

test_that('Valid Geography Geocode works', {
  skip_on_cran()
  skip_if_offline()

  expect_s3_class(
    cxy_geography(-90.23324, 38.63593),
    'data.frame'
  )
})

