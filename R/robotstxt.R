#' Generate a representations of a robots.txt file
#'
#' The function generates a list that entails data resulting from parsing a robots.txt file
#' as well as a function called check that enables to ask the representation if bot (or
#' particular bots) are allowed to access a resource on the domain.
#'
#' @param domain Domain for which to generate a representation. If text equals to NULL,
#' the function will download the file from server - the default.
#' @param text If automatic download of the robots.txt is not preferred, the text can be
#' supplied directly.
#' @inheritParams get_robotstxt
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
#'   initialization or automatically downloaded from domain supplied on
#'   initialization
#'
#' @field bots character vector of bot names mentioned in robots.txt
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
#' Please, note that path to a folder should end with a trailing slash ("/").
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
robotstxt <-
  function(
    domain                = NULL,
    text                  = NULL,
    user_agent            = NULL,
    warn                  = getOption("robotstxt_warn", TRUE),
    force                 = FALSE,
    ssl_verifypeer        = c(1,0),
    encoding              = "UTF-8",
    verbose               = FALSE,
    on_server_error       = on_server_error_default,
    on_client_error       = on_client_error_default,
    on_not_found          = on_not_found_default,
    on_redirect           = on_redirect_default,
    on_domain_change      = on_domain_change_default,
    on_file_type_mismatch = on_file_type_mismatch_default,
    on_suspect_content    = on_suspect_content_default
  ) {

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
        self$text   <-
          get_robotstxt(
            domain                = domain,
            warn                  = warn,
            force                 = force,
            user_agent            = user_agent,
            ssl_verifypeer        = ssl_verifypeer,
            encoding              = encoding,
            verbose               = verbose,
            on_server_error       = on_server_error       ,
            on_client_error       = on_client_error       ,
            on_not_found          = on_not_found          ,
            on_redirect           = on_redirect           ,
            on_domain_change      = on_domain_change      ,
            on_file_type_mismatch = on_file_type_mismatch ,
            on_suspect_content    = on_suspect_content
          )

      }else{

        stop("robotstxt: I need text to initialize.")

      }
    }

    ## fill fields with default data

    tmp <- parse_robotstxt(self$text)
    self$robexclobj  <- spiderbar::robxp(self$text)
    self$bots        <- tmp$useragents
    self$comments    <- tmp$comments
    self$permissions <- tmp$permissions
    self$crawl_delay <- tmp$crawl_delay
    self$host        <- tmp$host
    self$sitemap     <- tmp$sitemap
    self$other       <- tmp$other

    self$check <-
      function(paths="/", bot="*"){
        spiderbar::can_fetch(
          obj        = self$robexclobj,
          path       = paths,
          user_agent = bot
        )
      }

    # return
    class(self) <- "robotstxt"
    return(self)
  }


