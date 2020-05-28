## Release summary
This release brings full functionality to the package, including not just the batch geocoding offered in earlier versions but also single line and reverse geocoding. It is now possible to return Census Bureau geographies as well.

## Test environments
* local OS X install: R 4.0.0
* Ubuntu (via GitHub Actions): R-4.0, R-3.6, R-3.5, R-3.4, and R-3.3
* macOS (via GitHub Actions): R-devel, R-4.0, R-3.6
* windows (via GitHub Actions): R-4.0, R-3.6
* winbuilder, R-release, R-oldrel, R-devel

* r-hub not used because it lacks dependencies needed to build `sf` on Debian

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs with local or CI checks.

## Reverse dependencies
Not applicable.
