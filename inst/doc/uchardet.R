## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)
library(uchardet)

## ---- eval=FALSE--------------------------------------------------------------
#  system.file("examples", path, package = "uchardet")

## -----------------------------------------------------------------------------
detect_str_enc("Hello, useR!")

## -----------------------------------------------------------------------------
# get file path
file <- system.file("examples", "zh/big5.txt", package = "uchardet")
# create the file connection with the encoding
con <- file(file, encoding = "BIG-5")
# read file into the working env
zh_utf8 <- paste(readLines(con, warn = FALSE), collapse = "\n")
# close connection
close(con)
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
read_bin <- function(path) {
  # get file path
  file <- system.file("examples", path, package = "uchardet")
  # read file to raw vector
  readBin(file, raw(), file.size(file))
}

# print first 5 bytes
read_bin("de/iso-8859-1.txt")[1:5]

## -----------------------------------------------------------------------------
detect_raw_enc(charToRaw("Hello, useR!"))

## -----------------------------------------------------------------------------
detect_raw_enc(read_bin("de/iso-8859-1.txt"))
detect_raw_enc(read_bin("de/windows-1252.txt"))
detect_raw_enc(read_bin("fr/utf-16.be"))
detect_raw_enc(read_bin("zh/big5.txt"))

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

