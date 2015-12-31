#' make automatically named list
#' @param ... things to be put in list
named_list <- function(...){
  thelist <- list(...)
  names(thelist) <- as.character(substitute(list(...)))[-1]
  thelist
}

#' load robots.txt files saved along with the package
#' @param name name of the robots.txt files, defaults to a random drawn file ;-)
#' @export
rt_get_rtxt <- function(name=sample(rt_list_rtxt(),1)){
  readLines( system.file( paste0("robotstxts/",name), package = "robotstxt" ), warn = FALSE)
}

#' list robots.txt files saved along with the package
#' @export
rt_list_rtxt <- function(){
  list.files(system.file("robotstxts", package = "robotstxt" ))
}