context("testing ssu function")
# Make objects to test
x  <- structure(
  list(
    sample_data = data.frame(YEAR = rep(2012,4),
                             REGION = rep('FLA KEYS',4),
                             SPECIES_CD = rep("EPI MORI", 4),
                             STRAT = rep("FMLR", 4),
                             PRIMARY_SAMPLE_UNIT = rep("001u", 4),
                             STATION_NR = c(1,1,2,2),
                             PROT = rep(0,4),
                             NUM = c(1,1,2,2),
                             LEN = c(1,1, 2,2)),
    stratum_data = NULL,
    lhp_data = NULL),
  class = "RVC"
  );
growth_parameters = list(a = 1, b = 3)
# Test density 
test_that("test ssu density",
  { s  <- ssu(x, "density", NULL)
    expect_equal(names(s), names(x)) 
    expect_is(s, "SSU")
    expect_true(all(c("YEAR", "REGION", "SPECIES_CD", "STRAT", "PRIMARY_SAMPLE_UNIT",
                   "STATION_NR", "PROT", "yi") %in% names(s$sample_data)))
    expect_equal(s$sample_data$yi, c(2, 4))
  }
)
#test biomass 
test_that("test ssu biomass",
  {
    b  <- ssu(x, "biomass", growth_parameters)
    expect_equal(b$sample_data$yi, c(2, 32))
  }
          )
# test length_frequency
test_that(
  "test ssu length_frequency",
{
  l  <- ssu(x, "length_frequency", NULL)
  expect_equal(l$sample_data$yi, c(2,4))
}
  )