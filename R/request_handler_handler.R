#' request_handler_handler
#'
#' Helper function to handle robotstxt handlers.
#'
#' @param request the request object returned by call to httr::GET()
#' @param handler the handler either a character string entailing various options or a function producing a specific list, see return.
#' @param res a list a list with elements '[handler names], ...', 'rtxt', and 'cache'
#' @param info info to add to problems list
#' @param warn if FALSE warnings and messages are suppressed
#'
#' @return a list with elements '[handler name]', 'rtxt', and 'cache'
#' @export
#'
request_handler_handler <-
  function(request, handler, res, info = TRUE, warn = TRUE){
    # use handler function or simply go through options bit by bit
    if ( is.function(handler) ){

      return(handler(request, handler, res, info, warn))

    } else {

      # signaling
      if ( length(handler$signal) == 0 ){
        # do nothing
      } else if ( handler$signal %in% "error" ) {

        stop(paste0("Event: ", deparse(substitute(handler))))

      } else if (  handler$signal %in% "warning" & warn == TRUE) {

        warning(paste0("Event: ", deparse(substitute(handler))))

      } else if (  handler$signal %in% "message"   & warn == TRUE) {

        message(paste0("Event: ", deparse(substitute(handler))))

      }


      # problems logging
      res$problems[[ deparse(substitute(handler)) ]] <- info


      # rtxt handling
      if ( is.null(handler$over_write_file_with) ) {
        # do nothing
      } else {
        if ( res$priority < handler$priority){
          res$priority <- handler$priority
          res$rtxt     <-
            paste0(
              "# robots.txt overwrite by: ", deparse(substitute(handler)), "\n\n",
              paste0(handler$over_write_file_with, collapse = "\n")
            )
        }

      }

      # cache handling
      if ( handler$cache %in% TRUE ) {
        if ( res$priority < handler$priority){
          res$cache <- TRUE
        }
      } else if ( handler$cache %in% FALSE ) {
        if ( res$priority < handler$priority){
          res$priority <- handler$priority
          res$cache <- FALSE
        }
      }
    }

    # return
    res
  }