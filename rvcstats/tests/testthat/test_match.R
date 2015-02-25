context("test match helper function")

test_that("test match",
{
  expect_true(all(c(1,2,3) %match% c(2,1,3)))
  expect_true(all(c(1,2,3) %match% NULL))
  expect_true(!all(c(1,2,4) %match% c(1,2,3)))
}
          )