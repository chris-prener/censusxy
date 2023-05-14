## Release summary
This version of `censusxy` is a maintenance release to address errors that had occured on CRAN at the end of April that appear to be due to the Census Bureau's geocoder being temporarily down. I've added a check for each function to make sure the API is online and to fail gracefully if it is not.

## Test environments
* local macOS install: R 4.2.2
* Linux ubuntu distribution (via GitHub Actions): R-devel, R-release, past four R-oldrel (4.1.3, 4.0.5, 3.6.3, 3.5.3, 3.4.4)
* macOS (via GitHub Actions): R-release
* windows (via GitHub Actions): R-release
* winbuilder: R-release, R-oldrel, R-devel

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs with local or CI checks. There is one NOTE on winbuilder:

```r
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Christopher Prener <chris.prener@gmail.com>'
  
Found the following (possibly) invalid URLs:
  URL: https://doi.org/10.1111/tgis.12741
    From: inst/CITATION
          README.md
    Status: 503
    Message: Service Unavailable
```

I also double checked the citation links and found both to work correctly. The link is valid - I have confirmed this manually. 

## revdepcheck results

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
