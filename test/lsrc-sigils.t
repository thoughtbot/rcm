  $ . "$TESTDIR/helper.sh"

Should print @ for links

  $ touch .dotfiles/example

  $ lsrc -F
  /*/.example:/*/.dotfiles/example:@ (glob)

Should print X for files in COPY_ALWAYS

  $ touch .dotfiles/copy

  $ COPY_ALWAYS=copy lsrc -F
  /*/.copy:/*/.dotfiles/copy:X (glob)
  /*/.example:/*/.dotfiles/example:@ (glob)
