#' request_handler_handler
#'
#' Helper function to handle robotstxt hanlders.
#'
#' @param request the request object returned by call to httr::GET()
#' @param handler the handler either a character string entailing various options or a function producing a specific list, see return.
#' @param res a list a list with elements '[handler names], ...', 'rtxt', and 'cache'
#' @param info ???
#'
#' @return a list with elements '[handler name]', 'rtxt', and 'cache'
#' @export
#'
request_handler_handler <-
  function(request, handler, res, info = TRUE){
    # use handler function or simply go through options bit by bit
    if ( is.function(handler) ){

      return(handler(request))

    } else {

      # error handling
      if ( "error" %in% handler ) {

        stop(paste0("Event: ", deparse(substitute(handler))))

      } else if ( "warn" %in% handler ) {

        warning(paste0("Event: ", deparse(substitute(handler))))

      } else if ( "message" %in% handler ) {

        message(paste0("Event: ", deparse(substitute(handler))))

      }


      # problems handling
      res$problems[[ deparse(substitute(handler)) ]] <- info


      # rtxt handling
      if ( "allow" %in% handler ) {
        res$rtxt <-
          "# robots.txt file created by robotstxt::rt_request_handler()\nUser-agent: *\nAllow: /\n"
      } else if ( "disallow" %in% handler ) {
        res$rtxt <-
          "# robots.txt file created by robotstxt::rt_request_handler()\nUser-agent: *\nDisallow: /\n"
      } else if ( "ignore" %in% handler ){
        # do nothing
      }


      # cache handling
      if ( "cache" %in% handler ) {
        res$cache <- TRUE
      } else if ( "do_not_cache" %in% handler ) {
        res$cache <- FALSE
      }
    }

    # return
    res
  }