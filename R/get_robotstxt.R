#' downloading robots.txt file
#'
#' @param domain domain from which to download robots.txt file
#' @param warn warn about being unable to download domain/robots.txt because of
#' @param force if TRUE instead of using possible cached results the function will
#'              re-download the robotstxt file
#'              HTTP response status 404. If this happens,
#' @param user_agent HTTP user-agent string to be used to retrieve robots.txt file
#'   from domain
#'
#' @export

get_robotstxt <-
  function(
    domain,
    warn       = TRUE,
    force      = FALSE,
    user_agent = NULL
  ){

    # pre checking input
    if( is.na(domain) ){
      return(NA)
    }

    # get data from cache or do download
    if( force ){

      request <-
        get_robotstxt_http_get(
          domain     = domain,
          user_agent = user_agent
        )

    }else if ( !is.null(rt_cache[[domain]]) ) {

      request <-
        rt_cache[[domain]]

    }else if ( is.null(rt_cache[[domain]]) ){

      request <-
        get_robotstxt_http_get(
          domain     = domain,
          user_agent = user_agent
        )

    }

    # ok
    if( request$status < 400 ){
      rtxt <- httr::content(request,  encoding="UTF-8", as="text")

      # check if robots.txt is parsable
      if ( is_valid_robotstxt(rtxt) ){
        rt_cache[[domain]] <- request
      }else{
        # give back a digest of the retrieved file
        message(
          "\n\n",
          substring(paste(rtxt, collapse = "\n"), 1, 200),
          "\n\n"
        )

        # dump file
        fname_tmp <-
          tempfile(pattern = "robots_", fileext = ".txt")

        writeLines(
          text     = rtxt,
          con      = fname_tmp,
          useBytes = TRUE
        )

        # stop
        stop(
          paste(
            "get_robotstxt(): the thing retrieved does not seem to be a valid robots.txt.",
            "file dumpend to:",
            fname_tmp
          )
        )
      }
    }

    # not found - can happen, everything is allowed
    if( request$status == 404 ){
      if(warn){
        warning(paste0(
          "get_robotstxt(): could not get robots.txt from domain: ",
          domain,
          " HTTP status: 404"
        ))
      }
      rtxt <- ""
      rt_cache[[domain]] <- request
    }

    # not ok - diverse
    if( !(request$status == 404 | request$status < 400) ){
      stop(paste0(
        "get_robotstxt(): could not get robots.txt from domain: ",
        domain,
        "; HTTP status: ",
        request$status
      ))
    }
    # return
    class(rtxt) <- c("robotstxt_text", "character")
    return(rtxt)
  }

