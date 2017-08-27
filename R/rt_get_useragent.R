#' extracting HTTP useragents from robots.txt
#' @param txt content of the robots.txt file
#' @keywords internal
rt_get_useragent <- function(txt){
  tmp  <- stringr::str_extract_all(txt, "[uU]ser-agent:.*")
  stringr::str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
}
