
<!-- README.md is generated from README.Rmd. Please edit that file -->

# censusxy <img src="man/figures/logo.png" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis-CI Build
Status](https://travis-ci.org/slu-openGIS/censusxy.svg?branch=master)](https://travis-ci.org/slu-openGIS/censusxy)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/slu-openGIS/censusxy?branch=master&svg=true)](https://ci.appveyor.com/project/chris-prener/censusxy)
[![Coverage
status](https://codecov.io/gh/slu-openGIS/censusxy/branch/master/graph/badge.svg)](https://codecov.io/github/slu-openGIS/censusxy?branch=master)
[![DOI](https://zenodo.org/badge/165924122.svg)](https://zenodo.org/badge/latestdoi/165924122)
[![CRAN\_status\_badge](http://www.r-pkg.org/badges/version/censusxy)](https://cran.r-project.org/package=censusxy)

The `censusxy` package is designed to provide easy and efficient access
to the [U.S. Census Bureau Batch
Geocoder](https://geocoding.geo.census.gov/geocoder/) in `R`. The
package offers a batch solution for address geocoding (as opposed to
packages like [`censusr`](https://CRAN.R-project.org/package=censusr),
which provide functionality for a single address at a time). `censusxy`
has also been developed specifically with large data sets in mind - only
unique addresses are passed to the API for geocoding. If a data set
exceeds 1,000 unique addresses, it will be automatically subset into
appropriately sized API calls, geocoded, and then put back together so
that a single object is returned.

## Installation

### Installing Dependencies

You should check the [`sf` package
website](https://r-spatial.github.io/sf/) and the [`censusxy` package
website](https://slu-openGIS.github.io/censusxy/) for the latest details
on installing dependencies for that package. Instructions vary
significantly by operating system. For best results, have `sf` installed
before you install `censusxy`. Other dependencies, like `dplyr`, will be
installed automatically with `censusxy` if they are not already present.

### Installing censusxy

Once `sf` is installed, the easiest way to get `censusxy` is to install
it from CRAN:

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

There are two possible variable configurations (`minimal` and `full`,
specified using the `style` argument), and two possible output types
(`tibble` and `sf`, specified using the `output` argument):

``` r
homicide_sf <- cxy_geocode(data, address = street_address, city = city, state = state, 
    style = "minimal", output = "sf")
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
