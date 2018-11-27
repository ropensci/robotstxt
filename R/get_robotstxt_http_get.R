
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
    if ( !is.null(user_agent) ) {
      # with user agent
      request <-
        httr::GET(
          url    = paste0(domain, "/robots.txt"),
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
          url    = paste0(domain, "/robots.txt"),
          httr::config(ssl_verifypeer = ssl_verifypeer)
        )
    }

    # return
    request
  }
