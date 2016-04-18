  $ . "$TESTDIR/helper.sh"

mkrc should prefer ./rcrc to $HOME/.rcrc when RCRC is not set

  $ touch .example
  > mkdir .other-dotfiles

  $ mkdir hello
  $ echo 'DOTFILES_DIRS="$HOME/.other-dotfiles"' > $HOME/hello/rcrc
  $ echo 'DOTFILES_DIRS="$HOME/.bad"' > $HOME/.rcrc

  $ cd hello
  $ RCRC= mkrc -v $HOME/.example
  Moving...
  '*/.example' -> '*/.other-dotfiles/example' (glob)
  Linking...
  '*/.other-dotfiles/example' -> '*/.example' (glob)

  $ assert_linked "$HOME/.example" "$HOME/.other-dotfiles/example"
