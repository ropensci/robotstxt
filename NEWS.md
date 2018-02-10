NEWS robotstxt
==========================================================================


0.6.0 | 2018-02-10
--------------------------------------------------------------------------

- **change/fix** check function paths_allowed() would not return correct result in some edge cases, indicating that spiderbar/rep-cpp check method is more reliable and shall be the default and only  method: [see 1](https://github.com/ropenscilabs/robotstxt/issues/22), [see 2](https://github.com/hrbrmstr/spiderbar/issues/2), [see 3](https://github.com/seomoz/rep-cpp/issues/33)




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





