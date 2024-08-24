NEWS robotstxt
==========================================================================

0.7.15 | 2024-08-24
--------------------------------------------------------------------------

- CRAN compliance - Packages which use Internet resources should fail gracefully
- CRAN compliance - fix R CMD check NOTES.


0.7.14 | 2024-08-24
--------------------------------------------------------------------------

- CRAN compliance - Packages which use Internet resources should fail gracefully


0.7.13 | 2020-09-03
--------------------------------------------------------------------------

- CRAN compliance - prevent URL forwarding (HTTP 301): add www to URLs


0.7.12 | 2020-09-03
--------------------------------------------------------------------------

- CRAN compliance - prevent URL forwarding (HTTP 301): add trailing slashes to URLs



0.7.11 | 2020-09-02
--------------------------------------------------------------------------

- CRAN compliance - LICENCE file wording; prevent URL forwarding (HTTP 301)




0.7.10 | 2020-08-19
--------------------------------------------------------------------------

- fix problem in parse_robotstxt() - comment in last line of robots.txt file would lead to errornous parsing - reported by @gittaca, https://github.com/ropensci/robotstxt/pull/59 and https://github.com/ropensci/robotstxt/issues/60





0.7.9 | 2020-08-02
--------------------------------------------------------------------------

- fix problem is_valid_robotstxt() - robots.txt validity check was to lax - reported by @gittaca, https://github.com/ropensci/robotstxt/issues/58





0.7.8 | 2020-07-22
--------------------------------------------------------------------------

- fix problem with domain name extraction - reported by @gittaca, https://github.com/ropensci/robotstxt/issues/57
- fix problem with vArYING CasE in robots.txt field names - reported by @steffilazerte, https://github.com/ropensci/robotstxt/issues/55





0.7.7 | 2020-06-17
--------------------------------------------------------------------------

- fix problem in rt_request_handler - reported by @MHWauben https://github.com/dmi3kno/polite/issues/28 - patch by @dmi3kno





0.7.6 | 2020-06-13
--------------------------------------------------------------------------

- make info whether or not results were cached available - requested by @dmi3kno, https://github.com/ropensci/robotstxt/issues/53




0.7.5 | 2020-06-07
--------------------------------------------------------------------------

- **fix** passing through more parameters from robotstxt() to get_robotstxt() - reported and implemented by @dmi3kno





0.7.3 | 2020-05-29
--------------------------------------------------------------------------

- **minor** : improve printing of robots.txt
- add request data as attribute to robots.txt
- add `as.list()` method for robots.txt
- adding several paragrpahs to the README file
- **major** : finishing handlers - quality check, documentation
- **fix** : Partial matching warnings #51 - reported by @mine-cetinkaya-rundel





0.7.2 | 2020-05-04
--------------------------------------------------------------------------

- **minor** : changes in dependencies were introducing errors when no scheme/protocoll was provided in URL -- fixed https://github.com/ropensci/robotstxt/issues/50





0.7.1 | 2018-01-09
--------------------------------------------------------------------------

- **minor** : modifying robots.txt parser to be more robust against different formatting of robots.txt files -- fixed https://github.com/ropensci/robotstxt/issues/48





0.7.0 | 2018-11-27
--------------------------------------------------------------------------

- **major** : introducing http handler to allow for better interpretation of robots.txt files in case of certain events: redirects, server error, client error, suspicous content, ...



0.6.4 | 2018-09-14
--------------------------------------------------------------------------

- **minor** : pass through of parameter for content encoding 



0.6.3 | 2018-09-14
--------------------------------------------------------------------------

- **minor** : introduced parameter encoding to `get_robotstxt()` that defaults to "UTF-8" which does the content function anyways - but now it will not complain about it
- **minor** : added comment to help files specifying use of trailing slash in paths pointing to folders in `paths_allowed` and `robotstxt`.




0.6.2 | 2018-07-18
--------------------------------------------------------------------------

- **minor** : changed from `future::future_lapply()` to `future.apply::future_lapply()` to make package compatible with versions of future after 1.8.1




0.6.1 | 2018-05-30
--------------------------------------------------------------------------

- **minor** : package was moved to other repo location and project status badge was added



0.6.0 | 2018-02-10
--------------------------------------------------------------------------

- **change/fix** check function paths_allowed() would not return correct result in some edge cases, indicating that spiderbar/rep-cpp check method is more reliable and shall be the default and only  method: [see 1](https://github.com/ropensci/robotstxt/issues/22), [see 2](https://github.com/hrbrmstr/spiderbar/issues/2), [see 3](https://github.com/seomoz/rep-cpp/issues/33)




0.5.2 | 2017-11-12
--------------------------------------------------------------------------

- **fix** : rt_get_rtxt() would break on Windows due trying to readLines() from folder




0.5.1 | 2017-11-11
--------------------------------------------------------------------------

- **change** : spiderbar is now non-default second (experimental) check method
- **fix** : there were warnings in case of multiple domain guessing



0.5.0 | 2017-10-07
--------------------------------------------------------------------------

- **feature** : spiderbar's can_fetch() was added, now one can choose which check method to use for checking access rights 
- **feature** : use futures (from package future) to speed up retrieval and parsing
- **feature** : now there is a `get_robotstxts()` function wich is a 'vectorized' version of `get_robotstxt()`
- **feature** : `paths_allowed()` now allows checking via either robotstxt parsed robots.txt files or via functionality provided by the spiderbar package (the latter should be faster by approximatly factor 10)
- **feature** : various functions now have a ssl_verifypeer option (analog to CURL option https://curl.haxx.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html) which might help with robots.txt file retrieval in some cases
- **change** : user_agent for robots.txt file retrieval will now default to: `sessionInfo()$R.version$version.string` 
- **change** : robotstxt now assumes it knows how to parse --> if it cannot parse it assumes that it got no valid robots.txt file meaning that there are no restrictions
- **fix** : valid_robotstxt would not accept some actual valid robotstxt files



0.4.1 | 2017-08-20
--------------------------------------------------------------------------

- **restructure** : put each function in separate file
- **fix** : parsing would go bonkers for robots.txt of cdc.gov (e.g. combining all robots with all permissions) due to errornous handling of carriage return character (reported by @hrbrmstr - thanks)



0.4.0 | 2017-07-14
--------------------------------------------------------------------------

- **user_agent** parameter **added** to robotstxt() and paths_allowed to allow for user defined HTTP user-agent send when retrieving robots.txt file from domain



0.3.4 | 2017-07-08
--------------------------------------------------------------------------

- **fix** : non robots.txt files (e.g. html files returned by server instead of the requested robots.txt / facebook.com) would be handled as if it were non existent / empty files (reported by @simonmunzert - thanks)
- **fix** : UTF-8 encoded robots.txt with BOM (byte order mark) would break parsing although files were otherwise valid robots.txt files




0.3.3 | 2016-12-10
--------------------------------------------------------------------------

- updating NEWS file and switching to NEWS.md





0.3.2 | 2016-04-28 
--------------------------------------------------------------------------

- CRAN publication





0.3.1 | 2016-04-27 
--------------------------------------------------------------------------

- get_robotstxt() tests for HTTP errors and handles them, warnings might be suppressed while un-plausible HTTP status codes will lead to stoping the function https://github.com/ropenscilabs/robotstxt#5

- dropping R6 dependency and use list implementation instead https://github.com/ropenscilabs/robotstxt#6

- use caching for get_robotstxt() https://github.com/ropenscilabs/robotstxt#7 / https://github.com/ropenscilabs/robotstxt/commit/90ad735b8c2663367db6a9d5dedbad8df2bc0d23

- make explicit, less error prone usage of httr::content(rtxt) https://github.com/ropenscilabs/robotstxt#

- replace usage of missing for parameter check with explicit NULL as default value for parameter https://github.com/ropenscilabs/robotstxt#9

- partial match useragent / useragents https://github.com/ropenscilabs/robotstxt#10

- explicit declaration encoding: encoding="UTF-8" in httr::content() https://github.com/ropenscilabs/robotstxt#11





version 0.1.2 // 2016-02-08 ...
--------------------------------------------------------------------------

- first feature complete version on CRAN





