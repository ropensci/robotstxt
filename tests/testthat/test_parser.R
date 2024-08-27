rtxt_asb        <- rt_get_rtxt("allow_single_bot.txt")
rtxt_dafa       <- rt_get_rtxt("disallow_all_for_all.txt")
rtxt_dafbb      <- rt_get_rtxt("disallow_all_for_BadBot.txt")
rtxt_dsfa       <- rt_get_rtxt("disallow_some_for_all.txt")
rtxt_empty      <- rt_get_rtxt("empty.txt")
rtxt_datao      <- rt_get_rtxt("disallow_two_at_once.txt")
rtxt_tcom       <- rt_get_rtxt("testing_comments.txt")
rtxt_amzn       <- rt_get_rtxt("robots_amazon.txt")
rtxt_bt         <- rt_get_rtxt("robots_bundestag.txt")
rtxt_ggl        <- rt_get_rtxt("robots_google.txt")
rtxt_nyt        <- rt_get_rtxt("robots_new_york_times.txt")
rtxt_spgl       <- rt_get_rtxt("robots_spiegel.txt")
rtxt_yh         <- rt_get_rtxt("robots_yahoo.txt")
rtxt_she        <- rt_get_rtxt("selfhtml_Example.txt")
rtxt_pm         <- rt_get_rtxt("robots_pmeissner.txt")
rtxt_wp         <- rt_get_rtxt("robots_wikipedia.txt")
rtxt_cd         <- rt_get_rtxt("crawl_delay.txt")
rtxt_host       <- rt_get_rtxt("host.txt")
rtxt_fb_nsp     <- rt_get_rtxt("robots_facebook_unsupported.txt")
rtxt_cdc        <- rt_get_rtxt("robots_cdc.txt")
rtxt_cdc2       <- paste(rt_get_rtxt("robots_cdc2.txt"), collapse = "\r\n")
rtxt_rbloggers  <- rt_get_rtxt("rbloggers.txt")
rtxt_ct         <- rt_get_rtxt("robots_commented_token.txt")


valid_rtxt_files <- c(
  rtxt_asb, rtxt_dafa, rtxt_dafbb, rtxt_dsfa, rtxt_empty,
  rtxt_datao, rtxt_tcom, rtxt_amzn, rtxt_bt, rtxt_ggl,
  rtxt_nyt, rtxt_spgl, rtxt_yh, rtxt_she, rtxt_pm,
  rtxt_wp, rtxt_cd, rtxt_host, rtxt_cdc, rtxt_ct,
  "\n\n\n"
)

test_that("all robots.txt files are valid with check_strickt_ascii = F", {
  expect_true(is_valid_robotstxt(valid_rtxt_files))
})


valid_rtxt_files_ascii <- c(
  rtxt_asb, rtxt_dafa, rtxt_dafbb, rtxt_dsfa, rtxt_empty,
  rtxt_datao, rtxt_tcom, rtxt_amzn, rtxt_bt, rtxt_ggl,
  rtxt_nyt, rtxt_spgl, rtxt_yh, rtxt_she, rtxt_pm,
  rtxt_cd, rtxt_host, rtxt_cdc, rtxt_ct,
  "\n\n\n"
)

test_that("all robots.txt files are valid with check_strickt_ascii = T", {
  expect_true(
    is_valid_robotstxt(valid_rtxt_files_ascii, check_strickt_ascii = TRUE)
  )
})


test_that("broken robots.txt files are invalid", {
  expect_false(is_valid_robotstxt(rtxt_fb_nsp))

  expect_false(
    is_valid_robotstxt(
      "       # dings\nbums\n        dings"
    )
  )
})


for (char in c(" ", "\t", "(", ")", "<", ">", "@", ",", ";", "<", ">", "/", "[", "]", "?", "=", "{", "}") ) {

  txt <-
    gsub(
      x           = "extension<<SPECIAL CHAR>>field: some value",
      pattern     = "<<SPECIAL CHAR>>",
      replacement = char
    )

  if (is_valid_robotstxt(txt)) {
    cat("CHAR: ", "'", char,"'; ", sep = "")
  }

  test_that("field name has no special character", {
    expect_false(is_valid_robotstxt(txt))
  })
}


test_that("field name has no special character", {
  expect_false(
    is_valid_robotstxt("extension\\field: some value", check_strickt_ascii = TRUE)
  )
})


test_that("field name has no special character", {
  expect_false(
    is_valid_robotstxt("Error in curl::curl_fetch_memory(url, handle = handle) :   Could not resolve host: domain.tld", check_strickt_ascii = TRUE)
  )
})


test_that("broken robots.txt files are invalid", {
  expect_false(is_valid_robotstxt(rtxt_fb_nsp, check_strickt_ascii = TRUE))

  expect_false(
    is_valid_robotstxt(
      "       # dings\nbums\n        dings", check_strickt_ascii = TRUE
    )
  )
})


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


test_that(
  "specification of more than one user agent gets interpreted right", {
    expect_true( dim(parse_robotstxt(rtxt_datao )$permissions)[1]==2)
    expect_true( all(parse_robotstxt(rtxt_datao )$permissions$value=="/private/"))
  }
)


test_that(
  "comments get extracted right", {
    expect_true(dim(parse_robotstxt(rtxt_tcom )$comments)[1]==3)
  }
)


test_that(
  "craw-delay gets extracted", {
    expect_true(parse_robotstxt(rtxt_host)$host$value=="www.whatever.com")
  }
)


test_that(
  "craw-delay gets extracted", {
    expect_true(parse_robotstxt(rtxt_cd)$crawl_delay$value==10)
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


test_that(
  "cdc gets parsed correctly", {
    expect_true(
      nrow(parse_robotstxt(rtxt_cdc)$permissions) == 23
    )

    expect_true(
      nrow(parse_robotstxt(rtxt_cdc2)$permissions) == 23
    )
  }
)


test_that(
  "can handle varIOUs cases for robots.txt fields - issue #55", {
    expect_true({
      cd <- parse_robotstxt(rtxt_rbloggers)$crawl_delay
      sum(cd$useragent == "AhrefsBot") == 1
    })
  }
)


test_that(
  "Commented-out tokens get ignored", {
    expect_true(
      nrow(parse_robotstxt(rtxt_ct)$permissions) == 1
    )
  }
)
