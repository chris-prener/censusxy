test_that('batch parallel works', {
  skip_on_cran()
  skip_if_offline()

  data('stl_homicides_small')

  df_par <- cxy_geocode(stl_homicides_small, street = 'street_address',
                         city = 'city', state = 'state', zip = 'postal_code',
                         return = 'locations', class = 'dataframe', output = 'full',
                         parallel = 2)

  df_par_sf <- cxy_geocode(stl_homicides_small, street = 'street_address',
                        city = 'city', state = 'state', zip = 'postal_code',
                        return = 'locations', class = 'sf', output = 'full',
                        parallel = 2)

  expect_s3_class(df_par,
                  'data.frame'
                  )
  expect_s3_class(df_par_sf,
                  'sf'
  )

  expect_length(
    names(df_par),
    14
    )
  expect_length(
    names(df_par_sf),
    13
  )

})
