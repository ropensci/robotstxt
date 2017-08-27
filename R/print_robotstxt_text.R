
#' printing robotstxt_text
#' @param x character vector aka robotstxt$text to be printed
#' @param ... goes down the sink
#' @export
print.robotstxt_text <- function(x, ...){
  cat(x)
  invisible(x)
}