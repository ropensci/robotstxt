library(spiderbar)
library(robotstxt)


# get file with urls
urls_fname <- system.file("urls.txt", package="robotstxt")
readLines(urls_fname)[1:3]
urls <- readLines(urls_fname)[-c(1:5)][1:20]


#

time1 <- system.time(paths_allowed(urls))
time2 <- system.time(paths_allowed(urls))
time3 <- system.time(paths_allowed(urls, check_method = "spiderbar"))

