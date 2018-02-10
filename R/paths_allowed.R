#' check if a bot has permissions to access page(s)
#'
#'
#' @param domain Domain for which paths should be checked. Defaults to "auto".
#'   If set to "auto" function will try to guess the domain by parsing the paths
#'   argument. Note however, that these are educated guesses which might utterly
#'   fail. To be on the save side, provide appropriate domains manually.
#' @param bot name of the bot, defaults to "*"
#' @param paths paths for which to check bot's permission, defaults to "/"
#' @param check_method at the moment only kept for backward compatibility reasons - do not use parameter anymore --> will let the function simply use the default
#' @param robotstxt_list either NULL -- the default -- or a list of character
#'                       vectors with one vector per path to check
#'
#' @inheritParams get_robotstxt
#' @inheritParams get_robotstxts
#'
#'
#' @export
paths_allowed <-
  function(
    paths          = "/",
    domain         = "auto",
    bot            = "*",
    user_agent     = utils::sessionInfo()$R.version$version.string,
    check_method   = c("spiderbar"),
    warn           = TRUE,
    force          = FALSE,
    ssl_verifypeer = c(1,0),
    use_futures    = TRUE,
    robotstxt_list = NULL
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
          domain,
          warn           = warn,
          force          = force,
          user_agent     = user_agent,
          ssl_verifypeer = ssl_verifypeer,
          use_futures    = use_futures
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

























