% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/paths_allowed_worker_spiderbar.R
\name{paths_allowed_worker_spiderbar}
\alias{paths_allowed_worker_spiderbar}
\title{Check if a spiderbar bot has permissions to access page(s)}
\usage{
paths_allowed_worker_spiderbar(domain, bot, paths, robotstxt_list)
}
\arguments{
\item{domain}{Domain for which paths should be checked. Defaults to "auto".
If set to "auto" function will try to guess the domain by parsing the paths
argument. Note however, that these are educated guesses which might utterly
fail. To be on the safe side, provide appropriate domains manually.}

\item{bot}{name of the bot, defaults to "*"}

\item{paths}{paths for which to check bot's permission, defaults to "/". Please note that path to a folder should end with a trailing slash ("/").}

\item{robotstxt_list}{either NULL -- the default -- or a list of character
vectors with one vector per path to check}
}
\description{
Check if a spiderbar bot has permissions to access page(s)
}
