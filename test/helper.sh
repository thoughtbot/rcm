for bin in lsrc mkrc rcup rcdn; do
  chmod +x "$TESTDIR/../bin"/$bin
done

export HOME="$PWD"
export PATH="$TESTDIR/../bin:$PATH"
export RCRC="$HOME/.rcrc"
export RCM_LIB="$TESTDIR/../share"

mkdir .dotfiles

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
  local actual_path="$original_path"
  local actual_basename="$(basename "$original_path")"

  cd "$(dirname "$original_path")"

  while [ -L "$actual_basename" ]; do
    actual_path="$(readlink "$actual_basename")"
    actual_basename="$(basename "$actual_path")"

    cd "$(dirname "$actual_path")"
  done

  local current_directory="$(pwd -P)"

  printf "%s/%s\n" "$current_directory" "$actual_basename"
}

assert_linked() {
  local from="$1" to="$2"
  local resolved="$(resolved_path "$from")"

  assert "$from should be a symlink" -h "$from"
  assert "$from should resolve to $to, resolved to $resolved" "$resolved" = "$to"
}
