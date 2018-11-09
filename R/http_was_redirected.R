#' http_was_redirected
#'
#' @param response an httr response object, e.g. from a call to httr::GET()
#'
#' @return logical of length 1 indicating whether or not any redirect happened
#'   during the HTTP request
#'
#'
http_was_redirected <-
  function(response){
    # extract status
    status <-
      vapply(
        X         = response$all_headers,
        FUN       = `[[`,
        FUN.VALUE = integer(1),
        "status"
      )

    # check status and return
    any(status >= 300 & status < 400)
  }
