# random seed
set.seed(0)

# detect windows i386
win_i386 <- .Platform$OS.type == "windows" && .Platform$r_arch == "i386"

# list of examples files
ex_path <- system.file("examples", package = "uchardet")
ex_files <- Sys.glob(file.path(ex_path, "*", "*"))

# skip tests for certain files (see src/uchardet/test/CMakeLists.txt)
to_skip <- c(
  "da/iso-8859-1.txt",
  "es/iso-8859-15.txt",
  "he/iso-8859-8.txt",
  "ja/utf-16be.txt",
  "ja/utf-16le.txt"
)
to_skip <- file.path(ex_path, to_skip)
ex_files <- setdiff(ex_files, to_skip)

# encodings based on files names
ex_encs <- toupper(tools::file_path_sans_ext(basename(ex_files)))

# read file to raw vector
read_bin <- function(x) {
  readBin(x, raw(), file.size(x))
}

# read UTF-8 encoded test file to character string
read_char <- function(x) {
  readChar(x, file.size(x))
}

read_utf8 <- function(x) {
  # detect encoding by file extension
  enc <- tools::file_path_sans_ext(basename(x))
  # define file encoding for the connection
  con <- file(x, encoding = enc)
  on.exit(close(con))
  # read file to UTF-8 string
  res <- paste(readLines(con, warn = FALSE), collapse = "\n")
  # convert ecnoding back
  iconv(res, "UTF-8", enc)
}
