#' make automatically named list
#' @param ... things to be put in list
#' @keywords internal
named_list <- function(...){
  thelist <- list(...)
  names(thelist) <- as.character(substitute(list(...)))[-1]
  thelist
}

#' load robots.txt files saved along with the package
#'
#' load robots.txt files saved along with the package:
#' these functions ar very handy for testing (not used otherwise)
#' @param name name of the robots.txt files, defaults to a random drawn file ;-)
#' @keywords internal
rt_get_rtxt <- function(name=sample(rt_list_rtxt(),1)){
  if( is.numeric(name) ){
    name <- rt_list_rtxt()[name]
  }
  readLines( system.file( paste0("robotstxts/",name), package = "robotstxt" ), warn = FALSE)
}

#' list robots.txt files saved along with the package
#'
#' list robots.txt files saved along with the package:
#' these functions ar very handy for testing (not used otherwise)
#' @keywords internal
rt_list_rtxt <- function(){
  list.files(system.file("robotstxts", package = "robotstxt" ))
}

