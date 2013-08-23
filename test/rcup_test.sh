#!/usr/bin/env sh

test_rcup() {
  mkdir .dotfiles
  touch .dotfiles/top-level

  mkdir .dotfiles/nested
  touch .dotfiles/nested/mid-level

  call rcup

  assert_linked .dotfiles/top-level .top-level
  assert_linked .dotfiles/nested/mid-level .nested/mid-level
}

test_rcup_tag_excluded() {
  mkdir .dotfiles
  touch .dotfiles/foo

  mkdir .dotfiles/tag-bar
  touch .dotfiles/tag-bar/excluded

  call rcup

  assert_linked .dotfiles/foo .foo
}

test_rcup_tag_included() {
  mkdir .dotfiles
  touch .dotfiles/foo

  mkdir .dotfiles/tag-bar
  touch .dotfiles/tag-bar/included

  call rcup -t bar

  assert_linked .dotfiles/foo .foo
  assert_linked .dotfiles/tag-bar/included .included
}

test_rcup_hostname() {
  mkdir .dotfiles
  touch .dotfiles/foo

  mkdir .dotfiles/host-`hostname`
  touch .dotfiles/host-`hostname`/included

  mkdir .dotfiles/host-not-`hostname`
  touch .dotfiles/host-not-`hostname`/excluded

  call rcup

  assert_linked .dotfiles/foo .foo
  assert_linked .dotfiles/host-`hostname`/included .included
  assert_not_present .excluded
}

run 'test_rcup'
run 'test_rcup_tag_excluded'
run 'test_rcup_tag_included'
run 'test_rcup_hostname'
