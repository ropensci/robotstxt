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
## Die folgenden Objekte sind maskiert von 'package:stats':
## 
##     filter, lag
## 
## Die folgenden Objekte sind maskiert von 'package:base':
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
  rt_get_robotstxt("wikipedia.org") 

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

... extracting permissions ... 


```r
rtxt %>% 
  rt_get_permissions() %>% 
  slice(1:10)
```

```
##                     useragent permission value
## 1       Mediapartners-Google*   Disallow     /
## 2                     IsraBot   Disallow      
## 3                  Orthogaffe   Disallow      
## 4                  UbiCrawler   Disallow     /
## 5                         DOC   Disallow     /
## 6                         Zao   Disallow     /
## 7  sitecheck.internetseer.com   Disallow     /
## 8                     Zealbot   Disallow     /
## 9                 MSIECrawler   Disallow     /
## 10                SiteSnagger   Disallow     /
```

... parsing robots.txt file more general ... 


```r
rtxt %>% 
  parse_robotstxt() %>% 
  lapply(head, 2)
```

```
## $useragents
## [1] "Mediapartners-Google*" "IsraBot"              
## 
## $comments
##   line                                                comment
## 1    1                                                      #
## 2    2 # robots.txt for http://www.wikipedia.org/ and friends
## 
## $permissions
##               useragent permission value
## 1 Mediapartners-Google*   Disallow     /
## 2               IsraBot   Disallow      
## 
## $sitemap
## [1] field value
## <0 rows> (or 0-length row.names)
## 
## $other
## [1] field value
## <0 rows> (or 0-length row.names)
```

... and checking permissions ... 


```r
rtxt %>% 
  rt_get_permissions() %>% 
  paths_allowed(paths=c("/","*images/"), bot="*")
```

```
##        / *images/ 
##    FALSE    FALSE
```














