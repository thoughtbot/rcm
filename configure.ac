#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT(rcm, 1.2.2, mburns@thoughtbot.com)
AM_INIT_AUTOMAKE

# Checks for programs.
case "$host_os" in
solaris*)
    AC_PATH_PROGS(POSIX_SHELL, [ksh93 ksh sh])
    SHELL="$POSIX_SHELL"
    ;;
esac
AC_SUBST([SHELL])

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AM_EXTRA_RECURSIVE_TARGETS([release_build_man_html release_push_man_html release_clean_man_html])
AC_OUTPUT(Makefile bin/Makefile man/Makefile share/Makefile test/Makefile share/rcm.sh NEWS.md bin/lsrc bin/mkrc bin/rcdn bin/rcup)
