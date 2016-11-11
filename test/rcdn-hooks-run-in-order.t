  $ . "$TESTDIR/helper.sh"

Pre-down and post-down hooks should run in order according to their name

  $ mkdir -p .dotfiles/hooks/pre-down .dotfiles/hooks/post-down
  > printf "#!/bin/bash\necho '1'\n" > .dotfiles/hooks/pre-down/00-test.sh
  > printf "#!/bin/bash\necho '2'\n" > .dotfiles/hooks/pre-down/01-test.sh
  > printf "#!/bin/bash\necho '3'\n" > .dotfiles/hooks/pre-down/02-test.sh
  > printf "#!/bin/bash\necho '4'\n" > .dotfiles/hooks/post-down/00-test.sh
  > printf "#!/bin/bash\necho '5'\n" > .dotfiles/hooks/post-down/01-test.sh
  > printf "#!/bin/bash\necho '6'\n" > .dotfiles/hooks/post-down/02-test.sh

  $ chmod +x .dotfiles/hooks/pre-down/00-test.sh
  > chmod +x .dotfiles/hooks/pre-down/01-test.sh
  > chmod +x .dotfiles/hooks/pre-down/02-test.sh
  > chmod +x .dotfiles/hooks/post-down/00-test.sh
  > chmod +x .dotfiles/hooks/post-down/01-test.sh
  > chmod +x .dotfiles/hooks/post-down/02-test.sh

  $ rcdn
  1
  2
  3
  4
  5
  6


Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  > rcdn
  1
  2
  3
  4
  5
  6

