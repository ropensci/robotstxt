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
#' @param domain the domain to get robots.txt file for.
#' @param user_agent the user agent to use for HTTP request header. Defaults to current version of R.
#'   If `NULL` is passed, httr will use software versions for the header, such as
#'   `libcurl/8.7.1 r-curl/5.2.3 httr/1.4.7`
#' @export
get_robotstxt_http_get <- function(domain, user_agent = utils::sessionInfo()$R.version$version.string, ssl_verifypeer = 1) {
  url <- fix_url(paste0(domain, "/robots.txt"))

  headers <- if (!is.null(user_agent)) {
    httr::add_headers("user-agent" = user_agent)
  } else {
    NULL
  }

  request <- httr::GET(
    url = url,
    config = httr::config(ssl_verifypeer = ssl_verifypeer),
    headers
  )

  rt_last_http$request <- request

  request
}
