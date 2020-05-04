#' fix_url
#'
#'
#' @param url a character string containing a single URL
#'
fix_url <-
  function(url){
    parsed_url <- httr::parse_url(url)
    if ( is.null(parsed_url$scheme) ){
      url <- paste0("http://", url)
    }
    url
  }