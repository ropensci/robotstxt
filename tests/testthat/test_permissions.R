# tests for functions responsible for data gathering and transformation


rtxt_asb   <- readLines(system.file("robotstxts/allow_single_bot.txt", package = "robotstxt"), warn = FALSE)
rtxt_dafa  <- readLines(system.file("robotstxts/disallow_all_for_all.txt", package = "robotstxt"), warn = FALSE)
rtxt_dafbb <- readLines(system.file("robotstxts/disallow_all_for_BadBot.txt", package = "robotstxt"), warn = FALSE)
rtxt_dsfa  <- readLines(system.file("robotstxts/disallow_some_for_all.txt", package = "robotstxt"), warn = FALSE)
rtxt_empty <- readLines(system.file("robotstxts/empty.txt", package = "robotstxt"), warn = FALSE)
rtxt_amzn  <- readLines(system.file("robotstxts/robots_amazon.txt", package = "robotstxt"), warn = FALSE)
rtxt_bt    <- readLines(system.file("robotstxts/robots_bundestag.txt", package = "robotstxt"), warn = FALSE)
rtxt_ggl   <- readLines(system.file("robotstxts/robots_google.txt", package = "robotstxt"), warn = FALSE)
rtxt_nyt   <- readLines(system.file("robotstxts/robots_new_york_times.txt", package = "robotstxt"), warn = FALSE)
rtxt_spgl  <- readLines(system.file("robotstxts/robots_spiegel.txt", package = "robotstxt"), warn = FALSE)
rtxt_yh    <- readLines(system.file("robotstxts/robots_yahoo.txt", package = "robotstxt"), warn = FALSE)
rtxt_she   <- readLines(system.file("robotstxts/selfhtml_Example.txt", package = "robotstxt"), warn = FALSE)




context("path sanitization")

test_that(
  "path sanitization", {
    expect_true(sanitize_path("")=="/")
    expect_true(sanitize_path("/blah")=="/blah")
    expect_true(sanitize_path("blah")=="/blah")
    expect_true(sanitize_path("blah/")=="/blah/")
    expect_true(sanitize_path("   blah")=="/blah")
  }
)

test_that(
  "path sanitization vectorized", {
    expect_true( sanitize_path("")=="/")
    expect_true( all(sanitize_path(c("/blah","/blah"))==c("/blah","/blah")))
    expect_true( all(sanitize_path(c("blah","/blah"))==c("/blah","/blah")))
    expect_true( length(sanitize_path(c("/blah","/blah"))==c("/blah","/blah"))==2)
    expect_true( sanitize_path("blah")=="/blah")
    expect_true( sanitize_path("blah/")=="/blah/")
    expect_true( sanitize_path("   blah")=="/blah")
  }
)


context("permission sanitization")

test_that(
  "escapes and transformations", {
    expect_true(sanitize_permission_values("?")=="^/\\?")
    expect_true(sanitize_permission_values("*")=="^/.*")
    expect_true(sanitize_permission_values("")=="^/")
  }
)


context("permission grepping works")

test_that(
  "permission grepping", {
    expect_true(grepl(sanitize_permission_values("/"),  "/"))
    expect_true(grepl(sanitize_permission_values("/"),  "/asdfasdf"))
    expect_true(grepl(sanitize_permission_values(" /"), "/asdfasdf"))
    expect_true(grepl(sanitize_permission_values("/"),  "/asdfasdf"))
    expect_true(grepl(sanitize_permission_values("sdfg/"),  "/sdfg/"))
    expect_true(grepl(sanitize_permission_values(" sdfg/"),  "/sdfg/"))
  }
)



context("checking works")

permissions <- rt_get_permissions(rtxt_she)

test_that(
  "permission checking works", {
    expect_false(path_allowed(permissions, path="temp", bot="mein-robot"))
  }
)














