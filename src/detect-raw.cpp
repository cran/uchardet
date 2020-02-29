#include <uchardet.h>
#include <Rcpp.h>

using namespace Rcpp;

// [[Rcpp::interfaces(r, cpp)]]

//' @title
//' Raw bytes encoding detection
//'
//' @description
//' This function tries to detect raw bytes encoding.
//'
//' @param x Raw vector.
//'
//' @return A character which contains a guessed iconv-compatible encoding name.
//'
//' @export
//'
//' @encoding UTF-8
//'
//' @example man-roxygen/ex_detect_raw.R
//'
// [[Rcpp::export(rng = false)]]
String detect_raw_enc(RawVector x) {
  std::size_t n = x.size();
  if (n == 0) {
    return NA_STRING;
  }
  const char* ptr = reinterpret_cast<const char*>(x.begin());
  uchardet_t handle = uchardet_new();
  int retval = uchardet_handle_data(handle, ptr, n);
  uchardet_data_end(handle);
  if (retval != 0) {
    uchardet_delete(handle);
    warning("Can not handling data.");
    return NA_STRING;
  }
  std::string res = uchardet_get_charset(handle);
  uchardet_delete(handle);
  if (res.empty()) {
    warning("Can not detect encoding.");
    return NA_STRING;
  }
  return wrap(res);
}
