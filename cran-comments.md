## Release summary
This version of `censusxy` is a maintenance release: it attempts to address the ERROR on CRAN with OpenBLAS. The specific error could not be replicated locally. The problem was not an API error - the package returned the correct error as designed. However, I have changed how user inputs are validated in attempt to prevent this from continuing to be an issue in the first place.

## Test environments
* local macOS install: R 4.2.0
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
