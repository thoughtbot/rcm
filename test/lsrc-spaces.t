  $ . "$TESTDIR/helper.sh"

Should handle dotfiles with spaces

  $ touch ".dotfiles/sublame text 3.config"

  $ lsrc 
  /*/.sublame text 3.config:/*/.dotfiles/sublame text 3.config (glob)
