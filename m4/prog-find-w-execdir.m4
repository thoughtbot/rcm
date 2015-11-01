# AX_PROG_FIND_W_EXECDIR
# ------------
# Check for a find(1) that has the `-execdir` action.
AC_DEFUN([AX_PROG_FIND_W_EXECDIR],
[AC_CACHE_CHECK([for a find that has the -execdir action],
                [ac_cv_path_FIND],
                [_$0([FIND],
                     [find gfind],
                     [. -execdir sh -c 'echo hello file $[1]' arg0 '{}' \;])])
 FIND="$ac_cv_path_FIND"
 AC_SUBST([FIND])dnl
]) # AX_PROG_FIND_W_EXECDIR


# _AX_PROG_FIND_W_EXECDIR(VARIABLE, PROGNAME-LIST, PROG-ARGUMENTS)
# ----------------------------------------------------------------
m4_define([_AX_PROG_FIND_W_EXECDIR],
[AC_PATH_PROGS_FEATURE_CHECK([$1], [$2],
                             ["$ac_path_$1" $3 2>/dev/null | grep 'hello file' >/dev/null 2>&1 &&
                              ac_cv_path_$1="$ac_path_$1" &&
                              ac_path_$1_found=':'],
                             [AC_MSG_WARN([no acceptable find(1) with -execdir could be found in \$PATH])])dnl
]) # _AX_PROG_FIND_W_EXECDIR
