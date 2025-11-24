## Test environments
* local Windows 10, R version 4.5.1 (2025-06-13 ucrt)
* win-builder R Under development (unstable) (2025-11-16 r89026 ucrt)
* R-universe checks for: linux-devel-x86_64, macos-*, windows-*

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new submission.

## Comments

This is a small package, with only a few functions, but it serves a need not otherwise met in available R packages.
It is therefore useful to have this on CRAN.

### colorize 0.2.1

* Fix Description: as per CRAN request

### colorize 0.2.0

* Add `format` argument to `colorize()` and `colorize_bg()`
* Extend vignette, making it more general
* Now Suggests: crayon, for reference
