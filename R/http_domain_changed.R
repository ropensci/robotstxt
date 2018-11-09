#' http_domain_changed
#'
#' @param response an httr response object, e.g. from a call to httr::GET()
#'
#' @return logical of length 1 indicating whether or not any domain change
#'     happened during the HTTP request
#'
#'
http_domain_changed <-
  function(response){
    # get domain of origignal HTTP request
    orig_domain <- urltools::domain(response$request$url)

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

    # new domains
    new_domains <- urltools::domain(location)

    # check domains in location against original domain
    any( !is.na(new_domains) & new_domains != orig_domain )
  }
