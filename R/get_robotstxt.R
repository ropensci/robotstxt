#' downloading robots.txt file
#'
#' @param domain domain from which to download robots.txt file
#' @param warn warn about being unable to download domain/robots.txt because of
#' @param force if TRUE instead of using possible cached results the function
#'   will re-download the robotstxt file HTTP response status 404. If this
#'   happens,
#' @param user_agent HTTP user-agent string to be used to retrieve robots.txt
#'   file from domain
#'
#' @param ssl_verifypeer analog to CURL option
#'   \url{https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html} -- and
#'   might help with robots.txt file retrieval in some cases
#' @param rt_robotstxt_http_getter function that executes HTTP request
#' @param rt_request_handler handler function that handles request according to
#'     the event handlers specified
#'
#'
#' @inheritParams rt_request_handler
#'
#' @param encoding Encoding of the robots.txt file.
#'
#' @export

get_robotstxt <-
  function(
    domain,
    warn                      = TRUE,
    force                     = FALSE,
    user_agent                = utils::sessionInfo()$R.version$version.string,
    ssl_verifypeer            = c(1,0),
    encoding                  = "UTF-8",
    rt_request_handler        = robotstxt::rt_request_handler,
    rt_robotstxt_http_getter  = robotstxt::get_robotstxt_http_get,
    on_server_error           = on_server_error_default,
    on_client_error           = on_client_error_default,
    on_not_found              = on_not_found_default,
    on_redirect               = on_redirect_default,
    on_domain_change          = on_domain_change_default,
    on_file_type_mismatch     = on_file_type_mismatch_default,
    on_suspect_content        = on_suspect_content_default
  ){

    # pre checking input
    if( is.na(domain) ){
      return(NA)
    }

    # get data from cache or do download
    if( force ){

      request <-
        rt_robotstxt_http_getter(
          domain         = domain,
          user_agent     = user_agent,
          ssl_verifypeer = ssl_verifypeer[1]
        )

    }else if ( !is.null(rt_cache[[domain]]) ) {

      request <-
        rt_cache[[domain]]

    }else if ( is.null(rt_cache[[domain]]) ){

      request <-
        rt_robotstxt_http_getter(
          domain         = domain,
          user_agent     = user_agent,
          ssl_verifypeer = ssl_verifypeer[1]
        )

    }


    # handle request
    res  <-
      rt_request_handler(
        request          = request,
        on_redirect      = on_redirect,
        on_domain_change = on_domain_change,
        on_not_found     = on_not_found,
        on_client_error  = on_client_error,
        on_server_error  = on_server_error,
        warn             = warn,
        encoding         = encoding
      )

    rtxt <- res$rtxt

    # return
    attributes(rtxt) <- list(problems = res$problems, cached = res$cache)
    class(rtxt)                  <- c("robotstxt_text", "character")
    return(rtxt)
  }

