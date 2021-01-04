  $ . "$TESTDIR/helper.sh"
  > mkdir -p .dotfiles/hooks
  > echo 'echo Pre' > .dotfiles/hooks/pre-up
  > echo 'echo Post' > .dotfiles/hooks/post-up
  > chmod +x .dotfiles/hooks/{pre-up,post-up}
  > touch .example

Making an rc file runs pre- and post-up hooks

  $ mkrc -v .example
  Moving...
  '*/.example' -> '*/.dotfiles/example' (glob)
  Linking...
  running pre-up hooks for */.dotfiles (glob)
  Pre
  '*/.dotfiles/example' -> '*/.example' (glob)
  running post-up hooks for */.dotfiles (glob)
  Post
