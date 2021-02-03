# Test Option Functions
context("test censusxy options functions")

# Test Benchmarks -------------------------------------------------------------
test_that('Valid Benchmarks are returned', {
  skip_if_offline()

  expect_s3_class(
    cxy_benchmarks(),
    'data.frame'
  )
})

# Test Vintages ---------------------------------------------------------------
test_that('Valid Vintages are returned', {
  skip_if_offline()

  expect_s3_class(
    cxy_vintages(cxy_benchmarks()$benchmarkName[1]),
    'data.frame'
  )
  expect_s3_class(
    cxy_vintages(cxy_benchmarks()$id[1]),
    'data.frame'
  )
})

test_that('Invalid Vintages Error Correctly', {
  expect_error(
    cxy_vintages(),
    '`benchmark` is a required argument'
  )

  skip_if_offline()
  expect_error(
    cxy_vintages('Bad Input'),
    'Not a Valid Benchmark'
  )
})
