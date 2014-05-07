  $ . "$TESTDIR/helper.sh"

Able to override the hostname

  $ touch .example

  $ mkrc -B another_thing .example >/dev/null

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/host-another_thing/example"
