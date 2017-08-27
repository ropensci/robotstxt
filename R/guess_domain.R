#' function guessing domain from path
#' @param x path aka URL from which to infer domain
guess_domain <- function(x){
  if(length(x)>1){
    return(unlist(lapply(x, guess_domain)))
  }else{
    hostname <- httr::parse_url(x)$hostname
    if( is.null(hostname) ){
      hostname <- NA
    }
    return(hostname)
  }
}