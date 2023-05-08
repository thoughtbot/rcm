  $ . "$TESTDIR/helper.sh"
  $ unset RCRC
  $ unset XDG_CONFIG_HOME
  $ unset XDG_DATA_HOME

Should support ~/.config/rcm/rcrc with ~/.dotfiles

  $ mkdir -p ~/.config/rcm
  $ touch ~/.config/rcm/rcrc
  $ mkdir -p .dotfiles
  > mkdir -p ".dotfiles/config/software2/"
  > touch ".dotfiles/config/software2/foobar"

  $ rcup
  > assert_linked "$HOME/.config/software2/foobar" "$HOME/.dotfiles/config/software2/foobar"
