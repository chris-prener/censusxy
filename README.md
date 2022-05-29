
<!-- README.md is generated from README.Rmd. Please edit that file -->

# censusxy <img src="man/figures/logo.png" align="right" />

[![R build
status](https://github.com/chris-prener/censusxy/workflows/R-CMD-check/badge.svg)](https://github.com/chris-prener/censusxy/actions)
[![Coverage
status](https://codecov.io/gh/chris-prener/censusxy/branch/master/graph/badge.svg)](https://codecov.io/github/chris-prener/censusxy?branch=main)
[![CRAN_status_badge](https://www.r-pkg.org/badges/version/censusxy)](https://cran.r-project.org/package=censusxy)
[![cran
checks](https://cranchecks.info/badges/worst/censusxy)](https://cran.r-project.org/web/checks/check_results_censusxy.html)
[![Downloads](https://cranlogs.r-pkg.org/badges/censusxy?color=brightgreen)](https://www.r-pkg.org/pkg/censusxy)
[![DOI](https://zenodo.org/badge/165924122.svg)](https://zenodo.org/badge/latestdoi/165924122)

The `censusxy` package is designed to provide easy access to the [U.S.
Census Bureau Geocoding
Tools](https://geocoding.geo.census.gov/geocoder/) in `R`. `censusxy`
has also been developed specifically with large data sets in mind - only
unique addresses are passed to the API for geocoding. If a data set
exceeds 1,000 unique addresses, it will be automatically subset into
appropriately sized API calls, geocoded, and then put back together so
that a single object is returned. There is also support for parallel
processing of requests, which can significantly shorten the time it
takes to batch geocode large numbers of addresses.

`censusxy` is described in a 2021 paper in [*Transactions in
GIS*](https://onlinelibrary.wiley.com/doi/abs/10.1111/tgis.12741) by
Chris and Branson - please cite the paper if you use `censusxy` in your
work!

## What’s New in v1.1.0?

-   `censusxy` now supports parallel processing on Windows (macOS and
    Linux had support for this since `v1.0.0`), thanks to a PR from
    [Christopher Kenny](https://github.com/christopherkenny), and an
    error that cropped up with macOS 12.4 when submitting requests for
    parallel processing is addressed
-   `R` version 3.4 is now the minimum version supported
-   We’ve made some internal changes to ensure that API issues fail
    gracefully and to improve the documentation

## Installation

### Installing censusxy

The easiest way to get `censusxy` is to install it from CRAN:

``` r
install.packages("censusxy")
```

Alternatively, the development version of `censusxy` can be accessed
from GitHub with `remotes`:

``` r
# install.packages("remotes")
remotes::install_github("chris-prener/censusxy")
```

### Installing Suggested Dependencies

Since the package does not need `sf` for its basic functionality, it is
a suggested dependency rather than a required one. However, many users
will want to map these data as `sf` objects, and we therefore recommend
users install `sf`. Windows and macOS users should be able to install
`sf` without significant issues unless they are building from source.
Linux users will need to install several open source spatial libraries
to get `sf` itself up and running.

If you want to use these `sf`, you can either install it individually
(faster) or install all of the suggested dependencies at once (slower,
will also give you a number of other packages you may or may not want):

``` r
## install sf only
install.packages("sf")

## install all suggested dependencies
install.packages("censusxy", dependencies = TRUE)
```

## Usage

The `censusxy` package contains two data sets, `stl_homicides` (*n* =
1,812) and `stl_homicides_small` (*n* = 24), that can be used to
demonstrate the functionality of the package. The `stl_homicides_small`
data is included specifically for quick experimentation, as its small
sample size ensures an expedient response from the API.

To test `censusxy`’s functionality, load the package and either of the
sample data sets:

``` r
library(censusxy)

data <- stl_homicides
```

There are two possible variable configurations (`simple` and `full`,
specified using the `output` argument), and two possible output class
types (`dataframe` and `sf`, specified using the `class` argument):

``` r
homicide_sf <- cxy_geocode(data, street = "street_address", city = "city", state = "state", 
    output = "simple", class = "sf")
```

If you request an `sf` object, you easily preview the results with the
[`mapview` package](https://CRAN.R-project.org/package=mapview):

``` r
> mapview::mapview(homicide_sf)
```

<img src="man/figures/homicide_example.png" width="100%" />

## Contributor Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://chris-prener.github.io/censusxy/CODE_OF_CONDUCT.html).
By participating in this project you agree to abide by its terms.
