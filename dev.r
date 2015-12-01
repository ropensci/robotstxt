zlibrary(stringr)
library(robotstxt)


# test

rtxt_asb   <- readLines(system.file("robotstxts/allow_single_bot.txt", package = "robotstxt"), warn = FALSE)
rtxt_dafa  <- readLines(system.file("robotstxts/disallow_all_for_all.txt", package = "robotstxt"), warn = FALSE)
rtxt_dafbb <- readLines(system.file("robotstxts/disallow_all_for_BadBot.txt", package = "robotstxt"), warn = FALSE)
rtxt_dsfa  <- readLines(system.file("robotstxts/disallow_some_for_all.txt", package = "robotstxt"), warn = FALSE)
rtxt_empty <- readLines(system.file("robotstxts/empty.txt", package = "robotstxt"), warn = FALSE)
rtxt_amzn  <- readLines(system.file("robotstxts/robots_amazon.txt", package = "robotstxt"), warn = FALSE)
rtxt_bt    <- readLines(system.file("robotstxts/robots_bundestag.txt", package = "robotstxt"), warn = FALSE)
rtxt_ggl   <- readLines(system.file("robotstxts/robots_google.txt", package = "robotstxt"), warn = FALSE)
rtxt_nyt   <- readLines(system.file("robotstxts/robots_new_york_times.txt", package = "robotstxt"), warn = FALSE)
rtxt_spgl  <- readLines(system.file("robotstxts/robots_spiegel.txt", package = "robotstxt"), warn = FALSE)
rtxt_yh    <- readLines(system.file("robotstxts/robots_yahoo.txt", package = "robotstxt"), warn = FALSE)
rtxt_she   <- readLines(system.file("robotstxts/selfhtml_Example.txt", package = "robotstxt"), warn = FALSE)


txt <- rtxt_she
txt_long  <- paste0(txt, collapse = "\n")
txt_vec   <- unlist(str_split(txt_long, "\n"))
txt_parts <- unlist( str_split( str_replace(str_replace_all(txt_long, "#.*?\n",""),"^\n",""), "\n[ \t]*\n" ) )



permissions <- get_permissions(rtxt_ggl)
parse_robotstxt(rtxt_ggl)


dings <- robotstxt$new(text=rtxt_ggl)
dings$other

dings <- robotstxt$new(domain="wikipedia.org")


## strategy :
# use permission value as regex on path
# special: ?
# str_replace_all("?..d","\\?", "\\\\?")
# special: *
# str_replace_all("/*","\\*", ".*")


path_allowed <- function(path="/", bot="*"){
  path <- sanatize_path(path)
  stopifnot(length(path)==length(bot) | length(bot)==1 | length(path)==1)
  perm     <- permissions[permissions$useragent %in% c(bot,"*"), ]
  disallow <- permissions$value[grep("disallow", perm$permission, ignore.case = TRUE)]
  allow    <- permissions$value[grep("^allow"  , perm$permission, ignore.case = TRUE)]
  not_allowed <- disallow[as.logical(unlist(lapply(lapply(disallow, grep, x=path, fixed=TRUE), length)))]
  is_allowed  <- allow[   as.logical(unlist(lapply(lapply(   allow, grep, x=path, fixed=TRUE), length)))]

  # if nothing is forbidden everything should be allowed
  if( length(not_allowed)==0 ){
    return(TRUE)
  }
  # if some part of the path is forbidden but no part of it is explicitly allowed it should be forbidden
  if( length(not_allowed) >0 & length(is_allowed)==0 ){
    return(FALSE)
  }
}

path_allowed(path="ct/index.html")
path_allowed("/drake/?" )
path_allowed("/")





















