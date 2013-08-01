#!/usr/bin/env sh

test_mkrc_file() {
  mkdir .dotfiles
  touch .example

  call mkrc .example

  assert_linked .dotfiles/example .example
}

test_mkrc_directory() {
  mkdir .dotfiles
  mkdir .nested
  touch .nested/example

  call mkrc .nested/example

  assert_linked .dotfiles/nested/example .nested/example
}

run 'test_mkrc_file'
run 'test_mkrc_directory'
