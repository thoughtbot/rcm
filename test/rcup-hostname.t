  $ . "$TESTDIR/helper.sh"

Should create symlinks for files and directories in the hostname

  $ touch .dotfiles/example
  > mkdir .dotfiles/host-awesome_host/
  > touch .dotfiles/host-awesome_host/example2
  > mkdir .dotfiles/host-$(hostname)/
  > touch .dotfiles/host-$(hostname)/example3

  $ rcup -B awesome_host > /dev/null

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/example"
  $ assert_linked "$HOME/.example2" "$HOME/.dotfiles/host-awesome_host/example2"
