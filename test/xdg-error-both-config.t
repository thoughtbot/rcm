  $ . "$TESTDIR/helper.sh"
  $ unset RCRC
  $ unset XDG_CONFIG_HOME
  $ unset XDG_DATA_HOME

Should exit when using both ~/.rcrc and ~/.config/rcm/rcrc

  $ mkdir -p ~/.config/rcm
  $ touch ~/.config/rcm/rcrc
  $ touch ~/.rcrc
  $ rcup
  Both \/[\/\d\w_.-]+\.rcrc and \/[\/\d\w_.-]+\.config\/rcm\/rcrc exists\. Please remove one to use rcm (re)
  [1]
