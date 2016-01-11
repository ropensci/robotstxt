# tests for functions responsible for data gathering and transformation


# note: get rt_get_rtxt() with devtools::load_all()
rtxt_asb   <- rt_get_rtxt("allow_single_bot.txt")
rtxt_dafa  <- rt_get_rtxt("disallow_all_for_all.txt")
rtxt_dafbb <- rt_get_rtxt("disallow_all_for_BadBot.txt")
rtxt_dsfa  <- rt_get_rtxt("disallow_some_for_all.txt")
rtxt_empty <- rt_get_rtxt("empty.txt")
rtxt_datao <- rt_get_rtxt("disallow_two_at_once.txt")
rtxt_tcom  <- rt_get_rtxt("testing_comments.txt")
rtxt_amzn  <- rt_get_rtxt("robots_amazon.txt")
rtxt_bt    <- rt_get_rtxt("robots_bundestag.txt")
rtxt_ggl   <- rt_get_rtxt("robots_google.txt")
rtxt_nyt   <- rt_get_rtxt("robots_new_york_times.txt")
rtxt_spgl  <- rt_get_rtxt("robots_spiegel.txt")
rtxt_yh    <- rt_get_rtxt("robots_yahoo.txt")
rtxt_she   <- rt_get_rtxt("selfhtml_Example.txt")
rtxt_pm    <- rt_get_rtxt("robots_pmeissner.txt")
rtxt_wp    <- rt_get_rtxt("robots_wikipedia.txt")



#### context("path sanitization") ==============================================
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

#### context("permission sanitization") ========================================
context("permission sanitization")

test_that(
  "escapes and transformations", {
    expect_true(sanitize_permission_values("?")=="^/\\?")
    expect_true(sanitize_permission_values("*")=="^/.*")
    expect_true(sanitize_permission_values("")=="^/")
  }
)

#### context("permission grepping works") ======================================
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


#### context("checking works") =================================================
context("permission checking")

permissions_she   <- rt_get_fields(rtxt_she, "allow")
permissions_asb   <- rt_get_fields(rtxt_asb, "allow")
permissions_pm    <- rt_get_fields(rtxt_pm, "allow")
permissions_dafa  <- rt_get_fields(rtxt_dafa, "allow")
permissions_dafbb <- rt_get_fields(rtxt_dafbb, "allow")
permissions_empty <- rt_get_fields(rtxt_empty, "allow")



test_that(
  "simple check", {
    expect_false(path_allowed(permissions_she, path="temp", bot="mein-robot"))
  }
)


test_that(
  "Allows and Disallows applicable at the same time", {
    expect_false(path_allowed(permissions_pm,  path="images"))
    expect_false(path_allowed(permissions_pm,  path="/images"))
    expect_false(path_allowed(permissions_pm,  path="/images/"))
    expect_false(path_allowed(permissions_pm,  path="images/"))
    expect_false(path_allowed(permissions_pm,  path="images/dings"))
  }
)

test_that(
  "check 'only single bot allowed'", {
    expect_false(path_allowed(permissions_asb,  path="images"))
    expect_false(path_allowed(permissions_asb,  path="/images"))
    expect_false(path_allowed(permissions_asb,  path="/images/"))
    expect_false(path_allowed(permissions_asb,  path="images/"))
    expect_false(path_allowed(permissions_asb,  path="images/dings"))
    expect_false(path_allowed(permissions_asb,  path="*"))

    expect_false(path_allowed(permissions_asb,  path="images", bot="harald"))
    expect_false(path_allowed(permissions_asb,  path="/images", bot="*"))
    expect_false(path_allowed(permissions_asb,  path="/images/", "*er"))
    expect_false(path_allowed(permissions_asb,  path="*", bot="erwin"))

    expect_true(path_allowed(permissions_asb,  path="images", bot="Google"))
    expect_true(path_allowed(permissions_asb,  path="/images", bot="Google"))
    expect_true(path_allowed(permissions_asb,  path="/images/", bot="Google"))
    expect_true(path_allowed(permissions_asb,  path="images/", bot="Google"))
    expect_true(path_allowed(permissions_asb,  path="images/dings", bot="Google"))
    expect_true(path_allowed(permissions_asb,  path="*", bot="Google"))
  }
)


test_that(
  "dissallow all for all", {
    expect_false(path_allowed(permissions_dafa, path="", bot="mybot"))
    expect_false(path_allowed(permissions_dafa, path="/imgages", bot="mybot"))
    expect_false(path_allowed(permissions_dafa, path="index.html", bot="mybot"))
    expect_false(path_allowed(permissions_dafa, path="*", bot="mybot"))

    expect_false(path_allowed(permissions_dafa, path=""))
    expect_false(path_allowed(permissions_dafa, path="/imgages"))
    expect_false(path_allowed(permissions_dafa, path="index.html"))
    expect_false(path_allowed(permissions_dafa, path="*"))
  }
)


test_that(
  "dissallow all for BadBot", {
    expect_false(path_allowed(permissions_dafbb, path="", bot="BadBot"))
    expect_false(path_allowed(permissions_dafbb, path="/imgages", bot="BadBot"))
    expect_false(path_allowed(permissions_dafbb, path="index.html", bot="BadBot"))
    expect_false(path_allowed(permissions_dafbb, path="*", bot="BadBot"))

    expect_true(path_allowed(permissions_dafbb, path=""))
    expect_true(path_allowed(permissions_dafbb, path="/imgages"))
    expect_true(path_allowed(permissions_dafbb, path="index.html"))
    expect_true(path_allowed(permissions_dafbb, path="*"))
  }
)


test_that(
  "case of Bot naME dOeS not matter", {
    expect_false(path_allowed(permissions_dafbb, path="", bot="badbot"))
    expect_false(path_allowed(permissions_dafbb, path="/imgages", bot="badbot"))
    expect_false(path_allowed(permissions_dafbb, path="index.html", bot="badbot"))
    expect_false(path_allowed(permissions_dafbb, path="*", bot="badbot"))

    expect_false(path_allowed(permissions_dafbb, path="", bot="Badbot"))
    expect_false(path_allowed(permissions_dafbb, path="/imgages", bot="Badbot"))
    expect_false(path_allowed(permissions_dafbb, path="index.html", bot="Badbot"))
    expect_false(path_allowed(permissions_dafbb, path="*", bot="Badbot"))
  }
)


test_that(
  "empty file leads to all allowed for all", {
    expect_true(path_allowed(permissions_empty, path=""))
    expect_true(path_allowed(permissions_empty, path="/"))
    expect_true(path_allowed(permissions_empty, path="/imgages"))
    expect_true(path_allowed(permissions_empty, path="index.html"))

    expect_true(path_allowed(permissions_empty, path="", bot = "BadBot"))
    expect_true(path_allowed(permissions_empty, path="/", bot = "BadBot"))
    expect_true(path_allowed(permissions_empty, path="/imgages", bot = "BadBot"))
    expect_true(path_allowed(permissions_empty, path="index.html", bot = "BadBot"))
  }
)



