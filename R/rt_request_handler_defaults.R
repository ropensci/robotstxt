#' @docType data
#' @rdname rt_request_handler
#' @export
on_server_error_default <-
  list(
    over_write_file_with = "User-agent: *\nDisallow: /",
    signal               = "error",
    cache                = FALSE,
    priority             = 20
  )

#' @docType data
#' @rdname rt_request_handler
#' @export
on_client_error_default <-
  list(
    over_write_file_with = "User-agent: *\nAllow: /",
    signal               = "warning",
    cache                = TRUE,
    priority             = 19
  )

#' @docType data
#' @rdname rt_request_handler
#' @export
on_not_found_default <-
  list(
    over_write_file_with = "User-agent: *\nAllow: /",
    signal               = "warning",
    cache                = TRUE,
    priority             = 1
  )

#' @docType data
#' @rdname rt_request_handler
#' @export
on_redirect_default <-
  list(
    #over_write_file_with = "User-agent: *\nAllow: /",
    #signal               = "warning",
    cache                = TRUE,
    priority             = 3
  )

#' @docType data
#' @rdname rt_request_handler
#' @export
on_domain_change_default <-
  list(
    # over_write_file_with = "User-agent: *\nAllow: /",
    signal               = "warning",
    cache                = TRUE,
    priority             = 4
  )

#' @docType data
#' @rdname rt_request_handler
#' @export
on_sub_domain_change_default <-
  list(
    # over_write_file_with = "User-agent: *\nAllow: /",
    # signal               = "warning",
    cache                = TRUE,
    priority             = 5
  )


#' @docType data
#' @rdname rt_request_handler
#' @export
on_file_type_mismatch_default <-
  list(
    over_write_file_with = "User-agent: *\nAllow: /",
    signal               = "warning",
    cache                = TRUE,
    priority             = 6
  )

#' @docType data
#' @rdname rt_request_handler
#' @export
on_suspect_content_default <-
  list(
    over_write_file_with = "User-agent: *\nAllow: /",
    signal               = "warning",
    cache                = TRUE,
    priority             = 7
  )
