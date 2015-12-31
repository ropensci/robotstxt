# tests for functions responsible for data gathering and transformation


rtxt_asb   <- rt_get_rtxt("allow_single_bot.txt")
rtxt_dafa  <- rt_get_rtxt("disallow_all_for_all.txt")
rtxt_dafbb <- rt_get_rtxt("disallow_all_for_BadBot.txt")
rtxt_dsfa  <- rt_get_rtxt("disallow_some_for_all.txt")
rtxt_empty <- rt_get_rtxt("empty.txt")
rtxt_amzn  <- rt_get_rtxt("robots_amazon.txt")
rtxt_bt    <- rt_get_rtxt("robots_bundestag.txt")
rtxt_ggl   <- rt_get_rtxt("robots_google.txt")
rtxt_nyt   <- rt_get_rtxt("robots_new_york_times.txt")
rtxt_spgl  <- rt_get_rtxt("robots_spiegel.txt")
rtxt_yh    <- rt_get_rtxt("robots_yahoo.txt")
rtxt_she   <- rt_get_rtxt("selfhtml_Example.txt")




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














