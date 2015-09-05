  $ . "$TESTDIR/helper.sh"

Use a pre-generated UUID in a filename to make sure the filename is unique to this test
and also that the pre-down hook has found the right directory having found this file.

  $ uniquish_file_prefix='test-hooks-run-in-situ-'
  > uuid='5b811e03-5977-40e6-80ef-dd6c35013e56'
  > uniquish_file=${uniquish_file_prefix}${uuid}

Pre-down and post-down hooks should run by default. More importantly the hooks\' cwd should
be the directory where they are situated. We test this by trying to find $uniquish_file.

  $ touch .dotfiles/$uniquish_file
  > mkdir -p .dotfiles/hooks/pre-down .dotfiles/hooks/post-down
  > touch .dotfiles/hooks/pre-down/00-test.sh .dotfiles/hooks/post-down/00-test.sh
  > chmod +x .dotfiles/hooks/pre-down/00-test.sh .dotfiles/hooks/post-down/00-test.sh

  $ echo "echo ../../${uniquish_file_prefix}* > /tmp/test-$uuid" > .dotfiles/hooks/pre-down/00-test.sh
  > echo "cat /tmp/test-$uuid; rm /tmp/test-$uuid" > .dotfiles/hooks/post-down/00-test.sh

  $ rcdn
  ../../test-hooks-run-in-situ-5b811e03-5977-40e6-80ef-dd6c35013e56

Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  > rcup
  > rcdn
  ../../test-hooks-run-in-situ-5b811e03-5977-40e6-80ef-dd6c35013e56
