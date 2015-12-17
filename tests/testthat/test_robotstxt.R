# testing the workings of robotstxt objects

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


context("robotstxt creation")

test_that(
  "initialisation works well", {
    expect_error( rt <- robotstxt$new() )
    expect_error( rt <- robotstxt$new("") )
    expect_true( all(class(robotstxt$new(text=rtxt_she)) %in% c("R6", "robotstxt")) )
  }
)

test_that(
  "robotstxt check method works well", {
    expect_true( robotstxt$new(text=rtxt_she)$check() )
    expect_true( robotstxt$new(text=rtxt_she)$check("blah") )
  }
)


context("robotstxt checking")

test_that(
  "robotstxt check method works well", {
    expect_true( robotstxt$new(text=rtxt_she)$check() )
    expect_true( robotstxt$new(text=rtxt_she)$check("blah") )
  }
)