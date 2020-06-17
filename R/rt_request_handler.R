
#' rt_request_handler
#'
#' A helper function for get_robotstxt() that will extract the robots.txt file
#' from the HTTP request result object. furthermore it will inform
#' get_robotstxt() if the request should be cached and which problems occured.
#'
#'
#'
#' @param request result of an HTTP request (e.g. httr::GET())
#'
#'
#' @param on_server_error request state handler for any 5xx status
#'
#' @param on_client_error request state handler for any 4xx HTTP status that is
#'   not 404
#'
#' @param on_not_found request state handler for HTTP status 404
#'
#' @param on_redirect request state handler for any 3xx HTTP status
#'
#' @param on_domain_change request state handler for any 3xx HTTP status where
#'   domain did change as well
#'
#' @param on_sub_domain_change request state handler for any 3xx HTTP status where
#'   domain did change but only to www-sub_domain
#'
#' @param on_file_type_mismatch request state handler for content type other
#'   than 'text/plain'
#'
#' @param on_suspect_content request state handler for content that seems to be
#'   something else than a robots.txt file (usually a JSON, XML or HTML)
#'
#'
#' @param warn suppress warnings
#' @param encoding The text encoding to assume if no encoding is provided in the
#'   headers of the response
#'
#' @return a list with three items following the following schema: \cr \code{
#'   list( rtxt = "", problems = list( "redirect" = list( status_code = 301 ),
#'   "domain" = list(from_url = "...", to_url = "...") ) ) }
#'
#' @export
#'
#'
rt_request_handler <-
  function(
    request,
    on_server_error       = on_server_error_default,
    on_client_error       = on_client_error_default,
    on_not_found          = on_not_found_default,
    on_redirect           = on_redirect_default,
    on_domain_change      = on_domain_change_default,
    on_sub_domain_change  = on_sub_domain_change_default,
    on_file_type_mismatch = on_file_type_mismatch_default,
    on_suspect_content    = on_suspect_content_default,
    warn                  = TRUE,
    encoding              = "UTF-8"
  ){

    # apply options to defaults
    on_server_error       <- list_merge(on_server_error_default, on_server_error)
    on_client_error       <- list_merge(on_client_error_default, on_client_error)
    on_not_found          <- list_merge(on_not_found_default, on_not_found)
    on_redirect           <- list_merge(on_redirect_default, on_redirect)
    on_domain_change      <- list_merge(on_domain_change_default, on_domain_change)
    on_file_type_mismatch <- list_merge(on_file_type_mismatch_default, on_file_type_mismatch)
    on_suspect_content    <- list_merge(on_suspect_content_default, on_suspect_content)


    # storage for output
    res <-
      list(
        rtxt      = NULL,
        problems  = list(),
        cache     = NULL,
        priority  = 0
      )


    # encoding suplied or not
    encoding_supplied  <-
      grepl("charset", null_to_defeault(request$headers$`content-type`, ""))


    if ( encoding_supplied == TRUE ) {
      rtxt_not_handled <-
        httr::content(
          request,
          as       = "text"
        )
    } else {
      rtxt_not_handled <-
        httr::content(
          request,
          encoding = encoding,
          as       = "text"
        )
    }




    ## server error
    server_error <-
      request$status_code >= 500

    if ( server_error == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_server_error,
          res     = res,
          info    = list(status_code = request$status_code),
          warn    = warn
        )
    }

    ## http 404 not found
    not_found <-
      request$status_code == 404

    if ( not_found == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_not_found,
          res     = res,
          info    = list(status_code = request$status_code),
          warn    = warn
        )
    }


    ## other client error
    client_error       <-
      request$status_code >= 400 &
      request$status_code != 404 &
      request$status_code < 500

    if ( client_error == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_client_error,
          res     = res,
          info    = list(status_code = request$status_code),
          warn    = warn
        )
    }


    ## redirect
    redirected <-
      http_was_redirected(request)

    ## domain change
    domain_change <-
      http_domain_changed(request)

    ## subdomain changed to www
    subdomain_changed <-
      http_subdomain_changed(request)


    if ( redirected == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_redirect,
          res     = res,
          info    =
            {
              tmp <- list()
              for ( i in seq_along(request$all_headers)){
                tmp[[length(tmp)+1]] <-
                  list(
                    status   = request$all_headers[[i]]$status,
                    location = request$all_headers[[i]]$headers$location
                  )
              }
              tmp
            }
            ,
          warn    = warn
        )

      if ( domain_change == TRUE && subdomain_changed == TRUE ){
        res <-
          request_handler_handler(
            request = request,
            handler = on_domain_change,
            res     = res,
            info    = "domain change",
            warn    = warn
          )
      } else if ( domain_change == TRUE ) {
        res <-
          request_handler_handler(
            request = request,
            handler = on_sub_domain_change,
            res     = res,
            info    = "subdomain change",
            warn    = warn
          )
      }
    }




    ## file type mismatch
    file_type_mismatch <-
      !(grepl("text/plain", null_to_defeault(request$headers$`content-type`, "")))

    if ( file_type_mismatch == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_file_type_mismatch,
          res     = res,
          info    = list(content_type = request$headers$`content-type`),
          warn    = warn
        )
    }


    ## content suspect
    parsable           <- is_valid_robotstxt(rtxt_not_handled)
    content_suspect    <- is_suspect_robotstxt(rtxt_not_handled)

    if ( parsable == FALSE | content_suspect == TRUE  ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_suspect_content,
          res     = res,
          info    = list(parsable = parsable, content_suspect = content_suspect),
          warn    = warn
        )
    }

    ## default robotstxt if not handled otherwise
    if ( is.null(res$rtxt) ){
      res$rtxt <- rtxt_not_handled
    }


    # return
    res
  }
