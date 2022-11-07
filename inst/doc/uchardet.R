## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)
library(uchardet)

## ---- eval=FALSE--------------------------------------------------------------
#  dir(system.file("examples", package = "uchardet"), recursive = TRUE, full.names = TRUE)

## -----------------------------------------------------------------------------
detect_str_enc("Hello, useR!")

## -----------------------------------------------------------------------------
read_char <- function(path, enc) {
  # get file path
  file <- system.file("examples", path, package = "uchardet")
  # create the file connection with the encoding
  con <- file(file, encoding = enc)
  # close connection on exit
  on.exit(close(con))
  # read file content
  paste(readLines(con, warn = FALSE), collapse = "\n")
}

## -----------------------------------------------------------------------------
# read file into the working env
zh_utf8 <- read_char("zh/big5.txt", "BIG-5")
# print content
print(zh_utf8)
# check the encoding of the created object
Encoding(zh_utf8)
# detection result
detect_str_enc(zh_utf8)

## -----------------------------------------------------------------------------
# convert zh_utf8 from UTF-8 into unusual encodings
zh_big5 <- iconv(zh_utf8, "UTF-8", "BIG-5")
print(zh_big5)

zh_gb <- iconv(zh_utf8, "UTF-8", "GB18030")
print(zh_gb)

# detect encoding
detect_str_enc(c(zh_utf8, zh_big5, zh_gb))

## -----------------------------------------------------------------------------
Encoding(c(zh_utf8, zh_big5, zh_gb))

## -----------------------------------------------------------------------------
detect_raw_enc(charToRaw("Hello, useR!"))

## -----------------------------------------------------------------------------
read_raw <- function(path) {
  # get file path
  file <- system.file("examples", path, package = "uchardet")
  # read file to raw vector
  readBin(file, raw(), file.size(file))
}

# print first 5 bytes
read_raw("de/iso-8859-1.txt")[1:5]

## -----------------------------------------------------------------------------
detect_raw_enc(read_raw("de/iso-8859-1.txt"))
detect_raw_enc(read_raw("de/windows-1252.txt"))
detect_raw_enc(read_raw("fr/utf-16.be"))
detect_raw_enc(read_raw("zh/big5.txt"))

## ----warning = FALSE----------------------------------------------------------
# paths to examples files
ex_path <- system.file("examples", package = "uchardet")
ex_files <- Sys.glob(file.path(ex_path, "*", "*"))
# detect encoding
res <- detect_file_enc(ex_files)

## -----------------------------------------------------------------------------
# regex pattern
pattern <- ".*/examples/((.*)/(.*)\\.(?:.*))$"
proto <- list(file = character(1L), lang = character(1L), original = character(1L))
cmp <- strcapture(pattern, ex_files, proto)
cmp$lang <- toupper(cmp$lang)
cmp$original <- toupper(cmp$original)
cmp$uchardet <- res
head(cmp, n = 15)

