  $ . "$TESTDIR/helper.sh"

Use a pre-generated UUID in a filename to make sure the filename is unique to this test
and also that the pre-up hook has found the right directory having found this file.

  $ uniquish_file_prefix='test-hooks-run-in-situ-'
  > uuid='820a557b-1acb-4e86-8c5b-feb2536b5777'
  > uniquish_file=${uniquish_file_prefix}${uuid}

Pre-up and post-up hooks should run by default. More importantly the hooks\' cwd should
be the directory where they are situated. We test this by trying to find $uniquish_file.

  $ touch .dotfiles/$uniquish_file
  > mkdir -p .dotfiles/hooks/pre-up .dotfiles/hooks/post-up
  > touch .dotfiles/hooks/pre-up/00-test.sh .dotfiles/hooks/post-up/00-test.sh
  > chmod +x .dotfiles/hooks/pre-up/00-test.sh .dotfiles/hooks/post-up/00-test.sh

  $ echo "echo ../../${uniquish_file_prefix}* > /tmp/test-$uuid" > .dotfiles/hooks/pre-up/00-test.sh
  > echo "cat /tmp/test-$uuid; rm /tmp/test-$uuid" > .dotfiles/hooks/post-up/00-test.sh

  $ rcup
  ../../test-hooks-run-in-situ-820a557b-1acb-4e86-8c5b-feb2536b5777

Ensure that hooks run when output of lsrc is non-empty
  $ touch .dotfiles/testrc
  > rcup
  ../../test-hooks-run-in-situ-820a557b-1acb-4e86-8c5b-feb2536b5777
