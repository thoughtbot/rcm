  $ source $SRC/test/helper.sh

Making an rc file should move it into dotfiles and create a symlink

  $ touch .example

  $ mkrc .example
  '.example' -> '*/.dotfiles/example' (glob)
  '*/.example' -> '*/.dotfiles/example' (glob)

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/example"

Making an rc file in a sub-directory should create the directories then
create a symlink

  $ mkdir .nested
  > touch .nested/example

  $ mkrc .nested/example
  '.nested/example' -> '*/.dotfiles/nested/example' (glob)
  '*/.nested/example' -> '*/.dotfiles/nested/example' (glob)

  $ assert_linked "$HOME/.nested/example" "$HOME/.dotfiles/nested/example"

Making an rc file in a deeply nested sub-directory should create all of
the required directories then create a symlink

  $ mkdir .nested/deeply
  > touch .nested/deeply/example

  $ mkrc .nested/deeply/example
  '.nested/deeply/example' -> '*/.dotfiles/nested/deeply/example' (glob)
  '*/.nested/deeply/example' -> '*/.dotfiles/nested/deeply/example' (glob)

  $ assert_linked "$HOME/.nested/deeply/example" "$HOME/.dotfiles/nested/deeply/example"
