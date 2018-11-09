#' null_to_defeault
#'
#' @param x value to check and return
#' @param d value to return in case x is NULL
#'
null_to_defeault <-
  function(x, d){
    if ( is.null(x) ){
      d
    }else{
      x
    }
  }