
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
#'   -- and might help with robots.txt file retrieval in some cases              #'
#' @export
#'
get_robotstxts <-
  function(
    domain,
    warn           = TRUE,
    force          = FALSE,
    user_agent     = utils::sessionInfo()$R.version$version.string,
    ssl_verifypeer = c(1,0),
    use_futures    = FALSE
  ){


    # combine parameter
    if ( length(user_agent) == 0 ) {

      parameter <-
        data.frame(
          domain           = domain,
          warn             = warn[1],
          force            = force[1],
          ssl_verifypeer   = ssl_verifypeer[1],
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
          domain         = x$domain,
          warn           = x$warn,
          force          = x$force,
          user_agent     = x$user_agent,
          ssl_verifypeer = x$ssl_verifypeer
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


