library(spiderbar)
library(robotstxt)
library(future)

# get file with urls
urls_fname <- system.file("urls.txt", package="robotstxt")
readLines(urls_fname)[1:3]
urls <- readLines(urls_fname)[-c(1:5)][1:100]

paths <- urls
domain <- robotstxt:::guess_domain(paths)

# tests for sequential
plan("sequential")

with_fetch_seq <-
  system.time(
    paths_allowed(
      urls,
      warn         = FALSE,
      force        = TRUE,
      use_futures  = FALSE,
      check_method = "robotstxt"
    )
  )

wo_fetch_seq_robotstxt <-
  system.time(
    paths_allowed(
      urls,
      warn         = FALSE,
      force        = FALSE,
      use_futures  = FALSE,
      check_method = "robotstxt"
    )
  )

wo_fetch_seq_spiderbar <-
  system.time(
    paths_allowed(
      urls,
      warn         = FALSE,
      force        = FALSE,
      use_futures  = FALSE,
      check_method = "spiderbar"
    )
  )


# tests for parallel
plan("multisession")

with_fetch_parallel <-
  system.time(
    paths_allowed(
      urls,
      warn         = FALSE,
      force        = TRUE,
      use_futures  = TRUE,
      check_method = "robotstxt"
    )
  )

wo_fetch_parallel_robotstxt <-
  system.time(
    paths_allowed(
      urls,
      warn         = FALSE,
      force        = FALSE,
      use_futures  = TRUE,
      check_method = "robotstxt"
    )
  )

wo_fetch_parallel_spiderbar <-
  system.time(
    paths_allowed(
      urls,
      warn         = FALSE,
      force        = FALSE,
      use_futures  = TRUE,
      check_method = "spiderbar"
    )
  )




# results

with_fetch_seq
wo_fetch_seq_robotstxt
wo_fetch_seq_spiderbar


with_fetch_parallel
wo_fetch_parallel_robotstxt
wo_fetch_parallel_spiderbar


with_fetch_seq
with_fetch_parallel


wo_fetch_seq_robotstxt
wo_fetch_parallel_robotstxt


wo_fetch_seq_spiderbar
wo_fetch_parallel_spiderbar


