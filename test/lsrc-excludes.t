  $ . "$TESTDIR/helper.sh"

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

Should accept directory:file syntax with wildcard directory

  $ lsrc -d .dotfiles -d .other-dotfiles -x *:excluded
  /*/.example:/*/.dotfiles/example (glob)
  /*/.included:/*/.other-dotfiles/included (glob)

Should handle excludes with globs

  $ mkdir -p fresh/hola/chao
  > touch fresh/hola/chao/wo
  > touch fresh/hola/chao/nemo
  > touch fresh/hola/tossala
  > touch fresh/hola/s
  > touch fresh/s

  $ lsrc -d fresh -x 'hola/chao/*' -x s
  /*/.hola/tossala:/*/fresh/hola/tossala (glob)

  $ lsrc -d fresh -x 'hola/chao' -x s
  /*/.hola/tossala:/*/fresh/hola/tossala (glob)

Should support wildcards in the excludes, including Emacs backup
files, and wildcards in directory specifier.

  $ rm -rf .dotfiles
  $ ( mkdir .dotfiles && cd .dotfiles && touch included README.md included~ README.md~ )

Should exclude multiple patterns including globs and plain names using -x argument

  $ lsrc -x README.md -x "*~"
  /*/.included:/*/.dotfiles/included (glob)

And the with directory tagged globs using -x with sole exclude

  $ lsrc -x "*:*~" | grep -v README.md
  /*/.included:/*/.dotfiles/included (glob)

And the with directory tagged globs using -x

  $ lsrc -x README.md -x "*:*~"
  /*/.included:/*/.dotfiles/included (glob)

And sanity check that directory tagged this work with just one exclude

  $ lsrc -x "*~" | grep -v README.md
  /*/.included:/*/.dotfiles/included (glob)
