#' printing robotstxt
#' @param x robotstxt instance to be printed
#' @param ... goes down the sink
#' @export
print.robotstxt <- function(x, ...){
  tmp <- x
  tmp_text <- unlist(stringr::str_split(tmp$text, "\n"))
  if( length(tmp_text) > 15 ){
    tmp$text <-
      paste0( c(tmp_text[1:10], "", paste0("[... ",length(tmp_text)-10," lines omitted ...]")), collapse = "\n")
  }
  if( length(tmp$bots) > 7 ){
    tmp$bots <-
      c(utils::head(tmp$bots), "", paste("[... ", length(tmp$bots)-5, "items omitted ...]") )
  }
  for(i in c("permissions", "crawl_delay", "host", "sitemap", "other") ){
    if( dim(tmp[[i]])[1] > 7  ){
      tmp_fill <- data.frame(cbind( paste("[... ", dim(tmp[[i]])[1]-5, "items omitted ...]"), "",""))
      names(tmp_fill) <- names(tmp[[i]])
      tmp[[i]]  <- rbind( utils::head(tmp[[i]]), "", tmp_fill )
    }
  }
  if( dim(tmp$comments)[1] > 7 ){
    tmp_fill <- data.frame(cbind( "", paste("[... ", dim(tmp[["comments"]])[1]-5, "items omitted ...]")))
    names(tmp_fill) <- names(tmp[["comments"]])
    tmp[["comments"]]  <- rbind( utils::head(tmp[["comments"]]), "", tmp_fill )
  }
  print.default(tmp)
  invisible(x)
}


