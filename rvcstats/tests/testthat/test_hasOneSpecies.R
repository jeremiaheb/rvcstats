context("testing hasOneSpecies helper method")
# Data
x  <- data.frame(SPECIES_CD  = rep("OCY CHRYS", 4))
y  <- data.frame(SPECIES_CD = c("OCY CHRYS", "LUT ANAL"))
# test
test_that("test hasOneSpecies",
{
  expect_true(hasOneSpecies(x))
  expect_true(!hasOneSpecies(y))
}
          )