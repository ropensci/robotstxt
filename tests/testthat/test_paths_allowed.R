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



options_grid <-
  expand.grid(
    check_method     = c("spiderbar"),
    use_futures      = c(TRUE, FALSE),
    stringsAsFactors = FALSE
  )


## fails because of spiderbar

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
        expect_true(
          paths_allowed(
            robotstxt_list = list(rtxt_she),
            paths          = "/temp/",
            bot            = "mein-robot",
            check_method   = options_grid$check_method[i],
            use_futures    = options_grid$use_futures[i]
          )
        )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_she),
          paths          = "/temp/",
          bot            = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}


test_that(
  "Allows and Disallows applicable at the same time", {

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_pm),
              domain         = "test.de",
              paths          = "images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_pm),
              domain         = "test.de",
              paths          = "/images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }


    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_pm),
              domain         = "test.de",
              paths          = "/images/",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_pm),
              domain         = "test.de",
              paths          = "images/",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_pm),
              domain         = "test.de",
              paths          = "/images/dings",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

  }
)


test_that(
  "check 'only single bot allowed'", {

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "/images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "/images/",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images/",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images/dings",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "*",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images",
              bot            = "harald",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "/images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "/images/",
              bot            = "*er",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "*",
              bot            = "erwin",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "/images",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              path           ="/images/",
              bot            ="Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              domain         = "test.de",
              paths          = "images/dings",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "*",
              domain         = "test.de",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
  }
)

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "",
          domain         = "test.de",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "/images",
          domain         = "test.de",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_asb),
          paths          = "index.html",
          domain         = "test.de",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "*",
          domain         = "test.de",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "",
          domain         = "test.de",
          bot            = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_asb),
          paths          = "/images",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "index.html",
          bot            = "*",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "*",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          bot            = "BadBot",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          bot            = "BadBot",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          bot            = "BadBot",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          bot            = "BadBot",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "",
          domain         = "test.de",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          domain         = "test.de",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          domain         = "test.de",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          domain         = "test.de",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "",
          domain         = "test.de",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          domain         = "test.de",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          domain         = "test.de",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          domain         = "test.de",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/images",
          domain         = "test.de",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "index.html",
          domain         = "test.de",
          bot            = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "",
          domain         = "test.de",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/",
          domain         = "test.de",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/images",
          domain         = "test.de",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "index.html",
          domain         = "test.de",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}


test_that("paths_allowed() works also with 'downloaded' robots.txt files",{
  expect_snapshot({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    suppressMessages(
      paths_allowed(
        paths                    = "https://github.io/index.html",
        rt_robotstxt_http_getter = function(...){domain_change},
        warn = FALSE
      )
    )
  })

  expect_snapshot({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    suppressMessages(
      paths_allowed(
        paths                    = "https://github.io/index.html",
        rt_robotstxt_http_getter = function(...){domain_change}
      )
    )
  })

  expect_true({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    suppressMessages(
      paths_allowed(
        paths                    = "https://github.io/index.html",
        rt_robotstxt_http_getter = function(...){domain_change},
        warn = FALSE
      )
    )
  })

  expect_true({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    res <-
      suppressMessages(
        paths_allowed(
          paths  = c("index.html", "dings/bums/trallalla"),
          domain = "github.io",
          rt_robotstxt_http_getter = function(...){domain_change},
          warn = FALSE
        )
      )
    all(res)
  })

  expect_true({
    domain_change <- readRDS(system.file("http_requests/http_domain_change.rds", package = "robotstxt"))
    res <-
      suppressMessages(
        paths_allowed(
          paths  = c("https://github.io/index.html", "https://github.io/index.html"),
          rt_robotstxt_http_getter = function(...){domain_change},
          warn = FALSE
        )
      )
    all(res)
  })

  expect_true({
    http_ok <- readRDS(system.file("http_requests/http_ok_1.rds", package = "robotstxt"))
    res <-
      suppressMessages(
        paths_allowed(
          paths  = c("https://google.com/?", "https://google.com/search/about"),
          rt_robotstxt_http_getter = function(...){http_ok}
        )
      )
    all(res == c(FALSE, TRUE))
  })
})
