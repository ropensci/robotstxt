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
get_fields <- function(txt, type="all", regex=NULL){
  txt_vec   <- unlist(stringr::str_split(txt, "\n"))
  fields    <- grep("(^[ \t]{0,2}[^#]\\w.*)", txt_vec, value=TRUE)
  fields    <- data.frame(do.call(rbind, str_split(fields, ":")), stringsAsFactors = FALSE)
  names(fields) <- c("field", "value")
  fields$value <- stringr::str_trim(fields$value)
  fields$field <- stringr::str_trim(fields$field)
  # subset by regex
  if ( !is.null(regex) ){
    fields <- fields[ grepl(regex, fields$field) ,]
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

#' a representation of robotstxt
robotstxt <-
  R6::R6Class(
  # class name
    "robotstxt",
  # declaration
    public = list(
  # puplic data fields
      text        =  NA,
      bots        =  NA,
      permissions =  NA,
      domain      =  NA,
  # startup
      initialize = function(text, domain) {
        if (missing(domain)) self$domain <- "???"
        if (!missing(text)){
          self$text <- text
        }else{
          if(!missing(domain)){
            self$domain <- domain
            rtxt <- httr::GET(paste0(domain,"/robots.txt"))
            if( rtxt$status == 200 ){
              self$text <- rtxt
            }else{
              stop("robotstxt: could not get robots txt from domain")
            }
          }else{
            stop("robotstxt: I need text to initialize.")
          }
        }
        self$bots        <- get_useragent(self$text)
        self$permissions <- get_permissions(self$text)
      },
  # checking if bot is allowed to to access path
      check = function(path, bot) {
        if(missing(bot))  bot  <- "*"
        if(missing(path)) path <- "/"
        message(paste0("[",bot,"]", " allowed / disallowed @ ", self$domain,  path))
      }
    )
  )






