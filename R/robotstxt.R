

#' An object representation of robots.txt files
#'
#' @docType class
#'
#' @name robotstxt
#'
#' @export
#' @importFrom R6 R6Class
#'
#' @keywords data
#'
#' @return Object of \code{\link{R6Class}} with method(s) for bot permission checking.
#'
#' @format \code{\link{R6Class}} object.
#'
#' @field domain
#'  character vector holding domain name for which the robots.txt file is valid;
#'  will be set to NA if not supplied on initialization
#'
#' @field text
#'  character vector of text of robots.txt file;
#'  either supplied on initializetion
#'  or automatically downloaded from domain supplied on initialization
#'
#' @field bots
#'  character vector of bot names mentionend in robots.txt
#'
#' @field permissions
#'  data.frame of bot permissions found in robots.txt file
#'
#' @field host
#'  data.frame of host fields found in robots.txt file
#'
#' @field sitemap
#'  data.frame of sitemap fields found in robots.txt file
#'
#' @field other
#'  data.frame of other - none of the above - fields found in robots.txt file
#'
#'
#' @section Methods:
#' \describe{
#'  \item{\code{
#'    initialize(domain, text) }}{
#'    Method called when initialising object via
#'    \code{robotstxt$new()}. Needs either \code{text} or \code{domain} to be
#'    present at initialization. If only domain is supplied -- should be seen as
#'    default -- than the robots.txt file for that domain will be downloaded. If
#'    \code{text} is supplied as well, nothing will be downloaded. If only
#'    \code{text} is supplied than domain is set to '???'.
#'  }
#'  \item{\code{
#'    check( path="/", bot="*" ) }}{
#'    Method for checking whether or not paths are allowed to be accessed by a bot
#'  }
#' }
#'
#' @examples
#' \dontrun{
#' rt <- robotstxt$new(domain="google.com")
#' rt$bots
#' rt$permissions
#' rt$check( paths = c("/", "forbidden"), bot="*")
#' }
#'
robotstxt <-
  R6::R6Class(
  # class name
    "robotstxt",
  # declaration
    public = list(
  # puplic data fields
      domain      =  NA,
      text        =  NA,
      bots        =  NA,
      comments    =  NA,
      permissions =  NA,
      crawl_delay =  NA,
      host        =  NA,
      sitemap     =  NA,
      other       =  NA,
  # startup
      initialize = function(domain, text) {
      # check input
        if (missing(domain)) self$domain <- NA
        if (!missing(text)){
          self$text <- text
          if(!missing(domain)){
            self$domain <- domain
          }
        }else{
          if(!missing(domain)){
            self$domain <- domain
            self$text   <- get_robotstxt(domain)
          }else{
            stop("robotstxt: I need text to initialize.")
          }
        }
      # fill fields with default data

        tmp <- parse_robotstxt(self$text)

        self$bots        <- tmp$useragents
        self$comments    <- tmp$comments
        self$permissions <- tmp$permissions
        self$crawl_delay <- tmp$crawl_delay
        self$host        <- tmp$host
        self$sitemap     <- tmp$sitemap
        self$other       <- tmp$other
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
#' @param ... goes down the sink
#' @export
print.robotstxt_text <- function(x, ...){
  cat(x)
  invisible(x)
}





