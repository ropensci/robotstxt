robotsCheck <- function(robotstxt = "", useragent = "*", dirs = "disallowed") {
  # packages
  require(stringr)
  require(RCurl)
  # read robots.txt
  signatures = system.file("CurlSSL", "cacert.pem", package = "RCurl")
  bots <- getURL(robotstxt, cainfo = signatures)
  write(bots, file = "robots.txt")
  bots <- readLines("robots.txt")
  # detect if defined bot is on the list
  useragent <- ifelse(useragent == "*", "\\*", useragent)
  bot_line1 <- which(str_detect(bots, str_c("[Uu]ser-[Aa]gent:[ ]{0,}", useragent, "$"))) + 1
  bot_listed <- ifelse(length(bot_line1)>0, TRUE, FALSE)
  # identify all user-agents and user-agent after defined bot
  ua_detect <- which(str_detect(bots, "[Uu]ser-[Aa]gent:[ ].+"))
  uanext_line <- ua_detect[which(ua_detect == (bot_line1 - 1)) + 1]
  # if bot is on the list, identify rules
  bot_d_dir <- NULL
  bot_a_dir <- NULL
  bot_excluded <- 0
  if (bot_listed) {
    bot_eline <- which(str_detect(bots, "^$"))
    bot_eline_end <- length(which(bot_eline - uanext_line < 0))
    bot_eline_end <- ifelse(bot_eline_end == 0, length(bots), bot_eline[bot_eline_end])
    botrules <- bots[bot_line1:bot_eline_end]
    # extract forbidden directories
    botrules_d <- botrules[str_detect(botrules, "[Dd]isallow")]
    bot_d_dir <- unlist(str_extract_all(botrules_d, "/.{0,}"))
    # extract allowed directories
    botrules_a <- botrules[str_detect(botrules, "^[Aa]llow")]
    bot_a_dir <- unlist(str_extract_all(botrules_a, "/.{0,}"))
    # bot totally excluded?
    bot_excluded <- str_detect(bot_d_dir, "^/$")
  }
  # return results
  if (bot_excluded[1]) { message("This bot is blocked from the site.")}
  if (dirs == "disallowed" & !bot_excluded[1]) { return(bot_d_dir) }
  if (dirs == "allowed"  & !bot_excluded[1]) { return(bot_a_dir) }
}