  $ . "$TESTDIR/helper.sh"

-h should output usage information and exit 0

  $ lsrc -h
  Usage: lsrc [-FhqVv] [-B HOSTNAME] [-d DOT_DIR] [-I EXCL_PAT] [-S EXCL_PAT] [-s EXCL_PAT] [-t TAG] [-U EXCL_PAT] [-u EXCL_PAT] [-x EXCL_PAT]
  see lsrc(1) and rcm(7) for more details

Unsupported options should output usage information and exit EX_USAGE

  $ lsrc --version
  Usage: lsrc [-FhqVv] [-B HOSTNAME] [-d DOT_DIR] [-I EXCL_PAT] [-S EXCL_PAT] [-s EXCL_PAT] [-t TAG] [-U EXCL_PAT] [-u EXCL_PAT] [-x EXCL_PAT]
  see lsrc(1) and rcm(7) for more details
  [64]
