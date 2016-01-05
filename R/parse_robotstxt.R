#' downloading robots.txt file
#' @param domain domain from which to download robots.txt file
#' @export
rt_get_robotstxt <- function(domain){
  rtxt <- httr::GET(paste0(domain, "/robots.txt"))
  if( rtxt$status == 200 ){
    rtxt <- httr::content(rtxt)
    class(rtxt) <- c("robotstxt_text", "character")
  }else{
    stop("robotstxt: could not get robots txt from domain")
  }
  return(rtxt)
}

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
      permissions = rt_get_permissions(txt),
      sitemap     = rt_get_fields(txt, type="sitemap"),
      other       = rt_get_other(txt)
    )
  return(res)
}


#' extracting HTTP useragents from robots.txt
#' @param txt content of the robots.txt file
rt_get_useragent <- function(txt){
  tmp  <- stringr::str_extract_all(txt, "[uU]ser-agent:.*")
  stringr::str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
}



#' extrcting comments from robots.txt
#' @param txt content of the robots.txt file
#' @export
rt_get_comments <- function(txt){
  txt      <- unlist(stringr::str_split(txt, "\n"))
  clines   <- grep("^[ \t]*#", txt)
  data.frame(line=clines, comment=txt[clines])
}

#' get_fields() wrapper to extract !(sitemap,(dis)allow,user-agent)
#' @param txt \code{\link{rt_get_fields}}
#' @param regex defaults to "sitemap|allow|user-agent" ; \code{\link{rt_get_fields}}
#' @param invert defaults to TRUE; \code{\link{rt_get_fields}}
rt_get_other <- function(txt, regex  = "sitemap|allow|user-agent", invert = TRUE){
  rt_get_fields( txt, regex, invert)
}


#' extracting robotstxt fields
#' @param txt content of the robots.txt file
#' @param type name or names of the fields to be returned, defaults to all
#'   fields
#' @param regex subsetting field names via regular expressions
#' @param invert field selection
#' @export
rt_get_fields <- function(txt, type="all", regex=NULL, invert=FALSE){
  if( all(txt == "") | all(!grepl(":",txt)) ) return(data.frame(field="", value="")[NULL,])
  txt_vec   <- unlist(stringr::str_split(txt, "\n"))
  fields    <- grep("(^[ \t]{0,2}[^#]\\w.*)", txt_vec, value=TRUE)
  fields    <- data.frame(do.call(rbind, stringr::str_split(fields, ":", n=2)), stringsAsFactors = FALSE)
  names(fields) <- c("field", "value")
  fields$value <- stringr::str_trim(fields$value)
  fields$field <- stringr::str_trim(fields$field)
  # subset by regex
  if ( !is.null(regex) ){
    fields <- fields[ grep(regex, fields$field, invert=invert, ignore.case=TRUE) ,]
  }
  if ( all(type == "all") ){
    return(fields)
  }else{
    return( fields[ tolower(fields$field) %in% tolower(type) ,] )
  }
}

#' extracting permissions from robots.txt
#' @param txt content of the robots.txt file
#' @export
rt_get_permissions <- function(txt){
  txt_parts   <- unlist( stringr::str_split( stringr::str_replace(stringr::str_replace_all(paste0(txt, collapse = "\n"), "#.*?\n",""),"^\n",""), "\n[ \t]*\n" ) )
  useragents  <- lapply(txt_parts, rt_get_useragent)
  permissions <- lapply(txt_parts, rt_get_fields, regex="[aA]llow")
  perm_df     <- data.frame(stringsAsFactors = FALSE)
  for ( i in seq_along(txt_parts) ){
    perm_df <-
      rbind(
        perm_df,
        cbind(
          useragents[[i]][rep(seq_along(useragents[[i]]), length(permissions[[i]][,1]))],
          permissions[[i]][rep(seq_along(permissions[[i]][,1]), length(useragents[[i]])),],
          stringsAsFactors=FALSE
        )
      )
  }
  names(perm_df)    <- c("useragent","permission","value")
  rownames(perm_df) <- NULL
  return(perm_df)
}












