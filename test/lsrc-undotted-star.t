  $ . "$TESTDIR/helper.sh"

Should undot files with -U, with wildcard * expansion

  $ touch .dotfiles/example
  > touch .dotfiles/undotted

  $ lsrc -v -U '*'
  /*/example:/*/.dotfiles/example (glob)
  /*/undotted:/*/.dotfiles/undotted (glob)

  $ lsrc -v -U '*:*'
  /*/example:/*/.dotfiles/example (glob)
  /*/undotted:/*/.dotfiles/undotted (glob)
