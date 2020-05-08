#' function guessing domain from path
#' @param x path aka URL from which to infer domain
guess_domain <- function(x){

    if(length(x)>1){
    return(
      unlist(
        lapply(
          X   = x,
          FUN = guess_domain
        )
      )
    )

  } else {

    domain <- parse_url(url = x)$domain

    if( is.null(domain) ){
      domain <- NA
    }

    return(domain)
  }

}