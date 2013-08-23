  $ . "$TESTDIR/helper.sh"

no arguments should output usage information and exit 1

  $ mkrc
  Usage: mkrc [-hvqo] [-t TAG] [-d DIR] FILES ...
  see mkrc(1) and rcm(5) for more details
  [1]

-h should output usage information and exit 0

  $ mkrc -h
  Usage: mkrc [-hvqo] [-t TAG] [-d DIR] FILES ...
  see mkrc(1) and rcm(5) for more details
