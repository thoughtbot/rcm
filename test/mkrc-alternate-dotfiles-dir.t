  $ . "$TESTDIR/helper.sh"
  > mkdir .other-dotfiles

Passing -d should specify alternate dotfiles location

  $ touch .example

  $ mkrc -d .other-dotfiles .example  >/dev/null

  $ assert_linked "$HOME/.example" "$HOME/.other-dotfiles/example"
