# testing the workings of robotstxt objects


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

rtxt_list <-
  list(
    rtxt_asb, rtxt_dafa, rtxt_dafbb, rtxt_dsfa, rtxt_empty, rtxt_datao,
    rtxt_tcom, rtxt_amzn, rtxt_bt, rtxt_ggl, rtxt_nyt, rtxt_spgl,
    rtxt_yh, rtxt_she, rtxt_pm, rtxt_wp
  )

context("robotstxt print")


test_that(
  "robotstxt print works", {
    expect_true({
      res <- logical()

      for ( i in seq_along(rtxt_list) ){
        rt <- robotstxt(text = rtxt_list[[i]])
        rt_print <- capture.output(rt)
        res <-
          c(
            res,
            all(
              any(grepl("\\$domain", rt_print)),
              any(grepl("\\$bots", rt_print)),
              any(grepl("\\$comments", rt_print)),
              any(grepl("\\$permissions", rt_print)),
              any(grepl("\\$crawl_delay", rt_print)),
              any(grepl("\\$host", rt_print)),
              any(grepl("\\$sitemap", rt_print)),
              any(grepl("\\$other", rt_print)),
              any(grepl("\\$check", rt_print))
            )
          )
      }

      all(res)
    })
  }
)



context("robotstxt tools")


test_that(
  "robotstxt tools work", {

    expect_true({
      a <- 1
      identical(named_list(1), list(`1` = 1)) &
      identical(named_list(a), list(a = 1))
    })

    expect_silent({
      rt_get_rtxt(1)
      rt_get_rtxt("robots_wikipedia.txt")
      rt_get_rtxt()
    })



  }
)


test_that(
  "guess domain works", {

    expect_true({
      is.na(guess_domain(""))
    })

    expect_true({
      guess_domain("google.com") == "google.com"
    })

    expect_true({
      guess_domain("www.google.com") == "www.google.com"
    })

    expect_true({
      guess_domain("www.domain-with-hyphen.tld") == "www.domain-with-hyphen.tld"
    })

    expect_true({
      guess_domain("tld-domain.tld") == "tld-domain.tld"
    })

  }
)


