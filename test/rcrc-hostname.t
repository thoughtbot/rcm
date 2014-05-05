  $ . "$TESTDIR/helper.sh"

The hostname can be set in ~/.rcrc

  $ touch .dotfiles/example
  > mkdir .dotfiles/host-$(hostname)
  > touch .dotfiles/host-$(hostname)/h-example
  > mkdir .dotfiles/host-eggplant_firetruck
  > touch .dotfiles/host-eggplant_firetruck/nh-example
  > mkdir .dotfiles/host-haircut_hammer
  > touch .dotfiles/host-haircut_hammer/nh-example

  $ echo 'HOSTNAME="eggplant_firetruck"' > $HOME/.rcrc

  $ lsrc
  /*/.example:/*/.dotfiles/example (glob)
  /*/.nh-example:/*/.dotfiles/host-eggplant_firetruck/nh-example (glob)

  $ lsrc -B haircut_hammer
  /*/.example:/*/.dotfiles/example (glob)
  /*/.nh-example:/*/.dotfiles/host-haircut_hammer/nh-example (glob)
