# README
Peter Meißner  
`r Sys.time()`  

![](logo/robotstxt.png)


<table>
<tr><td>&nbsp;</td></tr>
<tr>
<td> Ubuntu build </td>
<td> <a href="https://travis-ci.org/petermeissner/robotstxt"><img src="https://api.travis-ci.org/petermeissner/robotstxt.svg?branch=master"></a></td>
</tr>
<tr><td>Version on CRAN  </td> 
<td><a href="https://cran.r-project.org/web/packages/robotstxt/index.html"><img src="http://www.r-pkg.org/badges/version/robotstxt"></a></td></tr>
<tr>
<td>Downloads from <a href='http://cran.rstudio.com/'>CRAN.RStudio</a>&nbsp;&nbsp;&nbsp;</td>
<td><img src="http://cranlogs.r-pkg.org/badges/grand-total/robotstxt"></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>


**Status:** feature complete, currently under code review by [ropensci](https://github.com/ropensci/onboarding/issues/25)

**Author:** Peter Meißner

**Licence:** MIT

**Description:**

The package provides a robotstxt class ('R6') and accompanying methods to
parse and check 'robots.txt' files. Data fields are provided as 
data frames and vectors. Permissions can be checked by providing
path character vectors and optional bot names. 



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
rtxt <- robotstxt$new(domain="wikipedia.org")
rtxt$check("/")
```

```
##     / 
## FALSE
```

**Contribution**

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








