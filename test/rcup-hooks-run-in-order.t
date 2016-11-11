  $ . "$TESTDIR/helper.sh"

Pre-up hooks should run in order according to their name

  $ mkdir -p .dotfiles/hooks/pre-up .dotfiles/hooks/post-up
  > printf "#!/bin/sh\necho '1'\n" > .dotfiles/hooks/pre-up/00-test.sh
  > printf "#!/bin/sh\necho '2'\n" > .dotfiles/hooks/pre-up/01-test.sh
  > printf "#!/bin/sh\necho '3'\n" > .dotfiles/hooks/pre-up/02-test.sh
  > printf "#!/bin/sh\necho '4'\n" > .dotfiles/hooks/post-up/00-test.sh
  > printf "#!/bin/sh\necho '5'\n" > .dotfiles/hooks/post-up/01-test.sh
  > printf "#!/bin/sh\necho '6'\n" > .dotfiles/hooks/post-up/02-test.sh

  $ chmod +x .dotfiles/hooks/pre-up/00-test.sh
  > chmod +x .dotfiles/hooks/pre-up/01-test.sh
  > chmod +x .dotfiles/hooks/pre-up/02-test.sh
  > chmod +x .dotfiles/hooks/post-up/00-test.sh
  > chmod +x .dotfiles/hooks/post-up/01-test.sh
  > chmod +x .dotfiles/hooks/post-up/02-test.sh

  $ rcup
  1
  2
  3
  4
  5
  6


Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  > rcup
  1
  2
  3
  4
  5
  6
