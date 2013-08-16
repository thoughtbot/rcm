#!/usr/bin/env sh

failure="\e[1;31mFailure\e[0m"
success="\e[1;32mSuccess\e[0m"

output() {
  printf -- "$*\n"
}

call() {
  local bin=$1; shift

  RCM_LIB=$SRC_DIR/share $SRC_DIR/bin/$bin $@ > stdout.log 2> stderr.log
}

assert_stdout() {
  cat > expected_stdout

  if ! diff -q -s expected_stdout stdout.log > /dev/null; then
    failure_message="/dev/stdout mismatch

Expected:

`cat expected_stdout`

Actual:

`cat stdout.log`

"

    return 1
  fi

  return 0
}

assert_linked() {
  local src=$1 dest=$2 abs resolved

  if [ ! -h $dest ]; then
    failure_message="$dest is not a symlink"
    return 1
  fi

  abs=`readlink -f $src`
  resolved=`readlink -f $dest`

  if [ $abs != $resolved ]; then
    failure_message="expected $dest to resolve to $abs (actually $resolved)"
    return 1
  fi

  return 0
}

assert_present() {
  if [ ! -e $1 ]; then
    failure_message="Expected $1 to exist"
    return 1
  fi

  return 0
}

assert_not_present() {
  if [ -e $1 ]; then
    failure_message="Expected $1 to not exist"
    return 1
  fi

  return 0
}

run() {
  local run_directory="./test-run-$$-$1"

  mkdir "$run_directory"
  cd "$run_directory"

  if HOME=$PWD $1; then
    output "$success - $1"
  else
    output "[*] $failure - $1"
    output
    output 'Message:'
    output "$failure_message"
    output
  fi

  cd - > /dev/null
  rm -r "$run_directory"
}

SRC_DIR=$PWD

clear

if ! make >/dev/null; then
  echo 'Failed to run make'
  exit 1
fi

for test_file in `dirname $0`/*_test.sh; do
  . $test_file
done
