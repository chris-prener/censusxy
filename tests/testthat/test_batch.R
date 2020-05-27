# Test Batch Function
context('test batch geocoder function')

###########################
#### TESTS OUTSTANDING ####
###########################
## Duplicated IDs #########
## SF Installation ########
## Parallel Configuration #
###########################

# Load Homicide Data
stl_homicides_small <- stl_homicides_small

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

test_that('Invalid Argument Specifications fail', {
  expect_error(
    cxy_geocode(),
    '`.data` and `street` are required arguments'
  )
  expect_error(
    cxy_geocode(stl_homicides_small),
    '`.data` and `street` are required arguments'
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', return = 'BAD INPUT'),
    "`return` must be one of 'locations' or 'geographies'"
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', return = 'geographies'),
    "`vintage` must be specified for return = 'geographies'"
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', class = 'BAD INPUT'),
    "`class` must be one of 'dataframe' or 'sf'"
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', output = 'BAD INPUT'),
    "`output` must be one of 'simple' or 'full'"
  )
})

test_that('Warnings for specified arguments are triggered', {
  skip_on_cran()
  skip_if_offline(host = "r-project.org")

  expect_warning(
    cxy_geocode(stl_homicides_small, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code', vintage = 'Current_Current'),
    "Vintage ignored for return = 'locations'"
  )
  expect_warning(
    cxy_geocode(stl_homicides_small, street = 'street_address', state = 'state', zip = 'postal_code'),
    'Omission of `city`, `state` or `zip` greatly reduces the speed and accuracy of the geocoder.'
  )
  expect_warning(
    cxy_geocode(stl_homicides_small, street = 'street_address', city = 'city', zip = 'postal_code'),
    'Omission of `city`, `state` or `zip` greatly reduces the speed and accuracy of the geocoder.'
  )
  expect_warning(
    cxy_geocode(stl_homicides_small, street = 'street_address', city = 'city', state = 'state'),
    'Omission of `city`, `state` or `zip` greatly reduces the speed and accuracy of the geocoder.'
  )
})

test_that('Invalid column names error', {
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'BAD INPUT', city = 'city', state = 'state', zip = 'postal_code'),
    'BAD INPUT is not a defined column name in the data.frame'
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', city = 'BAD INPUT', state = 'state', zip = 'postal_code'),
    'BAD INPUT is not a defined column name in the data.frame'
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', city = 'city', state = 'BAD INPUT', zip = 'postal_code'),
    'BAD INPUT is not a defined column name in the data.frame'
  )
  expect_error(
    cxy_geocode(stl_homicides_small, street = 'street_address', city = 'city', state = 'state', zip = 'BAD INPUT'),
    'BAD INPUT is not a defined column name in the data.frame'
  )
  expect_error(
    cxy_geocode(stl_homicides_small, id = 'BAD INPUT', street = 'street_address', city = 'city', state = 'state', zip = 'postal_code'),
    'BAD INPUT is not a defined column name in the data.frame'
  )
})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Execute Valid Geocodes

test_that('Valid batch geocodes execute, and return correctly', {
  skip_on_cran()
  skip_if_offline(host = "r-project.org")

  # Batch Testing of Different Kinds
  x <- stl_homicides[1:10,]

  ## LOCATION
  df_simple <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'locations', class = 'dataframe', output = 'simple')
  df_full <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'locations', class = 'dataframe', output = 'full')
  sf_simple <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'locations', class = 'sf', output = 'simple')
  sf_full <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'locations', class = 'sf', output = 'full')

  ## GEOGRAPHY
  g_df_simple <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'geographies', class = 'dataframe', output = 'simple', vintage = 'Current_Current')
  g_df_full <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'geographies', class = 'dataframe', output = 'full', vintage = 'Current_Current')
  g_sf_simple <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'geographies', class = 'sf', output = 'simple', vintage = 'Current_Current')
  g_sf_full <-
    cxy_geocode(x, street = 'street_address', city = 'city', state = 'state', zip = 'postal_code',
                return = 'geographies', class = 'sf', output = 'full', vintage = 'Current_Current')

  expect_s3_class(
    df_simple,
    'data.frame'
  )
  expect_s3_class(
    df_full,
    'data.frame'
  )
  expect_s3_class(
    g_df_simple,
    'data.frame'
  )
  expect_s3_class(
    g_df_full,
    'data.frame'
  )
  expect_s3_class(
    sf_simple,
    'sf'
  )
  expect_s3_class(
    sf_full,
    'sf'
  )
  expect_s3_class(
    g_sf_simple,
    'sf'
  )
  expect_s3_class(
    g_sf_full,
    'sf'
  )
  expect_length(
    names(df_simple),
    8
  )
  expect_length(
    names(df_full),
    14
  )
  expect_length(
    names(g_df_simple),
    12
  )
  expect_length(
    names(g_df_full),
    18
  )
  expect_length(
    names(sf_simple),
    7
  )
  expect_length(
    names(sf_full),
    13
  )
  expect_length(
    names(g_sf_simple),
    11
  )
  expect_length(
    names(g_sf_full),
    17
  )

})


