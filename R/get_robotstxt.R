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
#'
#' @export

get_robotstxt <-
  function(
    domain,
    warn           = TRUE,
    force          = FALSE,
    user_agent     = utils::sessionInfo()$R.version$version.string,
    ssl_verifypeer = c(1,0)
  ){

    # pre checking input
    if( is.na(domain) ){
      return(NA)
    }

    # get data from cache or do download
    if( force ){

      request <-
        get_robotstxt_http_get(
          domain         = domain,
          user_agent     = user_agent,
          ssl_verifypeer = ssl_verifypeer[1]
        )

    }else if ( !is.null(rt_cache[[domain]]) ) {

      request <-
        rt_cache[[domain]]

    }else if ( is.null(rt_cache[[domain]]) ){

      request <-
        get_robotstxt_http_get(
          domain         = domain,
          user_agent     = user_agent,
          ssl_verifypeer = ssl_verifypeer[1]
        )

    }

    # ok
    if( request$status < 400 ){
      rtxt <- httr::content(request,  encoding="UTF-8", as="text")

      # check if robots.txt is parsable
      if ( is_valid_robotstxt(rtxt) ){
        rt_cache[[domain]] <- request
      }else{
        # dump file
        fname_tmp <-
          tempfile(pattern = "robots_", fileext = ".txt")

        writeLines(
          text     = rtxt,
          con      = fname_tmp,
          useBytes = TRUE
        )

        # give back a digest of the retrieved file
        if( warn ){
          message(
            "\n\n",
            "[domain] ", domain, " --> ", fname_tmp,
            "\n\n",
            substring(paste(rtxt, collapse = "\n"), 1, 200),"\n", "[...]",
            "\n\n"
          )
        }


        # found file but could not parse it - can happen, everything is allowed
        # --> treated as if there was no file
          warning(paste0(
            "get_robotstxt(): ",  domain, "; Not valid robots.txt."
          ))
        rtxt <- ""
        rt_cache[[domain]] <- request
      }
    }

    # not found - can happen, everything is allowed
    if( request$status == 404 ){
      if(warn){
        warning(paste0(
          "get_robotstxt(): ",  domain, "; HTTP status: ",  request$status
        ))
      }
      rtxt <- ""
      rt_cache[[domain]] <- request
    }

    # not ok - diverse
    if( !(request$status == 404 | request$status < 400) ){
      stop(paste0(
        "get_robotstxt(): ",  domain, "; HTTP status: ",  request$status
      ))
    }
    # return
    class(rtxt) <- c("robotstxt_text", "character")
    return(rtxt)
  }

