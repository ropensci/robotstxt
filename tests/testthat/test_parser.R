# tests for functions responsible for data gathering and transformation



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




context("is_valid_robotstxt()")


test_that(
  "all robots.txt files are valid", {
    expect_true(
      is_valid_robotstxt( rtxt_asb    )
    )

    expect_true(
      is_valid_robotstxt( rtxt_dafa   )
    )

    expect_true(
      is_valid_robotstxt( rtxt_dafbb  )
    )

    expect_true(
      is_valid_robotstxt( rtxt_dsfa   )
    )
    expect_true(
      is_valid_robotstxt( rtxt_empty  )
    )

    expect_true(
      is_valid_robotstxt( rtxt_datao  )
    )

    expect_true(
      is_valid_robotstxt( rtxt_tcom   )
    )

    expect_true(
      is_valid_robotstxt( rtxt_amzn   )
    )

    expect_true(
      is_valid_robotstxt( rtxt_bt     )
    )

    expect_true(
      is_valid_robotstxt( rtxt_ggl    )
    )

    expect_true(
      is_valid_robotstxt( rtxt_nyt    )
    )

    expect_true(
      is_valid_robotstxt( rtxt_spgl   )
    )

    expect_true(
      is_valid_robotstxt( rtxt_yh     )
    )

    expect_true(
      is_valid_robotstxt( rtxt_she    )
    )

    expect_true(
      is_valid_robotstxt( rtxt_pm     )
    )

    expect_true(
      is_valid_robotstxt( rtxt_wp     )
    )

    expect_true(
      is_valid_robotstxt( rtxt_cd     )
    )

    expect_true(
      is_valid_robotstxt( rtxt_host   )
    )

    expect_true(
      is_valid_robotstxt(
        "\n\n\n"
      )
    )

    expect_false(
      is_valid_robotstxt(
        "       # dings\nbums\n        dings"
      )
    )

    expect_false(
      is_valid_robotstxt( rtxt_fb_nsp )
    )

    expect_true(
      is_valid_robotstxt( rtxt_cdc )
    )

    expect_true(
      is_valid_robotstxt( rtxt_ct )
    )
  })


test_that(
  "broken robots.txt files are invalid", {
    expect_false( is_valid_robotstxt( rtxt_fb_nsp ))
  })




for (char in c(" ", "\t", "(", ")", "<", ">", "@", ",", ";", "<", ">", "/", "[", "]", "?", "=", "{", "}") ) {

  txt <-
    gsub(
      x           = "extension<<SPECIAL CHAR>>field: some value",
      pattern     = "<<SPECIAL CHAR>>",
      replacement = char
    )

  if ( is_valid_robotstxt(txt) ){
    cat("CHAR: ", "'", char,"'; ", sep = "")
  }

  test_that(
    "field name has no special character",
    expect_false( is_valid_robotstxt(txt) )
  )

}



test_that(
  "field name has no special character",
  expect_false(
    is_valid_robotstxt("extension\\field: some value", check_strickt_ascii = TRUE)
  )
)


test_that(
  "field name has no special character",
  expect_false(
    is_valid_robotstxt("Error in curl::curl_fetch_memory(url, handle = handle) :   Could not resolve host: domain.tld", check_strickt_ascii = TRUE)
  )
)





test_that(
  "all robots.txt files are valid", {
    expect_true(
      is_valid_robotstxt( rtxt_asb    , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_dafa   , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_dafbb  , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_dsfa   , check_strickt_ascii = TRUE)
    )
    expect_true(
      is_valid_robotstxt( rtxt_empty  , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_datao  , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_tcom   , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_amzn   , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_bt     , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_ggl    , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_nyt    , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_spgl   , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_yh     , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_she    , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_pm     , check_strickt_ascii = TRUE)
    )

    # expect_true(
    #   is_valid_robotstxt( rtxt_wp     , check_strickt_ascii = TRUE)
    # )

    expect_true(
      is_valid_robotstxt( rtxt_cd     , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_host   , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt(
        "\n\n\n", check_strickt_ascii = TRUE
      )
    )

    expect_false(
      is_valid_robotstxt(
        "       # dings\nbums\n        dings", check_strickt_ascii = TRUE
      )
    )

    expect_false(
      is_valid_robotstxt( rtxt_fb_nsp , check_strickt_ascii = TRUE)
    )

    expect_true(
      is_valid_robotstxt( rtxt_cdc , check_strickt_ascii = TRUE)
    )
  })


test_that(
  "broken robots.txt files are invalid", {
    expect_false( is_valid_robotstxt( rtxt_fb_nsp , check_strickt_ascii = TRUE))
  })





context("useragent extraction")

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


context("cdc gets parsed correctly")

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


context("can handle varIOUs cases for robots.txt fields")

test_that(
  "can handle varIOUs cases for robots.txt fields - issue #55", {
    expect_true({
      cd <- parse_robotstxt(rtxt_rbloggers)$crawl_delay
      sum(cd$useragent == "AhrefsBot") == 1
    })
  }
)








context("Commented-out tokens get parsed correctly")

test_that(
  "Commented-out tokens get ignored", {
    expect_true(
      nrow(parse_robotstxt(rtxt_ct)$permissions) == 1
    )
  }
)















