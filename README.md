
# bbb: build bounding boxes

<!-- badges: start -->
[![R-CMD-check](https://github.com/baslat/bbb/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/baslat/bbb/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of bbb is to allow for the interactive creation of spatial bounding boxes
inside R Studio.

## Installation

You can install the development version of `bbb` from
[GitHub](https://github.com/baslat/bbb) with:

``` r
remotes::install_github(repo = "baslat/bbb")
```

## Example

`bbb` is an RStudio addin, so it is best accessed via the `Addins` drop-down
menu in RStudio and then following the on-screen instructions. If you are
inclined to manually call it, you can do so with

``` r
bbb::box()
```
