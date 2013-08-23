  $ source $SRC/test/helper.sh

Should exclude items with -x

  $ touch .dotfiles/example
  > touch .dotfiles/excluded

  $ lsrc -x excluded
  /*/.example:/*/.dotfiles/example (glob)

Should accept directory:file syntax

  $ mkdir .other-dotfiles
  > touch .other-dotfiles/included
  > touch .other-dotfiles/excluded

  $ lsrc -d .dotfiles -d .other-dotfiles -x other-dotfiles:excluded
  /*/.example:/*/.dotfiles/example (glob)
  /*/.excluded:/*/.dotfiles/excluded (glob)
  /*/.included:/*/.other-dotfiles/included (glob)
