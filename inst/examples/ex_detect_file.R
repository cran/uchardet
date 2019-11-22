# detect ASCII file encoding
detect_file_enc(system.file("DESCRIPTION", package = "uchardet"))

# paths to examples files
ex_path <- system.file("examples", package = "uchardet")
# various langaues and encodings examples files
ex_files <- Sys.glob(file.path(ex_path, "*", "*"))
# detect files encodings
detect_file_enc(head(ex_files, 10))
