## Test rvcData
context("Testing RVC data")

## Import test data
## Properly formatted
data(test1)
## Improperly Formatted, missing YEAR
test1N1 = test1[,-1]
## Improperly formatted (for includes.proetected = TRUE) missing MPA_NR
test1N2 = test1[,-3]
## Improperly formatted missing both year and STRAT
test1N3 = test1[,-c(1,2)]

context(" testing required variables")
expect_error(rvcData(test1N1, "NOT FISH"), "required variables YEAR not found in data")
expect_error(rvcData(test1N2, "NOT FISH", includes.protected = TRUE), "required variable MPA_NR not found in data")
expect_error(rvcData(test1N3, "NOT FISH"), "required variables YEAR, STRAT not found in data")







