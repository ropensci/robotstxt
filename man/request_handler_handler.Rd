% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/request_handler_handler.R
\name{request_handler_handler}
\alias{request_handler_handler}
\title{Handle robotstxt handlers}
\usage{
request_handler_handler(request, handler, res, info = TRUE, warn = TRUE)
}
\arguments{
\item{request}{the request object returned by call to httr::GET()}

\item{handler}{the handler either a character string entailing various options or a function producing a specific list, see return.}

\item{res}{a list with elements '[handler names], ...', 'rtxt', and 'cache'}

\item{info}{info to add to problems list}

\item{warn}{if FALSE warnings and messages are suppressed}
}
\value{
a list with elements '[handler name]', 'rtxt', and 'cache'
}
\description{
Helper function to handle robotstxt handlers.
}
