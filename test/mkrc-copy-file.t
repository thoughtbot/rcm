  $ . "$TESTDIR/helper.sh"

Passing -C should copy the file

  $ echo 'Content' > .example

  $ mkrc -C .example >/dev/null

  $ refute "should not be a symlink" -h $HOME/.example

  $ cat $HOME/.example
  Content

  $ cat $HOME/.dotfiles/example
  Content
