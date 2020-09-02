#define R_NO_REMAP
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Visibility.h>
#include <fstream>
#include <uchardet.h>

#define BUFFER_SIZE 65536
char buffer[BUFFER_SIZE];

SEXP attribute_hidden get_charset(uchardet_t handle) {
  const char* ans = uchardet_get_charset(handle);
  if (strlen(ans) == 0) {
    // Rf_warning("Can not detect encoding.");
    return NA_STRING;
  }
  return Rf_mkChar(ans);
}

SEXP attribute_hidden do_detect_sexp(SEXP x, uchardet_t handle) {
  R_xlen_t x_len = Rf_length(x);
  if (x_len == 0) {
    return NA_STRING;
  }
  const char* x_data;
  switch(TYPEOF(x)) {
    case CHARSXP: {
      if (x == NA_STRING) {
        return NA_STRING;
      }
      x_data = CHAR(x);
      break;
    }
    case RAWSXP: {
      x_data = (const char*) RAW(x);
      break;
    }
    default: {
      Rf_warning("Unsupported data type '%s'.", Rf_type2char(TYPEOF(x)));
      return NA_STRING;
    }
  }
  int retval = uchardet_handle_data(handle, x_data, x_len);
  uchardet_data_end(handle);
  if (retval != 0) {
    // Rf_warning("Can not handling data.");
    return NA_STRING;
  }

  return get_charset(handle);
}

SEXP attribute_hidden do_detect_file(SEXP x, uchardet_t handle) {
  if (x == NA_STRING) {
    return NA_STRING;
  }

  const char* fname = CHAR(x);
  std::ifstream fs(R_ExpandFileName(fname), std::ios::binary);
  if (!fs.is_open()) {
    Rf_warning("Can not open file '%s'.", fname);
    return NA_STRING;
  }

  while (!fs.eof()) {
    fs.read(buffer, BUFFER_SIZE);
    std::size_t len = fs.gcount();
    uchardet_handle_data(handle, buffer, len);
  }
  uchardet_data_end(handle);
  fs.close();

  return get_charset(handle);
}

template<typename T>
SEXP attribute_hidden do_detect_vec(SEXP x, T fun) {
  if (TYPEOF(x) != STRSXP) {
    Rf_error("'x' must be character vector.");
  }
  R_xlen_t n = Rf_length(x);
  SEXP res = PROTECT(Rf_allocVector(STRSXP, n));
  uchardet_t handle = uchardet_new();
  for (R_len_t i = 0; i < n; ++i) {
    SET_STRING_ELT(res, i, fun(STRING_ELT(x, i), handle));
    uchardet_reset(handle);
  }
  uchardet_delete(handle);
  UNPROTECT(1);
  return res;
}

SEXP detect_character(SEXP x) {
  return do_detect_vec(x, do_detect_sexp);
}

SEXP detect_file(SEXP x) {
  return do_detect_vec(x, do_detect_file);
}

SEXP detect_raw(SEXP x) {
  if (TYPEOF(x) != RAWSXP) {
    Rf_error("'x' must be raw vector.");
  }
  SEXP res = PROTECT(Rf_allocVector(STRSXP, 1));
  uchardet_t handle = uchardet_new();
  SET_STRING_ELT(res, 0, do_detect_sexp(x, handle));
  uchardet_delete(handle);
  UNPROTECT(1);
  return res;
}
