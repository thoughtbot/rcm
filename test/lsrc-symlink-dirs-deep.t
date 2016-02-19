  $ . "$TESTDIR/helper.sh"

Allows nested SYMLINK_DIRS

  $ mkdir -p .dotfiles/dir/subdir/subsubdir-a
  > mkdir -p .dotfiles/dir/subdir/subsubdir-b
  > touch .dotfiles/dir/subdir/subsubdir-a/file1
  > touch .dotfiles/dir/subdir/subsubdir-b/file2
  > touch .dotfiles/dir/subdir/subsubdir-b/file3

  $ echo 'SYMLINK_DIRS="dir/subdir"' > $HOME/.rcrc

  $ lsrc
  /*/.dir/subdir:/*/.dotfiles/dir/subdir (glob)
