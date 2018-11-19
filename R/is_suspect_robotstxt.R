#' is_suspect_robotstxt
#'
#' function that checks if file is valid / parsable robots.txt file
#'
#' @param text content of a robots.txt file provides as character vector
#'
is_suspect_robotstxt <- function(text){

  # check for html
  if( grep(x = text[1], pattern = "^\\s*<!doctype ", ignore.case = TRUE) ){
    return(TRUE)
  }

  # check for xml
  if( grep(x = text[1], pattern = "^\\s*<?xml ", ignore.case = TRUE) ){
    return(TRUE)
  }

  # check for json
  if( grep(x = text[1], pattern = "^\\s*{", ignore.case = TRUE) ){
    return(TRUE)
  }


  # return default
  return(FALSE)
}


