#' function to remove domain from path
#' @param x path aka URL from which to first infer domain and then remove it
remove_domain <- function(x){
  unlist(lapply(
    x,
    function(x){
      if( is.na(x) ){
        return(x)
      }else{
        stringr::str_replace(x, paste0("^.*", "\\Q", guess_domain(x), "\\E"), "")
      }
    }
  ))
}


