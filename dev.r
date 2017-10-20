library(spiderbar)
library(robotstxt)
library(future)
#plan("multisession")

# get file with urls
urls_fname <- system.file("urls.txt", package="robotstxt")
readLines(urls_fname)[1:3]
urls <- readLines(urls_fname)[-c(1:5)][1:100]

paths <- urls
domain <- robotstxt:::guess_domain(paths)

#
time1 <-
  system.time(paths_allowed(urls, warn = FALSE))
time2 <-
  system.time(paths_allowed(urls, warn = FALSE, check_method = "robotstxt"))
time3 <-
  system.time(paths_allowed(urls, warn = FALSE, check_method = "spiderbar"))



time1
time2
time3
