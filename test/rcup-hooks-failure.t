  $ . "$TESTDIR/helper.sh"

Pre-up hooks failing should prevent rcup continuing

  $ mkdir -p .dotfiles/hooks/pre-up
  > printf "#!/bin/sh\necho '1'\nexit 7\n" > .dotfiles/hooks/pre-up/00-test.sh
  > printf "#!/bin/sh\necho '2'\n" > .dotfiles/hooks/pre-up/01-test.sh

  $ chmod +x .dotfiles/hooks/pre-up/00-test.sh
  > chmod +x .dotfiles/hooks/pre-up/01-test.sh

  $ rcup
  1
  pre-up hook */.dotfiles/hooks/pre-up/00-test.sh exited non-zero (7) (glob)
  [7]
