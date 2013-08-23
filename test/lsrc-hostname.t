  $ source $SRC/test/helper.sh

Should include entries that match hostname

  $ touch .dotfiles/example
  > mkdir .dotfiles/host-$(hostname)
  > touch .dotfiles/host-$(hostname)/h-example
  > mkdir .dotfiles/host-not-hostname
  > touch .dotfiles/host-not-hostname/nh-example

  $ lsrc
  /*/.example:/*/.dotfiles/example (glob)
  /*/.h-example:/*/.dotfiles/host-*/h-example (glob)
