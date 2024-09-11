  $ . "$TESTDIR/helper.sh"
  $ unset RCRC
  $ unset XDG_CONFIG_HOME
  $ unset XDG_DATA_HOME

Should prefer ~/.local/share/rcm/dotfiles over ~/.dotfiles

  $ mkdir -p .dotfiles
  > mkdir -p .dotfiles/config/software3/
  > touch ".dotfiles/config/software3/traditional-config"
  $ mkdir -p .local/share/rcm/dotfiles
  > mkdir -p .local/share/rcm/dotfiles/config/software3
  > touch ".local/share/rcm/dotfiles/config/software3/xdg-config"

  $ rcup
  > assert_linked "$HOME/.config/software3/xdg-config" "$HOME/.local/share/rcm/dotfiles/config/software3/xdg-config"
  > refute "used ~/.dotfiles" -r $HOME/.config/software3/traditional-config
