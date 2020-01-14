  $ . "$TESTDIR/helper.sh"

The target for rcup should be specifiable on the command line

  $ touch .dotfiles/example
  > mkdir "$HOME/target2"

  $ echo 'TARGET="$HOME/target2"' > $HOME/.rcrc

  $ rcup -v > /dev/null

  $ assert_linked "$HOME/target2/.example" "$HOME/.dotfiles/example"

