#' function that checks if file is valid / parseable robots.txt file
#'
#' @param text
#' @export
#'
is_valid_robotstxt <- function(text){
  grepl("^ *[\\w#]", text)
}


