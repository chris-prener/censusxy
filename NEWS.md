# censusxy 0.1.3

* The `cxy_geocode()` function now includes an option `fill_na`, which is enabled by default. Two fields in the original implementation of the package, `cxy_quality` and `cxy_match`, were returned as empty strings when no match was identified. Now, by default, they will both be returned with `NA` values when there is no match. If you want to return to the original behavior, simply set `fill_na = FALSE` in your function call.

# censusxy 0.1.2

* Address CRAN policy concerns with how temporary files are saved and removed when uploading batches of addresses to the Census Bureau's website

# censusxy 0.1.1

* CRAN release version of the software.
* Corrected tense shifts in description paragraph in `DESCRIPTION`, `README.Rmd`, and `index.Rmd`
* Other minor updates to `pkgdown` site and `README.Rmd`

# censusxy 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* Add initial package infrastructure and functionality.
* Enable continuous integration and code coverage testing of package.
* Build `pkgdown` site.
