#' make automatically named list
#'
named_list <- function(...){
  thelist <- list(...)
  names(thelist) <- as.character(substitute(list(...)))[-1]
  thelist
}
