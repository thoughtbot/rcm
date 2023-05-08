  $ . "$TESTDIR/helper.sh"
  $ unset RCRC
  $ unset XDG_CONFIG_HOME
  $ unset XDG_DATA_HOME

Should allow when ~/.rcrc is a symlink to ~/.config/rcm/rcrc

  $ mkdir -p ~/.config/rcm
  $ touch ~/.config/rcm/rcrc
  $ ln -s ~/.config/rcm/rcrc ~/.rcrc
  $ rcup
