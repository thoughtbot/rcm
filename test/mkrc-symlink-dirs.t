  $ . "$TESTDIR/helper.sh"

Overrides SYMLINK_DIRS with -s

  $ mkdir -p .eggplant_firetruck/lampshade
  > touch .eggplant_firetruck/lampshade/bottle

  $ mkdir -p .boxing_card
  > touch .boxing_card/fragrance

  $ echo 'SYMLINK_DIRS="eggplant_firetruck boxing_card"' > $HOME/.rcrc

  $ mkrc -v .boxing_card
  Moving...
  '/*/.boxing_card' -> '/*/.dotfiles/boxing_card' (glob)
  Linking...
  '/*/.dotfiles/boxing_card' -> '/*/.boxing_card' (glob)

  $ mkrc -vs .eggplant_firetruck
  Moving...
  '/*/.eggplant_firetruck' -> '/*/.dotfiles/eggplant_firetruck' (glob)
  Linking...
  '/*/.dotfiles/eggplant_firetruck/lampshade/bottle' -> '/*/.eggplant_firetruck/lampshade/bottle' (glob)
