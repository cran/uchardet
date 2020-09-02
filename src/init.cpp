#include <stdlib.h>
#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>

SEXP detect_character(SEXP);
SEXP detect_file(SEXP);
SEXP detect_raw(SEXP);

static const R_CallMethodDef CallEntries[] = {
  {"detect_character", (DL_FUNC) &detect_character, 1},
  {"detect_file", (DL_FUNC) &detect_file, 1},
  {"detect_raw", (DL_FUNC) &detect_raw, 1},
  {NULL, NULL, 0}
};

extern "C" void R_init_uchardet(DllInfo *dll) {
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
