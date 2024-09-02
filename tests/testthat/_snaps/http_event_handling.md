# non www redirects are handled non silently

    Code
      domain_change <- readRDS(system.file("http_requests/http_domain_change.rds",
        package = "robotstxt"))
      suppressMessages(get_robotstxt("http://google.com", rt_robotstxt_http_getter = function(
        ...) {
        domain_change
      }, warn = TRUE))
    Condition
      Warning in `request_handler_handler()`:
      Event: on_file_type_mismatch
      Warning in `request_handler_handler()`:
      Event: on_suspect_content
    Output
      [robots.txt]
      --------------------------------------
      
      # robots.txt overwrite by: on_suspect_content
      
      User-agent: *
      Allow: /
      
      
      
      [events]
      --------------------------------------
      
      requested:   www.petermeissner.de 
      downloaded:  https://petermeissner.de/ 
      
      $on_redirect
      $on_redirect[[1]]
      $on_redirect[[1]]$status
      [1] 301
      
      $on_redirect[[1]]$location
      [1] "https://www.petermeissner.de/"
      
      
      $on_redirect[[2]]
      $on_redirect[[2]]$status
      [1] 301
      
      $on_redirect[[2]]$location
      [1] "https://petermeissner.de/"
      
      
      $on_redirect[[3]]
      $on_redirect[[3]]$status
      [1] 200
      
      $on_redirect[[3]]$location
      NULL
      
      
      
      $on_file_type_mismatch
      $on_file_type_mismatch$content_type
      [1] "text/html"
      
      
      $on_suspect_content
      $on_suspect_content$parsable
      [1] FALSE
      
      $on_suspect_content$content_suspect
      [1] TRUE
      
      
      [attributes]
      --------------------------------------
      
      problems, cached, request, class

# client error

    Code
      http_client_error <- readRDS(system.file("http_requests/http_client_error.rds",
        package = "robotstxt"))
      suppressMessages(get_robotstxt("httpbin.org", rt_robotstxt_http_getter = function(
        ...) {
        http_client_error
      }))
    Condition
      Warning in `request_handler_handler()`:
      Event: on_client_error
      Warning in `request_handler_handler()`:
      Event: on_file_type_mismatch
    Output
      [robots.txt]
      --------------------------------------
      
      # robots.txt overwrite by: on_client_error
      
      User-agent: *
      Allow: /
      
      
      
      [events]
      --------------------------------------
      
      requested:   https://httpbin.org/status/400 
      downloaded:  https://httpbin.org/status/400 
      
      $on_client_error
      $on_client_error$status_code
      [1] 400
      
      
      $on_file_type_mismatch
      $on_file_type_mismatch$content_type
      [1] "text/html; charset=utf-8"
      
      
      [attributes]
      --------------------------------------
      
      problems, cached, request, class

# server error

    Code
      res <- suppressMessages(get_robotstxt("httpbin.org", rt_robotstxt_http_getter = f,
        on_server_error = list(signal = "warning"), force = TRUE))
    Condition
      Warning in `request_handler_handler()`:
      Event: on_server_error
      Warning in `request_handler_handler()`:
      Event: on_file_type_mismatch

