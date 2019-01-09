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

context("robotstxt creation")

# test_that(
#   "get_robotstxt() can fetch a file", {
#     expect_true(
#       {
#         rt <- get_robotstxt(domain="pmeissner.com")
#         TRUE
#       }
#     )
#   }
# )

test_that(
  "initialisation works well", {
    expect_error( rt <- robotstxt() )
    expect_error( rt <- robotstxt("") )
    expect_true( all(class(robotstxt(text=rtxt_she)) %in% c("robotstxt")) )
  }
)

test_that(
  "robotstxt check method works well", {
    expect_true( robotstxt(text=rtxt_she)$check() )
    expect_true( robotstxt(text=rtxt_she)$check("blah") )
  }
)


context("robotstxt checking")

test_that(
  "robotstxt check method works well", {
    expect_true( robotstxt(text=rtxt_she)$check() )
    expect_true( robotstxt(text=rtxt_she)$check("blah") )
  }
)


context("robotstxt parsing multi agent records without newline")

test_that(
  "robotstxt parsing multi agent records without newline", {
    expect_true({
      rbtx <- spiderbar::robxp("
User-agent: *
Disallow: /*/print$
# Don't allow indexing of user needs pages
Disallow: /info/*
Sitemap: https://www.gov.uk/sitemap.xml
# https://ahrefs.com/robot/ crawls the site frequently
User-agent: dooby
User-agent: AhrefsBot
Crawl-delay: 10
# https://www.deepcrawl.com/bot/ makes lots of requests. Ideally
# we'd slow it down rather than blocking it but it doesn't mention
# whether or not it supports crawl-delay.
User-agent: deepcrawl
Disallow: /
# Complaints of 429 'Too many requests' seem to be coming from SharePoint servers
# (https://social.msdn.microsoft.com/Forums/en-US/3ea268ed-58a6-4166-ab40-d3f4fc55fef4)
# The robot doesn't recognise its User-Agent string, see the MS support article:
# https://support.microsoft.com/en-us/help/3019711/the-sharepoint-server-crawler-ignores-directives-in-robots-txt
User-agent: MS Search 6.0 Robot
Disallow: /
"
      )
      sum(spiderbar::crawl_delays(rbtx)$crawl_delay==10)==2
    })

    expect_true({
      robot <- robotstxt(text = "
User-agent: *
Disallow: /*/print$
# Don't allow indexing of user needs pages
Disallow: /info/*
Sitemap: https://www.gov.uk/sitemap.xml
# https://ahrefs.com/robot/ crawls the site frequently
User-agent: dooby
User-agent: AhrefsBot
Crawl-delay: 10
# https://www.deepcrawl.com/bot/ makes lots of requests. Ideally
# we'd slow it down rather than blocking it but it doesn't mention
# whether or not it supports crawl-delay.
User-agent: deepcrawl
Disallow: /
# Complaints of 429 'Too many requests' seem to be coming from SharePoint servers
# (https://social.msdn.microsoft.com/Forums/en-US/3ea268ed-58a6-4166-ab40-d3f4fc55fef4)
# The robot doesn't recognise its User-Agent string, see the MS support article:
# https://support.microsoft.com/en-us/help/3019711/the-sharepoint-server-crawler-ignores-directives-in-robots-txt
User-agent: MS Search 6.0 Robot
Disallow: /
")
      nrow(robot$crawl_delay) == 2
    })
  }
)

