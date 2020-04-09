# Test Option Functions
context("test censusxy options functions")

# Test Benchmarks -------------------------------------------------------------
test_that('Valid Benchmarks are returned', {
  expect_s3_class(
    cxy_benchmarks(),
    'data.frame'
  )
})


# Test Vintages ---------------------------------------------------------------
test_that('Valid Vintages are returned', {
  expect_s3_class(
    cxy_vintages('Public_AR_Census2010'),
    'data.frame'
  )
  expect_s3_class(
    cxy_vintages(8),
    'data.frame'
  )
})

test_that('Invalid Vintages Error Correctly', {
  expect_error(
    cxy_vintages(),
    '`benchmark` is a required argument'
  )
  expect_error(
    cxy_vintages('Bad Input'),
    'Not a Valid Benchmark'
  )
})
