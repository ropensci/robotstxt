#' check if a bot has permissions to access page(s)
#'
#' wrapper to \code{\link{path_allowed}}
#' @param domain Domain for which paths should be checked. Defaults to "auto".
#'   If set to "auto" function will try to guess the domain by parsing the paths
#'   argument. Note however, that these are educated guesses which might utterly
#'   fail. To be on the save side, provide appropriate domains manually.
#' @param bot name of the bot, defaults to "*"
#' @param paths paths for which to check bot's permission, defaults to "/"
#' @param check_method which method to use for checking -- either
#'                     "robotstxt" for the package's own method or "spiderbar"
#'                     for using spiderbar::can_fetch; note that at the current
#'                     state spiderbar is considered less accurate: the spiderbar
#'                     algorithm will only take into consideration rules for *
#'                     or a particular bot but does not merge rules together
#'                     (see: \code{paste0(system.file("robotstxts", package = "robotstxt"),"/selfhtml_Example.txt")})
#' @param robotstxt_list either NULL -- the default -- or a list of character
#'                       vectors with one vector per path to check
#'
#' @inheritParams get_robotstxt
#' @inheritParams get_robotstxts
#'
#' @seealso \link{path_allowed}
#'
#' @export
paths_allowed <-
  function(
    paths          = "/",
    domain         = "auto",
    bot            = "*",
    user_agent     = utils::sessionInfo()$R.version$version.string,
    check_method   = c("robotstxt", "spiderbar"),
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
    res <-
      if ( check_method[1] == "spiderbar"){

        paths_allowed_worker_spiderbar(
          domain         = domain,
          bot            = bot,
          paths          = paths,
          robotstxt_list = robotstxt_list
        )

      } else {

        if( use_futures ){
          permissions_list <-
            future::future_lapply(
              robotstxt_list,
              function(x){robotstxt(text=x)$permissions}
            )

        }else{
          permissions_list <-
            lapply(
              robotstxt_list,
              function(x){robotstxt(text=x)$permissions}
            )

        }

        paths_allowed_worker_robotstxt(
          domain           = domain,
          bot              = bot,
          paths            = paths,
          permissions_list = permissions_list
        )

      }


    # return
    return(res)
  }

























