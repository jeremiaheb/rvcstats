context("testing toQuery helper function")

test_that("formats query properly",
          {expect_equal(toQuery(species = "EPI MORI"),
                        "?species[]=EPI+MORI")
           expect_equal(toQuery(species = "LUT GRIS", stratum = c("FDLR","FMLR")),
                        "?species[]=LUT+GRIS&stratum[]=FDLR&stratum[]=FMLR"
                        )});