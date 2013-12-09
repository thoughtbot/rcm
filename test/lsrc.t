  $ source $SRC/test/helper.sh

Should list the contents of ~/.dotfiles

  $ touch .dotfiles/example
  > mkdir .dotfiles/nested
  > touch .dotfiles/nested/example
  > mkdir .dotfiles/nested/deeply
  > touch .dotfiles/nested/deeply/example

  $ lsrc
  /*/.example:/*/.dotfiles/example (glob)
  /*/.nested/deeply/example:/*/.dotfiles/nested/deeply/example (glob)
  /*/.nested/example:/*/.dotfiles/nested/example (glob)
