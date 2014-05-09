  $ . "$TESTDIR/helper.sh"

no arguments should output usage information and exit 1

  $ mkrc
  Usage: mkrc [-ChSsVvqo] [-t TAG] [-d DIR] [-B HOSTNAME] FILES ...
  see mkrc(1) and rcm(7) for more details
  [1]

-h should output usage information and exit 0

  $ mkrc -h
  Usage: mkrc [-ChSsVvqo] [-t TAG] [-d DIR] [-B HOSTNAME] FILES ...
  see mkrc(1) and rcm(7) for more details
