
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
#' @param on_file_type_mismatch request state handler for content type other
#'   than 'text/plain'
#'
#' @param on_suspect_content request state handler for content that seems to be
#'   something else than a robots.txt file (usually a JSON, XML or HTML)
#'
#'
#' @param warn deprecated! this will still work but is replaced by new
#'     mechanism specified in handler functions
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
    on_server_error       = c("disallow", "error",   "do_not_cache"),
    on_client_error       = c("allow",    "warn",    "cache"),
    on_not_found          = c("allow",    "warn",    "cache"),
    on_redirect           = c("ignore",   "message", "cache"),
    on_domain_change      = c("allow",    "warn",    "cache"),
    on_file_type_mismatch = c("allow",    "warn",    "cache"),
    on_suspect_content    = c("allow",    "warn",    "cache"),
    warn                  = TRUE,
    encoding              = "UTF-8"
  ){

    # suppress warnings
    if ( warn == TRUE) {
      # do nothing
    } else {
      warn <- function(...){
        # do nothing at all because user said so
      }
    }

    # storage for output
    res <-
      list(
        rtxt     = NULL,
        problems = list(),
        cache    = NULL
      )

    # default robots.txt handling

    # encoding suplied or not
    encoding_supplied  <-
      grepl("charset", null_to_defeault(request$headers$`content-type`, ""))


    if ( encoding_supplied == TRUE ){
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
          info    = list(status_code = request$status_code)
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
          info    = list(status_code = request$status_code)
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
          info    = list(status_code = request$status_code)
        )
    }


    ## redirect
    redirected <-
      http_was_redirected(request)

    if ( redirected == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_redirect,
          res     = res,
          info    = list(status_code = request$status_code)
        )
    }

    ## domain change
    domain_change <-
      http_domain_changed(request)

    if ( domain_change == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_domain_change,
          res     = res,
          info    = list(orig_url = request$request$url, url = request$url)
        )
    }

    ## file type mismatch
    file_type_mismatch <-
      !(grepl("text/plain", null_to_defeault(request$headers$`content-type`)))

    if ( file_type_mismatch == TRUE ){
      res <-
        request_handler_handler(
          request = request,
          handler = on_file_type_mismatch,
          res     = res,
          info    = list(content_type = request$headers$`content-type`)
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
          info    = list(parsable = parsable, content_suspect = content_suspect)
        )
    }

    ## default robotstxt if not handled otherwise
    if( is.null(res$rtxt) ){
      res$rtxt <- rtxt_not_handled
    }


    # return
    res
  }
