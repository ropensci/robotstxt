

#' Generate object representations of a robots.txt file
#'
#' @export
#'
#' @keywords data
#'
#' @return Object (list) of class robotstxt with parsed data from a
#'   robots.txt file and method(s) for bot permission checking.
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
#' @usage robotstxt(domain="mydomain.com")
#' robotstxt(text="User-agent: *\nDisallow: /")
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
    function(paths="/", bot="*", permissions=self$permissions){
      sapply(paths, path_allowed, permissions=permissions, bot=bot)
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
      c(head(tmp$bots), "", paste("[... ", length(tmp$bots)-5, "items omitted ...]") )
  }
  for(i in c("permissions", "crawl_delay", "host", "sitemap", "other") ){
    if( dim(tmp[[i]])[1] > 7  ){
      tmp_fill <- data.frame(cbind( paste("[... ", dim(tmp[[i]])[1]-5, "items omitted ...]"), "",""))
      names(tmp_fill) <- names(tmp[[i]])
      tmp[[i]]  <- rbind( head(tmp[[i]]), "", tmp_fill )
    }
  }
  if( dim(tmp$comments)[1] > 7 ){
    tmp_fill <- data.frame(cbind( "", paste("[... ", dim(tmp[["comments"]])[1]-5, "items omitted ...]")))
    names(tmp_fill) <- names(tmp[["comments"]])
    tmp[["comments"]]  <- rbind( head(tmp[["comments"]]), "", tmp_fill )
  }
  print.default(tmp)
  invisible(x)
}



