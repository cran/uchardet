AC_PREREQ([2.69])

AC_INIT([uchardet],m4_esyscmd_s([awk '/^Version:/ {print $2}' DESCRIPTION]),[a.a.klevtsov@gmail.com])

AC_CONFIG_SRCDIR([src/RcppExports.cpp])

dnl find R home and set correct compiler + flags
: ${R_HOME=`R RHOME`}
AC_MSG_CHECKING([R_HOME])
if test -z "${R_HOME}"; then
    AC_MSG_RESULT([No])
    AC_MSG_ERROR([Can not find ${R_HOME}.])
fi
AC_MSG_RESULT([${R_HOME}])
R_BIN="${R_HOME}/bin/R"

dnl pick all flags for testing from R
: ${CC=`"${R_BIN}" CMD config CC`}
: ${CXX=`"${R_BIN}" CMD config CXX`}
: ${CFLAGS=`"${R_BIN}" CMD config CFLAGS`}
: ${CPPFLAGS=`"${R_BIN}" CMD config CPPFLAGS`}
: ${LDFLAGS=`"${R_BIN}" CMD config LDFLAGS`}

AC_PROG_CC(${CC})
AC_PROG_CXX(${CXX})
AC_REQUIRE_CPP
AC_LANG(C++)

dnl check pkg-config
AC_PATH_PROG([PKG_CONFIG],[pkg-config])

dnl uchardet force compile flag
UCHARDET_COMPILE="no"
AC_ARG_WITH(
    [builtin-uchardet],
    AS_HELP_STRING([--with-builtin-uchardet],[Force compilation of bundled uchardet source files]),
    [UCHARDET_COMPILE="yes"]
)

dnl uchardet include path
AC_ARG_VAR([UCHARDET_INCLUDES],[Path to uchardet library directory])
if test ! -z "${UCHARDET_INCLUDES}"; then
    CPPFLAGS="${CPPFLAGS} -I${UCHARDET_INCLUDES}"
    AC_CHECK_HEADER([uchardet.h],,AC_MSG_ERROR([Header file uchardet.h not found]))
    PKG_CPPFLAGS="-I${UCHARDET_INCLUDES}"
elif test ! -z "${PKG_CONFIG}" && ${PKG_CONFIG} --exists uchardet; then
    PKG_CPPFLAGS=`${PKG_CONFIG} --cflags uchardet`
fi

dnl uchardet library path
AC_ARG_VAR([UCHARDET_LIBS],[Path to uchardet library directory])
if test ! -z "${UCHARDET_LIBS}"; then
    LIBS="${LIBS} -L${UCHARDET_LIBS}"
    AC_CHECK_LIB([uchardet],[uchardet_new],,AC_MSG_ERROR([Can not link to uchardet library]))
    PKG_LIBS="-Wl,-rpath,${UCHARDET_LIBS} -L${UCHARDET_LIBS}"
elif test ! -z "${PKG_CONFIG}" && ${PKG_CONFIG} --exists uchardet; then
    PKG_LIBS=`${PKG_CONFIG} --libs uchardet`
else
    UCHARDET_COMPILE="yes"
fi

if test ${UCHARDET_COMPILE} != "no" ; then
    AC_MSG_NOTICE([compile uchardet from source])
    PKG_CPPFLAGS="-I../inst/include/uchardet"
    PKG_LIBS="uchardet/src/libuchardet.a"
    SHLIB_DEPS="uchardet/src/libuchardet.a"
fi

dnl add option to strip debug symbols
case `uname -s` in
    Linux|Darwin*)
        PKG_LIBS="-Wl,-S ${PKG_LIBS}"
esac

AC_MSG_NOTICE([CC: ${CC}])
AC_MSG_NOTICE([CXX: ${CXX}])
AC_MSG_NOTICE([PKG_CPPFLAGS: ${PKG_CPPFLAGS}])
AC_MSG_NOTICE([PKG_LIBS: ${PKG_LIBS}])
AC_MSG_NOTICE([${PACKAGE_NAME}: ${PACKAGE_VERSION}])

AC_SUBST([PKG_CPPFLAGS])
AC_SUBST([PKG_LIBS])
AC_SUBST([SHLIB_DEPS])
AC_CONFIG_FILES([src/Makevars])
AC_OUTPUT
