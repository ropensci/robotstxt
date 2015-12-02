

#' An object representation of robotstxt
#' @name robotstxt
#'
#' @field text text of robots.txt either supplied by user or downloaded from
#'   domain
#' @field bots vector of bot names mentionend in robots.txt
#' @field permissions Data.frame with all permissions (Allow/Disallow) the bot
#'   name they apply to and the path ().
#' @field domain Domain for which the robots.txt file is valid.
#' @field sitemap Robots.txt files might contain sitemap entries -- these are
#'   accessible as data.frame via this field.
#' @field other Other fields that might have bee written in the robots.txt file.
#'
#' @field initialize(domain,text) Method called when initialising object via
#'   \code{robotstxt$new()}. Needs either \code{text} or \code{domain} to be
#'   present at initialization. If only domain is supplied -- should be seen as
#'   default -- than the robots.txt file for that domain will be downloaded. If
#'   \code{text} is supplied as well, nothing will be downloaded. If only
#'   \code{text} is supplied than domain is set to '???'.
#'
#' @field check(path="/",bot="*") Method for checking whether or not a certain path is
#'   allowed to be accessed by certain bot.
#'
#' @usage rt <- robotstxt$new(domain="google.com")
#' rt$bots
#' rt$permissions[1:10, ]
#'
robotstxt <-
  R6::R6Class(
  # class name
    "robotstxt",
  # declaration
    public = list(
  # puplic data fields
      text        =  NA,
      bots        =  NA,
      permissions =  NA,
      domain      =  NA,
      sitemap     =  NA,
      other       =  NA,
  # startup
      initialize = function(domain, text) {
        if (missing(domain)) self$domain <- "???"
        if (!missing(text)){
          self$text <- text
          if(!missing(domain)){
            self$domain <- domain
          }
        }else{
          if(!missing(domain)){
            self$domain <- domain
            rtxt <- httr::GET(paste0(domain,"/robots.txt"))
            if( rtxt$status == 200 ){
              self$text <- httr::content(rtxt)
            }else{
              stop("robotstxt: could not get robots txt from domain")
            }
          }else{
            stop("robotstxt: I need text to initialize.")
          }
        }
        self$bots        <- get_useragent(self$text)
        self$permissions <- get_permissions(self$text)
        self$sitemap     <- get_fields(self$text, type="sitemap")
        self$other       <-
          get_fields(
            self$text,
            regex  = "sitemap|allow|user-agent",
            invert = TRUE
          )
      },
  # checking if bot is allowed to to access path
      check = function(path="/", bot="*") {
#        if(missing(bot))  bot  <- "*"
#        if(missing(path)) path <- "/"
        message(paste0("[",bot,"]", " allowed / disallowed @ ", self$domain,  path))
      }
    )
  )






