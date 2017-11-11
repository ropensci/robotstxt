

#' paths_allowed_worker spiderbar flavor
#'
#' @inheritParams paths_allowed
#'
paths_allowed_worker_spiderbar <-
  function(
    domain,
    bot,
    paths,
    robotstxt_list
  ){


    # process inputs
    robotstxts <-
      unlist(lapply(robotstxt_list, paste, collapse="\n"))


    # apply permission checker to permission data
    worker <-
      function(path, robotstxt, domain, bot){
        if( is.na(domain) ){
          return(NA)
        }else{
          rtxt_obj <- spiderbar::robxp(robotstxt)

          bot_can_fetch <-
            spiderbar::can_fetch(
              obj        = rtxt_obj,
              path       = path,
              user_agent = bot
            )

          # star_can_fetch <-
          #   spiderbar::can_fetch(
          #     obj        = rtxt_obj,
          #     path       = path,
          #     user_agent = "*"
          #   )

          # return
          # if ( star_can_fetch == FALSE ) {
          #   return(FALSE)
          # }else{
          #   return(bot_can_fetch)
          # }
        }
        return(bot_can_fetch)
      }

    tmp <-
      mapply(
        worker,
        path        = paths,
        robotstxt   = robotstxts,
        bot         = bot,
        domain      = domain
      )

    names(tmp) <- NULL

    # return
    return(tmp)

  }


