  $ . "$TESTDIR/helper.sh"

The target for rcup should be specifiable in .rcrc and expand variables

  $ touch .dotfiles/example
  > mkdir "$HOME/target-rcrc"

  $ echo 'TARGET=$HOME/target-rcrc' > $HOME/.rcrc

  $ rcup -v > /dev/null

  $ assert_linked "$HOME/target-rcrc/.example" "$HOME/.dotfiles/example"

