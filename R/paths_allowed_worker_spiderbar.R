

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
          spiderbar::can_fetch(
            obj        = spiderbar::robxp(robotstxt),
            path       = path,
            user_agent = bot
          )
        }
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


