
<!-- README.md is generated from README.Rmd. Please edit that file -->

# censusxy <img src="man/figures/logo.png" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![R build
status](https://github.com/slu-openGIS/censusxy/workflows/R-CMD-check/badge.svg)](https://github.com/slu-openGIS/censusxy/actions)
[![Coverage
status](https://codecov.io/gh/slu-openGIS/censusxy/branch/master/graph/badge.svg)](https://codecov.io/github/slu-openGIS/censusxy?branch=master)
[![DOI](https://zenodo.org/badge/165924122.svg)](https://zenodo.org/badge/latestdoi/165924122)
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
Conduct](https://slu-opengis.github.io/censusxy/CODE_OF_CONDUCT.html).
By participating in this project you agree to abide by its terms.
