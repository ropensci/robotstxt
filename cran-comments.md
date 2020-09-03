This is a re-submission.

## Your comments

You still have not followed the moved content in

   Found the following (possibly) invalid URLs:
     URL: https://contributor-covenant.org/ (moved to
https://www.contributor-covenant.org/)
       From: README.md
       Status: 200
       Message: OK
     URL: https://contributor-covenant.org/version/1/0/0/ (moved to
https://www.contributor-covenant.org/version/1/0/0/)
       From: README.md
       Status: 200
       Message: OK

Please fix and resubmit.




## My actions

I changed the URLs.

Sorry, that this is such a mess - I am really trying to get them fixed and
minimize workload on behalf of CRAN. 

(HTTP 301 forwards are however also a very common in the ever changing internet 
and in contrast to 4xx and 5xx HTTP status codes no errors as such - 
"301 moved permanetly" can mean anything really including any kind of 
redirect for any reason. 
It would be great if those test would be 
part of the normal R CMD check?. ...So I (and all the others) 
can fetch them locally or via the CI pipelines set up and ready to catch problems 
beforhand). 





## Test environments

- Ubuntu precise (16.04) (on travis-ci: old, current, devel; https://travis-ci.org/github/ropensci/robotstxt ) --> OK

- Win10 lokal with R 3.6.3 --> OK
- win-builder   - devel    --> OK
- win-builder   - release  --> OK


## R CMD check results

0 errors | 0 warnings | 0 notes



## Reverse Dependency Checks

Seems ok.



