  $ . "$TESTDIR/helper.sh"

-h should output usage information and exit 0

  $ rcck -h
  Usage: rcck
  see rcck(1) and rcm(7) for more details

Unsupported options should output usage information and exit EX_USAGE

  $ rcck --version
  Usage: rcck
  see rcck(1) and rcm(7) for more details
  [64]
