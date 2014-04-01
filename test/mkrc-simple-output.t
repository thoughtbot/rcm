  $ . "$TESTDIR/helper.sh"

Making an rc file should move it into dotfiles and create a symlink

  $ touch .example

  $ mkrc -v .example
  Moving...
  '*/.example' -> '*/.dotfiles/example' (glob)
  Linking...
  '*/.dotfiles/example' -> '*/.example' (glob)

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/example"

Making an rc file in a sub-directory should create the directories then
create a symlink

  $ mkdir .nested
  > touch .nested/example

  $ mkrc -v .nested/example
  Moving...
  '*/.nested/example' -> '*/.dotfiles/nested/example' (glob)
  Linking...
  '*/.dotfiles/nested/example' -> '*/.nested/example' (glob)

  $ assert_linked "$HOME/.nested/example" "$HOME/.dotfiles/nested/example"

Making an rc file in a deeply nested sub-directory should create all of
the required directories then create a symlink

  $ mkdir .nested/deeply
  > touch .nested/deeply/example

  $ mkrc -v .nested/deeply/example
  Moving...
  '*/.nested/deeply/example' -> '*/.dotfiles/nested/deeply/example' (glob)
  Linking...
  '*/.dotfiles/nested/deeply/example' -> '*/.nested/deeply/example' (glob)

  $ assert_linked "$HOME/.nested/deeply/example" "$HOME/.dotfiles/nested/deeply/example"

Making a relative rc file being in a sub-directory should move into dotfiles
preserving the full path then symlink

  $ touch .nested/deeply/another_example
  > cd .nested/deeply

  $ mkrc -v another_example
  Moving...
  '*/.nested/deeply/another_example' -> '*/.dotfiles/nested/deeply/another_example' (glob)
  Linking...
  '*/.dotfiles/nested/deeply/another_example' -> '*/.nested/deeply/another_example' (glob)

  $ assert_linked "$HOME/.nested/deeply/another_example" "$HOME/.dotfiles/nested/deeply/another_example"
