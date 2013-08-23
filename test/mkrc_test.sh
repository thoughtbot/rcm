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

test_mkrc_tag() {
  mkdir .dotfiles
  touch .example

  call mkrc -t foo .example

  assert_linked .dotfiles/tag-foo/example .example
}

test_mkrc_host() {
  mkdir .dotfiles
  touch .example

  call mkrc -o .example

  assert_linked .dotfiles/host-`hostname`/example .example
}

test_mkrc_copy() {
  mkdir .dotfiles
  touch .example

  call mkrc -C .example

  assert_present .example
}

run 'test_mkrc_file'
run 'test_mkrc_directory'
run 'test_mkrc_tag'
run 'test_mkrc_host'
run 'test_mkrc_copy'
