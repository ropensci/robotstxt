


#' parse_url
#'
#' @param url url to parse into its components
#'
#' @return data.frame with columns protocol, domain, path
#'
#'
#' @keywords internal
#'
#' @examples
#'
#' \dontrun{
#' url <-
#' c(
#'   "google.com",
#'   "google.com/",
#'   "www.google.com",
#'   "http://google.com",
#'   "https://google.com",
#'   "sub.domain.whatever.de"
#'   "s-u-b.dom-ain.what-ever.de"
#' )
#'
#' parse_url(url)
#' }
#'
parse_url <- function(url){
  match <-
    stringr::str_match(
      string  = url,
      pattern = "(^\\w+://)?([^/]+)?(/.*)?"
    )

  match <- match[, -1, drop = FALSE]

  df        <- as.data.frame(match, stringsAsFactors = FALSE)
  names(df) <- c("protocol", "domain", "path")
  df$path[ is.na(df$path) ] <- ""

  # return
  df
}


