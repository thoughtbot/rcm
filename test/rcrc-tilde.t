  $ . "$TESTDIR/helper.sh"

rcrc should accept a DOTFILES_DIR with a ~ instead of $HOME

  $ mkdir ~/.other-dotfiles
  > touch ~/.other-dotfiles/o-example

  $ echo 'DOTFILES_DIRS="~/.other-dotfiles"' > alt-rcrc
  $ RCRC=./alt-rcrc lsrc
  /*/.o-example:/*/.other-dotfiles/o-example (glob)
