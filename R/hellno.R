#' logical constant for FALSE
HELLNO <- FALSE

#' alternative data.frame() implementation
#'
#' \code{hellno::data.frame()} wraps up \code{base::data.frame()} so that
#' \code{stringAsFactors} is set to \code{HELLNO} ( \code{== FALSE} ) by default
#' @param ... see \code{\link[base]{data.frame}}
#' @param stringsAsFactors see \code{\link[base]{data.frame}} by default set to \code{FALSE}
#' @seealso \code{\link[base]{data.frame}}
data.frame <- function ( ..., stringsAsFactors = HELLNO ) {
  base::data.frame( ..., stringsAsFactors=stringsAsFactors )
}

#' alternative as.data.frame() implementation
#'
#' \code{hellno::as.data.frame()} wraps up \code{base::as.data.frame()} so that
#' \code{stringAsFactors} is set to \code{HELLNO} ( \code{== FALSE} ) by default
#' @param x see \code{\link[base]{as.data.frame}}
#' @param row.names see \code{\link[base]{as.data.frame}}
#' @param optional see \code{\link[base]{as.data.frame}}
#' @param stringsAsFactors see \code{\link[base]{as.data.frame}} by default set to \code{FALSE}
#' @param ... see \code{\link[base]{as.data.frame}}
#' @seealso \code{\link[base]{as.data.frame}}
as.data.frame <- function (
  x, row.names = NULL, optional = FALSE, stringsAsFactors=HELLNO, ...
){
  base::as.data.frame(
    x, row.names = NULL, optional = FALSE, stringsAsFactors=stringsAsFactors, ...
  )
}

#' altenative rbind implementation
#'
#' @param ... see \code{\link[base]{rbind.data.frame}}
#' @param deparse.level see \code{\link[base]{rbind.data.frame}}
#' @seealso \code{\link[base]{rbind.data.frame}}
rbind <- function (..., deparse.level = 1) {
  x <- list(...)
  iffer <- unlist(lapply(x, function(x){ class(x) %in% "data.frame" & sum(dim(x))==0 }))
  if( any(iffer) ){
    x <- do.call(base::rbind, x[!iffer])
    if( class(x) %in% "data.frame" ){
     x <- as.data.frame(x)
    }
  }else{
    x <- as.data.frame(do.call(base::rbind, x))
  }
  return(x)
}
















