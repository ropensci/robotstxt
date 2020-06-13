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
#' @param verbose make function print out more information
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
    warn                      = getOption("robotstxt_warn", TRUE),
    force                     = FALSE,
    user_agent                = utils::sessionInfo()$R.version$version.string,
    ssl_verifypeer            = c(1,0),
    encoding                  = "UTF-8",
    verbose                   = FALSE,
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

      if ( verbose == TRUE ){
        message("rt_robotstxt_http_getter: force http get")
      }

    } else if ( !is.null(rt_cache[[domain]]) ) {

      # get cache content
      request <-
        rt_cache[[domain]]

      # mark content as cached
      request$rt_from_cache <- TRUE

      if ( verbose == TRUE ){
        message("rt_robotstxt_http_getter: cached http get")
      }

    } else if ( is.null(rt_cache[[domain]]) ){

      # retrieve http content
      request <-
        rt_robotstxt_http_getter(
          domain         = domain,
          user_agent     = user_agent,
          ssl_verifypeer = ssl_verifypeer[1]
        )

      # mark content as not cached
      request$rt_from_cache <- FALSE

      rt_cache[[domain]] <- request

      if ( verbose == TRUE ){
        message("rt_robotstxt_http_getter: normal http get")
      }

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

    # check if cache has to be emptied if
    if ( length(res$cache) == 0 || res$cache == TRUE ){
      rt_cache[[domain]] <- request
    } else {
      rt_cache[[domain]] <- NULL
    }


    # collect info and return
    rtxt <- res$rtxt

    attributes(rtxt) <-
      list(
        problems = res$problems,
        cached   = request$rt_from_cache,
        request  = request
      )

    class(rtxt) <-
      c("robotstxt_text", "character")

    return(rtxt)
  }

