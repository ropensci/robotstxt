# paths_allowed() works also with 'downloaded' robots.txt files

    Code
      domain_change <- readRDS(system.file("http_requests/http_domain_change.rds",
        package = "robotstxt"))
      suppressMessages(paths_allowed(paths = "https://github.io/index.html",
        rt_robotstxt_http_getter = function(...) {
          domain_change
        }, warn = FALSE))
    Output
      [1] TRUE

---

    Code
      domain_change <- readRDS(system.file("http_requests/http_domain_change.rds",
        package = "robotstxt"))
      suppressMessages(paths_allowed(paths = "https://github.io/index.html",
        rt_robotstxt_http_getter = function(...) {
          domain_change
        }))
    Condition
      Warning in `request_handler_handler()`:
      Event: on_domain_change
      Warning in `request_handler_handler()`:
      Event: on_file_type_mismatch
      Warning in `request_handler_handler()`:
      Event: on_suspect_content
    Output
      [1] TRUE

