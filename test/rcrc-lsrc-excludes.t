  $ . "$TESTDIR/helper.sh"

Should exclude items with EXCLUDES=

  $ touch .dotfiles/example
  > touch .dotfiles/excluded

  $ echo 'EXCLUDES=excluded' > $HOME/.rcrc

  $ lsrc
  /*/.example:/*/.dotfiles/example (glob)

Should accept directory:file syntax

  $ mkdir .other-dotfiles
  > touch .other-dotfiles/included
  > touch .other-dotfiles/excluded

  $ echo 'EXCLUDES="other-dotfiles:excluded"'             > ~/.rcrc
  $ echo 'DOTFILES_DIRS="~/.dotfiles ~/.other-dotfiles"' >> ~/.rcrc

  $ lsrc
  /*/.example:/*/.dotfiles/example (glob)
  /*/.excluded:/*/.dotfiles/excluded (glob)
  /*/.included:/*/.other-dotfiles/included (glob)

Should handle excludes with globs

  $ mkdir -p fresh/hola/chao
  > touch fresh/hola/chao/wo
  > touch fresh/hola/chao/nemo
  > touch fresh/hola/tossala
  > touch fresh/hola/s
  > touch fresh/s

  $ echo 'EXCLUDES="hola/chao/* s"'           > ~/.rcrc
  $ lsrc -d fresh
  /*/.hola/tossala:/*/fresh/hola/tossala (glob)

  $ echo 'EXCLUDES="hola/chao s"'             > ~/.rcrc
  $ lsrc -d fresh
  /*/.hola/tossala:/*/fresh/hola/tossala (glob)

When -x argument is provided, RCRC EXCLUDES are ignored

  $ echo 'EXCLUDES="hola/chao"'               > ~/.rcrc
  $ lsrc -d fresh -x s
  /*/.hola/chao/nemo:/*/fresh/hola/chao/nemo (glob)
  /*/.hola/chao/wo:/*/fresh/hola/chao/wo (glob)
  /*/.hola/tossala:/*/fresh/hola/tossala (glob)

  $ echo 'EXCLUDES="s"'                       > ~/.rcrc
  $ lsrc -d fresh -x hola/chao
  /*/.hola/s:/*/fresh/hola/s (glob)
  /*/.hola/tossala:/*/fresh/hola/tossala (glob)
  /*/.s:/*/fresh/s (glob)

Should support globs in the excludes, including Emacs backup files

  $ rm -rf .dotfiles
  $ ( mkdir .dotfiles && cd .dotfiles && touch included README.md included~ README.md~ )

  $ echo 'EXCLUDES="README.md *~"'           > ~/.rcrc
  $ lsrc
  /*/.included:/*/.dotfiles/included (glob)

Should support a globs in the directory specifier

  $ echo 'EXCLUDES="*:*~"'                     > ~/.rcrc
  $ lsrc
  /*/.README.md:/*/.dotfiles/README.md (glob)
  /*/.included:/*/.dotfiles/included (glob)

And should support a mix of plain and directory tagged globs

  $ echo 'EXCLUDES="README.md *:*~"'           > ~/.rcrc
  $ lsrc
  /*/.included:/*/.dotfiles/included (glob)

And a redundant list of implied and specified globs

  $ echo 'EXCLUDES="README.md *~ *:*~"'        > ~/.rcrc
  $ lsrc
  /*/.included:/*/.dotfiles/included (glob)

