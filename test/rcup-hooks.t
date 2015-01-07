  $ . "$TESTDIR/helper.sh"

Pre-down and post-down hooks should run by default

  $ mkdir -p .dotfiles/hooks
  > touch .dotfiles/hooks/{pre,post}-up
  > chmod +x .dotfiles/hooks/{pre,post}-up

  $ echo 'echo "example" > /tmp/test' > .dotfiles/hooks/pre-up
  > echo 'cat /tmp/test; rm /tmp/test' > .dotfiles/hooks/post-up

  $ rcup
  example

Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  > rcup
  example
