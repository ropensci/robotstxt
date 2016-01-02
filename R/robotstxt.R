

#' An object representation of robotstxt
#' @name robotstxt
#' @export
#' @importFrom R6 R6Class
#' @import hellno
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
#' rt$permissions
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
      # check input
        if (missing(domain)) self$domain <- "???"
        if (!missing(text)){
          self$text <- text
          if(!missing(domain)){
            self$domain <- domain
          }
        }else{
          if(!missing(domain)){
            self$domain <- domain
            self$text   <- rt_get_robotstxt(domain)
          }else{
            stop("robotstxt: I need text to initialize.")
          }
        }
      # fill fields with default data
        self$bots        <- rt_get_useragent(self$text)
        self$permissions <- rt_get_permissions(self$text)
        self$sitemap     <- rt_get_fields(self$text, type="sitemap")
        self$other       <- rt_get_other(self$text)

      },
  # methods
    # checking bot permissions
      check = function(paths="/", bot="*", permission=self$permissions){
        paths_allowed(permissions=permission, paths=paths, bot=bot)
      }
    )
  )


#' printing robotstxt_text
#' @param x character vector / robotstxt_text to be printed
#' @export
print.robotstxt_text <- function(x){
  cat(x)
  invisible(x)
}





