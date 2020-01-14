  $ . "$TESTDIR/helper.sh"

Should create symlinks for files and directories, at the location specified by
the target metafile, with trailing forward slash

  $ touch .dotfiles/example
  > mkdir .dotfiles/nested/
  > touch .dotfiles/nested/example
  > mkdir .dotfiles/nested/deeply
  > touch .dotfiles/nested/deeply/example

  $ mkdir "$HOME/home2"
  > echo "$HOME/home2/" > .dotfiles/target

  $ rcup -v > /dev/null

  $ assert_linked "$HOME/home2/.example" "$HOME/.dotfiles/example"
  $ assert_linked "$HOME/home2/.nested/example" "$HOME/.dotfiles/nested/example"
  $ assert_linked "$HOME/home2/.nested/deeply/example" "$HOME/.dotfiles/nested/deeply/example"
