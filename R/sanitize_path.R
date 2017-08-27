#' making paths uniform
#' @param path path to be sanitized
#' @return sanitized path
#' @keywords internal
sanitize_path <- function(path){
  path <- stringr::str_replace(    path, "^ *", "")
  path <- ifelse( !grepl("^/", path),  paste0("/", path), path)
  return(path)
}

