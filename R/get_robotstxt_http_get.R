
#' storage for http request response objects
#'
#' @rdname get_robotstxt_http_get
#'
#' @export
rt_last_http         <- new.env()
rt_last_http$request <- list()

#' get_robotstxt() worker function to execute HTTP request
#'
#'
#' @param ssl_verifypeer analog to CURL option
#'   \url{https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html}
#'   -- and might help with robots.txt file retrieval in some cases
#'
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
    config <- httr::config(ssl_verifypeer = ssl_verifypeer)

    if ( !is.null(user_agent) ) {
      # with user agent
      config <- c(httr::add_headers("user-agent" = user_agent), config)
    }

    request <- try(httr::GET(url = url, config = config), silent = FALSE)

    if(inherits(request, "try-error")){
      message(sprintf("Unable to retrieve a response from the URL '%s'.\nPlease check the URL and try again, or ensure that the server is accessible.", url))
      return(NULL)
    }
    # store in storage
    rt_last_http$request <- request

    # return
    return(request)
  }
