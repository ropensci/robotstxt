# tests for functions responsible for data gathering and transformation

context("permission sanatization")

test_that(
  "question mark is escaped", {
    expect_true(sanatize_perm("?")=="\\?")
  }
)
















