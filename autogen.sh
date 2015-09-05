#!/bin/sh

aclocal -I m4 &&
  autoconf &&
  automake --add-missing --copy &&
  ./maint/autocontrib man/rcm.7.mustache
