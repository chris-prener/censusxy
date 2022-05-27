## Release summary
This version of `censusxy` is primarily to address the ERROR on CRAN, ensure that issues with the Census Bureau's API resolve gracefully, update documentation, and update the contact information for the maintainer. The ERROR on CRAN should now fail gracefully, and the only other change is that R v3.4 is now the minium version.

## Test environments
* local OS X install: R 4.1.2
* Linux ubuntu distribution (via GitHub Actions): R-devel, R-release, past four R-oldrel (4.1.3, 4.0.5, 3.6.3, 3.5.3, 3.4.4)
* macOS (via GitHub Actions): R-release
* windows (via GitHub Actions): R-release
* winbuilder: R-release, R-oldrel, R-devel

## R CMD check results
There were no ERRORs, WARNINGs, or NOTEs with local or CI checks. There is one NOTE on winbuilder:

```r
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Christopher Prener <chris.prener@gmail.com>'

New maintainer:
  Christopher Prener <chris.prener@gmail.com>
Old maintainer(s):
  Christopher Prener <chris.prener@slu.edu>
  
Found the following (possibly) invalid URLs:
URL: https://onlinelibrary.wiley.com/doi/abs/10.1111/tgis.12741
  From: inst/CITATION
        README.md
  Status: 503
  Message: Service Unavailable

Found the following (possibly) invalid DOIs:
  DOI: 10.1111/tgis.12741
    From: inst/CITATION
    Status: Service Unavailable
    Message: 503
```

I am still the maintainer - I have just changed my contact information due to new employment! I also double checked the citation links and found both to work correctly.

## reverse dependency checked

We checked 1 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
