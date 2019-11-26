library(tinytest)

source("setup.R")

expect_error(detect_file_enc(NULL))
expect_true(is.na(detect_file_enc(NA)))
expect_true(is.na(detect_file_enc(NA_character_)))
expect_true(is.na(detect_file_enc("")))
expect_true(is.na(detect_file_enc("no-exists")))
expect_equal(detect_file_enc(character(0)), structure(character(0), .Names = character(0)))

tmp <- tempfile()
x <- as.raw(sample(0:255, 50))
writeBin(x, tmp)
expect_equivalent(detect_file_enc(tmp), NA_character_)
expect_warning(detect_file_enc(tmp), "Can not handling file")
unlink(tmp)

if (skip_os()) {
  exit_file("Skip tests on current OS")
}

res <- detect_file_enc(ex_files)
expect_true(is.character(res))
expect_true(all(!is.na(res)))
expect_equal(length(res), length(ex_files))
expect_equal(names(res), ex_files)
expect_equivalent(res, ex_encs)
