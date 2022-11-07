
<!-- README.md is generated from README.Rmd. Please edit that file -->

# uchardet

<!-- badges: start -->

[![CRAN
Status](http://www.r-pkg.org/badges/version/uchardet)](https://cran.r-project.org/package=uchardet)
[![License: GPL
v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

<!-- badges: end -->

R bindings for
[`uchardet`](https://www.freedesktop.org/wiki/Software/uchardet/)
library, that is the encoding detector library of Mozilla. It takes a
sequence of bytes in an unknown character encoding without any
additional information, and attempts to determine the encoding of the
text and returns encoding names in the iconv-compatible format.

Key features:

- process character vector;
- process raw vector;
- process files without load whole file to memory;
- process contents of a URLs;

## Installation

To install the package from the CRAN run the following command:

``` r
install.packages("uchardet", repos = "https://cloud.r-project.org/")
```

Also you could install the dev-version with the `install_gitlab()`
function from the `remotes` package:

``` r
remotes::install_gitlab("artemklevtsov/uchardet@devel")
```

This package contains the compiled code, therefore you have to use the
[Rtools](https://cran.r-project.org/bin/windows/Rtools/) to install it
on Windows.

Installation from source requires
[`uchardet`](https://www.freedesktop.org/wiki/Software/uchardet/)
library and headers. On Linux or OSX the configure script try to find it
with `pkg-config` or system include/library paths. You can define
include and library paths with `UCHARDET_INCLUDES` and `UCHARDET_LIBS`
configure variables.

If the `uchardet` system library is not found it will be compiled from
source. You can force the compilation of the builtin library with the
`--with-builtin-uchardet` configure argument.

## Example

``` r
# load packages
library(uchardet)

# detect string encoding
ascii <- "Hello, useR!"
print(ascii)
#> [1] "Hello, useR!"
detect_str_enc(ascii)
#> [1] "ASCII"
utf8 <- "\u4e0b\u5348\u597d"
print(utf8)
#> [1] "下午好"
detect_str_enc(utf8)
#> [1] "UTF-8"

# detect raw vector encoding
detect_raw_enc(charToRaw(ascii))
#> [1] "ASCII"
detect_raw_enc(charToRaw(utf8))
#> [1] "UTF-8"

# detect file encoding
ascii_file <- tempfile()
writeLines(ascii, ascii_file)
detect_file_enc(ascii_file)
#> [1] "ASCII"
utf8_file <- tempfile()
writeLines(utf8, utf8_file)
detect_file_enc(utf8_file)
#> [1] "UTF-8"
```

## Bug reports

Use the following command to go to the page for bug report submissions:

``` r
bug.report(package = "uchardet")
```

Before reporting a bug or submitting an issue, please do the following:

- Make sure that you error or issue was not reported or discussed
  earlier. Please, use the search;
- Check the news list of the current version. Some errors could be
  caused by the package changes. It could be done with
  `news(package = "uchardet", Version == packageVersion("uchardet"))`
  command;
- Make a minimal reproducible example of the code that consistently
  causes the error;
- Make sure that the error occurs during the execution of a function
  from the `uchardet` package, not from other packages;
- Try to reproduce the error with the last development version of the
  package from the git repository.

Please attach traceback() and sessionInfo() output to bug report. It may
save a lot of time.

## License

The `uchardet` package is distributed under
[GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) license.
