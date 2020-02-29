#include <uchardet.h>
#include <Rcpp.h>

using namespace Rcpp;

String str_detect_enc(const std::string& x, uchardet_t handle) {
  int retval = uchardet_handle_data(handle, x.data(), x.size());
  uchardet_data_end(handle);
  if (retval != 0) {
    warning("Can not handling string.");
    return NA_STRING;
  }
  std::string res = uchardet_get_charset(handle);
  if (res.empty()) {
    warning("Can not detect encoding.");
    return NA_STRING;
  }
  return wrap(res);
}

// [[Rcpp::interfaces(r, cpp)]]

//' @title
//' String encoding detection
//'
//' @description
//' This function tries to detect character encoding.
//'
//' @param x Character vector.
//'
//' @return A character vector of length equal to the length of x and contains
//' guessed iconv-compatible encodings names.
//'
//' @encoding UTF-8
//'
//' @example man-roxygen/ex_detect_str.R
//'
//' @export
//'
// [[Rcpp::export(rng = false)]]
StringVector detect_str_enc(StringVector x) {
  std::size_t n = x.size();
  StringVector res = no_init(n);
  uchardet_t handle = uchardet_new();
  for (std::size_t i = 0; i < n; ++i) {
    if (StringVector::is_na(x[i]) || x[i].empty()) {
      res[i] = NA_STRING;
      continue;
    }
    res[i] = str_detect_enc(std::string(x[i]), handle);
    uchardet_reset(handle);
  }
  uchardet_delete(handle);
  if (x.hasAttribute("names")) {
    res.names() = x.names();
  }
  return res;
}
