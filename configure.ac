#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT(rcm, 1.2.2, mburns@thoughtbot.com)
AM_INIT_AUTOMAKE

# Checks for programs.
AC_PROG_CC
AC_PATH_PROG(TEST, test)

AC_ARG_WITH(ghc,
	    [  --with-ghc=GHC          where to find ghc],
	    [GHC=$withval])

if $TEST -z "$GHC"; then
  AC_CHECK_TOOL(GHC, ghc, ghc)
fi

GHC_FLAGS=""

if $TEST "$GHC"; then
	AC_MSG_CHECKING([for ghc version])
	changequote(<<, >>)
	ghc_version=`$GHC --version 2>&1 | sed -n -e 's/.* version \([0-9.][0-9.]*\).*/\1/p'`
	ghc_major=`echo "$ghc_version" | sed -n -e 's/\([0-9][0-9]*\).*/\1/p'`
	ghc_minor=`echo "$ghc_version" | sed -n -e 's/[0-9][0-9]*\.\([0-9][0-9]*\).*/\1/p'`
	changequote([, ])
	AC_MSG_RESULT([$ghc_version])
	if $TEST "$ghc_major" -ge 5 -a "$ghc_minor" -ge 02; then
		GHCTYPE=ghc5
		AC_MSG_CHECKING([for ghc library directory])
		GHC_LIB_PATH=`$GHC --print-libdir`
		AC_MSG_RESULT([$GHC_LIB_PATH])
	else
		AC_MSG_ERROR([
			      ** Sorry, your GHC is too old. GHC >= 5.02 required.
			      ])
		GHC=""
		GHCTYPE=""
	fi
else
	AC_MSG_ERROR([
		      ** Could not find GHC.
		      ])
fi

AC_SUBST(GHC)
AC_SUBST(GHC_LIB_PATH)

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AM_EXTRA_RECURSIVE_TARGETS([release_build_man_html release_push_man_html release_clean_man_html])
AC_OUTPUT(Makefile src/Makefile man/Makefile test/Makefile NEWS.md)
