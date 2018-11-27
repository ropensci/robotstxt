# ok
if( request$status < 400 ){
  rtxt <-
    httr::content(
      request,
      encoding = encoding,
      as       = "text"
    )

  # check if robots.txt is parsable
  if ( is_valid_robotstxt(rtxt) ){
    rt_cache[[domain]] <- request
  }else{
    # dump file
    fname_tmp <-
      tempfile(pattern = "robots_", fileext = ".txt")

    writeLines(
      text     = rtxt,
      con      = fname_tmp,
      useBytes = TRUE
    )

    # give back a digest of the retrieved file
    if( warn ){
      message(
        "\n\n",
        "[domain] ", domain, " --> ", fname_tmp,
        "\n\n",
        substring(paste(rtxt, collapse = "\n"), 1, 200),"\n", "[...]",
        "\n\n"
      )
    }


    # found file but could not parse it - can happen, everything is allowed
    # --> treated as if there was no file
    warning(paste0(
      "get_robotstxt(): ",  domain, "; Not valid robots.txt."
    ))
    rtxt <- ""
    rt_cache[[domain]] <- request
  }
}

# not found - can happen, everything is allowed
if( request$status == 404 ){
  if(warn){
    warning(paste0(
      "get_robotstxt(): ",  domain, "; HTTP status: ",  request$status
    ))
  }
  rtxt <- ""
  rt_cache[[domain]] <- request
}

# not ok - diverse
if( !(request$status == 404 | request$status < 400) ){
  stop(paste0(
    "get_robotstxt(): ",  domain, "; HTTP status: ",  request$status
  ))
}
