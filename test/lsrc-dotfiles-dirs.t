  $ source $SRC/test/helper.sh

Should include all the dotfiles

  $ touch .dotfiles/example
  > mkdir .second-dotfiles/
  > touch .second-dotfiles/s-example
  > mkdir .third-dotfiles/
  > touch .third-dotfiles/t-example

  $ lsrc -d .second-dotfiles -d .third-dotfiles
  /*/.s-example:/*/.second-dotfiles/s-example (glob)
  /*/.t-example:/*/.third-dotfiles/t-example (glob)
