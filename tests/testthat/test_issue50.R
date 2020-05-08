
context("robotstxt missing scheme")


test_that(
  "robotstxt no scheme works", {
    expect_true({
      if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
        paths_allowed("www.google.com")
      } else {
        TRUE
      }
    })

    expect_true({
      if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
        paths_allowed("google.com")
      } else {
        TRUE
      }
    })

  }
)



test_that(
  "robotstxt scheme works", {
    expect_true({
      if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
        paths_allowed("https://google.com")
      } else {
        TRUE
      }
    })

    expect_true({
      if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
        paths_allowed("https://www.google.com")
      } else {
        TRUE
      }
    })

    expect_true({
      if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
        paths_allowed("http://google.com")
      } else {
        TRUE
      }
    })

    expect_true({
      if ( Sys.getenv("rpkg_use_internet_for_testing") == "TRUE"  ){
        paths_allowed("http://www.google.com")
      } else {
        TRUE
      }
    })
  }
)



