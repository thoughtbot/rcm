  $ . "$TESTDIR/helper.sh"

Should create symlinks for files and directories, at the location specified by
the target metafile

  $ touch .dotfiles/example
  > mkdir .dotfiles/nested/
  > touch .dotfiles/nested/example
  > mkdir .dotfiles/nested/deeply
  > touch .dotfiles/nested/deeply/example

  $ mkdir "$HOME/.dotfiles2"
  > touch .dotfiles2/example
  > mkdir .dotfiles2/nested/
  > touch .dotfiles2/nested/example
  > mkdir .dotfiles2/nested/deeply
  > touch .dotfiles2/nested/deeply/example

  $ mkdir "$HOME/home2"
  > mkdir "$HOME/home3"
  > echo -e " \n\$BLAH\n$HOME/home2" > .dotfiles/target
  > echo -e " \n\$BLAH\n$HOME/home3" > .dotfiles2/target

  $ echo 'DOTFILES_DIRS="$HOME/.dotfiles2 $HOME/.dotfiles"' > $HOME/.rcrc

  $ rcup -v > /dev/null

  $ assert_linked "$HOME/home2/.example" "$HOME/.dotfiles/example"
  $ assert_linked "$HOME/home2/.nested/example" "$HOME/.dotfiles/nested/example"
  $ assert_linked "$HOME/home2/.nested/deeply/example" "$HOME/.dotfiles/nested/deeply/example"
  $ assert_linked "$HOME/home3/.example" "$HOME/.dotfiles2/example"
  $ assert_linked "$HOME/home3/.nested/example" "$HOME/.dotfiles2/nested/example"
  $ assert_linked "$HOME/home3/.nested/deeply/example" "$HOME/.dotfiles2/nested/deeply/example"
