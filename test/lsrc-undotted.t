  $ . "$TESTDIR/helper.sh"

Should undot files with -U

  $ touch .dotfiles/example
  > touch .dotfiles/undotted

  $ lsrc -U undotted
  /*/.example:/*/.dotfiles/example (glob)
  /*/undotted:/*/.dotfiles/undotted (glob)

