// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#ifndef RCPP_uchardet_RCPPEXPORTS_H_GEN_
#define RCPP_uchardet_RCPPEXPORTS_H_GEN_

#include <Rcpp.h>

namespace uchardet {

    using namespace Rcpp;

    namespace {
        void validateSignature(const char* sig) {
            Rcpp::Function require = Rcpp::Environment::base_env()["require"];
            require("uchardet", Rcpp::Named("quietly") = true);
            typedef int(*Ptr_validate)(const char*);
            static Ptr_validate p_validate = (Ptr_validate)
                R_GetCCallable("uchardet", "_uchardet_RcppExport_validate");
            if (!p_validate(sig)) {
                throw Rcpp::function_not_exported(
                    "C++ function with signature '" + std::string(sig) + "' not found in uchardet");
            }
        }
    }

    inline StringVector detect_file_enc(const StringVector& x) {
        typedef SEXP(*Ptr_detect_file_enc)(SEXP);
        static Ptr_detect_file_enc p_detect_file_enc = NULL;
        if (p_detect_file_enc == NULL) {
            validateSignature("StringVector(*detect_file_enc)(const StringVector&)");
            p_detect_file_enc = (Ptr_detect_file_enc)R_GetCCallable("uchardet", "_uchardet_detect_file_enc");
        }
        RObject rcpp_result_gen;
        {
            rcpp_result_gen = p_detect_file_enc(Shield<SEXP>(Rcpp::wrap(x)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (Rcpp::internal::isLongjumpSentinel(rcpp_result_gen))
            throw Rcpp::LongjumpException(rcpp_result_gen);
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<StringVector >(rcpp_result_gen);
    }

    inline String detect_raw_enc(const RawVector& x) {
        typedef SEXP(*Ptr_detect_raw_enc)(SEXP);
        static Ptr_detect_raw_enc p_detect_raw_enc = NULL;
        if (p_detect_raw_enc == NULL) {
            validateSignature("String(*detect_raw_enc)(const RawVector&)");
            p_detect_raw_enc = (Ptr_detect_raw_enc)R_GetCCallable("uchardet", "_uchardet_detect_raw_enc");
        }
        RObject rcpp_result_gen;
        {
            rcpp_result_gen = p_detect_raw_enc(Shield<SEXP>(Rcpp::wrap(x)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (Rcpp::internal::isLongjumpSentinel(rcpp_result_gen))
            throw Rcpp::LongjumpException(rcpp_result_gen);
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<String >(rcpp_result_gen);
    }

    inline StringVector detect_str_enc(const StringVector& x) {
        typedef SEXP(*Ptr_detect_str_enc)(SEXP);
        static Ptr_detect_str_enc p_detect_str_enc = NULL;
        if (p_detect_str_enc == NULL) {
            validateSignature("StringVector(*detect_str_enc)(const StringVector&)");
            p_detect_str_enc = (Ptr_detect_str_enc)R_GetCCallable("uchardet", "_uchardet_detect_str_enc");
        }
        RObject rcpp_result_gen;
        {
            rcpp_result_gen = p_detect_str_enc(Shield<SEXP>(Rcpp::wrap(x)));
        }
        if (rcpp_result_gen.inherits("interrupted-error"))
            throw Rcpp::internal::InterruptedException();
        if (Rcpp::internal::isLongjumpSentinel(rcpp_result_gen))
            throw Rcpp::LongjumpException(rcpp_result_gen);
        if (rcpp_result_gen.inherits("try-error"))
            throw Rcpp::exception(Rcpp::as<std::string>(rcpp_result_gen).c_str());
        return Rcpp::as<StringVector >(rcpp_result_gen);
    }

}

#endif // RCPP_uchardet_RCPPEXPORTS_H_GEN_