  $ . "$TESTDIR/helper.sh"

no arguments should output usage information and exit EX_USAGE

  $ mkrc
  Usage: mkrc [-ChSsUuVvqo] [-t TAG] [-d DIR] [-B HOSTNAME] FILES ...
  see mkrc(1) and rcm(7) for more details
  [64]

-h should output usage information and exit 0

  $ mkrc -h
  Usage: mkrc [-ChSsUuVvqo] [-t TAG] [-d DIR] [-B HOSTNAME] FILES ...
  see mkrc(1) and rcm(7) for more details

Unsupported options should output usage information and exit EX_USAGE

  $ mkrc --version
  Usage: mkrc [-ChSsUuVvqo] [-t TAG] [-d DIR] [-B HOSTNAME] FILES ...
  see mkrc(1) and rcm(7) for more details
  [64]
