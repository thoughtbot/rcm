  $ . "$TESTDIR/helper.sh"

Pre-down and post-down hooks should run by default

  $ mkdir -p .dotfiles/hooks
  > touch .dotfiles/hooks/{pre,post}-down
  > chmod +x .dotfiles/hooks/{pre,post}-down

  $ echo 'echo "example" > /tmp/test' > .dotfiles/hooks/pre-down
  > echo 'cat /tmp/test; rm /tmp/test' > .dotfiles/hooks/post-down

  $ rcdn
  example

Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  > rcup
  > rcdn
  example
