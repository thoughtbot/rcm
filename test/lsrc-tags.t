  $ . "$TESTDIR/helper.sh"

Should include entries that match passed tags

  $ touch .dotfiles/example
  > mkdir .dotfiles/tag-foo
  > touch .dotfiles/tag-foo/f-example
  > mkdir .dotfiles/tag-bar
  > touch .dotfiles/tag-bar/b-example

  $ lsrc -t foo -t bar
  /*/.f-example:/*/.dotfiles/tag-foo/f-example (glob)
  /*/.b-example:/*/.dotfiles/tag-bar/b-example (glob)
  /*/.example:/*/.dotfiles/example (glob)
