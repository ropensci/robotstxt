#' function parsing robots.txt files
#' @param text text of file

parse_robotstxt <- function(txt){
  if ( length(txt) > 1  ) txt <- paste0(txt, collapse = "\n")
  txt  <- stringr::str_replace_all(txt, "[ \t]*\n", "\n")
  rtxt <- stringr::str_split(txt,"\n\n")
  tmp  <- lapply(rtxt, stringr::str_extract_all, "[uU]ser-agent:.*\n")
  useragents <- stringr::str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
  return(named_list(useragents))
}