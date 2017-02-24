  $ . "$TESTDIR/helper.sh"

Should create symlinks for files in directories with whitespace in their names

  $ mkdir .dotfiles/sub\ dir
  > touch .dotfiles/sub\ dir/example

  $ rcup >/dev/null

  $ assert_linked "$HOME/.sub dir/example" "$HOME/.dotfiles/sub dir/example"
