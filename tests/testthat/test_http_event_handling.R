context("HTTP evenet handling")

test_that("www redirects are handled silently", {
  expect_silent({
    www_redirect <- readRDS(system.file("http_requests/http_redirect_www.rds", package = "robotstxt"))
    get_robotstxt(
      "http://google.com",
      rt_robotstxt_http_getter = function(...){www_redirect}
    )
  })
})

test_that("non www redirects are handled non silently", {
  expect_silent({
    www_redirect <- readRDS(system.file("http_requests/http_redirect_www.rds", package = "robotstxt"))
    get_robotstxt(
      "http://google.com",
      rt_robotstxt_http_getter = function(...){www_redirect}
    )
  })
})

