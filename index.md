# censusxy <img src="man/figures/logo.png" align="right" />

[![R build
status](https://github.com/chris-prener/censusxy/workflows/R-CMD-check/badge.svg)](https://github.com/chris-prener/censusxy/actions)
[![Coverage
status](https://codecov.io/gh/chris-prener/censusxy/branch/master/graph/badge.svg)](https://codecov.io/github/chris-prener/censusxy?branch=main)
[![CRAN\_status\_badge](https://www.r-pkg.org/badges/version/censusxy)](https://cran.r-project.org/package=censusxy)
[![cran
checks](https://badges.cranchecks.info/worst/censusxy.svg)](https://cran.r-project.org/web/checks/check_results_censusxy.html)
[![Downloads](https://cranlogs.r-pkg.org/badges/censusxy?color=brightgreen)](https://www.r-pkg.org/pkg/censusxy)
[![DOI](https://zenodo.org/badge/165924122.svg)](https://zenodo.org/badge/latestdoi/165924122)

The `censusxy` package is designed to provide easy access to the [U.S. Census Bureau Geocoding Tools](https://geocoding.geo.census.gov/geocoder/) in `R`. `censusxy` has also been developed specifically with large data sets in mind - only unique addresses are passed to the API for geocoding. If a data set exceeds 1,000 unique addresses, it will be automatically subset into appropriately sized API calls, geocoded, and then put back together so that a single object is returned. There is also support for parallel processing of requests, which can significantly shorten the time it takes to batch geocode large numbers of addresses.

`censusxy` is described in a 2021 paper in [*Transactions in GIS*](https://onlinelibrary.wiley.com/doi/abs/10.1111/tgis.12741) by Chris and Branson - please cite the paper if you use `censusxy` in your work!

## Installation
### Installing censusxy
The easiest way to get `censusxy` is to install it from CRAN:

```r
install.packages("censusxy")
```

Alternatively, the development version of `censusxy` can be accessed from GitHub with `remotes`:

```r
# install.packages("remotes")
remotes::install_github("chris-prener/censusxy")
```

### Installing Suggested Dependencies
Since the package does not need `sf` for its basic functionality, it is a suggested dependency rather than a required one. However, many users will want to map these data as `sf` objects, and we therefore recommend users install `sf`. Windows and macOS users should be able to install `sf` without significant issues unless they are building from source. Linux users will need to install several open source spatial libraries to get `sf` itself up and running. 

If you want to use these `sf`, you can either install it individually (faster) or install all of the suggested dependencies at once (slower, will also give you a number of other packages you may or may not want):

```r
## install sf only
install.packages("sf")

## install all suggested dependencies
install.packages("censusxy", dependencies = TRUE)
```

## Resources

The main [Get started](articles/censusxy.html) article has:

-   some tips on using `censusxy` in different workflows
-   an overview of the package’s functionality,
-   and considerations for handling computer timeout.

## Contributor Code of Conduct
Please note that this project is released with a [Contributor Code of Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
