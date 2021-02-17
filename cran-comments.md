## Release summary
This is a resubmission of a release that fixes defaults to align with changes to the API's defaults for the 2020 Decennial Census. It also makes several changes from Uwe Liggs, including wrapping two examples where the API takes time to respond in `\donttest{}` and converting all URLs from `http://` to `https://`.

## Test environments
* local OS X install: R 4.0.3
* Ubuntu (via GitHub Actions): R-4.0.3, R-3.6, R-3.5, R-3.4, and R-3.3
* macOS (via GitHub Actions): R-devel, R-4.0.3, R-3.6
* windows (via GitHub Actions): R-4.0.3, R-3.6
* winbuilder, R-release, R-oldrel, R-devel

* r-hub not used because it lacks dependencies needed to build `sf` on Debian

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs with local or CI checks.

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
