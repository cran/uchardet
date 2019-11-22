library(tinytest)

source("setup.R")

expect_error(detect_raw_enc(NULL))
expect_warning(detect_raw_enc(NA))
expect_warning(detect_raw_enc(NA_integer_))
expect_equal(detect_raw_enc(raw()), NA_character_)
expect_equal(detect_raw_enc(0), "ASCII")
expect_equal(detect_raw_enc(charToRaw("Hello")), "ASCII")

x <- as.raw(sample(0:255, 50))
expect_equal(detect_raw_enc(x), NA_character_)
expect_warning(detect_raw_enc(x), "Can not handling data.")

if (win_i386) {
  exit_file("Skip tests on Windows i386")
}

for (i in seq_along(ex_files)) {
  expect_equal(detect_raw_enc(read_bin(ex_files[i])), ex_encs[i])
}
