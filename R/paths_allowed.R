#' check if a bot has permissions to access page(s)
#'
#'
#' @param domain Domain for which paths should be checked. Defaults to "auto".
#'   If set to "auto" function will try to guess the domain by parsing the paths
#'   argument. Note however, that these are educated guesses which might utterly
#'   fail. To be on the save side, provide appropriate domains manually.
#' @param bot name of the bot, defaults to "*"
#' @param paths paths for which to check bot's permission, defaults to "/". Please, note that path to a folder should end with a trailing slash ("/").
#' @param check_method at the moment only kept for backward compatibility reasons - do not use parameter anymore --> will let the function simply use the default
#' @param robotstxt_list either NULL -- the default -- or a list of character
#'                       vectors with one vector per path to check
#'
#' @inheritParams rt_request_handler
#'
#' @inheritParams get_robotstxt
#' @inheritParams get_robotstxts
#'
#'
#' @export
paths_allowed <-
  function(
    paths                     = "/",
    domain                    = "auto",
    bot                       = "*",
    user_agent                = utils::sessionInfo()$R.version$version.string,
    check_method              = c("spiderbar"),
    warn                      = TRUE,
    force                     = FALSE,
    ssl_verifypeer            = c(1,0),
    use_futures               = TRUE,
    robotstxt_list            = NULL,
    rt_request_handler        = robotstxt::rt_request_handler,
    rt_robotstxt_http_getter  = robotstxt::get_robotstxt_http_get,
    on_server_error           = c("disallow", "error", "do_not_cache"),
    on_client_error           = c("allow",    "warn",  "cache"),
    on_not_found              = c("allow",    "warn",  "cache"),
    on_redirect               = c("allow",    "warn",  "cache"),
    on_domain_change          = c("allow",    "warn",  "cache"),
    on_file_type_mismatch     = c("allow",    "warn",  "cache"),
    on_suspect_content        = c("allow",    "warn",  "cache")
  ){

    # process inputs
    if( all(domain == "auto") ){
      domain <- guess_domain(paths)
      paths  <- remove_domain(paths)
    }

    if( all(is.na(domain)) & !is.null(robotstxt_list) ){
      domain <- "auto"
    }

    # get robots.txt files
    if( is.null(robotstxt_list) ){
      robotstxt_list <-
        get_robotstxts(
          domain                    = domain,
          warn                      = warn,
          force                     = force,
          user_agent                = user_agent,
          ssl_verifypeer            = ssl_verifypeer,
          use_futures               = use_futures,
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
      names(robotstxt_list) <- domain
    }

    # check paths
    if ( check_method[1] == "robotstxt"){
      warning(
        "
        This check method is deprecated,
        please stop using it -
        use 'spiderbar' instead
        or do not specify check_method parameter at all.
        "
      )
    }
    res <-
        paths_allowed_worker_spiderbar(
          domain         = domain,
          bot            = bot,
          paths          = paths,
          robotstxt_list = robotstxt_list
        )

    # return
    return(res)
  }

























