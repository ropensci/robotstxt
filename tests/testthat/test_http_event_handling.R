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
  expect_warning({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    get_robotstxt(
      "http://google.com",
      rt_robotstxt_http_getter = function(...){domain_change}
    )
  })
})

test_that("warn = FALSE does silences warnings", {
  expect_silent({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    get_robotstxt(
      "github.io",
      rt_robotstxt_http_getter = function(...){domain_change},
      warn = FALSE
    )
  })
})


test_that("suspect content", {
  expect_true({
    suppressWarnings({
      suspect_content <- readRDS(system.file("http_requests/http_html_content.rds", package = "robotstxt"))
      rtxt <-
        get_robotstxt(
          "pages.github.com",
          rt_robotstxt_http_getter = function(...){suspect_content}
        )
      problems <- attr(rtxt, "problems")
    })

    !is.null(problems$on_file_type_mismatch) & problems$on_suspect_content$content_suspect
  })
})





test_that("all ok", {
  expect_silent({
    http_ok <- readRDS(system.file("http_requests/http_ok_1.rds", package = "robotstxt"))
    get_robotstxt(
      "google.com",
      rt_robotstxt_http_getter = function(...){http_ok}
    )
  })

  expect_silent({
    http_ok <- readRDS(system.file("http_requests/http_ok_2.rds", package = "robotstxt"))
    get_robotstxt(
      "google.com",
      rt_robotstxt_http_getter = function(...){http_ok}
    )
  })

  expect_silent({
    http_ok <- readRDS(system.file("http_requests/http_ok_3.rds", package = "robotstxt"))
    get_robotstxt(
      "google.com",
      rt_robotstxt_http_getter = function(...){http_ok}
    )
  })

  expect_silent({
    if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
      get_robotstxt(
        "google.com"
      )
    }
  })


  expect_silent({
    if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
      get_robotstxt(
        "google.com",
        force = TRUE
      )
    }
  })
})