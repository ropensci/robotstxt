library(stringr)
library(robotstxt)



parse_robotstxt <- function(txt){
  # make one long string
  txt_long <- paste0(txt, collapse = "\n")

  # text as vector of lines
  txt_vec <- unlist(str_split(txt_long, "\n"))

  # text as list split by empty lines
  txt_parts <-
    unlist(
      str_split(
        str_replace(
          str_replace_all(txt_long, "#.*?\n",""),
          "^\n",""),
        "\n[ \t]*\n"
      )
    )


  # return
  res <- named_list(
    get_useragent(txt_long),
    get_comments(txt_long)
  )
  return(res)
}




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


txt_long  <- paste0(txt, collapse = "\n")
txt_vec   <- unlist(str_split(txt_long, "\n"))
txt_parts <- unlist( str_split( str_replace(str_replace_all(txt_long, "#.*?\n",""),"^\n",""), "\n[ \t]*\n" ) )



parse_robotstxt(rtxt_she)


























