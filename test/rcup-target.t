  $ . "$TESTDIR/helper.sh"

Should be able to modify the global dotfiles target using a command line argument

  $ touch .dotfiles/example
  > mkdir "$HOME/target"

  $ rcup -v -T "$HOME/target" > /dev/null

  $ assert_linked "$HOME/target/.example" "$HOME/.dotfiles/example"
