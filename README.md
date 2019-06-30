
<!-- README.md is generated from README.Rmd. Please edit that file -->

# censusxy <img src="man/figures/logo.png" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis-CI Build
Status](https://travis-ci.org/slu-openGIS/censusxy.svg?branch=master)](https://travis-ci.org/slu-openGIS/censusxy)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/slu-openGIS/censusxy?branch=master&svg=true)](https://ci.appveyor.com/project/chris-prener/censusxy)
[![Coverage
status](https://codecov.io/gh/slu-openGIS/censusxy/branch/master/graph/badge.svg)](https://codecov.io/github/slu-openGIS/censusxy?branch=master)

The `censusxy` package is designed to provide easy and efficient access
to the [US Census Bureau Batch
Geocoder](https://geocoding.geo.census.gov/geocoder/geographies/addressbatch?form)
in `R`. It was developed specifically with large datasets in mind.

## Installing censusxy

The package is soon to be on CRAN, but meanwhile, the development
version of `censusxy` can be accessed from GitHub with `remotes`:

``` r
# install.packages("remotes")
remotes::install_github("slu-openGIS/censusxy")
```

## Example Usage

``` r
homicide_sf <- cxy_geocode(homicides, id, street_address, city, state, postal_code, output = "sf")
```

``` r
> library(mapview)
> mapview(homicide_sf)
```

<img src="man/figures/homicide_example.png" width="60%" />

## Contributor Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](.github/CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.
