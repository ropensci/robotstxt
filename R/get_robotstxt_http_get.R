
#' storage for http request response objects
#'
#' @rdname get_robotstxt_http_get
#'
#' @export
rt_last_http         <- new.env()
rt_last_http$request <- list()

#' get_robotstxt() worker function to execute HTTP request
#'
#' @param ssl_verifypeer either 1 (default) or 0, if 0 it disables SSL peer verification, which
#'   might help with robots.txt file retrieval
#' @param domain the domain to get tobots.txt. file for
#' @param user_agent the user agent to use for HTTP request header
#'
#' @export
#'
get_robotstxt_http_get <-
  function(
    domain,
    user_agent     = utils::sessionInfo()$R.version$version.string,
    ssl_verifypeer = 1
  ){
    # generate url
    url <- fix_url(paste0(domain, "/robots.txt"))

    if ( !is.null(user_agent) ) {
      # with user agent
      request <-
        httr::GET(
          url    = url,
          config =
            httr::add_headers(
              "user-agent" = user_agent
            ),
          httr::config(ssl_verifypeer = ssl_verifypeer)
        )
    }else{
      # without user agent
      request <-
        httr::GET(
          url = url,
          httr::config(ssl_verifypeer = ssl_verifypeer)
        )
    }


    # store in storage
    rt_last_http$request <- request

    # return
    request
  }
