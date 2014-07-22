  $ . "$TESTDIR/helper.sh"
  > touch random-dotfile

Passing -U should make a file be undotted

  $ mkrc -U random-dotfile  >/dev/null

  $ assert_linked "$HOME/random-dotfile" "$HOME/.dotfiles/random-dotfile"
