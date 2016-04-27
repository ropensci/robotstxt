

#' Generate a representations of a robots.txt file
#'
#' The function generates a list that entails data resulting from parsing a robots.txt file
#' as well as a funtion called check that enables to ask the representation if bot (or
#' particular bots) are allowed to access a resource on the domain.
#'
#' @param domain Domain for which to genarate a representation. If text equals to NULL,
#' the function will download the file from server - the default.
#' @param text If automatic download of the robots.txt is not prefered, the text can be
#' supplied directly.
#'
#' @export
#'
#'
#' @return Object (list) of class robotstxt with parsed data from a
#'   robots.txt (domain, text, bots, permissions, host, sitemap, other) and one
#'   function to (check()) to check resource permissions.
#'
#' @field domain character vector holding domain name for which the robots.txt
#'   file is valid; will be set to NA if not supplied on initialization
#'
#' @field text character vector of text of robots.txt file; either supplied on
#'   initializetion or automatically downloaded from domain supplied on
#'   initialization
#'
#' @field bots character vector of bot names mentionend in robots.txt
#'
#' @field permissions data.frame of bot permissions found in robots.txt file
#'
#' @field host data.frame of host fields found in robots.txt file
#'
#' @field sitemap data.frame of sitemap fields found in robots.txt file
#'
#' @field other data.frame of other - none of the above - fields found in
#'   robots.txt file
#'
#'
#'
#' @field check() Method to check for bot permissions. Defaults to the
#' domains root and no bot in particular. check() has two arguments:
#' paths and bot. The first is for supplying the paths for which to check
#' permissions and the latter to put in the name of the bot.
#'
#'
#'
#' @examples
#' \dontrun{
#' rt <- robotstxt(domain="google.com")
#' rt$bots
#' rt$permissions
#' rt$check( paths = c("/", "forbidden"), bot="*")
#' }
#'
robotstxt <- function(domain=NULL, text=NULL) {
  ## check input
  self <- list()
  if (is.null(domain)) {
    self$domain <- NA
  }
  if (!is.null(text)){
    self$text <- text
    if(!is.null(domain)){
      self$domain <- domain
    }
  }else{
    if(!is.null(domain)){
      self$domain <- domain
      self$text   <- get_robotstxt(domain)
    }else{
      stop("robotstxt: I need text to initialize.")
    }
  }
  ## fill fields with default data

  tmp <- parse_robotstxt(self$text)
  self$bots        <- tmp$useragents
  self$comments    <- tmp$comments
  self$permissions <- tmp$permissions
  self$crawl_delay <- tmp$crawl_delay
  self$host        <- tmp$host
  self$sitemap     <- tmp$sitemap
  self$other       <- tmp$other

  self$check <-
    function(paths="/", bot="*"){
      sapply(paths, path_allowed, permissions=self$permissions, bot=bot)
    }

  # return
  class(self) <- "robotstxt"
  return(self)
}


#' printing robotstxt_text
#' @param x character vector aka robotstxt$text to be printed
#' @param ... goes down the sink
#' @export
print.robotstxt_text <- function(x, ...){
  cat(x)
  invisible(x)
}

#' printing robotstxt
#' @param x robotstxt instance to be printed
#' @param ... goes down the sink
#' @export
print.robotstxt <- function(x, ...){
  tmp <- x
  tmp_text <- unlist(stringr::str_split(tmp$text, "\n"))
  if( length(tmp_text) > 15 ){
    tmp$text <-
      paste0( c(tmp_text[1:10], "", paste0("[... ",length(tmp_text)-10," lines omitted ...]")), collapse = "\n")
  }
  if( length(tmp$bots) > 7 ){
    tmp$bots <-
      c(utils::head(tmp$bots), "", paste("[... ", length(tmp$bots)-5, "items omitted ...]") )
  }
  for(i in c("permissions", "crawl_delay", "host", "sitemap", "other") ){
    if( dim(tmp[[i]])[1] > 7  ){
      tmp_fill <- data.frame(cbind( paste("[... ", dim(tmp[[i]])[1]-5, "items omitted ...]"), "",""))
      names(tmp_fill) <- names(tmp[[i]])
      tmp[[i]]  <- rbind( utils::head(tmp[[i]]), "", tmp_fill )
    }
  }
  if( dim(tmp$comments)[1] > 7 ){
    tmp_fill <- data.frame(cbind( "", paste("[... ", dim(tmp[["comments"]])[1]-5, "items omitted ...]")))
    names(tmp_fill) <- names(tmp[["comments"]])
    tmp[["comments"]]  <- rbind( utils::head(tmp[["comments"]]), "", tmp_fill )
  }
  print.default(tmp)
  invisible(x)
}



