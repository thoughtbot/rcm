  $ . "$TESTDIR/helper.sh"
  $ unset RCRC
  $ unset XDG_CONFIG_HOME
  $ unset XDG_DATA_HOME

Should support complete XDG-style directories and configuration

  $ mkdir -p .local/share/rcm/dotfiles
  > mkdir -p ".local/share/rcm/dotfiles/config"
  > mkdir -p ".local/share/rcm/dotfiles/config/software1"
  > mkdir -p ".local/share/rcm/dotfiles/config/software4"
  > touch ".local/share/rcm/dotfiles/config/software1/config"
  > touch ".local/share/rcm/dotfiles/config/software4/config"
  > touch ".local/share/rcm/dotfiles/config/software4/more"

  $ rcup
  > assert_linked "$HOME/.config/software1/config" "$HOME/.local/share/rcm/dotfiles/config/software1/config"
  > assert_linked "$HOME/.config/software4/config" "$HOME/.local/share/rcm/dotfiles/config/software4/config"
  > assert_linked "$HOME/.config/software4/more" "$HOME/.local/share/rcm/dotfiles/config/software4/more"
