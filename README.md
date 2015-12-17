# README
Peter Meißner  
`r Sys.time()`  



# Installation and Start


```r
devtools::install_github("petermeissner/robotstxt")
```



# Dokumentation


```r
?robotstxt
```

# Example Usage

Loading the package and magrittr for neater code  ... 


```r
library(robotstxt)
library(magrittr)
```

Initializing a new instance of the robotstxt class ... 

```r
rt_wikipedia <- robotstxt$new(domain="wikipedia.org")
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
  substring(1, 400) %>% 
  cat()
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
rt_wikipedia$check(path = "/", bot = "*")
```

```
## $`/`
## NULL
```

