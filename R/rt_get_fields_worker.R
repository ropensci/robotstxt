
#' extracting robotstxt fields
#' @param txt content of the robots.txt file
#' @param type name or names of the fields to be returned, defaults to all
#'   fields
#' @param regex subsetting field names via regular expressions
#' @param invert field selection
#' @keywords internal
rt_get_fields_worker <- function(txt, type="all", regex=NULL, invert=FALSE){

  # handle empty file or no fields at all
  # (--> return empty data.frame)
  if( all(txt == "") | all(!grepl(":",txt)) ){
    return(data.frame(field="", value="")[NULL,])
  }

  # split lines int ovector elements
  txt_vec   <- unlist(stringr::str_split(txt, "\r*\n"))

  # filter for fields ( ^= not a comment)
  fields    <- grep("(^[ \t]{0,2}[^#]\\w.*)", txt_vec, value=TRUE)

  # split by ":" to get field_name, field_vlue pairs
  fields    <-
    data.frame(
      do.call(
        rbind,
        stringr::str_split(fields, ":", n=2)
      ),
      stringsAsFactors = FALSE
    )
  names(fields) <- c("field", "value")

  # some post processing and cleaning
  fields$value <- stringr::str_trim(fields$value)
  fields$field <- stringr::str_trim(fields$field)

  # subset fields by regex
  if ( !is.null(regex) ){
    fields <- fields[ grep(regex, fields$field, invert=invert, ignore.case=TRUE) ,]
  }

  # subset by type
  if ( all(type == "all") ){
    # do nothing
  }else{
    fields <- fields[ tolower(fields$field) %in% tolower(type) ,]
  }

  # return
  return(fields)
}
