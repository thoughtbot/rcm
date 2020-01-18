  $ . "$TESTDIR/helper.sh"

Keeps globs as globs

  $ mkdir vimulator
  > lsrc -vvv -x '*vim*' 2>&1 | grep exclude_file_globs
  exclude_file_globs: *vim*
