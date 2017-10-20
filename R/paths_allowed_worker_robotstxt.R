#' paths_allowed_worker for robotstxt flavor
#'
#' @inheritParams paths_allowed
#' @param permissions_list list of permissions from robotstxt objects

paths_allowed_worker_robotstxt <-
  function(
    domain,
    bot,
    paths,
    permissions_list
  ){
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
        permissions = permissions_list,
        bot         = bot,
        domain      = domain
      )
    names(tmp) <- NULL

    # return
    return(tmp)
  }

