library(testthat)
if(curl::has_internet()){
  test_check("robotstxt")
}
