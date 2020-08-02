# tests for functions responsible for data gathering and transformation




# This table illustrates some examples:
#
#   Record Path        URL path         Matches
# /tmp               /tmp               yes
# /tmp               /tmp.html          yes
# /tmp               /tmp/a.html        yes
# /tmp/              /tmp               no
# /tmp/              /tmp/              yes
# /tmp/              /tmp/a.html        yes
#
# /a%3cd.html        /a%3cd.html        yes
# /a%3Cd.html        /a%3cd.html        yes
# /a%3cd.html        /a%3Cd.html        yes
# /a%3Cd.html        /a%3Cd.html        yes
#
# /a%2fb.html        /a%2fb.html        yes
# /a%2fb.html        /a/b.html          no
# /a/b.html          /a%2fb.html        no
# /a/b.html          /a/b.html          yes
#
# /%7ejoe/index.html /~joe/index.html   yes
# /~joe/index.html   /%7Ejoe/index.html yes


context("paths_allowed()")

test_that(
  "simple check", {
    expect_true(
      paths_allowed(
        robotstxt_list = list(""),
        paths          = "/temp/",
        bot            = "mein-robot"
      )
    )
  }
)



# A fictional site may have the following URLs:
#
#   http://www.fict.org/
#   http://www.fict.org/index.html
# http://www.fict.org/robots.txt
# http://www.fict.org/server.html
# http://www.fict.org/services/fast.html
# http://www.fict.org/services/slow.html
# http://www.fict.org/orgo.gif
# http://www.fict.org/org/about.html
# http://www.fict.org/org/plans.html
# http://www.fict.org/%7Ejim/jim.html
# http://www.fict.org/%7Emak/mak.html
#
# The site may in the /robots.txt have specific rules for robots that
# send a HTTP User-agent "UnhipBot/0.1", "WebCrawler/3.0", and
#
#
# Koster                draft-koster-robots-00.txt                [Page 8]
#
# INTERNET DRAFT        A Method for Robots Control       December 4, 1996
#
# "Excite/1.0", and a set of default rules:
#
#   # /robots.txt for http://www.fict.org/
#   # comments to webmaster@fict.org
#
#   User-agent: unhipbot
# Disallow: /
#
#   User-agent: webcrawler
# User-agent: excite
# Disallow:
#
#   User-agent: *
#   Disallow: /org/plans.html
# Allow: /org/
#   Allow: /serv
# Allow: /~mak
# Disallow: /
#
#   The following matrix shows which robots are allowed to access URLs:
#
#   unhipbot webcrawler other
# & excite
# http://www.fict.org/                         No       Yes       No
# http://www.fict.org/index.html               No       Yes       No
# http://www.fict.org/robots.txt               Yes      Yes       Yes
# http://www.fict.org/server.html              No       Yes       Yes
# http://www.fict.org/services/fast.html       No       Yes       Yes
# http://www.fict.org/services/slow.html       No       Yes       Yes
# http://www.fict.org/orgo.gif                 No       Yes       No
# http://www.fict.org/org/about.html           No       Yes       Yes
# http://www.fict.org/org/plans.html           No       Yes       No
# http://www.fict.org/%7Ejim/jim.html          No       Yes       No
# http://www.fict.org/%7Emak/mak.html          No       Yes       Yes







