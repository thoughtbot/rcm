  $ . "$TESTDIR/helper.sh"

Use the first existing dotfiles location
$HOME/.dotfiles is created at test time

  $ touch .example

  $ mkrc -d .missing-dotfiles .example  >/dev/null

  $ assert_linked "$HOME/.example" "$HOME/.dotfiles/example"

Exit when no location found

  $ mv .dotfiles .dotfiles-error

  $ touch .exampleno

  $ mkrc -d .missing-dotfiles .exampleno  >/dev/null
  No dotfiles directories found in .missing-dotfiles */share/rcm/dotfiles (glob)
  [1]

  $ refute "should not be a symlink" -h $HOME/.examplenob

