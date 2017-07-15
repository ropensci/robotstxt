NEWS robotstxt
==========================================================================

0.4.0 | 2017-07-14
--------------------------------------------------------------------------

- user_agent parameter added to tobotstxt() and paths_allowed to allow for user defined HTTP user-agent send when retrieving robots.txt file from domain


0.3.4 | 2017-07-08
--------------------------------------------------------------------------

- fix : non robots.txt files (e.g. html files returned by server instead of 
the requested robots.txt / facebook.com) would be handled as if it were non 
existent / empty files 
- fix : UTF-8 encoded robots.txt with BOM (byte order mark) would break parsing
although files were otherwise valid robots.txt files



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
- make explicit, less error prone usage of httr::content(rtxt) https://github.com/ropenscilabs/robotstxt#8
- replace usage of missing for parameter check with explicit NULL as default value for parameter https://github.com/ropenscilabs/robotstxt#9
- partial match useragent / useragents https://github.com/ropenscilabs/robotstxt#10
- explicit declaration encoding: encoding="UTF-8" in httr::content() https://github.com/ropenscilabs/robotstxt#11





version 0.1.2 // 2016-02-08 ...
--------------------------------------------------------------------------

- first feature complete version on CRAN
