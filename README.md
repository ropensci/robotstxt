# README
Peter Meißner  
`r Sys.time()`  

![](logo/robotstxt.png)


<table>
<tr>
<td> Ubuntu build </td>
<td> <a href="https://travis-ci.org/ropenscilabs/robotstxt"><img src="https://api.travis-ci.org/ropenscilabs/robotstxt.svg?branch=master"></a></td>
</tr>
<tr><td>Version on CRAN  </td> 
<td><a href="https://cran.r-project.org/package=robotstxt"><img src="http://www.r-pkg.org/badges/version/robotstxt"></a></td></tr>
<tr>
<td>Downloads from <a href='https://cran.rstudio.com/'>CRAN.RStudio</a>&nbsp;&nbsp;&nbsp;</td>
<td><img src="http://cranlogs.r-pkg.org/badges/grand-total/robotstxt"></td>
</tr>
</table>


**Status:** Feature complete and part of the [ROpenSci](https://github.com/ropenscilabs) network.

**Author:** Peter Meißner

**Contributer:** Oliver Keys (code review and improvements), Rich FitzJohn (code review and improvements)

**Licence:** MIT

**Description:**

The robotstxt package provides functions to download and parse robots.txt files. 
Ultimatly the package makes it easy to check if bots (spiders, scrapers, ...) are allowed to access specific resources on a domain. 



**Installation and start - stable version**


```r
install.packages("robotstxt")
library(robotstxt)
```


**Installation and start - development version**


```r
devtools::install_github("petermeissner/robotstxt")
library(robotstxt)
```


**Robotstxt class documentation**


```r
?robotstxt
```

**Usage**


```r
library(robotstxt)

paths_allowed(
  paths  = c("/api/rest_v1/?doc", "/w/"), 
  domain = "wikipedia.org", 
  bot    = "*"
)
```

```
## [1]  TRUE FALSE
```

```r
paths_allowed(
  paths = c(
    "https://wikipedia.org/api/rest_v1/?doc", 
    "https://wikipedia.org/w/"
  )
)
```

```
## [1]  TRUE FALSE
```

... or use it that way ...


```r
library(robotstxt)

rtxt <- robotstxt(domain = "wikipedia.org")
rtxt$check(paths = c("/api/rest_v1/?doc", "/w/"), bot= "*")
```

```
## /api/rest_v1/?doc               /w/ 
##              TRUE             FALSE
```


**More information**

[vignette](http://cran.r-project.org/package=robotstxt/vignettes/using_robotstxt.html)



**Contribution - AKA The-Think-Twice-Be-Nice-Rule**

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms:

> As contributors and maintainers of this project, we pledge to respect all people who 
contribute through reporting issues, posting feature requests, updating documentation,
submitting pull requests or patches, and other activities.
> 
> We are committed to making participation in this project a harassment-free experience for
everyone, regardless of level of experience, gender, gender identity and expression,
sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.
> 
> Examples of unacceptable behavior by participants include the use of sexual language or
imagery, derogatory comments or personal attacks, trolling, public or private harassment,
insults, or other unprofessional conduct.
> 
> Project maintainers have the right and responsibility to remove, edit, or reject comments,
commits, code, wiki edits, issues, and other contributions that are not aligned to this 
Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed 
from the project team.
> 
> Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by 
opening an issue or contacting one or more of the project maintainers.
> 
> This Code of Conduct is adapted from the Contributor Covenant 
(http:contributor-covenant.org), version 1.0.0, available at 
http://contributor-covenant.org/version/1/0/0/








