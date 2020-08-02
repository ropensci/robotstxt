#' function that checks if file is valid / parsable robots.txt file
#'
#' @param text content of a robots.txt file provides as character vector
#' @param check_strickt_ascii whether or not to check if content does adhere to the specification of RFC to use plain text aka ASCII
#'
#' @export
#'
is_valid_robotstxt <- function(text, check_strickt_ascii = FALSE){
  text  <- unlist(strsplit(text, "\n"))


  # actually REF specifies files to be ASCII only
  # but one of the most frequently visited webpages worlld wide, namely wikipedia
  # does use UTF-8 within its robots.txt files
  if ( check_strickt_ascii ) {
    ascii <- text == "" | stringr::str_detect(pattern = "^[[:ascii:]]+$", string = text)
  } else {
    ascii <- rep(TRUE, length(text))
  }

  all(
    # allow :

      # - spaces followed by #
      grepl(
        pattern  = "^(\xef\xbb\xbf)*(\\s)*#",
        x        = text,
        useBytes = TRUE
      )   |

        # - spaces followed by letter(s) followed by a double dot (somewhere)
        stringr::str_detect(
          pattern = "^(\xef\xbb\xbf)*( )*([^\\[\\] ,;<>()@/?=\\{\\}\t\\\\])+( )*:",
          string  = text
        )  & ascii |

        # - spaces only or empty line
        grepl("^(\xef\xbb\xbf)*(\\s)*$", text, useBytes = TRUE) & ascii

  )
}


