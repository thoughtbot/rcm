  $ . "$TESTDIR/helper.sh"

mkrc should accept a custom rcrc

  $ touch .example
  > mkdir .other-dotfiles

  $ echo 'DOTFILES_DIRS="$HOME/.other-dotfiles"' > alt-rcrc

  $ RCRC=./alt-rcrc mkrc -v .example
  Moving...
  '*/.example' -> '*/.other-dotfiles/example' (glob)
  Linking...
  '*/.other-dotfiles/example' -> '*/.example' (glob)

  $ assert_linked "$HOME/.example" "$HOME/.other-dotfiles/example"
