context("attribute handling")

test_that("get_robotstxt produces attributes", {

  expect_true({
    www_redirect <- readRDS(system.file("http_requests/http_redirect_www.rds", package = "robotstxt"))

    suppressWarnings(
      rtxt <-
        get_robotstxt(
          "http://google.com",
          rt_robotstxt_http_getter = function(...){www_redirect}
        )
    )

    "problems" %in% names(attributes(rtxt))
  })

  expect_true({
    http_404 <- readRDS(system.file("http_requests/http_404.rds", package = "robotstxt"))

    suppressWarnings(
      rtxt <-
        get_robotstxt(
          "http://google.com",
          rt_robotstxt_http_getter = function(...){http_404}
        )
    )

    "problems" %in% names(attributes(rtxt))
  })


  expect_true({
    http_ok <- readRDS(system.file("http_requests/http_ok_1.rds", package = "robotstxt"))

    suppressWarnings(
      rtxt <-
        get_robotstxt(
          "http://google.com",
          rt_robotstxt_http_getter = function(...){http_404}
        )
    )

    "problems" %in% names(attributes(rtxt))
  })


  expect_true({
    http_ok <- readRDS(system.file("http_requests/http_ok_2.rds", package = "robotstxt"))

    suppressWarnings(
      rtxt <-
        get_robotstxt(
          "http://google.com",
          rt_robotstxt_http_getter = function(...){http_404}
        )
    )

    "problems" %in% names(attributes(rtxt))
  })



  expect_true({
    http_ok <- readRDS(system.file("http_requests/http_ok_3.rds", package = "robotstxt"))

    suppressWarnings(
      rtxt <-
        get_robotstxt(
          "http://google.com",
          rt_robotstxt_http_getter = function(...){http_404}
        )
    )

    "problems" %in% names(attributes(rtxt))
  })


  expect_true({
    http_ok <- readRDS(system.file("http_requests/http_ok_4.rds", package = "robotstxt"))

    suppressWarnings(
      rtxt <-
        get_robotstxt(
          "http://google.com",
          rt_robotstxt_http_getter = function(...){http_404}
        )
    )

    "problems" %in% names(attributes(rtxt))
  })



})



