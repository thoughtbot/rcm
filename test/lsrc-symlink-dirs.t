  $ . "$TESTDIR/helper.sh"

Overrides SYMLINK_DIRS with -s

  $ mkdir -p .dotfiles/eggplant_firetruck/lampshade
  > touch .dotfiles/eggplant_firetruck/lampshade/bottle

  $ echo 'SYMLINK_DIRS="eggplant_firetruck"' > $HOME/.rcrc

  $ lsrc
  /*/.eggplant_firetruck:/*/.dotfiles/eggplant_firetruck (glob)

  $ lsrc -s eggplant_firetruck
  /*/.eggplant_firetruck/lampshade/bottle:/*/.dotfiles/eggplant_firetruck/lampshade/bottle (glob)

  $ lsrc -S eggplant_firetruck -s eggplant_firetruck
  /*/.eggplant_firetruck/lampshade/bottle:/*/.dotfiles/eggplant_firetruck/lampshade/bottle (glob)
