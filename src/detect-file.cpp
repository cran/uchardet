#include <fstream>
#include <uchardet.h>
#include <Rcpp.h>

using namespace Rcpp;

#define BUFFER_SIZE 65536
char buffer[BUFFER_SIZE];

String file_detect_enc(const char* fname, uchardet_t handle) {
  std::ifstream fs(R_ExpandFileName(fname), std::ios::binary);
  if (!fs.is_open()) {
    warning("Can not open file '%s'.", fname);
    return NA_STRING;
  }
  while(!fs.eof()) {
    fs.read(buffer, BUFFER_SIZE);
    std::size_t len = fs.gcount();
    uchardet_handle_data(handle, buffer, len);
  }
  uchardet_data_end(handle);
  fs.close();
  std::string res = uchardet_get_charset(handle);
  if (res.empty()) {
    warning("Can not detect encoding.");
    return NA_STRING;
  }
  return wrap(res);
}

// [[Rcpp::interfaces(r, cpp)]]

//' @title
//' Files encoding detection
//'
//' @description
//' This function tries to detect character encoding of files.
//'
//' @param x Character vector, containing file names or paths.
//'
//' @return A character vector of length equal to the length of x and contains
//' guessed iconv-compatible encodings names.
//'
//' @export
//'
//' @encoding UTF-8
//'
//' @example man-roxygen/ex_detect_file.R
//'
// [[Rcpp::export(rng = false)]]
StringVector detect_file_enc(StringVector x) {
  size_t n = x.size();
  StringVector res = no_init(n);
  uchardet_t handle = uchardet_new();
  for (size_t i = 0; i < n; ++i) {
    if (StringVector::is_na(x[i]) || x[i].empty()) {
      res[i] = NA_STRING;
      continue;
    }
    res[i] = file_detect_enc(x[i], handle);
    uchardet_reset(handle);
  }
  uchardet_delete(handle);
  res.attr("names") = x;
  return res;
}
