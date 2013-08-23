  $ . "$TESTDIR/helper.sh"

Should create symlinks for files and directories

  $ touch .dotfiles/example
  > mkdir .dotfiles/nested/
  > touch .dotfiles/nested/example
  > mkdir .dotfiles/nested/deeply
  > touch .dotfiles/nested/deeply/example

  $ rcup >/dev/null

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/example"
  $ assert_linked "$HOME/.nested/example" "$HOME/.dotfiles/nested/example"
  $ assert_linked "$HOME/.nested/deeply/example" "$HOME/.dotfiles/nested/deeply/example"
