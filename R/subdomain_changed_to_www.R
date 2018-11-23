#' subdomain_changed_to_www
#'
#' @param response an httr response object, e.g. from a call to httr::GET()
#'
#' @return logical of length 1 indicating whether or not any domain change
#'     happened during the HTTP request
#'
#'
subdomain_changed_to_www <-
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
    if ( length(location) > 0 ){
      new_domains        <- urltools::domain(location)
      new_domains_wo_www <- gsub("^www\\.", "", urltools::domain(location))
    } else {
      new_domains        <- orig_domain
      new_domains_wo_www <- orig_domain
    }


    # check domains in location against original domain
    any( !is.na(new_domains) & new_domains != orig_domain ) & all( !is.na(new_domains_wo_www) & new_domains_wo_www == orig_domain)
  }
