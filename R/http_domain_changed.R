#' Check if HTTP domain changed
#'
#' @param response an httr response object, e.g. from a call to httr::GET()
#'
#' @return logical of length 1 indicating whether or not any domain change
#'     happened during the HTTP request
#'
#'
http_domain_changed <-
  function(response){

    # get domain of original HTTP request
    orig_domain <- guess_domain(response$request$url)
    orig_domain <- stringr::str_replace(orig_domain, "www\\.", "")

    # extract location headers
    location <-
      unlist(
        lapply(
          X   = response$all_headers,
          FUN =
            function(x){
              x$headers$location
            }
        )
      )
    location        <- utils::tail(location, 1)
    location        <- stringr::str_replace(location, "www\\.", "")
    location_domain <- guess_domain(location)

    # if there is no location header nothing has changed
    #
    if ( length(location) > 0 ) {
      return(
        !(
          stringr::str_detect(
            string = guess_domain(location_domain),
            pattern =
              stringr::regex(
                stringr::str_replace_all(orig_domain, "\\.", "\\\\."),
                ignore_case = TRUE
              )
          )
        )
      )
    } else {
      return(FALSE)
    }

  }
