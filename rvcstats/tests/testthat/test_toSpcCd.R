context("testing toSpcCd helper function")
# Test objects
a  <- "epinephelus morio"
b  <- "EPINEPHELUS MORIO"
d  <- "EPI MORI"
e  <- "EPI MOR"
f  <- "EP MORI"
g  <- "EPI MORI O"
h  <- c("EPI MORI", "LUTjanus griseus")

test_that("takes species codes",
          expect_equal(toSpcCd(d), "EPI MORI")
          )
test_that("handles full scinames",{
 expect_equal(toSpcCd(b), "EPI MORI")
 expect_equal(toSpcCd(a), "EPI MORI")
})

test_that("handles vectors", {
 expect_equal(toSpcCd(h), c("EPI MORI", "LUT GRIS")) 
})