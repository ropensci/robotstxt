rtxt <- "# robots.txt zu http://www.example.org/\n\nUser-agent: UniversalRobot/1.0\nUser-agent: mein-Robot\nDisallow: /quellen/dtd/\n\nUser-agent: *\nDisallow: /unsinn/\nDisallow: /temp/\nDisallow: /newsticker.shtml"


paths_allowed(
  paths          = "/temp/some_file.txt",
  robotstxt_list = list(rtxt),
  check_method   = "spiderbar",
  bot            = "*"
)
## FALSE


paths_allowed(
  paths          = "/temp/some_file.txt",
  robotstxt_list = list(rtxt),
  check_method   = "spiderbar",
  bot            = "mein-Robot"
)
### TRUE


paths_allowed(
  paths          = "/temp/some_file.txt",
  robotstxt_list = list(rtxt),
  check_method   = "robotstxt",
  bot            = "*"
)
## FALSE


paths_allowed(
  paths          = "/temp/some_file.txt",
  robotstxt_list = list(rtxt),
  check_method   = "robotstxt",
  bot            = "mein-Robot"
)
## TRUE

