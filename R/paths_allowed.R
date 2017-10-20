#' check if a bot has permissions to access page(s)
#'
#' wrapper to \code{\link{path_allowed}}
#' @param domain Domain for which paths should be checked. Defaults to "auto".
#'   If set to "auto" function will try to guess the domain by parsing the paths
#'   argument. Note however, that these are educated guesses which might utterly
#'   fail. To be on the save side, provide appropriate domains manually.
#' @param bot name of the bot, defaults to "*"
#' @param paths paths for which to check bot's permission, defaults to "/"
#' @param check_method which method to use for checking -- either robotstxt for
#'                     the package's own method or spiderbar for using spiderbar::can_fetch
#'
#' @inheritParams get_robotstxt
#'
#' @seealso \link{path_allowed}
#'
#' @export
paths_allowed <-
  function(
    paths        = "/",
    domain       = "auto",
    bot          = "*",
    user_agent   = NULL,
    check_method = c("spiderbar", "robotstxt"),
    warn         = TRUE,
    force        = FALSE
  ){

    # process inputs
    if( all(domain == "auto") ){
      domain <- guess_domain(paths)
      paths  <- remove_domain(paths)
    }

    if( length(unique(domain))==1 ){
      domain <- domain[1]
    }


    # check paths
    res <-
      if ( check_method[1] == "spiderbar"){

        paths_allowed_worker_spiderbar(
          user_agent = user_agent,
          domain     = domain,
          bot        = bot,
          paths      = paths
        )

      } else {

        paths_allowed_worker_robotstxt(
          user_agent = user_agent,
          domain     = domain,
          bot        = bot,
          paths      = paths
        )

      }


    # return
    return(res)
  }


#' paths_allowed_worker for robotstxt flavor
#'
#' @inheritParams paths_allowed
#'

paths_allowed_worker_robotstxt <-
  function(
    user_agent,
    domain,
    bot,
    paths
  ){
    # get permissions
    permissions <-
      if ( length(user_agent) == 0 ) {

        mapply(

          FUN =
            function(domain, user_agent){
              robotstxt(
                domain     = domain,
                warn       = TRUE,
                force      = FALSE
              )$permissions
            },

          domain     = domain,

          SIMPLIFY   = FALSE
        )

      }else{

        mapply(

          FUN =
            function(domain, user_agent){
              robotstxt(
                domain     = domain,
                user_agent = user_agent,
                warn       = TRUE,
                force      = FALSE
              )$permissions
            },

          domain     = domain,
          user_agent = user_agent,

          SIMPLIFY   = FALSE
        )

      }


    # apply permission checker to permission data
    worker <-
      function(path, permissions, bot, domain){
        if( is.na(domain) ){
          return(NA)
        }else{
          path_allowed(
            permissions = permissions,
            path        = path,
            bot         = bot
          )
        }
      }

    tmp <-
      mapply(
        worker,
        path        = paths,
        permissions = permissions,
        bot         = bot,
        domain      = domain
      )
    names(tmp) <- NULL

    # return
    return(tmp)
  }



#' paths_allowed_worker spiderbar flavor
#'
#' @inheritParams paths_allowed
#'
paths_allowed_worker_spiderbar <-
  function(
    user_agent,
    domain,
    bot,
    paths
  ){

    browser()

    permissions <-
      if ( length(user_agent) == 0 ) {

        mapply(

          FUN =
            function(domain, user_agent){
              robotstxt(
                domain     = domain,
                warn       = TRUE,
                force      = FALSE
              )$permissions
            },

          domain     = domain,

          SIMPLIFY   = FALSE
        )

      }else{

        mapply(

          FUN =
            function(domain, user_agent){
              robotstxt(
                domain     = domain,
                user_agent = user_agent,
                warn       = TRUE,
                force      = FALSE
              )$permissions
            },

          domain     = domain,
          user_agent = user_agent,

          SIMPLIFY   = FALSE
        )

      }

    rbt_text <-
      get_robotstxt(
        domain     = domain[1],
        user_agent = user_agent
      )

    spiderbar::can_fetch(
      obj        = spiderbar::robxp(rbt_text),
      path       = paths[1],
      user_agent = bot
    )
  }


