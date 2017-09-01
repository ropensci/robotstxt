
#' extracting comments from robots.txt
#' @param txt content of the robots.txt file
#' @keywords internal
rt_get_comments <- function(txt){
  txt      <- unlist(stringr::str_split(txt, "\n"))
  clines   <- grep("#", txt)
  ccontent <- stringr::str_extract(txt[clines], "#.*")
  data.frame(line=clines, comment=ccontent, stringsAsFactors = FALSE)
}

