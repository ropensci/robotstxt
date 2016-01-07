# README
Peter Meißner  
`r Sys.time()`  

# STATUS: 

**UNDER DEVELOPMENT**





# Installation and Start


```r
devtools::install_github("petermeissner/robotstxt")
```



# Documentation


```r
?robotstxt
```

# Example Usage 

Loading the package and dplyr/magrittr for neater code  ... 


```r
library(robotstxt)
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

## The Object Oriented Style

Initializing a new instance of the robotstxt class ... 

```r
rt_wikipedia <- robotstxt$new(domain="wikipedia.org")

rt_wikipedia
```

```
## <robotstxt>
##   Public:
##     bots: Mediapartners-Google* IsraBot Orthogaffe UbiCrawler DOC  ...
##     check: function
##     clone: function
##     domain: wikipedia.org
##     initialize: function
##     other: data.frame
##     permissions: data.frame
##     sitemap: data.frame
##     text: #
##     # robots.txt for http://www.wikipedia.org/ and friends ...
```


Having a look a some fields (the data stored inside the object) ... 

... the domain for which the permissions apply ... 


```r
rt_wikipedia$domain
```

```
## [1] "wikipedia.org"
```

... the actual text of the robots.txt file ... 


```r
rt_wikipedia$text %>% 
  substring(1, 400) 
```

```
## #
## # robots.txt for http://www.wikipedia.org/ and friends
## #
## # Please note: There are a lot of pages on this site, and there are
## # some misbehaved spiders out there that go _way_ too fast. If you're
## # irresponsible, your access to the site may be blocked.
## #
## 
## # advertising-related bots:
## User-agent: Mediapartners-Google*
## Disallow: /
## 
## # Wikipedia work bots:
## User-agent: IsraBot
## Disallow:
## 
## User-agent: Or
```

... bots mentioned by name ...


```r
rt_wikipedia$bots
```

```
##  [1] "Mediapartners-Google*"      "IsraBot"                   
##  [3] "Orthogaffe"                 "UbiCrawler"                
##  [5] "DOC"                        "Zao"                       
##  [7] "sitecheck.internetseer.com" "Zealbot"                   
##  [9] "MSIECrawler"                "SiteSnagger"               
## [11] "WebStripper"                "WebCopier"                 
## [13] "Fetch"                      "OfflineExplorer"           
## [15] "Teleport"                   "TeleportPro"               
## [17] "WebZIP"                     "linko"                     
## [19] "HTTrack"                    "Microsoft.URL.Control"     
## [21] "Xenu"                       "larbin"                    
## [23] "libwww"                     "ZyBORG"                    
## [25] "DownloadNinja"              "fast"                      
## [27] "wget"                       "grub-client"               
## [29] "k2spider"                   "NPBot"                     
## [31] "WebReaper"                  "ia_archiver"               
## [33] "*"
```

Checking if some any bot might access the root path ... 

```r
# checking for access permissions
rt_wikipedia$check(paths = c("/","*images/"), bot = "*")
```

```
##        / *images/ 
##    FALSE    FALSE
```

## The Functional Style

Retrieving robots.txt file ... 


```r
rtxt <- 
  get_robotstxt("wikipedia.org") 

rtxt %>% 
  substring(1,400)
```

```
## #
## # robots.txt for http://www.wikipedia.org/ and friends
## #
## # Please note: There are a lot of pages on this site, and there are
## # some misbehaved spiders out there that go _way_ too fast. If you're
## # irresponsible, your access to the site may be blocked.
## #
## 
## # advertising-related bots:
## User-agent: Mediapartners-Google*
## Disallow: /
## 
## # Wikipedia work bots:
## User-agent: IsraBot
## Disallow:
## 
## User-agent: Or
```


... parsing robots.txt file more general ... 


```r
parsed_rtxt <- 
  rtxt %>% 
  parse_robotstxt() 

names(parsed_rtxt)
```

```
## [1] "useragents"  "comments"    "permissions" "crawl_delay" "sitemap"    
## [6] "host"        "other"
```

... permissions ... 


```r
permissions <- 
  parsed_rtxt$permissions
```


... and checking permissions ... 


```r
permissions %>% 
  paths_allowed(paths=c("/","*images/"), bot="*")
```

```
##        / *images/ 
##    FALSE    FALSE
```














