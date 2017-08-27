#' transforming permissions into regular expressions (whole permission)
#'
#' @param permissions the permissions to be transformed
#' @keywords internal
sanitize_permissions <- function(permissions){
  tmp <- permissions
  # epressing Disallow "" as Allow "*"
  iffer <- grepl("Disallow", tmp$field, ignore.case = TRUE) & grepl("^ *$", tmp$value)
  if( sum(iffer) > 0 ){
    tmp[iffer, ]$field <- "Allow"
    tmp[iffer, ]$value      <- "/"
  }
  # permission path sanitization
  tmp$value <- sanitize_permission_values(tmp$value)
  return(tmp)
}
