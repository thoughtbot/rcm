  $ . "$TESTDIR/helper.sh"
  > mkdir -p .dotfiles/hooks
  > echo 'echo Pre' > .dotfiles/hooks/pre-up
  > echo 'echo Post' > .dotfiles/hooks/post-up
  > chmod +x .dotfiles/hooks/pre-up
  > chmod +x .dotfiles/hooks/post-up
  > touch .example
  > touch .example-2
  > touch .example-3

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

Avoids hooks by -K

  $ mkrc -K -v .example-2
  Moving...
  '*/.example-2' -> '*/.dotfiles/example-2' (glob)
  Linking...
  '*/.dotfiles/example-2' -> '*/.example-2' (glob)

Accepts -k for parity with rcup

  $ mkrc -k -v .example-3
  Moving...
  '*/.example-3' -> '*/.dotfiles/example-3' (glob)
  Linking...
  running pre-up hooks for */.dotfiles (glob)
  Pre
  '*/.dotfiles/example-3' -> '*/.example-3' (glob)
  running post-up hooks for */.dotfiles (glob)
  Post
