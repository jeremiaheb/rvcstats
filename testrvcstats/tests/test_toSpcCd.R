## Test .toSpcCd
context("Testing toSpcCd")

## Test 1: One name
expect_equal(.toSpcCd("chaetodon capistratus"), c("CHA CAPI"))

## Test 2: Multiple names
expect_equal(.toSpcCd(c("lutjanus griseus", "hypoplectrus unicolor", "epi mori")), 
              c("LUT GRIS", "HYP UNIC", "EPI MORI"))