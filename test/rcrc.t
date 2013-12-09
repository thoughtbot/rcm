  $ source $SRC/test/helper.sh

Information should be read from ~/.rcrc by default

  $ touch .example
  > mkdir .other-dotfiles

  $ echo 'DOTFILES_DIRS="$HOME/.other-dotfiles"' > $HOME/.rcrc

  $ mkrc .example
  '.example' -> '*/.other-dotfiles/example' (glob)
  '*/.example' -> '*/.other-dotfiles/example' (glob)

  $ assert_linked "$HOME/.example" "$HOME/.other-dotfiles/example"
