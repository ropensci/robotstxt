
#' function to get multiple robotstxt files
#'
#' @inheritParams get_robotstxt
#' @param use_futures Should future::future_lapply be used for possible
#'                    parallel/async retrieval or not. Note: check out help
#'                    pages and vignettes of package future on how to set up
#'                    plans for future execution because the robotstxt package
#'                    does not do it on its own.
#' @param ssl_verifypeer analog to CURL option
#'   \url{https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html}
#'   -- and might help with robots.txt file retrieval in some cases
#'
#' @param rt_request_handler handler function that handles request according to
#'     the event handlers specified
#'
#' @export
#'
get_robotstxts <-
  function(
    domain,
    warn                      = TRUE,
    force                     = FALSE,
    user_agent                = utils::sessionInfo()$R.version$version.string,
    ssl_verifypeer            = c(1,0),
    use_futures               = FALSE,
    verbose                   = FALSE,
    rt_request_handler        = robotstxt::rt_request_handler,
    rt_robotstxt_http_getter  = robotstxt::get_robotstxt_http_get,
    on_server_error       = on_server_error_default,
    on_client_error       = on_client_error_default,
    on_not_found          = on_not_found_default,
    on_redirect           = on_redirect_default,
    on_domain_change      = on_domain_change_default,
    on_file_type_mismatch = on_file_type_mismatch_default,
    on_suspect_content    = on_suspect_content_default
  ){


    # combine parameter
    if ( length(user_agent) == 0 ) {

      parameter <-
        data.frame(
          domain           = domain,
          warn             = warn[1],
          force            = force[1],
          ssl_verifypeer   = ssl_verifypeer[1],
          verbose          = verbose,
          stringsAsFactors = FALSE
        )

    } else {

      parameter <-
        data.frame(
          domain           = domain,
          user_agent       = user_agent,
          warn             = warn[1],
          force            = force[1],
          ssl_verifypeer   = ssl_verifypeer[1],
          verbose          = verbose,
          stringsAsFactors = FALSE
        )
    }

    parameter_list <-
      lapply(
        split(parameter, seq_len(nrow(parameter))),
        as.list
      )


    # prepare execution of get_robotstxt()
    apply_fun <-
      if ( isTRUE(use_futures) ) {
        future.apply::future_lapply
      } else {
        lapply
      }

    to_be_applied_fun <-
      function(x){

        message(
          paste("\r", x$domain, "                     "),
          appendLF = FALSE
        )

        get_robotstxt(
          domain                    = x$domain,
          warn                      = x$warn,
          force                     = x$force,
          user_agent                = x$user_agent,
          ssl_verifypeer            = x$ssl_verifypeer,
          verbose                   = x$verbose,
          rt_request_handler        = rt_request_handler,
          rt_robotstxt_http_getter  = rt_robotstxt_http_getter,
          on_server_error           = on_server_error,
          on_client_error           = on_client_error,
          on_not_found              = on_not_found,
          on_redirect               = on_redirect,
          on_domain_change          = on_domain_change,
          on_file_type_mismatch     = on_file_type_mismatch,
          on_suspect_content        = on_suspect_content
        )

      }

    # execute get_robotstxt to parameter grid
    rtxt_list <-
      apply_fun(
        parameter_list,
        FUN = to_be_applied_fun
      )
    names(rtxt_list) <- domain
    message("\n")

    # return
    return(rtxt_list)
  }


