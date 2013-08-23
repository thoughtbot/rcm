  $ source $SRC/test/helper.sh

Passing -C should copy the file

  $ echo 'Content' > .example

  $ mkrc -C .example >/dev/null

  $ assert_not -h $HOME/.example

  $ cat $HOME/.example
  Content

  $ cat $HOME/.dotfiles/example
  Content
