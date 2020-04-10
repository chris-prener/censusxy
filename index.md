
<!-- index.md is generated from index.Rmd. Please edit that file -->

# censusxy <img src="man/figures/logo.png" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis-CI Build
Status](https://travis-ci.org/slu-openGIS/censusxy.svg?branch=master)](https://travis-ci.org/slu-openGIS/censusxy)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/slu-openGIS/censusxy?branch=master&svg=true)](https://ci.appveyor.com/project/chris-prener/censusxy)
[![Coverage
status](https://codecov.io/gh/slu-openGIS/censusxy/branch/master/graph/badge.svg)](https://codecov.io/github/slu-openGIS/censusxy?branch=master)
[![CRAN\_status\_badge](http://www.r-pkg.org/badges/version/censusxy)](https://cran.r-project.org/package=censusxy)

The `censusxy` package is designed to provide easy access to the [U.S.
Census Bureau Geocoding
Tools](https://geocoding.geo.census.gov/geocoder/) in `R`. `censusxy`
has also been developed specifically with large data sets in mind - only
unique addresses are passed to the API for geocoding. If a data set
exceeds 1,000 unique addresses, it will be automatically subset into
appropriately sized API calls, geocoded, and then put back together so
that a single object is returned. There is also support for parallel
processing on Non-Windows platforms.

## What’s New in v1.0.0?

  - Full support for all Census Bureau Geographic Tools
  - The syntax of `cxy_geocode()` has changed slightly to facilitate new
    options
  - Non-Standard Evaluation (NSE) Has Been Removed
  - `censusxy` now only has 1 dependency
  - Parallel support added for Unix Platforms

## Installing censusxy

The easiest way to get `censusxy` is to install it from CRAN:

``` r
install.packages("censusxy")
```

Alternatively, the development version of `censusxy` can be accessed
from GitHub with `remotes`:

``` r
# install.packages("remotes")
remotes::install_github("slu-openGIS/censusxy")
```

## Resources

The main [Get started](articles/censusxy.html) article has:

  - some tips on using `censusxy` in different workflows
  - an overview of the package’s functionality,
  - and considerations for handling computer timeout.

## Contributor Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.
