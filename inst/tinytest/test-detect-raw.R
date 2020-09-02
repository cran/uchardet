source("setup.R")

expect_error(detect_raw_enc(NULL))
expect_error(detect_raw_enc(NA))
expect_error(detect_raw_enc(NA_character_))
expect_error(detect_raw_enc(NA_integer_))
expect_error(detect_raw_enc(NA_real_))
expect_error(detect_raw_enc(0L))
expect_error(detect_raw_enc(0))
expect_equal(detect_raw_enc(raw()), NA_character_)
expect_equal(detect_raw_enc(as.raw(0)), "ASCII")

x <- "Hello"
expect_equal(detect_raw_enc(charToRaw(x)), "ASCII")

x <- "\uc548\ub155 \uc0ac\uc6a9\uc790"
expect_equal(detect_raw_enc(charToRaw(x)), "UTF-8")

x <- as.raw(sample(0:255, 50))
expect_equal(detect_raw_enc(x), NA_character_)
# expect_warning(detect_raw_enc(x), "Can not detect encoding.")

if (skip_os()) {
  exit_file("Skip tests on current OS")
}

for (i in seq_along(ex_files)) {
  expect_equal(detect_raw_enc(read_bin(ex_files[i])), ex_encs[i])
}
