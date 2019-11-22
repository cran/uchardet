#include <uchardet.h>
#include <Rcpp.h>

using namespace Rcpp;

template <typename T>
bool inline str_is_empty(const T& x) {
  return x.empty() || x.get() == NA_STRING;
}

String str_detect_enc(const std::string& s, uchardet_t& handle) {
  int retval = uchardet_handle_data(handle, s.data(), s.size());
  uchardet_data_end(handle);
  if (retval != 0) {
    warning("Can not handling string.");
    return NA_STRING;
  }
  std::string res = uchardet_get_charset(handle);
  if (res.empty()) {
    warning("Can not handling string.");
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
//' @example inst/examples/ex_detect_str.R
//'
//' @export
//'
// [[Rcpp::export(rng = false)]]
StringVector detect_str_enc(const StringVector& x) {
  std::size_t n = x.size();
  StringVector res = no_init(n);
  uchardet_t handle = uchardet_new();
  for (std::size_t i = 0; i < n; ++i) {
    res[i] = str_is_empty(x[i]) ? NA_STRING : str_detect_enc(std::string(x[i]), handle);
    uchardet_reset(handle);
  }
  uchardet_delete(handle);
  if (x.hasAttribute("names")) {
    res.names() = x.names();
  }
  return res;
}
