  $ . "$TESTDIR/helper.sh"

Information should be read from ~/.rcrc by default

  $ touch .example
  > mkdir .other-dotfiles

  $ echo 'DOTFILES_DIRS="$HOME/.other-dotfiles"' > $HOME/.rcrc

  $ mkrc -v .example
  Moving...
  '*/.example' -> '*/.other-dotfiles/example' (glob)
  Linking...
  '*/.other-dotfiles/example' -> '*/.example' (glob)

  $ assert_linked "$HOME/.example" "$HOME/.other-dotfiles/example"
