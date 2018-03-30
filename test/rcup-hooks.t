  $ . "$TESTDIR/helper.sh"

Pre-up and post-up hooks should run by default

  $ mkdir -p .dotfiles/hooks
  > touch .dotfiles/hooks/pre-up .dotfiles/hooks/post-up
  > chmod +x .dotfiles/hooks/pre-up .dotfiles/hooks/post-up

  $ echo 'echo "example" > /tmp/test' > .dotfiles/hooks/pre-up
  > echo 'cat /tmp/test; rm /tmp/test' > .dotfiles/hooks/post-up

  $ /usr/bin/env -i PATH="$PATH" HOME="$HOME" RCRC="$RCRC" RCM_LIB="$RCM_LIB" rcup
  example

Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  $ /usr/bin/env -i PATH="$PATH" HOME="$HOME" RCRC="$RCRC" RCM_LIB="$RCM_LIB" rcup
  example
