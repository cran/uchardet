#' @title The Universal Character Encoding Detector
#'
#' @description
#' R bindings for the uchardet library
#' (<https://www.freedesktop.org/wiki/Software/uchardet/>), that
#' is the encoding detector library of Mozilla. It takes a sequence
#' of bytes in an unknown character encoding without any additional
#' information, and attempts to determine the encoding of the text.
#' Returned encoding names are iconv-compatible.
#'
#' @name uchardet
#' @docType package
#'
#' @example man-roxygen/ex_detect_str.R
#' @example man-roxygen/ex_detect_file.R
#' @example man-roxygen/ex_detect_raw.R
#'
#' @references
#'
#' \code{uchardet} page: \url{https://www.freedesktop.org/wiki/Software/uchardet/}
#'
#' @useDynLib uchardet, .registration = TRUE, .fixes = "Cpp_"
#'
"_PACKAGE"
