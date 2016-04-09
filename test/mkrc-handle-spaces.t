  $ . "$TESTDIR/helper.sh"

Making an rc file should move it into dotfiles and create a symlink

  $ touch .file\ with\ spaces

  $ mkrc -v .file\ with\ spaces
  Moving...
  '*/.file\ with\ spaces' -> '*/.dotfiles/file\ with\ spaces' (glob)
  Linking...
  '*/.dotfiles/file\ with\ spaces' -> '*/.file\ with\ spaces' (glob)

  $ assert_linked "$HOME/.file\ with\ spaces" "$HOME/.dotfiles/file\ with\ spaces"