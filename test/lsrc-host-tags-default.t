  $ . "$TESTDIR/helper.sh"

Hosts override tags override defaults

  $ touch .dotfiles/host-example
  > touch .dotfiles/tag-example
  > touch .dotfiles/default-example
  > mkdir .dotfiles/tag-firetruck
  > touch .dotfiles/tag-firetruck/host-example
  > touch .dotfiles/tag-firetruck/tag-example
  > mkdir .dotfiles/host-eggplant
  > touch .dotfiles/host-eggplant/host-example

  $ lsrc -B eggplant -t firetruck
  /*/.host-example:/*/.dotfiles/host-eggplant/host-example (glob)
  /*/.tag-example:/*/.dotfiles/tag-firetruck/tag-example (glob)
  /*/.default-example:/*/.dotfiles/default-example (glob)
