  $ . "$TESTDIR/helper.sh"

Should include entries that match hostname

  $ touch .dotfiles/example
  > mkdir .dotfiles/host-$(hostname)
  > touch .dotfiles/host-$(hostname)/h-example
  > mkdir .dotfiles/host-not-hostname
  > touch .dotfiles/host-not-hostname/nh-example

  $ lsrc
  /*/.h-example:/*/.dotfiles/host-*/h-example (glob)
  /*/.example:/*/.dotfiles/example (glob)

  $ lsrc -B not-hostname
  /*/.nh-example:/*/.dotfiles/host-*/nh-example (glob)
  /*/.example:/*/.dotfiles/example (glob)
