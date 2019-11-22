library(tinytest)

source("setup.R")

x <- detect_str_enc(letters)
expect_true(is.character(x))
expect_equal(length(x), length(letters))
expect_equal(x, rep("ASCII", length(letters)))
expect_equal(detect_str_enc(""), NA_character_)
expect_equal(detect_str_enc(NA_character_), NA_character_)
expect_equal(detect_str_enc(character(0)), character(0))

x <- c("a" = "a", "b" = "b")
expect_equal(names(detect_str_enc(x)), names(x))

x <- "\uc548\ub155 \uc0ac\uc6a9\uc790"
expect_equal(detect_str_enc(x), "UTF-8")

x <- rawToChar(as.raw(sample(0:255, 50)))
expect_equal(detect_str_enc(x), NA_character_)
expect_warning(detect_str_enc(x), "Can not handling string")

if (win_i386) {
  exit_file("Skip tests on Windows i386")
}

# skip some encodings
skip_enc <- function(enc) {
  # skip if encoding not in iconvlist
  supported <- (enc %in% iconvlist())
  # skip if encoding is UTF-16 or UTF-32 (can not be converted)
  except <- any(startsWith(enc, c("UTF-16", "UTF-32")))
  !supported || except
}

for (i in seq_along(ex_files)) {
  if (skip_enc(ex_encs[i])) next
  expect_equal(detect_str_enc(read_utf8(ex_files[i])), ex_encs[i])
}
