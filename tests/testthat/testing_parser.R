# tests for functions responsible for data gathering and transformation

context("useragent extraction")

library(stringr)

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


test_that(
  "all user agents are extracted", {
    expect_true(all( parse_robotstxt(rtxt_asb   )$useragent %in% c("*", "Google") ))
    expect_true(all( parse_robotstxt(rtxt_dafa  )$useragent %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_dafbb )$useragent %in% c("BadBot") ))
    expect_true(all( parse_robotstxt(rtxt_dsfa  )$useragent %in% c("*") ))
    expect_true(all( length(parse_robotstxt(rtxt_empty )$useragent) == 0  ))
    expect_true(all( parse_robotstxt(rtxt_amzn  )$useragent %in% c("EtaoSpider", "*") ))
    expect_true(all( parse_robotstxt(rtxt_bt    )$useragent %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_ggl   )$useragent %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_nyt   )$useragent %in% c("*", "Mediapartners-Google", "AdsBot-Google", "adidxbot" ) ))
    expect_true(all( parse_robotstxt(rtxt_spgl  )$useragent %in% c("WebReaper", "Slurp") ))
    expect_true(all( parse_robotstxt(rtxt_yh    )$useragent %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_she   )$useragent %in% c("*","mein-Robot", "UniversalRobot/1.0") ))
  }
)
