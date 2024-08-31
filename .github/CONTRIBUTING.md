# Contributing[^1]

Development is a community effort, and we welcome participation.

## Code of Conduct

Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). 

## Issues

[Issues](https://github.com/ropensci/robotstxt/issues) are for maintenance, tasks, and feature requests.

## Development

External code and documentation contributions are extremely helpful in the right circumstances. Here are the recommended steps.

1. Prior to contribution, please propose your idea in a discussion thread so you and the maintainer can define the intent and scope of your work.

1. [Fork the repository](https://help.github.com/articles/fork-a-repo/).

1. Follow the [GitHub flow](https://guides.github.com/introduction/flow/index.html) to create a new branch, add commits, and open a pull request.

1. Discuss your code with the maintainer in the pull request thread.

1. If everything looks good, the maintainer will merge your code into the project.

Please also follow these additional guidelines.

* Respect the architecture and reasoning of the package. Depending on the scope of your work, you may want to read the design documents (package vignettes).
* If possible, keep contributions small enough to easily review manually. It is okay to split up your work into multiple pull requests.
* For new features or functionality, add tests in `tests`.
* Check code coverage with `covr::package_coverage()`. Automated tests should cover all the new or changed functionality in your pull request.
* Run overall package checks with `devtools::check()`.
* Describe your contribution in the project's [`NEWS.md`](https://github.com/ropensci/robotstxt/blob/master/NEWS.md) file. Be sure to mention relevent GitHub issue numbers and your GitHub name as done in existing news entries.
* If you feel contribution is substantial enough for official author or contributor status, please add yourself to the `Authors@R` field of the [`DESCRIPTION`](https://github.com/ropensci/robotstxt/blob/master/DESCRIPTION) file.

[^1] This `CONTRIBUTING` file is modified from [ropensci/targets](https://github.com/ropensci/targets/blob/main/CONTRIBUTING.md).
