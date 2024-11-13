#' Storage for HTTP request response objects
#'
#' @rdname get_robotstxt_http_get
#' @export
rt_last_http <- new.env()
rt_last_http$request <- list()

#' Execute HTTP request for get_robotstxt()
#'
#' @param ssl_verifypeer either 1 (default) or 0, if 0 it disables SSL peer verification, which
#'   might help with robots.txt file retrieval
#' @param domain the domain to get robots.txt file for. Defaults to current version of R
#' @param user_agent the user agent to use for HTTP request header
#' @export
get_robotstxt_http_get <- function(domain, user_agent = utils::sessionInfo()$R.version$version.string, ssl_verifypeer = 1) {
  url <- fix_url(paste0(domain, "/robots.txt"))
  request <- httr::GET(
    url = url,
    config = httr::config(ssl_verifypeer = ssl_verifypeer),
    httr::add_headers("user-agent" = user_agent)
  )

  rt_last_http$request <- request

  request
}
