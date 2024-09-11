  $ . "$TESTDIR/helper.sh"
  > mv .dotfiles .other-dotfiles
  > mkdir .another-dotfiles
  > touch rcfile

Trying to fool should result in no dir found error

  $ mkrc -d ".other-dotfiles .another-dotfiles" rcfile
  No dotfiles directories found in .other-dotfiles .another-dotfiles /*/share/rcm/dotfiles (glob)
  [1]

Giving 2 dotfiles dir should result in an error and exit EX_USAGE

  $ mkrc -d .dotfiles -d .other-dotfiles rcfile
  Only one '-d' option is allowed in mkrc.
  Usage: mkrc * (glob)
  see mkrc(1) and rcm(7) for more details
  [64]

Giving one dotfiles dir should override default

  $ mv .other-dotfiles .dotfiles
  $ mkrc -v -d .another-dotfiles rcfile
  Moving...
  '/*/rcfile' -> '.another-dotfiles/rcfile' (glob)
  Linking...
  '/*/.another-dotfiles/rcfile' -> '/*/.rcfile' (glob)

