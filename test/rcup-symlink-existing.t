  $ . "$TESTDIR/helper.sh"

Symlinks files even if they are identical

  $ mkdir -p .dotfiles
  > echo find-me > "$HOME/.door"
  > echo find-me > .dotfiles/door

  $ rcup
  > assert_linked "$HOME/.door" "$HOME/.dotfiles/door"
