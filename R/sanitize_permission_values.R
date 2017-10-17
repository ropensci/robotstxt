#' transforming permissions into regular expressions (values)
#'
#' @param permission_value the value column of permissions (the paths)
#' @keywords internal
sanitize_permission_values <- function(permission_value){
  tmp <- sanitize_path(permission_value)
  tmp <- stringr::str_replace_all(tmp, "\\?", "\\\\?") # escape questionmarks
  tmp <- stringr::str_replace_all(tmp, "\\+", "\\\\+") # escape questionmarks
  tmp <- stringr::str_replace_all(tmp, "\\*",".*")     # translate '*' to '.*'
  tmp <- stringr::str_replace_all(tmp, "^/","^/")
  tmp <- stringr::str_replace_all(tmp, "/$","")
  tmp <- stringr::str_replace_all(tmp, "^\\^$","^/")

  return(tmp)
}
