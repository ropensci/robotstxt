## ---- message=FALSE------------------------------------------------------
library(robotstxt)
paths_allowed("http://google.com/")
paths_allowed("http://google.com/search")

## ---- message=FALSE------------------------------------------------------
library(robotstxt)
library(dplyr)

## ---- include=FALSE------------------------------------------------------
rtxt <- 
  robotstxt(
    domain = "wikipedia.org", 
    text   = robotstxt:::rt_get_rtxt("robots_wikipedia.txt")
  )

## ---- eval=FALSE---------------------------------------------------------
#  rtxt <- robotstxt(domain="wikipedia.org")

## ------------------------------------------------------------------------
class(rtxt)

## ------------------------------------------------------------------------
rtxt

## ------------------------------------------------------------------------
# checking for access permissions
rtxt$check(paths = c("/","api/"), bot = "*")
rtxt$check(paths = c("/","api/"), bot = "Orthogaffe")
rtxt$check(paths = c("/","api/"), bot = "Mediapartners-Google*  ")

## ---- include=FALSE------------------------------------------------------
r_text <- robotstxt:::rt_get_rtxt("robots_new_york_times.txt")

## ---- eval=FALSE---------------------------------------------------------
#  r_text        <- get_robotstxt("nytimes.com")

## ------------------------------------------------------------------------
r_parsed <- parse_robotstxt(r_text)
r_parsed

## ------------------------------------------------------------------------
paths_allowed(
  paths  = c("images/","/search"), 
  domain = c("wikipedia.org", "google.com"),
  bot    = "Orthogaffe"
)

