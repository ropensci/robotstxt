library(robotstxt)

user_agent <-
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36"

robotstxt("facebook.com", user_agent = user_agent)


paths_allowed("/", "https://facebook.com/", bot = "*")

paths_allowed("/", "https://facebook.com/", bot = "*", user_agent = user_agent)
