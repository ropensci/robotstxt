
#' printing robotstxt_text
#' @param x character vector aka robotstxt$text to be printed
#' @param ... goes down the sink
#' @export
print.robotstxt_text <- function(x, ...){

  # rpint part of the robots.txt file
  cat("[robots.txt]\n--------------------------------------\n\n")
  tmp <- unlist(strsplit(x, "\n"))
  cat(tmp[seq_len(min(length(tmp), 50))], sep ="\n")
  cat("\n\n\n")
  if(length(tmp) > 50){
    cat("[...]\n\n")
  }

  # print problems
  problems <- attr(x, "problems")
  if ( length(problems) > 0){
    cat("[events]\n--------------------------------------\n\n")
    cat("requested:  ", attr(x, "request")$request$url, "\n")
    cat("downloaded: ", attr(x, "request")$url, "\n\n")
    cat(utils::capture.output(print(problems)), sep="\n")
    cat("[attributes]\n--------------------------------------\n\n")
    cat(names(attributes(x)), sep=", ")
  }

  cat("\n")

  # return
  invisible(x)
}