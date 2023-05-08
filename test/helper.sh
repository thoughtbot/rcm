for bin in lsrc mkrc rcup rcdn; do
  chmod +x "$TESTDIR/../bin"/$bin
done

export HOME="$PWD"
export XDG_CONFIG_HOME="$PWD/.config"
export XDG_DATA_HOME="$PWD/.local/share"
export PATH="$TESTDIR/../bin:$PATH"
export RCRC="$HOME/.rcrc"
export RCM_LIB="$TESTDIR/../share"

mkdir .dotfiles

hostname() {
  if [ -n "$HOSTNAME" ]; then
    echo "$HOSTNAME"
  else
    command hostname | sed -e 's/\..*//'
  fi
}

assert() {
  local msg="$1"; shift

  test "$@" || echo "Failed assertion: $msg"

  return 0
}

refute() {
  local msg="$1"; shift

  test "$@" && echo "Failed assertion: $msg"

  return 0
}

resolved_path() {
  local original_path="$1"
  perl -e \
    "use Cwd realpath; print realpath(\"$original_path\") . \"\\n\";" 
}

assert_linked() {
  local from="$1" to="$2"
  local resolved="$(resolved_path "$from")"

  assert "$from should be a symlink" -h "$from"
  assert "$from should resolve to $to, resolved to $resolved" "$resolved" = "$to"
}
