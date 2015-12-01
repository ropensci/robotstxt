# testing the workings of robotstxt objects

context("robotstxt creation")

test_that(
  "initialisation works well", {
    expect_error( rt <- robotstxt$new() )
  }
)