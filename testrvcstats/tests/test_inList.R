## Test inList helper
context("Testing inList")
a = c(1,2,3,4)
b = c(1,2,3,4,5)

## Test 1: Throws Error
expect_error(.inList("par",b,a), "par 5 not found in data")

## Test 2: No error
expect_true(is.null(.inList("par",a,b)))
