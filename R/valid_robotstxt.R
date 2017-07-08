#' function that checks if file is valid / parseable robots.txt file
#'
#' @param text content of a robots.txt file rovides as character vector
#' @export
#'
is_valid_robotstxt <- function(text){
  text <- unlist(strsplit(text, "\n"))
  all(
    # allow :
      # - spaces followed by #
      grepl(
        pattern  = "^(\xef\xbb\xbf)*\\s*#",
        x        = text,
        useBytes = TRUE
      )   |
      # - spaces followed by letter(s) followed by a double dot (somewhere)
      grepl("^(\xef\xbb\xbf)*(\\s*\\w.*:)", text) |
      # - spaces only or empty line
      grepl("^(\xef\xbb\xbf)*(\\s)*$", text)
  )
}


