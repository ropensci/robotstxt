#' function parsing robots.txt
#' @param  txt content of the robots.txt file
#' @return a named list with useragents, comments, permissions, sitemap
#' @export
parse_robotstxt <- function(txt){
  # return
  res <-
    list(
      useragents  = rt_get_useragent(txt),
      comments    = rt_get_comments(txt),
      permissions = rt_get_fields(txt, "allow"),
      crawl_delay = rt_get_fields(txt, "crawl-delay"),
      sitemap     = rt_get_fields(txt, "sitemap"),
      host        = rt_get_fields(txt, "host"),
      other       =
        rt_get_fields(
          txt,
          regex="sitemap|allow|user-agent|host|crawl-delay",
          invert=TRUE
        )
    )
  return(res)
}


















