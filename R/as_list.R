

#' Method as.list() for class robotstxt_text
#'
#' @param x class robotstxt_text object to be transformed into list
#' @param ... further arguments (inherited from \code{base::as.list()})
#' @export
#'
#'
as.list.robotstxt_text <-
  function(x, ...){
    res <- list()

    res$content   <- httr::content(attr(x, "request"), encoding = "UTF-8")
    res$robotstxt <- as.character(x)
    res$problems  <- attr(x, "problems")
    res$request   <- attr(x, "request")

    res
  }