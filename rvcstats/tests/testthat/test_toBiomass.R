context("testing toBiomass helper function")
# Make data to test with
x  <- list(sample_data = data.frame(LEN = c(2, 3), NUM = c(1, 2)));
growth_parameters = list(a = 1, b = 3)

test_that("converts to biomass properly",
{expect_equal(toBiomass(x, growth_parameters)$sample_data$NUM, c(8, 54))}
          );