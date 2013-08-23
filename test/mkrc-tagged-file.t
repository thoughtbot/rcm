  $ . "$TESTDIR/helper.sh"

Passing -t should put it in a tag

  $ touch .example

  $ mkrc -t foo .example >/dev/null

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/tag-foo/example"
