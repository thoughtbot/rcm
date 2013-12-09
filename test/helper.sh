export HOME=$PWD
export PATH=$SRC/bin:$PATH
export RCM_LIB=$SRC/share
mkdir .dotfiles

assert() { test "$@" || echo 'Failed assertion'; return 0; }

assert_not() { test "$@" && echo 'Failed assertion'; return 0; }

assert_linked() {
  from="$1" to="$2"

  if [ ! -h "$from" ]; then
    echo 'Failed assertion, not a symlink'
    return 0
  fi

  if [ $(readlink -f "$from") != "$to" ]; then
    echo 'Failed assertion, symlink resolved incorrectly'
    return 0
  fi

  return 0
}
