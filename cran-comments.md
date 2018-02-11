## Test environments

- Ubuntu precise (14.04.5 LTS) (on travis-ci: old, current, devel; https://travis-ci.org/ropenscilabs/robotstxt) --> OK

- Win10 lokal with R current --> OK

- win-builder - devel --> OK


## R CMD check results

0 errors | 0 warnings | 0 notes





## Checks for Reverse Dependencies -> all ok 




$revdeps
NULL

$platform
 setting  value                       
 version  R version 3.4.3 (2017-11-30)
 system   x86_64, mingw32             
 ui       RStudio (1.1.419)           
 language (EN)                        
 collate  German_Germany.1252         
 tz       Europe/Berlin               
 date     2018-02-11                  

$dependencies
 package   * version date       source                           
 covr        3.0.1   2017-11-07 CRAN (R 3.4.3)                   
 dplyr       0.7.4   2017-09-28 CRAN (R 3.4.3)                   
 future      1.6.2   2017-10-16 CRAN (R 3.4.3)                   
 httr        1.3.1   2017-08-20 CRAN (R 3.4.3)                   
 knitr       1.19    2018-01-29 CRAN (R 3.4.3)                   
 magrittr    1.5     2014-11-22 CRAN (R 3.4.3)                   
 rmarkdown   1.8     2017-11-17 CRAN (R 3.4.3)                   
 robotstxt * 0.6.0   2018-02-11 local (ropenscilabs/robotstxt@NA)
 spiderbar   0.2.1   2017-11-17 CRAN (R 3.4.3)                   
 stringr     1.2.0   2017-02-18 CRAN (R 3.4.3)                   
 testthat    2.0.0   2017-12-13 CRAN (R 3.4.3)                   




$results
$results$seoR
## seoR (0.1.0)
Maintainer: Daniel Schmeh <danielschmeh@gmail.com>

0 errors | 0 warnings | 0 notes



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
