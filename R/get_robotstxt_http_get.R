
#' get_robotstxt() worker function to execute HTTP request
#'
#' @inheritParams get_robotstxt

get_robotstxt_http_get <-
  function(domain, user_agent = NULL){
    if ( !is.null(user_agent) ) {
      # with user agent
      request <-
        httr::GET(
          url    = paste0(domain, "/robots.txt"),
          config =
            httr::add_headers(
              "user-agent" = user_agent
            )
        )
    }else{
      # without user agent
      request <-
        httr::GET(
          url    = paste0(domain, "/robots.txt")
        )
    }
  }
