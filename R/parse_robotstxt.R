#' function parsing robots.txt
#' @param  txt content of the robots.txt file
#' @return a named list with useragents, comments, permissions, sitemap
parse_robotstxt <- function(txt){
  # return
  res <-
    list(
      useragents  = get_useragent(txt),
      comments    = get_comments(txt),
      permissions = get_permissions(txt),
      sitemap     = get_fields(txt, type="sitemap")
    )
  return(res)
}


#' function for making paths uniform
#' @param path path to be sanatized
#' @return sanatized path
sanatize_path <- function(path){
  tmp <- path
  if( !grepl("^/", path) ) tmp <- paste0("/", path)
  return(tmp)
}

#' function for extracting HTTP useragents from robots.txt
#' @param txt content of the robots.txt file
get_useragent <- function(txt){
  tmp  <- stringr::str_extract_all(txt, "[uU]ser-agent:.*")
  stringr::str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
}

#' function for extrcting comments from robots.txt
#' @param txt content of the robots.txt file
get_comments <- function(txt){
  txt      <- unlist(stringr::str_split(txt, "\n"))
  clines   <- grep("^[ \t]*#", txt)
  data.frame(line=clines, comment=txt[clines])
}

#' function for extracting robotstxt fields
#' @param txt content of the robots.txt file
get_fields <- function(txt, type="all", regex=NULL, invert=FALSE){
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

#' function for extracting permissions from robots.txt
#' @param txt content of the robots.txt file
get_permissions <- function(txt){
  txt_parts   <- unlist( stringr::str_split( stringr::str_replace(stringr::str_replace_all(paste0(txt, collapse = "\n"), "#.*?\n",""),"^\n",""), "\n[ \t]*\n" ) )
  useragents  <- lapply(txt_parts, get_useragent)
  permissions <- lapply(txt_parts, get_fields, regex="[aA]llow")
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

