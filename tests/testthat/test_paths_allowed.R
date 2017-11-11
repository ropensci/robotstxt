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



options_grid <-
  expand.grid(
    check_method = c("robotstxt", "spiderbar"),
    use_futures  = c(TRUE, FALSE)
  )


#### context("checking works") =================================================
context("paths_allowed()")

## fails because of spiderbar

for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      if( options_grid$check_method[i] == "spiderbar" ){
        cat("\n- will not run test for spiderbar - will fail - known issue\n")
      }else{
        expect_false(
          paths_allowed(
            robotstxt_list = list(rtxt_she),
            paths          = "/temp/",
            bot            = "mein-robot",
            check_method   = options_grid$check_method[i],
            use_futures    = options_grid$use_futures[i]
          )
        )
      }
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
              paths          = "images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    # expect_false(path_allowed(permissions_asb,  path="images"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="/images"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "/images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="/images/"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "/images/",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="images/"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images/",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="images/dings"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images/dings",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="*"))
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
    #
    # expect_false(path_allowed(permissions_asb,  path="images", bot="harald"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images",
              bot            = "harald",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="/images", bot="*"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "/images",
              bot            = "*",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="/images/", "*er"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "/images/",
              bot            = "*er",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_false(path_allowed(permissions_asb,  path="*", bot="erwin"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_false(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "*",
              bot            = "erwin",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    #
    # expect_true(path_allowed(permissions_asb,  path="images", bot="Google"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_true(path_allowed(permissions_asb,  path="/images", bot="Google"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "/images",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }

    # expect_true(path_allowed(permissions_asb,  path="/images/", bot="Google"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              path           ="/images/",
              bot            ="Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }


    # expect_true(path_allowed(permissions_asb,  path="images/", bot="Google"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_true(path_allowed(permissions_asb,  path="images/dings", bot="Google"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "images/dings",
              bot            = "Google",
              check_method   = options_grid$check_method[i],
              use_futures    = options_grid$use_futures[i]
            )
          )
        }
      )
    }
    # expect_true(path_allowed(permissions_asb,  path="*", bot="Google"))
    for ( i in seq_len(nrow(options_grid)) ) {
      test_that(
        "simple check", {
          expect_true(
            paths_allowed(
              robotstxt_list = list(rtxt_asb),
              paths          = "*",
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


# test_that(
#   "dissallow all for all", {
#     expect_false(path_allowed(permissions_dafa, path="", bot="mybot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafa, path="/imgages", bot="mybot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "/images",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafa, path="index.html", bot="mybot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_asb),
          paths          = "index.html",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafa, path="*", bot="mybot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "*",
          bot            = "mybot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#
#     expect_false(path_allowed(permissions_dafa, path=""))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "",
          bot            = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafa, path="/imgages"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_asb),
          paths          = "/images",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafa, path="index.html"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "index.html",
          bot            = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafa, path="*"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafa),
          paths          = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#   }
# )
#
#
# test_that(
#   "dissallow all for BadBot", {
#     expect_false(path_allowed(permissions_dafbb, path="", bot="BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="/imgages", bot="BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="index.html", bot="BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="*", bot="BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#
#     expect_true(path_allowed(permissions_dafbb, path=""))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_dafbb, path="/imgages"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_dafbb, path="index.html"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_dafbb, path="*"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#   }
# )
#
#
# test_that(
#   "case of Bot naME dOeS not matter", {
#     expect_false(path_allowed(permissions_dafbb, path="", bot="badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="/imgages", bot="badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="index.html", bot="badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="*", bot="badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          bot            = "badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#
#     expect_false(path_allowed(permissions_dafbb, path="", bot="Badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="/imgages", bot="Badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "/images",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="index.html", bot="Badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "index.html",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_false(path_allowed(permissions_dafbb, path="*", bot="Badbot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_false(
        paths_allowed(
          robotstxt_list = list(rtxt_dafbb),
          paths          = "*",
          bot            = "Badbot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#   }
# )
#
#
# test_that(
#   "empty file leads to all allowed for all", {
#     expect_true(path_allowed(permissions_empty, path=""))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_empty, path="/"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_empty, path="/imgages"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/images",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_empty, path="index.html"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "index.html",
          bot            = "*",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#
#     expect_true(path_allowed(permissions_empty, path="", bot = "BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_empty, path="/", bot = "BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_empty, path="/imgages", bot = "BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "/images",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#     expect_true(path_allowed(permissions_empty, path="index.html", bot = "BadBot"))
for ( i in seq_len(nrow(options_grid)) ) {
  test_that(
    "simple check", {
      expect_true(
        paths_allowed(
          robotstxt_list = list(rtxt_empty),
          paths          = "index.html",
          bot            = "BadBot",
          check_method   = options_grid$check_method[i],
          use_futures    = options_grid$use_futures[i]
        )
      )
    }
  )
}
#   }
# )
#
#
