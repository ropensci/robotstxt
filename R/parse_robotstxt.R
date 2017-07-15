#' get_robotstxt() cache
rt_cache <- new.env(parent=emptyenv())



#' get_robotstxt() worker function to execut HTTP request
#'
#' @inheritParams get_robotstxt

get_robotstxt_http_get <-
  function(domain, user_agent = NULL){
    if ( !is.null(user_agent) ) {
      # with user agent
      request <-
        httr::GET(
          url    = paste0(domain, "/robots.txt"),
          config =
            httr::add_headers(
              "user-agent" = user_agent
            )
        )
    }else{
      # without user agent
      request <-
        httr::GET(
          url    = paste0(domain, "/robots.txt")
        )
    }
  }



#' downloading robots.txt file
#'
#' @param domain domain from which to download robots.txt file
#' @param warn warn about being unable to download domain/robots.txt because of
#' @param force if TRUE instead of using possible cached results te function will
#'              re-download the robotstxt file
#'              HTTP resposne status 404. If this happens,
#' @param user_agent HTTP user-agent string to be used to retireve robots.txt file
#'   from domain
#' @export

get_robotstxt <-
  function(
    domain,
    warn       = TRUE,
    force      = FALSE,
    user_agent = NULL
  ){

  # pre checking input
  if( is.na(domain) ){
    return(NA)
  }

  # get data from cache or do download
  if( force ){

    request <-
      get_robotstxt_http_get(
        domain     = domain,
        user_agent = user_agent
      )

  }else if ( !is.null(rt_cache[[domain]]) ) {

    request <-
      rt_cache[[domain]]

  }else if ( is.null(rt_cache[[domain]]) ){

    request <-
      get_robotstxt_http_get(
        domain     = domain,
        user_agent = user_agent
      )

  }

  # ok
  if( request$status < 400 ){
    rtxt <- httr::content(request,  encoding="UTF-8", as="text")

    # check if robots.txt is parsable
    if ( is_valid_robotstxt(rtxt) ){
      rt_cache[[domain]] <- request
    }else{
      # give back a digest of the retrieved file
      message(
        "\n\n",
        substring(paste(rtxt, collapse = "\n"), 1, 200),
        "\n\n"
      )

      # dump file
      fname_tmp <-
        tempfile(pattern = "robots_", fileext = ".txt")

      writeLines(
        text     = rtxt,
        con      = fname_tmp,
        useBytes = TRUE
      )

      # stop
      stop(
        paste(
          "get_robotstxt(): the thing retrieved does not seem to be a valid robots.txt.",
          "file dumpend to:",
          fname_tmp
        )
      )
    }
  }

  # not found - can happen, everything is allowed
  if( request$status == 404 ){
    if(warn){
      warning(paste0(
        "get_robotstxt(): could not get robots.txt from domain: ",
        domain,
        " HTTP status: 404"
      ))
    }
    rtxt <- ""
    rt_cache[[domain]] <- request
  }

  # not ok - diverse
  if( !(request$status == 404 | request$status < 400) ){
    stop(paste0(
      "get_robotstxt(): could not get robots.txt from domain: ",
      domain,
      "; HTTP status: ",
      request$status
    ))
  }
  # return
  class(rtxt) <- c("robotstxt_text", "character")
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




#' extracting HTTP useragents from robots.txt
#' @param txt content of the robots.txt file
#' @keywords internal
rt_get_useragent <- function(txt){
  tmp  <- stringr::str_extract_all(txt, "[uU]ser-agent:.*")
  stringr::str_replace_all(unique(unlist(tmp)), "[uU].*:| |\n","")
}



#' extrcting comments from robots.txt
#' @param txt content of the robots.txt file
#' @keywords internal
rt_get_comments <- function(txt){
  txt      <- unlist(stringr::str_split(txt, "\n"))
  clines   <- grep("#", txt)
  ccontent <- stringr::str_extract(txt[clines], "#.*")
  data.frame(line=clines, comment=ccontent, stringsAsFactors = FALSE)
}




#' extracting robotstxt fields
#' @param txt content of the robots.txt file
#' @param type name or names of the fields to be returned, defaults to all
#'   fields
#' @param regex subsetting field names via regular expressions
#' @param invert field selection
#' @keywords internal
rt_get_fields_worker <- function(txt, type="all", regex=NULL, invert=FALSE){
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
#' @param regex regular expression specify field
#' @param invert invert selection made via regex?
#' @keywords internal
rt_get_fields <- function(txt, regex="", invert=FALSE){
  txt_parts   <- unlist( stringr::str_split( stringr::str_replace(stringr::str_replace_all(paste0(txt, collapse = "\n"), "#.*?\n",""),"^\n",""), "\n[ \t]*\n" ) )
  useragents  <- lapply(txt_parts, rt_get_useragent)
  for(i in seq_along(useragents)){
    if( length(useragents[[i]])==0 ){
      useragents[[i]] <- "*"
    }
  }
  fields      <- lapply(txt_parts, rt_get_fields_worker, regex=regex, invert=invert)
  df          <- data.frame()
  for ( i in seq_along(txt_parts) ){
    df <-
      rbind(
        df,
        cbind(
          useragents[[i]][rep(seq_along(useragents[[i]]), length(fields[[i]][,1]))],
          fields[[i]][rep(seq_along(fields[[i]][,1]), length(useragents[[i]])),]
        )
      )
  }
  # getting df right
  names(df)    <- c("useragent", "field", "value")
  df <- df[,c("field", "useragent", "value")]
  rownames(df) <- NULL
  # ensuring chracter columns
  for( i in seq_len(dim(df)[2]) ){
    if( class(df[,i])=="factor" ){
      df[,i] <- as.character(df[,i])
    }
  }
  # return
  return(df)
}









