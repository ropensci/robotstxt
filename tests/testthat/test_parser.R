# tests for functions responsible for data gathering and transformation

context("useragent extraction")


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
rtxt_pm    <- rt_get_rtxt("robots_pmeissner.txt")
rtxt_wp    <- rt_get_rtxt("robots_wikipedia.txt")

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
















