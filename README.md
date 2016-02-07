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
<td><a href="http://cran.r-project.org/package=robotstxt"><img src="http://www.r-pkg.org/badges/version/robotstxt"></a></td></tr>
<tr>
<td>Downloads from <a href='http://cran.rstudio.com/'>CRAN.RStudio</a>&nbsp;&nbsp;&nbsp;</td>
<td><img src="http://cranlogs.r-pkg.org/badges/grand-total/robotstxt"></td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>




**Author:** Peter Meißner

**Contributer:** Oliver Keys (code review)

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

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms: http://contributor-covenant.org/version/1/0/0/








