#' @title
#' String encoding detection
#'
#' @description
#' This function tries to detect character encoding.
#'
#' @param x Character vector.
#'
#' @return A character vector of length equal to the length of x and contains
#' guessed iconv-compatible encodings names.
#'
#' @encoding UTF-8
#'
#' @example man-roxygen/ex_detect_str.R
#'
#' @export
#'
detect_str_enc <- function(x) {
    .Call(Cpp_detect_character, x)
}

#' @title
#' String encoding detection
#'
#' @description
#' This function tries to detect character encoding.
#'
#' @param x Character vector, containing file names or paths.
#'
#' @return A character vector of length equal to the length of x and contains
#' guessed iconv-compatible encodings names.
#'
#' @encoding UTF-8
#'
#' @example man-roxygen/ex_detect_str.R
#'
#' @export
#'
detect_file_enc <- function(x) {
    .Call(Cpp_detect_file, x)
}

#' @title
#' Raw bytes encoding detection
#'
#' @description
#' This function tries to detect raw bytes encoding.
#'
#' @param x Raw vector.
#'
#' @return A character which contains a guessed iconv-compatible encoding name.
#'
#' @export
#'
#' @encoding UTF-8
#'
#' @example man-roxygen/ex_detect_raw.R
#'
detect_raw_enc <- function(x) {
    .Call(Cpp_detect_raw, x)
}
