robotstxt_dev <- function(domain, text) {
  ## check input
  self <- list()
  if (missing(domain)) {
    self$domain <- NA
  }
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
  ## fill fields with default data

  tmp <- parse_robotstxt(self$text)
  self$bots        <- tmp$useragents
  self$comments    <- tmp$comments
  self$permissions <- tmp$permissions
  self$crawl_delay <- tmp$crawl_delay
  self$host        <- tmp$host
  self$sitemap     <- tmp$sitemap
  self$other       <- tmp$other

  self$check <- function(paths="/", bot="*", permission=self$permissions) {
    paths_allowed(permissions=permission, paths=paths, bot=bot)
  }

  class(self) <- "robotstxt"
  self
}