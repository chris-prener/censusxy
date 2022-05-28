# Notes for Reverse Dependency Checks

## Dependencies
Make sure gfortran is [installed](https://github.com/fxcoudert/gfortran-for-macOS/releases) before checking `eiCompare`.

## Workflow

```r
# check
revdepcheck::revdep_check()

# reset results
revdepcheck::revdep_reset()
```
