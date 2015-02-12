context("testing without helper function")
## Test objects
a  <- c(1,2,3);
b  <- c(2,3,4);

test_that("a not in b returns a - intersect(a,b)", {
  expect_equal(a %w/o% b, 1);
})

test_that("a not in NULL, returns a", {
 expect_equal(a %w/o% NULL, a) 
})

test_that("NULL not in a, returns logical(0)", {
  expect_equal(length(NULL %w/o% a), 0)
})