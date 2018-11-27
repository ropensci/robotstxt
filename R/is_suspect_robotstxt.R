#' is_suspect_robotstxt
#'
#' function that checks if file is valid / parsable robots.txt file
#'
#' @param text content of a robots.txt file provides as character vector
#'
is_suspect_robotstxt <- function(text){

  if ( length(text) > 0 ){
    # check for html
    if( grepl(x = text[1], pattern = "^\\s*<!doctype ", ignore.case = TRUE) ){
      return(TRUE)
    }

    # check for xml
    if( grepl(x = text[1], pattern = "^\\s*<?xml ", ignore.case = TRUE) ){
      return(TRUE)
    }

    # check for json
    if( grepl(x = text[1], pattern = "^\\s*\\{", ignore.case = TRUE) ){
      return(TRUE)
    }
  }

  # return default
  return(FALSE)
}


