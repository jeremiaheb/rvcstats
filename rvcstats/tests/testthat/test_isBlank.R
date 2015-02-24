context("testing isBlank helper method")

test_that(
  "testing isBlank method",
{
  expect_true(isBlank(NULL))
  expect_true(isBlank(NA))
  expect_true(!isBlank(1))
}
  )