#' make automatically named list
#' @param ... things to be put in list
named_list <- function(...){
  thelist <- list(...)
  names(thelist) <- as.character(substitute(list(...)))[-1]
  thelist
}
