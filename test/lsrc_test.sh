#!/usr/bin/env sh

test_lsrc_nested() {
  mkdir .dotfiles
  touch .dotfiles/top-level

  mkdir .dotfiles/nested
  touch .dotfiles/nested/mid-level

  mkdir .dotfiles/nested/deeply
  touch .dotfiles/nested/deeply/lowest-level

  call lsrc

  assert_stdout <<EOF
$HOME/.nested/deeply/lowest-level:$PWD/.dotfiles/nested/deeply/lowest-level
$HOME/.nested/mid-level:$PWD/.dotfiles/nested/mid-level
$HOME/.top-level:$PWD/.dotfiles/top-level
EOF
}

test_lsrc_tag_excluded() {
  mkdir .dotfiles
  touch .dotfiles/foo

  mkdir .dotfiles/tag-bar
  touch .dotfiles/tag-bar/excluded

  call lsrc

  assert_stdout <<EOF
$HOME/.foo:$PWD/.dotfiles/foo
EOF
}

test_lsrc_tag_included() {
  mkdir .dotfiles
  touch .dotfiles/foo

  mkdir .dotfiles/tag-bar
  touch .dotfiles/tag-bar/included

  call lsrc -t bar

  assert_stdout <<EOF
$HOME/.foo:$PWD/.dotfiles/foo
$HOME/.included:$PWD/.dotfiles/tag-bar/included
EOF
}

test_lsrc_hostname() {
  mkdir .dotfiles
  touch .dotfiles/foo

  mkdir .dotfiles/host-`hostname`
  touch .dotfiles/host-`hostname`/included

  mkdir .dotfiles/host-not-`hostname`
  touch .dotfiles/host-not-`hostname`/excluded

  call lsrc

  assert_stdout <<EOF
$HOME/.foo:$PWD/.dotfiles/foo
$HOME/.included:$PWD/.dotfiles/host-`hostname`/included
EOF
}

run 'test_lsrc_nested'
run 'test_lsrc_tag_excluded'
run 'test_lsrc_tag_included'
run 'test_lsrc_hostname'
