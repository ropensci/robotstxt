
library(robotstxt)


txt <- get_robotstxt("www.cdc.gov")

txt <- get_robotstxt("wikipedia.org")

paths_allowed("/asthma/asthma_stats/default.htm", "www.cdc.gov")


rtxt <-
  robotstxt(
    domain     = "www.cdc.gov"
  )

rtxt$text
rtxt$permissions




