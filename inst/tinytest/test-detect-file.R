source("setup.R")

expect_error(detect_file_enc(NULL))
expect_error(detect_file_enc(NA))
expect_equal(detect_file_enc(NA_character_), NA_character_)
expect_equal(detect_file_enc(character(0)), character(0))
expect_equal(detect_file_enc(""), NA_character_)
expect_equal(detect_file_enc("no-exists"), NA_character_)
expect_warning(detect_file_enc(""), "Can not open file ''")
expect_warning(detect_file_enc("no-exists"), "Can not open file 'no-exists'")

tmp <- tempfile()
x <- as.raw(sample(0:255, 50))
writeBin(x, tmp)
expect_equivalent(detect_file_enc(tmp), NA_character_)
# expect_warning(detect_file_enc(tmp), "Can not detect encoding.")
unlink(tmp)

if (skip_os()) {
  exit_file("Skip tests on current OS")
}

res <- detect_file_enc(ex_files)
expect_true(is.character(res))
expect_true(all(!is.na(res)))
expect_equal(length(res), length(ex_files))
expect_equivalent(res, ex_encs)
