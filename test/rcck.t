  $ . "$TESTDIR/helper.sh"

It finds broken symlinks in `$HOME`

  $ touch .example
  > ln -s .example .example-symlink
  > rm .example

  $ rcck
  remove $HOME/.example-symlink?
