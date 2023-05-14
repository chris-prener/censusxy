# eiCompare

<details>

* Version: 3.0.1
* GitHub: https://github.com/RPVote/eiCompare
* Source code: https://github.com/cran/eiCompare
* Date/Publication: 2023-03-28 10:30:05 UTC
* Number of recursive dependencies: 167

Run `revdepcheck::revdep_details(, "eiCompare")` for more info

</details>

## In both

*   checking whether package ‘eiCompare’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/chris/Documents/censusxy/revdep/checks.noindex/eiCompare/new/eiCompare.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘eiCompare’ ...
** package ‘eiCompare’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** demo
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘ei’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/Users/chris/Documents/censusxy/revdep/library.noindex/eiCompare/gmm/libs/gmm.so':
  dlopen(/Users/chris/Documents/censusxy/revdep/library.noindex/eiCompare/gmm/libs/gmm.so, 0x0006): Library not loaded: /opt/R/arm64/gfortran/lib/libgomp.1.dylib
  Referenced from: <B51A8EC6-9771-364E-92F3-500E0B19F3DC> /Users/chris/Documents/censusxy/revdep/library.noindex/eiCompare/gmm/libs/gmm.so
  Reason: tried: '/opt/R/arm64/gfortran/lib/libgomp.1.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/opt/R/arm64/gfortran/lib/libgomp.1.dylib' (no such file), '/opt/R/arm64/gfortran/lib/libgomp.1.dylib' (no such file), '/Library/Frameworks/R.framework/Resources/lib/libgomp.1.dylib' (no such file), '/Library/Java/JavaVirtualMachines/jdk-17.0.1+12/Contents/Home/lib/server/libgomp.1.dylib' (no such file)
Execution halted
ERROR: lazy loading failed for package ‘eiCompare’
* removing ‘/Users/chris/Documents/censusxy/revdep/checks.noindex/eiCompare/new/eiCompare.Rcheck/eiCompare’


```
### CRAN

```
* installing *source* package ‘eiCompare’ ...
** package ‘eiCompare’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** data
*** moving datasets to lazyload DB
** demo
** inst
** byte-compile and prepare package for lazy loading
Error: package or namespace load failed for ‘ei’ in dyn.load(file, DLLpath = DLLpath, ...):
 unable to load shared object '/Users/chris/Documents/censusxy/revdep/library.noindex/eiCompare/gmm/libs/gmm.so':
  dlopen(/Users/chris/Documents/censusxy/revdep/library.noindex/eiCompare/gmm/libs/gmm.so, 0x0006): Library not loaded: /opt/R/arm64/gfortran/lib/libgomp.1.dylib
  Referenced from: <B51A8EC6-9771-364E-92F3-500E0B19F3DC> /Users/chris/Documents/censusxy/revdep/library.noindex/eiCompare/gmm/libs/gmm.so
  Reason: tried: '/opt/R/arm64/gfortran/lib/libgomp.1.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/opt/R/arm64/gfortran/lib/libgomp.1.dylib' (no such file), '/opt/R/arm64/gfortran/lib/libgomp.1.dylib' (no such file), '/Library/Frameworks/R.framework/Resources/lib/libgomp.1.dylib' (no such file), '/Library/Java/JavaVirtualMachines/jdk-17.0.1+12/Contents/Home/lib/server/libgomp.1.dylib' (no such file)
Execution halted
ERROR: lazy loading failed for package ‘eiCompare’
* removing ‘/Users/chris/Documents/censusxy/revdep/checks.noindex/eiCompare/old/eiCompare.Rcheck/eiCompare’


```
