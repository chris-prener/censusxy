## Release summary
This is the initial version of the `censusxy` package. It was previously submitted (on July 5) and then rejected (on July 9):

> Please ensure that your functions do not write by default or in your examples/vignettes/tests in the user's home filespace (including the  package directory and getwd()). 

We have reviewed the package to be sure - `censusxy` only interacts with the file system in `cxy_geocoder.R`, where a `.csv` is written to the temp directory (lines 14-16), which is subsequently cleaned up (line 57). We thought that this would be permissable according to CRAN policy since we're only working with the temp directory here. 

We are not at all opposed to making changes to ensure we comply with CRAN policy - but are unsure what to change in this instance. Uwe kindly suggested that we could resubmit the package as is and that he would be willing to take a look at the function. Thanks, Uwe, for your offer and help!

## Test environments
* local OS X install: R 3.6.0
* Linux xenial distribution (on Travis CI): R-release, R-oldrel, R-devel, R-3.4.4, and R-3.3.3
* macOS (on Travis CI): R-release, R-oldrel, R-3.4.4, and R-3.3.3
* windows x64 (on Appveyor): R-release, R-patched, R-oldrel, R-devel, R-3.4.4, and R-3.3.3
* windows i386 (on Appveyor): R-patched
* winbuilder, R-release, R-oldrel, R-devel

* r-hub not used because it lacks dependencies needed to build `sf` on Debian

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs with local or CI checks.

There was one NOTE on winbuilder checks:

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Christopher Prener <chris.prener@slu.edu>'

New submission

Possibly mis-spelled words in DESCRIPTION:
  Geocoder (2:38)
  geocoded (15:73)
  geocoding (10:72, 12:58, 14:31)
  vectorized (12:26)

The four words identified are all spelled correctly.

## Reverse dependencies
Not applicable.
