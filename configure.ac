#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT(rcm, 1.2.4, mburns@thoughtbot.com)
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE

# Checks for programs.
case "$host_os" in
solaris*)
    AC_PATH_PROGS(POSIX_SHELL, [ksh93 ksh sh])
    SHELL="$POSIX_SHELL"
    ;;
esac
AC_SUBST([SHELL])

AX_PROG_FIND_W_EXECDIR
if test -n "$FIND"; then
    FIND_HAS_EXECDIR=yes
    FIND_EXEC_SNIPPET="$srcdir/m4/prog-find-w-execdir.snippet.txt"
else
    FIND_HAS_EXECDIR=no
    AC_PATH_PROGS(FIND_WO_EXECDIR, [gfind find])
    FIND="$FIND_WO_EXECDIR"
    FIND_EXEC_SNIPPET="$srcdir/m4/prog-find-wo-execdir.snippet.txt"
fi
AC_SUBST([FIND])
AC_SUBST([FIND_HAS_EXECDIR])
AC_SUBST_FILE([FIND_EXEC_SNIPPET])

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_OUTPUT(Makefile bin/Makefile man/Makefile share/Makefile test/Makefile share/rcm.sh arch/git-PKGBUILD NEWS.md bin/lsrc bin/mkrc bin/rcdn bin/rcup maint/release)
