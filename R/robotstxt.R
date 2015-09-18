#' function for extracting HTTP useragents from robots.txt
#' @param txt content of the robots.txt file
get_useragent <- function(txt){
  tmp  <- str_extract_all(txt, "[uU]ser-agent:.*")
  str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
}

#' function for extrcting comments from robots.txt
#' @param txt content of the robots.txt file
get_comments <- function(txt){
  txt      <- unlist(str_split(txt, "\n"))
  clines   <- grep("^[ \t]*#", txt)
  data.frame(line=clines, comment=txt[clines])
}

#' a representation of robotstxt
robotstxt <-
  R6::R6Class(
  # class name
    "robotstxt",
  # declaration
    public = list(
  # puplic data fields
      text  =  NA,
      bots  =  NA,
      paths =  NA,
      domain = NA,
  # startup
      initialize = function(text, domain) {
        if (missing(domain)) self$domain <- "..."
        if (!missing(text)){
          self$text <- text
        }else{
          stop("robotstxt: I need text to initialize.")
        }
      },
  # checking if bot is allowed to to access path
      check = function(path, bot) {
        if(missing(bot))  bot  <- "*"
        if(missing(path)) path <- "/"
        message(paste0("[",bot,"]", " allowed / disallowed @ ", self$domain,  path))
      }
    )
  )






