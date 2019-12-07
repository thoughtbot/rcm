  $ . "$TESTDIR/helper.sh"

Passing a linked file is rejected.
We need a second path not under what will be $HOME

  $ EXTDIR="${CRAMTMP}2"
  > mkdir -p "$EXTDIR"
  > echo 'Content' > "$EXTDIR/example"
  > ln -s "$EXTDIR/example" "$HOME/.example"

  $ mkrc .example
  '.example' is a symlink. Cannot process file.
  [1]

  $ refute "is a symlink" -h $HOME/.dotfiles/.example

Passing a file in one linked dir is rejected

  $ mkdir "$HOME/.config"
  > ln -s "$EXTDIR/" "$HOME/.config/tmpdir"

  $ mkrc -v .config/tmpdir/example
  '.config/tmpdir/example' path contains a symlink (tmpdir). Cannot process file.
  [1]

  $ refute "is a symlink" -h "$HOME/.dotfiles/config/tmpdir/example"
