  $ . "$TESTDIR/helper.sh"

Pre-down hooks failing should prevent rcdn continuing

  $ mkdir -p .dotfiles/hooks/pre-down
  > printf "#!/bin/sh\necho '1'\nexit 7\n" > .dotfiles/hooks/pre-down/00-test.sh
  > printf "#!/bin/sh\necho '2'\n" > .dotfiles/hooks/pre-down/01-test.sh

  $ chmod +x .dotfiles/hooks/pre-down/00-test.sh
  > chmod +x .dotfiles/hooks/pre-down/01-test.sh

  $ rcdn
  1
  pre-down hook */.dotfiles/hooks/pre-down/00-test.sh exited non-zero (7) (glob)
  [7]

