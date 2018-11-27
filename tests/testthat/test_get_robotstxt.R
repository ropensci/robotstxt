# testing the workings of get_robotstxt function

context("get_robotstxt()")


test_that(
  "NA in NA out", {
    expect_true({
      is.na(get_robotstxt(domain = NA))
    })

    expect_true({
      all(
        is.na(
          get_robotstxts(domain = c(NA, NA))
        )
      )
    })
  }
)


test_that(
  "standard usage works", {
    if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE" ){
      expect_true({
        suppressWarnings(get_robotstxt(domain = "example.com"))
        TRUE
      })

      expect_true({
        suppressWarnings(get_robotstxts(domain = c("example.com", "example.com")))
        TRUE
      })
    }
  }
)