  $ . "$TESTDIR/helper.sh"

Overrides SYMLINK_DIRS with -s

  $ mkdir -p .dotfiles/eggplant_firetruck/lampshade
  > touch .dotfiles/eggplant_firetruck/lampshade/bottle

  $ echo 'SYMLINK_DIRS="eggplant_firetruck"' > $HOME/.rcrc

  $ rcup -s eggplant_firetruck
  $ assert_linked "$HOME/.eggplant_firetruck/lampshade/bottle" "$HOME/.dotfiles/eggplant_firetruck/lampshade/bottle"
