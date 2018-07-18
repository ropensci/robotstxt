## Comment

- minor package update to work with newer versions of import packages (future > 1.8.1)


## Test environments

- Ubuntu precise (14.04.5 LTS) (on travis-ci: old, current, devel; https://travis-ci.org/ropenscilabs/robotstxt) --> OK

- Win10 lokal with R old --> OK
- win-builder - devel    --> OK


## R CMD check results

0 errors | 0 warnings | 0 notes



## Reverse Dependency Checks

Seems ok.


$revdeps
NULL

$platform
 setting  value                       
 version  R version 3.4.4 (2018-03-15)
 system   x86_64, mingw32             
 ui       RStudio (1.1.453)           
 language (EN)                        
 collate  German_Germany.1252         
 tz       Europe/Berlin               
 date     2018-07-18                  

$dependencies
 package      * version date       source                       
 covr           3.1.0   2018-05-18 CRAN (R 3.4.4)               
 dplyr          0.7.6   2018-06-29 CRAN (R 3.4.4)               
 future         1.8.1   2018-05-03 CRAN (R 3.4.4)               
 future.apply   1.0.0   2018-06-20 CRAN (R 3.4.4)               
 httr           1.3.1   2017-08-20 CRAN (R 3.4.4)               
 knitr          1.20    2018-02-20 CRAN (R 3.4.4)               
 magrittr       1.5     2014-11-22 CRAN (R 3.4.4)               
 rmarkdown      1.10    2018-06-11 CRAN (R 3.4.4)               
 robotstxt      0.6.2   2018-07-18 local (ropensci/robotstxt@NA)
 spiderbar      0.2.1   2017-11-17 CRAN (R 3.4.4)               
 stringr        1.3.1   2018-05-10 CRAN (R 3.4.4)               
 testthat       2.0.0   2017-12-13 CRAN (R 3.4.4)               

$results
$results$spiderbar
## spiderbar (0.2.1)
Maintainer: Bob Rudis <bob@rud.is>  
Bug reports: https://github.com/hrbrmstr/spiderbar/issues

0 errors | 0 warnings | 1 note 

```
checking compiled code ... NOTE
File 'spiderbar/libs/x64/spiderbar.dll':
  Found no calls to: 'R_registerRoutines', 'R_useDynamicSymbols'

It is good practice to register native routines and to disable symbol
search.

See 'Writing portable packages' in the 'Writing R Extensions' manual.
```



