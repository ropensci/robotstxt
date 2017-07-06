#' function that checks if file is valid / parseable robots.txt file
#'
#' @param text
#' @export
#'
is_valid_robotstxt <- function(text){
  text <- unlist(strsplit(text, "\n"))
  all(
    # allow :
      # - spaces followed by #
      grepl("(^\\s*#)", text)   |
      # - spaces followed by letter(s) followed by a double dot (somewhere)
      grepl("(^\\s*\\w.*:)", text) |
      # - spaces only or empty line
      grepl("(^\\s*$)", text)
  )
}


