# tests for functions responsible for data gathering and transformation

context("useragent extraction")


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
rtxt_cd    <- rt_get_rtxt("crawl_delay.txt")
rtxt_host  <- rt_get_rtxt("host.txt")

test_that(
  "all user agents are extracted", {
    expect_true(all( parse_robotstxt(rtxt_asb   )$useragents %in% c("*", "Google") ))
    expect_true(all( parse_robotstxt(rtxt_dafa  )$useragents %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_dafbb )$useragents %in% c("BadBot") ))
    expect_true(all( parse_robotstxt(rtxt_dsfa  )$useragents %in% c("*") ))
    expect_true(all( length(parse_robotstxt(rtxt_empty )$useragents) == 0  ))
    expect_true(all( parse_robotstxt(rtxt_amzn  )$useragents %in% c("EtaoSpider", "*") ))
    expect_true(all( parse_robotstxt(rtxt_bt    )$useragents %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_ggl   )$useragents %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_nyt   )$useragents %in% c("*", "Mediapartners-Google", "AdsBot-Google", "adidxbot" ) ))
    expect_true(all( parse_robotstxt(rtxt_spgl  )$useragents %in% c("WebReaper", "Slurp") ))
    expect_true(all( parse_robotstxt(rtxt_yh    )$useragents %in% c("*") ))
    expect_true(all( parse_robotstxt(rtxt_she   )$useragents %in% c("*","mein-Robot", "UniversalRobot/1.0") ))
    expect_true(all( parse_robotstxt(rtxt_datao )$useragents %in% c("BadBot","Googlebot") ))
  }
)

context("permission extraction")

test_that(
  "specification of more than one user agent gets interpreted right", {
    expect_true( dim(parse_robotstxt(rtxt_datao )$permissions)[1]==2  )
    expect_true( all(parse_robotstxt(rtxt_datao )$permissions$value=="/private/")  )
  }
)


context("non-useragent extraction")

test_that(
  "comments get extracted right", {
    expect_true( dim(parse_robotstxt(rtxt_tcom )$comments)[1]==3  )
  }
)


test_that(
  "craw-delay gets extracted", {
    expect_true( parse_robotstxt(rtxt_host)$host$value=="www.whatever.com"  )
  }
)

test_that(
  "craw-delay gets extracted", {
    expect_true( parse_robotstxt(rtxt_cd)$crawl_delay$value==10  )
  }
)


classes <- function(x){
  unlist(lapply(x, class))
}

test_that(
  "data.frames contain no factors", {
    expect_false( any( classes( parse_robotstxt(rtxt_datao)$useragents ) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_datao)$comments   ) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_datao)$permissions) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_datao)$sitemap    ) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_datao)$other      ) %in% "factor") )

    expect_false( any( classes( parse_robotstxt(rtxt_empty)$useragents ) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_empty)$comments   ) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_empty)$permissions) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_empty)$sitemap    ) %in% "factor") )
    expect_false( any( classes( parse_robotstxt(rtxt_empty)$other      ) %in% "factor") )
  }
)











