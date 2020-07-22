#' extracting HTTP useragents from robots.txt
#' @param txt content of the robots.txt file
#' @keywords internal
# rt_get_useragent <- function(txt){
#   tmp  <- stringr::str_extract_all(txt, "[uU]ser-agent:.*")
#   stringr::str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
# }


rt_get_useragent <- function(txt){
  tmp  <-
    stringr::str_extract_all(
      string  = txt,
      pattern = stringr::regex("User-agent:.*", ignore_case = TRUE)
    )

  stringr::str_replace_all(
    string      = unique(unlist(tmp)),
    pattern     = stringr::regex("U.*:| |\n", ignore_case = TRUE),
    replacement = ""
  )
}