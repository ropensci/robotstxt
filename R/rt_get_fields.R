
#' extracting permissions from robots.txt
#' @param txt content of the robots.txt file
#' @param regex regular expression specify field
#' @param invert invert selection made via regex?
#' @keywords internal
rt_get_fields <- function(txt, regex = "", invert = FALSE){

  # split into text-parts to do all processing on
  txt_parts <-
    txt %>%
    stringr::str_replace_all("\r\n", "\n") %>%
    paste0(collapse = "\n") %>%
    stringr::str_replace_all( pattern = "#.*?\n", replacement = "") %>%
    stringr::str_replace(pattern = "^\n", replacement = "") %>%
    stringr::str_split("\n[ \t]*\n") %>%
    unlist()


  # get user agents per text-part
  useragents  <-
    lapply(
      X   = txt_parts,
      FUN = rt_get_useragent
    )

  for(i in seq_along(useragents)){
    if( length(useragents[[i]]) == 0 ){
      useragents[[i]] <- "*"
    }
  }

  # get fields per part
  fields  <-
    lapply(
      X      = txt_parts,
      FUN    = rt_get_fields_worker,
      regex  = regex,
      invert = invert
    )

  # put together user-agents and fields per text-part
  df <- data.frame()
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
    if( class(df[,i]) == "factor" ){
      df[,i] <- as.character(df[,i])
    }
  }

  # return
  return(df)
}
